<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ContinentsSeeder extends Seeder
{
    public function run(): void
    {
        $continents = [
            [
                'id' => 1,
                'name_translations' => json_encode([
                    'en' => 'Europe',
                    'de' => 'Europa',
                    'es' => 'Europa',
                    'fr' => 'Europe',
                    'it' => 'Europa'
                ]),
                'code' => 'EU',
                'description' => 'Europa ist ein Kontinent, der sich von Island im äußersten Westen bis zu den Ural-Bergen in Russland im Osten erstreckt.',
                'keywords' => json_encode(['Europa', 'Europe', 'EU', 'Europäische Union']),
                'lat' => 54.5260,
                'lng' => 15.2551,
                'created_at' => now(),
                'updated_at' => now(),
                'deleted_at' => null,
            ],
            [
                'id' => 2,
                'name_translations' => json_encode([
                    'en' => 'Asia',
                    'de' => 'Asien',
                    'es' => 'Asia',
                    'fr' => 'Asie',
                    'it' => 'Asia'
                ]),
                'code' => 'AS',
                'description' => 'Asien ist der größte Kontinent der Erde, sowohl nach Fläche als auch nach Einwohnerzahl.',
                'keywords' => json_encode(['Asien', 'Asia', 'Fernost', 'Orient']),
                'lat' => 34.0479,
                'lng' => 100.6197,
                'created_at' => now(),
                'updated_at' => now(),
                'deleted_at' => null,
            ],
            [
                'id' => 3,
                'name_translations' => json_encode([
                    'en' => 'Africa',
                    'de' => 'Afrika',
                    'es' => 'África',
                    'fr' => 'Afrique',
                    'it' => 'Africa'
                ]),
                'code' => 'AF',
                'description' => 'Afrika ist der zweitgrößte und bevölkerungsreichste Kontinent der Erde.',
                'keywords' => json_encode(['Afrika', 'Africa', 'Schwarzer Kontinent']),
                'lat' => -8.7832,
                'lng' => 34.5085,
                'created_at' => now(),
                'updated_at' => now(),
                'deleted_at' => null,
            ],
            [
                'id' => 4,
                'name_translations' => json_encode([
                    'en' => 'North America',
                    'de' => 'Nordamerika',
                    'es' => 'América del Norte',
                    'fr' => 'Amérique du Nord',
                    'it' => 'America del Nord'
                ]),
                'code' => 'NA',
                'description' => 'Nordamerika ist ein Kontinent der nördlichen Hemisphäre.',
                'keywords' => json_encode(['Nordamerika', 'North America', 'USA', 'Kanada', 'Mexiko']),
                'lat' => 45.0000,
                'lng' => -100.0000,
                'created_at' => now(),
                'updated_at' => now(),
                'deleted_at' => null,
            ],
            [
                'id' => 5,
                'name_translations' => json_encode([
                    'en' => 'South America',
                    'de' => 'Südamerika',
                    'es' => 'América del Sur',
                    'fr' => 'Amérique du Sud',
                    'it' => 'America del Sud'
                ]),
                'code' => 'SA',
                'description' => 'Südamerika ist der südliche Teil des amerikanischen Doppelkontinents.',
                'keywords' => json_encode(['Südamerika', 'South America', 'Lateinamerika', 'Brasilien', 'Argentinien']),
                'lat' => -15.0000,
                'lng' => -60.0000,
                'created_at' => now(),
                'updated_at' => now(),
                'deleted_at' => null,
            ],
            [
                'id' => 6,
                'name_translations' => json_encode([
                    'en' => 'Australia/Oceania',
                    'de' => 'Australien/Ozeanien',
                    'es' => 'Australia/Oceanía',
                    'fr' => 'Australie/Océanie',
                    'it' => 'Australia/Oceania'
                ]),
                'code' => 'OC',
                'description' => 'Ozeanien umfasst Australien, Neuseeland und die Inselwelt des Pazifiks.',
                'keywords' => json_encode(['Australien', 'Ozeanien', 'Australia', 'Oceania', 'Pazifik']),
                'lat' => -25.2744,
                'lng' => 133.7751,
                'created_at' => now(),
                'updated_at' => now(),
                'deleted_at' => null,
            ],
            [
                'id' => 7,
                'name_translations' => json_encode([
                    'en' => 'Antarctica',
                    'de' => 'Antarktis',
                    'es' => 'Antártida',
                    'fr' => 'Antarctique',
                    'it' => 'Antartide'
                ]),
                'code' => 'AN',
                'description' => 'Die Antarktis ist der südlichste Kontinent der Erde und fast vollständig von Eis bedeckt.',
                'keywords' => json_encode(['Antarktis', 'Antarctica', 'Südpol', 'Eis']),
                'lat' => -82.8628,
                'lng' => 135.0000,
                'created_at' => now(),
                'updated_at' => now(),
                'deleted_at' => null,
            ]
        ];

        foreach ($continents as $continent) {
            DB::table('continents')->updateOrInsert(
                ['id' => $continent['id']],
                $continent
            );
        }
    }
}