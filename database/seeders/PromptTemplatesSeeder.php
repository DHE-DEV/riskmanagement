<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PromptTemplatesSeeder extends Seeder
{
    public function run(): void
    {
        $templates = [
            [
                'id' => 1,
                'name' => 'Tourism Event Classification',
                'description' => 'Classifies news articles and events for tourism relevance and impact',
                'template' => 'Analyze the following news content for tourism impact...',
                'variables' => json_encode(['destination', 'event_type', 'language']),
                'is_active' => true,
                'created_at' => '2025-08-02 13:22:52',
                'updated_at' => '2025-08-02 13:22:52',
                'deleted_at' => null,
            ],
            [
                'id' => 2,
                'name' => 'Multi-Source Event Synthesis',
                'description' => 'Synthesizes information from multiple news sources into coherent event analysis',
                'template' => 'Synthesize the following multiple news sources...',
                'variables' => json_encode(['sources', 'region', 'time_period']),
                'is_active' => true,
                'created_at' => '2025-08-02 13:22:52',
                'updated_at' => '2025-08-02 13:22:52',
                'deleted_at' => null,
            ],
            [
                'id' => 3,
                'name' => 'Crisis Communication Generation',
                'description' => 'Generates crisis communication messages for tourists in multiple languages',
                'template' => 'Generate crisis communication for tourists...',
                'variables' => json_encode(['event_details', 'severity', 'target_languages']),
                'is_active' => true,
                'created_at' => '2025-08-02 13:22:52',
                'updated_at' => '2025-08-02 13:22:52',
                'deleted_at' => null,
            ],
        ];

        foreach ($templates as $template) {
            DB::table('prompt_templates')->insert($template);
        }
    }
}