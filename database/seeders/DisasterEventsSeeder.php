<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DisasterEventsSeeder extends Seeder
{
    public function run(): void
    {
        $events = [
            [
                'id' => 104,
                'title' => 'Tropical Cyclone GIL-25',
                'description' => 'Alert Score: 1',
                'severity' => 'low',
                'event_type' => 'hurricane',
                'lat' => 18.30000000,
                'lng' => -128.60000000,
                'radius_km' => 200.00,
                'country_id' => null,
                'region_id' => null,
                'city_id' => null,
                'affected_areas' => null,
                'event_date' => '2025-07-31',
                'start_time' => '2025-07-31 07:00:00',
                'end_time' => '2025-08-02 13:00:00',
                'is_active' => false,
                'impact_assessment' => null,
                'travel_recommendations' => null,
                'official_sources' => null,
                'media_coverage' => null,
                'tourism_impact' => null,
                'external_sources' => json_encode([
                    [
                        'geometry' => 'https://www.gdacs.org/gdacsapi/api/polygons/getgeometry?eventtype=TC&eventid=1001187&episodeid=10',
                        'report' => 'https://www.gdacs.org/report.aspx?eventid=1001187&episodeid=10&eventtype=TC',
                        'details' => 'https://www.gdacs.org/gdacsapi/api/events/geteventdata?eventtype=TC&eventid=1001187'
                    ]
                ]),
                'last_updated' => '2025-08-02 14:56:07',
                'confidence_score' => 0,
                'processing_status' => 'none',
                'ai_summary' => null,
                'ai_recommendations' => null,
                'crisis_communication' => '',
                'keywords' => null,
                'magnitude' => 0,
                'casualties' => null,
                'economic_impact' => null,
                'infrastructure_damage' => null,
                'emergency_response' => null,
                'recovery_status' => null,
                'external_id' => 'gdacs_1001187',
                'weather_conditions' => null,
                'evacuation_info' => null,
                'transportation_impact' => null,
                'accommodation_impact' => null,
                'communication_status' => null,
                'health_services_status' => null,
                'utility_services_status' => null,
                'border_crossings_status' => null,
                'created_at' => '2025-08-02 14:56:07',
                'updated_at' => '2025-08-02 14:56:07',
            ]
        ];

        foreach ($events as $event) {
            DB::table('disaster_events')->insert($event);
        }
    }
}