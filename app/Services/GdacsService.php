<?php

namespace App\Services;

use App\Models\DisasterEvent;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
use SimpleXMLElement;

class GdacsService
{
    private const GDACS_RSS_URL = 'https://www.gdacs.org/xml/rss.xml';
    
    private const EVENT_TYPE_MAPPING = [
        'EQ' => 'earthquake',
        'TC' => 'hurricane',
        'FL' => 'flood',
        'WF' => 'wildfire',
        'VO' => 'volcano',
        'DR' => 'drought',
        'TS' => 'tsunami'
    ];
    
    private const ALERT_LEVEL_SEVERITY_MAPPING = [
        'Green' => 'low',
        'Orange' => 'medium', 
        'Red' => 'high'
    ];

    /**
     * Fetch and process GDACS disaster events
     */
    public function fetchAndProcessEvents(): array
    {
        try {
            Log::info('Starting GDACS data fetch');
            
            $response = Http::timeout(30)->get(self::GDACS_RSS_URL);
            
            if (!$response->successful()) {
                throw new \Exception('Failed to fetch GDACS RSS feed: ' . $response->status());
            }
            
            $xml = new SimpleXMLElement($response->body());
            $events = $this->parseXmlEvents($xml);
            
            $stats = [
                'total' => 0,
                'new' => 0,
                'updated' => 0,
                'skipped' => 0
            ];
            
            foreach ($events as $eventData) {
                $stats['total']++;
                $result = $this->processEvent($eventData);
                $stats[$result]++;
            }
            
            Log::info('GDACS data fetch completed', $stats);
            
            return $stats;
            
        } catch (\Exception $e) {
            Log::error('GDACS data fetch failed: ' . $e->getMessage());
            throw $e;
        }
    }
    
    /**
     * Parse XML events from RSS feed
     */
    private function parseXmlEvents(SimpleXMLElement $xml): array
    {
        $events = [];
        
        foreach ($xml->channel->item as $item) {
            try {
                $gdacsNamespace = $item->children('gdacs', true);
                $geoNamespace = $item->children('geo', true);
                $dcNamespace = $item->children('dc', true);
                
                $eventData = [
                    // Basic event information
                    'title' => (string) $item->title,
                    'description' => (string) $item->description,
                    'link' => (string) $item->link,
                    'pub_date' => (string) $item->pubDate,
                    
                    // GDACS specific fields
                    'gdacs_event_id' => (string) $gdacsNamespace->eventid,
                    'gdacs_episode_id' => (string) $gdacsNamespace->episodeid,
                    'gdacs_alert_level' => (string) $gdacsNamespace->alertlevel,
                    'gdacs_alert_score' => (int) $gdacsNamespace->alertscore,
                    'gdacs_episode_alert_level' => (string) $gdacsNamespace->episodealertlevel,
                    'gdacs_episode_alert_score' => (int) $gdacsNamespace->episodealertscore,
                    'gdacs_event_name' => (string) $gdacsNamespace->eventname,
                    'gdacs_event_type' => (string) $gdacsNamespace->eventtype,
                    'gdacs_calculation_type' => (string) $gdacsNamespace->calculationtype,
                    'gdacs_temporary' => ((string) $gdacsNamespace->temporary) === 'true',
                    'gdacs_is_current' => ((string) $gdacsNamespace->iscurrent) === 'true',
                    'gdacs_version' => (int) $gdacsNamespace->version,
                    'gdacs_duration_weeks' => (int) $gdacsNamespace->durationinweek,
                    'gdacs_iso3' => (string) $gdacsNamespace->iso3,
                    'gdacs_country' => (string) $gdacsNamespace->country,
                    'gdacs_glide' => (string) $gdacsNamespace->glide,
                    'gdacs_bbox' => (string) $gdacsNamespace->bbox,
                    'gdacs_cap_url' => (string) $gdacsNamespace->cap,
                    'gdacs_icon_url' => (string) $gdacsNamespace->icon,
                    'gdacs_map_image' => (string) $gdacsNamespace->mapimage,
                    'gdacs_map_link' => (string) $gdacsNamespace->maplink,
                    'gdacs_date_added' => (string) $gdacsNamespace->dateadded,
                    'gdacs_date_modified' => (string) $gdacsNamespace->datemodified,
                    'gdacs_from_date' => (string) $gdacsNamespace->fromdate,
                    'gdacs_to_date' => (string) $gdacsNamespace->todate,
                    
                    // Geographic information
                    'latitude' => (float) $geoNamespace->Point->lat ?? (float) $geoNamespace->lat,
                    'longitude' => (float) $geoNamespace->Point->long ?? (float) $geoNamespace->long,
                    
                    // Additional data
                    'guid' => (string) $item->guid,
                    'subject' => (string) $dcNamespace->subject,
                    'enclosure_url' => (string) $item->enclosure['url'] ?? null,
                ];
                
                // Parse severity information
                $severity = $gdacsNamespace->severity;
                if ($severity) {
                    $eventData['gdacs_severity_value'] = (float) $severity['value'];
                    $eventData['gdacs_severity_unit'] = (string) $severity['unit'];
                    $eventData['gdacs_severity_text'] = (string) $severity;
                }
                
                // Parse population information
                $population = $gdacsNamespace->population;
                if ($population) {
                    $eventData['gdacs_population_value'] = (int) $population['value'];
                    $eventData['gdacs_population_unit'] = (string) $population['unit'];
                    $eventData['gdacs_population_text'] = (string) $population;
                }
                
                // Parse vulnerability
                $vulnerability = $gdacsNamespace->vulnerability;
                if ($vulnerability) {
                    $eventData['gdacs_vulnerability'] = (float) $vulnerability['value'];
                }
                
                // Parse resources
                $resources = [];
                foreach ($gdacsNamespace->resources->resource ?? [] as $resource) {
                    $resources[] = [
                        'id' => (string) $resource['id'],
                        'version' => (string) $resource['version'],
                        'source' => (string) $resource['source'],
                        'url' => (string) $resource['url'],
                        'type' => (string) $resource['type'],
                        'title' => (string) $resource->title,
                        'description' => (string) $resource->description,
                        'acknowledgements' => (string) $resource->acknowledgements,
                        'access_level' => (string) $resource->accesslevel,
                    ];
                }
                $eventData['gdacs_resources'] = $resources;
                
                $events[] = $eventData;
                
            } catch (\Exception $e) {
                Log::warning('Failed to parse GDACS event item: ' . $e->getMessage());
                continue;
            }
        }
        
        return $events;
    }
    
    /**
     * Process a single event - create new or update existing
     */
    private function processEvent(array $eventData): string
    {
        try {
            // Check if event already exists
            $existing = DisasterEvent::where('gdacs_event_id', $eventData['gdacs_event_id'])
                ->where('gdacs_episode_id', $eventData['gdacs_episode_id'])
                ->first();
            
            if ($existing) {
                // Check if the event needs updating
                $gdacsModified = Carbon::parse($eventData['gdacs_date_modified']);
                $lastUpdated = Carbon::parse($existing->gdacs_date_modified);
                
                if ($gdacsModified->greaterThan($lastUpdated)) {
                    $this->updateEvent($existing, $eventData);
                    return 'updated';
                }
                
                return 'skipped';
            }
            
            // Create new event
            $this->createEvent($eventData);
            return 'new';
            
        } catch (\Exception $e) {
            Log::error('Failed to process GDACS event: ' . $e->getMessage(), [
                'event_id' => $eventData['gdacs_event_id'] ?? 'unknown',
                'episode_id' => $eventData['gdacs_episode_id'] ?? 'unknown'
            ]);
            return 'skipped';
        }
    }
    
    /**
     * Create a new disaster event
     */
    private function createEvent(array $eventData): DisasterEvent
    {
        $mappedData = $this->mapEventData($eventData);
        return DisasterEvent::create($mappedData);
    }
    
    /**
     * Update an existing disaster event
     */
    private function updateEvent(DisasterEvent $event, array $eventData): DisasterEvent
    {
        $mappedData = $this->mapEventData($eventData);
        $event->update($mappedData);
        return $event;
    }
    
    /**
     * Map GDACS data to database structure
     */
    private function mapEventData(array $eventData): array
    {
        // Parse dates
        $eventDate = Carbon::parse($eventData['gdacs_from_date'])->format('Y-m-d');
        $startTime = Carbon::parse($eventData['gdacs_from_date']);
        $endTime = !empty($eventData['gdacs_to_date']) 
            ? Carbon::parse($eventData['gdacs_to_date']) 
            : null;
        
        // Map event type
        $eventType = self::EVENT_TYPE_MAPPING[$eventData['gdacs_event_type']] ?? 'other';
        
        // Map severity
        $severity = self::ALERT_LEVEL_SEVERITY_MAPPING[$eventData['gdacs_alert_level']] ?? 'low';
        
        // Parse bbox as JSON
        $bbox = null;
        if (!empty($eventData['gdacs_bbox'])) {
            $coords = explode(' ', $eventData['gdacs_bbox']);
            if (count($coords) === 4) {
                $bbox = [
                    'lonmin' => (float) $coords[0],
                    'lonmax' => (float) $coords[1], 
                    'latmin' => (float) $coords[2],
                    'latmax' => (float) $coords[3]
                ];
            }
        }
        
        return [
            'title' => $eventData['title'],
            'description' => $eventData['description'],
            'severity' => $severity,
            'event_type' => $eventType,
            'lat' => $eventData['latitude'] ?? null,
            'lng' => $eventData['longitude'] ?? null,
            'event_date' => $eventDate,
            'start_time' => $startTime,
            'end_time' => $endTime,
            'is_active' => $eventData['gdacs_is_current'] && !$eventData['gdacs_temporary'],
            'last_updated' => Carbon::parse($eventData['gdacs_date_modified']),
            'external_id' => 'gdacs_' . $eventData['gdacs_event_id'],
            'external_sources' => [
                [
                    'source' => 'GDACS',
                    'url' => $eventData['link'],
                    'cap_url' => $eventData['gdacs_cap_url'],
                    'map_url' => $eventData['gdacs_map_link'],
                    'icon_url' => $eventData['gdacs_icon_url']
                ]
            ],
            'magnitude' => $eventData['gdacs_severity_value'] ?? 0,
            
            // GDACS specific fields
            'gdacs_event_id' => $eventData['gdacs_event_id'],
            'gdacs_episode_id' => $eventData['gdacs_episode_id'],
            'gdacs_alert_level' => $eventData['gdacs_alert_level'],
            'gdacs_alert_score' => $eventData['gdacs_alert_score'],
            'gdacs_episode_alert_level' => $eventData['gdacs_episode_alert_level'],
            'gdacs_episode_alert_score' => $eventData['gdacs_episode_alert_score'],
            'gdacs_event_name' => $eventData['gdacs_event_name'],
            'gdacs_calculation_type' => $eventData['gdacs_calculation_type'],
            'gdacs_severity_value' => $eventData['gdacs_severity_value'] ?? null,
            'gdacs_severity_unit' => $eventData['gdacs_severity_unit'] ?? null,
            'gdacs_severity_text' => $eventData['gdacs_severity_text'] ?? null,
            'gdacs_population_value' => $eventData['gdacs_population_value'] ?? null,
            'gdacs_population_unit' => $eventData['gdacs_population_unit'] ?? null,
            'gdacs_population_text' => $eventData['gdacs_population_text'] ?? null,
            'gdacs_vulnerability' => $eventData['gdacs_vulnerability'] ?? null,
            'gdacs_iso3' => $eventData['gdacs_iso3'],
            'gdacs_country' => $eventData['gdacs_country'],
            'gdacs_glide' => $eventData['gdacs_glide'],
            'gdacs_bbox' => $bbox,
            'gdacs_cap_url' => $eventData['gdacs_cap_url'],
            'gdacs_icon_url' => $eventData['gdacs_icon_url'],
            'gdacs_version' => $eventData['gdacs_version'],
            'gdacs_temporary' => $eventData['gdacs_temporary'],
            'gdacs_is_current' => $eventData['gdacs_is_current'],
            'gdacs_duration_weeks' => $eventData['gdacs_duration_weeks'],
            'gdacs_resources' => $eventData['gdacs_resources'],
            'gdacs_map_image' => $eventData['gdacs_map_image'],
            'gdacs_map_link' => $eventData['gdacs_map_link'],
            'gdacs_date_added' => Carbon::parse($eventData['gdacs_date_added']),
            'gdacs_date_modified' => Carbon::parse($eventData['gdacs_date_modified']),
        ];
    }
    
    /**
     * Get statistics about GDACS events in database
     */
    public function getStatistics(): array
    {
        return [
            'total_events' => DisasterEvent::whereNotNull('gdacs_event_id')->count(),
            'active_events' => DisasterEvent::whereNotNull('gdacs_event_id')
                ->where('gdacs_is_current', true)
                ->count(),
            'by_alert_level' => DisasterEvent::whereNotNull('gdacs_event_id')
                ->selectRaw('gdacs_alert_level, COUNT(*) as count')
                ->groupBy('gdacs_alert_level')
                ->pluck('count', 'gdacs_alert_level')
                ->toArray(),
            'by_event_type' => DisasterEvent::whereNotNull('gdacs_event_id')
                ->selectRaw('event_type, COUNT(*) as count')
                ->groupBy('event_type')
                ->pluck('count', 'event_type')
                ->toArray(),
            'last_update' => DisasterEvent::whereNotNull('gdacs_event_id')
                ->max('gdacs_date_modified'),
        ];
    }
}