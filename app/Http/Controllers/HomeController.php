<?php

namespace App\Http\Controllers;

use App\Models\DisasterEvent;
use App\Services\GdacsService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;

class HomeController extends Controller
{
    private GdacsService $gdacsService;

    public function __construct(GdacsService $gdacsService)
    {
        $this->gdacsService = $gdacsService;
    }

    /**
     * Display the home page with world map
     */
    public function index()
    {
        $statistics = $this->gdacsService->getStatistics();
        
        return view('home.index', [
            'statistics' => $statistics,
            'lastUpdate' => $statistics['last_update'] 
                ? Carbon::parse($statistics['last_update'])->diffForHumans() 
                : 'Never'
        ]);
    }

    /**
     * Get events data for the map (API endpoint)
     */
    public function getEventsData(): JsonResponse
    {
        $events = DisasterEvent::gdacsEvents()
            ->active()
            ->whereNotNull(['lat', 'lng'])
            ->select([
                'id',
                'title',
                'description',
                'event_type',
                'severity',
                'gdacs_alert_level',
                'gdacs_alert_score',
                'gdacs_event_name',
                'gdacs_country',
                'lat',
                'lng',
                'event_date',
                'start_time',
                'end_time',
                'gdacs_population_value',
                'gdacs_population_text',
                'gdacs_severity_value',
                'gdacs_severity_text',
                'gdacs_icon_url',
                'external_sources'
            ])
            ->get()
            ->map(function ($event) {
                return [
                    'id' => $event->id,
                    'title' => $event->title,
                    'description' => $event->description,
                    'event_type' => $event->event_type,
                    'severity' => $event->severity,
                    'alert_level' => $event->gdacs_alert_level,
                    'alert_score' => $event->gdacs_alert_score,
                    'event_name' => $event->gdacs_event_name,
                    'country' => $event->gdacs_country,
                    'lat' => (float) $event->lat,
                    'lng' => (float) $event->lng,
                    'event_date' => $event->event_date->format('Y-m-d'),
                    'start_time' => $event->start_time?->format('Y-m-d H:i:s'),
                    'end_time' => $event->end_time?->format('Y-m-d H:i:s'),
                    'population_affected' => $event->gdacs_population_text,
                    'magnitude' => $event->gdacs_severity_text,
                    'icon_url' => $event->gdacs_icon_url,
                    'report_url' => $event->getGdacsReportUrl(),
                    'is_recent' => $event->event_date >= Carbon::now()->subDays(7),
                    'is_high_risk' => in_array($event->gdacs_alert_level, ['Orange', 'Red']),
                    'formatted_date' => $event->event_date->diffForHumans(),
                ];
            });

        return response()->json([
            'events' => $events,
            'total' => $events->count(),
            'last_updated' => now()->format('Y-m-d H:i:s')
        ]);
    }

    /**
     * Get detailed event information
     */
    public function getEventDetails($id): JsonResponse
    {
        $event = DisasterEvent::gdacsEvents()
            ->with(['country', 'city'])
            ->findOrFail($id);

        return response()->json([
            'event' => [
                'id' => $event->id,
                'title' => $event->title,
                'description' => $event->description,
                'event_type' => $event->event_type,
                'severity' => $event->severity,
                'alert_level' => $event->gdacs_alert_level,
                'alert_score' => $event->gdacs_alert_score,
                'event_name' => $event->gdacs_event_name,
                'country' => $event->gdacs_country,
                'lat' => (float) $event->lat,
                'lng' => (float) $event->lng,
                'event_date' => $event->event_date->format('Y-m-d'),
                'start_time' => $event->start_time?->format('Y-m-d H:i:s'),
                'end_time' => $event->end_time?->format('Y-m-d H:i:s'),
                'population_affected' => $event->gdacs_population_text,
                'population_value' => $event->gdacs_population_value,
                'magnitude' => $event->gdacs_severity_text,
                'magnitude_value' => $event->gdacs_severity_value,
                'vulnerability' => $event->gdacs_vulnerability,
                'icon_url' => $event->gdacs_icon_url,
                'report_url' => $event->getGdacsReportUrl(),
                'resources' => $event->gdacs_resources,
                'bbox' => $event->gdacs_bbox,
                'is_recent' => $event->event_date >= Carbon::now()->subDays(7),
                'is_high_risk' => in_array($event->gdacs_alert_level, ['Orange', 'Red']),
                'formatted_date' => $event->event_date->diffForHumans(),
                'last_updated' => $event->gdacs_date_modified?->diffForHumans(),
            ]
        ]);
    }

    /**
     * Get dashboard statistics
     */
    public function getDashboardStats(): JsonResponse
    {
        $statistics = $this->gdacsService->getStatistics();
        
        // Recent events (last 7 days)
        $recentEvents = DisasterEvent::gdacsEvents()
            ->where('event_date', '>=', Carbon::now()->subDays(7))
            ->count();
            
        // High risk events
        $highRiskEvents = DisasterEvent::gdacsEvents()
            ->active()
            ->whereIn('gdacs_alert_level', ['Orange', 'Red'])
            ->count();

        return response()->json([
            'total_events' => $statistics['total_events'],
            'active_events' => $statistics['active_events'],
            'recent_events' => $recentEvents,
            'high_risk_events' => $highRiskEvents,
            'by_alert_level' => $statistics['by_alert_level'],
            'by_event_type' => $statistics['by_event_type'],
            'last_update' => $statistics['last_update'] 
                ? Carbon::parse($statistics['last_update'])->diffForHumans() 
                : 'Never'
        ]);
    }

    /**
     * Refresh GDACS data from external API
     */
    public function refreshGdacsData(): JsonResponse
    {
        try {
            $results = $this->gdacsService->fetchAndProcessEvents();
            
            return response()->json([
                'success' => true,
                'message' => 'GDACS data refreshed successfully',
                'stats' => $results,
                'last_updated' => now()->format('Y-m-d H:i:s')
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to refresh GDACS data: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Server-Sent Events stream for GDACS updates
     */
    public function gdacsUpdatesStream(Request $request)
    {
        // Set headers for Server-Sent Events
        $response = response()->stream(function () {
            $lastUpdateCheck = null;
            $checkInterval = 30; // Check every 30 seconds
            
            while (true) {
                $statistics = $this->gdacsService->getStatistics();
                $currentUpdate = $statistics['last_update'];
                
                // If this is first check or data has been updated
                if ($lastUpdateCheck === null) {
                    $lastUpdateCheck = $currentUpdate;
                } elseif ($currentUpdate && $currentUpdate !== $lastUpdateCheck) {
                    // Send update event
                    echo "event: gdacs-updated\n";
                    echo "data: " . json_encode([
                        'last_update' => $currentUpdate,
                        'timestamp' => now()->toISOString(),
                        'message' => 'GDACS data has been updated'
                    ]) . "\n\n";
                    
                    $lastUpdateCheck = $currentUpdate;
                    flush();
                }
                
                // Send heartbeat every minute
                if (time() % 60 === 0) {
                    echo "event: heartbeat\n";
                    echo "data: " . json_encode(['timestamp' => now()->toISOString()]) . "\n\n";
                    flush();
                }
                
                sleep($checkInterval);
                
                // Break if connection is closed
                if (connection_aborted()) {
                    break;
                }
            }
        });
        
        $response->headers->set('Content-Type', 'text/event-stream');
        $response->headers->set('Cache-Control', 'no-cache');
        $response->headers->set('Connection', 'keep-alive');
        $response->headers->set('Access-Control-Allow-Origin', '*');
        $response->headers->set('Access-Control-Allow-Credentials', 'true');
        
        return $response;
    }
}
