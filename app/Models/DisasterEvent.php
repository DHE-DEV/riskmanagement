<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;
use Carbon\Carbon;

class DisasterEvent extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'title',
        'description',
        'severity',
        'event_type',
        'lat',
        'lng',
        'radius_km',
        'country_id',
        'region_id',
        'city_id',
        'affected_areas',
        'event_date',
        'start_time',
        'end_time',
        'is_active',
        'impact_assessment',
        'travel_recommendations',
        'official_sources',
        'media_coverage',
        'tourism_impact',
        'external_sources',
        'last_updated',
        'confidence_score',
        'processing_status',
        'ai_summary',
        'ai_recommendations',
        'crisis_communication',
        'keywords',
        'magnitude',
        'casualties',
        'economic_impact',
        'infrastructure_damage',
        'emergency_response',
        'recovery_status',
        'external_id',
        'weather_conditions',
        'evacuation_info',
        'transportation_impact',
        'accommodation_impact',
        'communication_status',
        'health_services_status',
        'utility_services_status',
        'border_crossings_status',
        
        // GDACS specific fields
        'gdacs_event_id',
        'gdacs_episode_id',
        'gdacs_alert_level',
        'gdacs_alert_score',
        'gdacs_episode_alert_level',
        'gdacs_episode_alert_score',
        'gdacs_event_name',
        'gdacs_calculation_type',
        'gdacs_severity_value',
        'gdacs_severity_unit',
        'gdacs_severity_text',
        'gdacs_population_value',
        'gdacs_population_unit',
        'gdacs_population_text',
        'gdacs_vulnerability',
        'gdacs_iso3',
        'gdacs_country',
        'gdacs_glide',
        'gdacs_bbox',
        'gdacs_cap_url',
        'gdacs_icon_url',
        'gdacs_version',
        'gdacs_temporary',
        'gdacs_is_current',
        'gdacs_duration_weeks',
        'gdacs_resources',
        'gdacs_map_image',
        'gdacs_map_link',
        'gdacs_date_added',
        'gdacs_date_modified',
    ];

    protected $casts = [
        'affected_areas' => 'array',
        'impact_assessment' => 'array',
        'travel_recommendations' => 'array',
        'tourism_impact' => 'array',
        'external_sources' => 'array',
        'keywords' => 'array',
        'weather_conditions' => 'array',
        'evacuation_info' => 'array',
        'transportation_impact' => 'array',
        'accommodation_impact' => 'array',
        'communication_status' => 'array',
        'health_services_status' => 'array',
        'utility_services_status' => 'array',
        'border_crossings_status' => 'array',
        'gdacs_bbox' => 'array',
        'gdacs_resources' => 'array',
        'event_date' => 'date',
        'start_time' => 'datetime',
        'end_time' => 'datetime',
        'last_updated' => 'datetime',
        'gdacs_date_added' => 'datetime',
        'gdacs_date_modified' => 'datetime',
        'is_active' => 'boolean',
        'gdacs_temporary' => 'boolean',
        'gdacs_is_current' => 'boolean',
        'lat' => 'decimal:8',
        'lng' => 'decimal:8',
        'radius_km' => 'decimal:2',
        'gdacs_severity_value' => 'decimal:2',
        'gdacs_vulnerability' => 'decimal:6',
    ];

    public function country(): BelongsTo
    {
        return $this->belongsTo(Country::class);
    }

    public function region(): BelongsTo
    {
        return $this->belongsTo(Region::class);
    }

    public function city(): BelongsTo
    {
        return $this->belongsTo(City::class);
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function scopeGdacsEvents($query)
    {
        return $query->whereNotNull('gdacs_event_id');
    }

    public function scopeBySeverity($query, $severity)
    {
        return $query->where('severity', $severity);
    }

    public function scopeByEventType($query, $type)
    {
        return $query->where('event_type', $type);
    }

    public function scopeByGdacsAlertLevel($query, $level)
    {
        return $query->where('gdacs_alert_level', $level);
    }

    // Accessors
    public function getIsRecentAttribute(): bool
    {
        return $this->event_date >= Carbon::now()->subDays(7);
    }

    public function getIsHighRiskAttribute(): bool
    {
        return in_array($this->severity, ['high', 'critical']) || 
               in_array($this->gdacs_alert_level, ['Orange', 'Red']);
    }

    public function getFormattedLocationAttribute(): string
    {
        $location = $this->gdacs_country ?? $this->country?->name ?? 'Unknown Location';
        
        if ($this->lat && $this->lng) {
            $location .= sprintf(' (%.4f, %.4f)', $this->lat, $this->lng);
        }
        
        return $location;
    }

    // Methods
    public function updateFromGdacs(array $gdacsData): bool
    {
        try {
            $this->update($gdacsData);
            return true;
        } catch (\Exception $e) {
            \Log::error('Failed to update event from GDACS data: ' . $e->getMessage());
            return false;
        }
    }

    public function isStale(): bool
    {
        return $this->gdacs_date_modified && 
               Carbon::parse($this->gdacs_date_modified)->lt(Carbon::now()->subHours(6));
    }

    public function getGdacsReportUrl(): ?string
    {
        if (!$this->gdacs_event_id) {
            return null;
        }

        $eventType = strtoupper($this->event_type === 'hurricane' ? 'TC' : 
                                ($this->event_type === 'earthquake' ? 'EQ' : 
                                 substr($this->event_type, 0, 2)));

        return sprintf('https://www.gdacs.org/report.aspx?eventtype=%s&eventid=%s',
                      $eventType, $this->gdacs_event_id);
    }
}
