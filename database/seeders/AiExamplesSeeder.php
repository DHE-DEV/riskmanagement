<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AiExamplesSeeder extends Seeder
{
    public function run(): void
    {
        $examples = [
            [
                'id' => 1,
                'title' => 'Mallorca Storm Classification Example',
                'input_text' => 'news_article: "PALMA, Mallorca - Ein schwerer Sturm mit Windgeschwindigkeiten bis zu 120 km/h hat am Dienstag die Baleareninsel Mallorca getroffen. Der Flughafen Palma musste den Betrieb für drei Stunden einstellen, mehrere Hotels in der Playa de Palma wurden evakuiert. Etwa 15.000 Touristen sind betroffen, verletzt wurde niemand. Die Strände bleiben bis Donnerstag geschlossen."' . "\n" . 'destination: "Mallorca"' . "\n" . 'language: "German"',
                'expected_output' => json_encode([
                    'tourism_relevance' => 4,
                    'event_category' => 'Extremwetter',
                    'impact_level' => 'HIGH',
                    'affected_sectors' => ['transport', 'accommodation', 'beaches'],
                    'location_coordinates' => ['lat' => 39.5696, 'lng' => 2.6502],
                    'duration_estimate_days' => 3,
                    'tourist_advisory' => [
                        'de' => 'HOCH: Reisen nach Mallorca derzeit nicht empfohlen. Flughafen zeitweise geschlossen, Hotels evakuiert. Situation wird überwacht.',
                        'en' => 'HIGH: Travel to Mallorca currently not recommended. Airport temporarily closed, hotels evacuated. Situation being monitored.'
                    ],
                    'confidence_score' => 0.9,
                    'keywords' => ['sturm', 'mallorca', 'flughafen', 'evakuierung', 'touristen']
                ]),
                'prompt_template_id' => 1,
                'is_active' => true,
                'created_at' => '2025-08-02 13:22:52',
                'updated_at' => '2025-08-02 13:22:52',
                'deleted_at' => null,
            ],
            [
                'id' => 2,
                'title' => 'Thailand Flooding Classification Example',
                'input_text' => 'news_article: "BANGKOK - Heavy monsoon rains have caused widespread flooding in central Bangkok, affecting the popular Khao San Road area and Chatuchak Weekend Market. River boat services have been suspended, but Suvarnabhumi Airport remains operational. Tourism authorities estimate 2,000 tourists in affected areas, with hotels providing alternative accommodations."' . "\n" . 'destination: "Bangkok"' . "\n" . 'language: "English"',
                'expected_output' => json_encode([
                    'tourism_relevance' => 3,
                    'event_category' => 'Naturkatastrophe',
                    'impact_level' => 'MEDIUM',
                    'affected_sectors' => ['attractions', 'transport', 'accommodation'],
                    'location_coordinates' => ['lat' => 13.7563, 'lng' => 100.5018],
                    'duration_estimate_days' => 5,
                    'tourist_advisory' => [
                        'de' => 'MODERAT: Bangkok-Reisen mit Vorsicht. Überschwemmungen in Touristengebieten. Flughafen weiterhin geöffnet.',
                        'en' => 'MEDIUM: Travel to Bangkok with caution. Flooding in tourist areas. Airport remains operational.'
                    ],
                    'confidence_score' => 0.85,
                    'keywords' => ['bangkok', 'flooding', 'khao san road', 'monsoon', 'tourists']
                ]),
                'prompt_template_id' => 1,
                'is_active' => true,
                'created_at' => '2025-08-02 13:22:52',
                'updated_at' => '2025-08-02 13:22:52',
                'deleted_at' => null,
            ],
        ];

        foreach ($examples as $example) {
            DB::table('ai_examples')->updateOrInsert(
                ['id' => $example['id']],
                $example
            );
        }
    }
}