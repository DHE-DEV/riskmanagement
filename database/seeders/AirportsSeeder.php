<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AirportsSeeder extends Seeder
{
    public function run(): void
    {
        $airports = $this->getAllAirports();
        
        foreach ($airports as $airport) {
            DB::table('airports')->updateOrInsert(
                ['iata_code' => $airport['iata_code']],
                $airport
            );
        }
    }

    private function getAllAirports(): array
    {
        return [
            // Europa - Vereinigtes Königreich (country_id: 17)
            ['name' => 'London Heathrow Airport', 'iata_code' => 'LHR', 'icao_code' => 'EGLL', 'city_id' => 1, 'country_id' => 17, 'lat' => 51.4700, 'lng' => -0.4543, 'altitude' => 25, 'timezone' => 'Europe/London', 'dst_timezone' => 'Europe/London', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'London Gatwick Airport', 'iata_code' => 'LGW', 'icao_code' => 'EGKK', 'city_id' => 1, 'country_id' => 17, 'lat' => 51.1481, 'lng' => -0.1903, 'altitude' => 202, 'timezone' => 'Europe/London', 'dst_timezone' => 'Europe/London', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'London Stansted Airport', 'iata_code' => 'STN', 'icao_code' => 'EGSS', 'city_id' => 1, 'country_id' => 17, 'lat' => 51.8849, 'lng' => 0.2345, 'altitude' => 348, 'timezone' => 'Europe/London', 'dst_timezone' => 'Europe/London', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'London Luton Airport', 'iata_code' => 'LTN', 'icao_code' => 'EGGW', 'city_id' => 1, 'country_id' => 17, 'lat' => 51.8747, 'lng' => -0.3683, 'altitude' => 526, 'timezone' => 'Europe/London', 'dst_timezone' => 'Europe/London', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Frankreich (country_id: 16)
            ['name' => 'Charles de Gaulle Airport', 'iata_code' => 'CDG', 'icao_code' => 'LFPG', 'city_id' => 2, 'country_id' => 16, 'lat' => 49.0097, 'lng' => 2.5479, 'altitude' => 392, 'timezone' => 'Europe/Paris', 'dst_timezone' => 'Europe/Paris', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Paris Orly Airport', 'iata_code' => 'ORY', 'icao_code' => 'LFPO', 'city_id' => 2, 'country_id' => 16, 'lat' => 48.7262, 'lng' => 2.3651, 'altitude' => 291, 'timezone' => 'Europe/Paris', 'dst_timezone' => 'Europe/Paris', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Deutschland (country_id: 12)
            ['name' => 'Frankfurt am Main Airport', 'iata_code' => 'FRA', 'icao_code' => 'EDDF', 'city_id' => 3, 'country_id' => 12, 'lat' => 50.0264, 'lng' => 8.5431, 'altitude' => 364, 'timezone' => 'Europe/Berlin', 'dst_timezone' => 'Europe/Berlin', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Munich Airport', 'iata_code' => 'MUC', 'icao_code' => 'EDDM', 'city_id' => 3, 'country_id' => 12, 'lat' => 48.3538, 'lng' => 11.7861, 'altitude' => 1487, 'timezone' => 'Europe/Berlin', 'dst_timezone' => 'Europe/Berlin', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Düsseldorf Airport', 'iata_code' => 'DUS', 'icao_code' => 'EDDL', 'city_id' => 3, 'country_id' => 12, 'lat' => 51.2895, 'lng' => 6.7668, 'altitude' => 147, 'timezone' => 'Europe/Berlin', 'dst_timezone' => 'Europe/Berlin', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Niederlande (country_id: 33)
            ['name' => 'Amsterdam Airport Schiphol', 'iata_code' => 'AMS', 'icao_code' => 'EHAM', 'city_id' => 4, 'country_id' => 33, 'lat' => 52.3086, 'lng' => 4.7639, 'altitude' => -11, 'timezone' => 'Europe/Amsterdam', 'dst_timezone' => 'Europe/Amsterdam', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Spanien (country_id: 1)
            ['name' => 'Adolfo Suárez Madrid-Barajas Airport', 'iata_code' => 'MAD', 'icao_code' => 'LEMD', 'city_id' => 5, 'country_id' => 1, 'lat' => 40.4936, 'lng' => -3.5668, 'altitude' => 2001, 'timezone' => 'Europe/Madrid', 'dst_timezone' => 'Europe/Madrid', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Barcelona-El Prat Airport', 'iata_code' => 'BCN', 'icao_code' => 'LEBL', 'city_id' => 5, 'country_id' => 1, 'lat' => 41.2971, 'lng' => 2.0785, 'altitude' => 12, 'timezone' => 'Europe/Madrid', 'dst_timezone' => 'Europe/Madrid', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Italien (country_id: 23)
            ['name' => 'Leonardo da Vinci-Fiumicino Airport', 'iata_code' => 'FCO', 'icao_code' => 'LIRF', 'city_id' => 6, 'country_id' => 23, 'lat' => 41.8003, 'lng' => 12.2389, 'altitude' => 13, 'timezone' => 'Europe/Rome', 'dst_timezone' => 'Europe/Rome', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Milan Malpensa Airport', 'iata_code' => 'MXP', 'icao_code' => 'LIMC', 'city_id' => 6, 'country_id' => 23, 'lat' => 45.6306, 'lng' => 8.7281, 'altitude' => 768, 'timezone' => 'Europe/Rome', 'dst_timezone' => 'Europe/Rome', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Schweiz (country_id: 9)
            ['name' => 'Zurich Airport', 'iata_code' => 'ZUR', 'icao_code' => 'LSZH', 'city_id' => 7, 'country_id' => 9, 'lat' => 47.4647, 'lng' => 8.5492, 'altitude' => 1416, 'timezone' => 'Europe/Zurich', 'dst_timezone' => 'Europe/Zurich', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Geneva Cointrin Airport', 'iata_code' => 'GVA', 'icao_code' => 'LSGG', 'city_id' => 7, 'country_id' => 9, 'lat' => 46.2381, 'lng' => 6.1089, 'altitude' => 1411, 'timezone' => 'Europe/Zurich', 'dst_timezone' => 'Europe/Zurich', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Österreich (country_id: 4)
            ['name' => 'Vienna International Airport', 'iata_code' => 'VIE', 'icao_code' => 'LOWW', 'city_id' => 8, 'country_id' => 4, 'lat' => 48.1103, 'lng' => 16.5697, 'altitude' => 600, 'timezone' => 'Europe/Vienna', 'dst_timezone' => 'Europe/Vienna', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Belgien (country_id: 6)
            ['name' => 'Brussels Airport', 'iata_code' => 'BRU', 'icao_code' => 'EBBR', 'city_id' => 9, 'country_id' => 6, 'lat' => 50.9014, 'lng' => 4.4844, 'altitude' => 184, 'timezone' => 'Europe/Brussels', 'dst_timezone' => 'Europe/Brussels', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Dänemark (country_id: 13)
            ['name' => 'Copenhagen Kastrup Airport', 'iata_code' => 'CPH', 'icao_code' => 'EKCH', 'city_id' => 10, 'country_id' => 13, 'lat' => 55.6181, 'lng' => 12.6561, 'altitude' => 17, 'timezone' => 'Europe/Copenhagen', 'dst_timezone' => 'Europe/Copenhagen', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Schweden (country_id: 40)
            ['name' => 'Stockholm Arlanda Airport', 'iata_code' => 'ARN', 'icao_code' => 'ESSA', 'city_id' => 11, 'country_id' => 40, 'lat' => 59.6519, 'lng' => 17.9186, 'altitude' => 137, 'timezone' => 'Europe/Stockholm', 'dst_timezone' => 'Europe/Stockholm', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Norwegen (country_id: 34)
            ['name' => 'Oslo Gardermoen Airport', 'iata_code' => 'OSL', 'icao_code' => 'ENGM', 'city_id' => 12, 'country_id' => 34, 'lat' => 60.1976, 'lng' => 11.1004, 'altitude' => 681, 'timezone' => 'Europe/Oslo', 'dst_timezone' => 'Europe/Oslo', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Finnland (country_id: 15)
            ['name' => 'Helsinki Vantaa Airport', 'iata_code' => 'HEL', 'icao_code' => 'EFHK', 'city_id' => 13, 'country_id' => 15, 'lat' => 60.3172, 'lng' => 24.9633, 'altitude' => 179, 'timezone' => 'Europe/Helsinki', 'dst_timezone' => 'Europe/Helsinki', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Irland (country_id: 21)
            ['name' => 'Dublin Airport', 'iata_code' => 'DUB', 'icao_code' => 'EIDW', 'city_id' => 14, 'country_id' => 21, 'lat' => 53.4213, 'lng' => -6.2701, 'altitude' => 242, 'timezone' => 'Europe/Dublin', 'dst_timezone' => 'Europe/Dublin', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Griechenland (country_id: 18)
            ['name' => 'Athens International Airport', 'iata_code' => 'ATH', 'icao_code' => 'LGAV', 'city_id' => 15, 'country_id' => 18, 'lat' => 37.9364, 'lng' => 23.9445, 'altitude' => 266, 'timezone' => 'Europe/Athens', 'dst_timezone' => 'Europe/Athens', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Portugal (country_id: 36)
            ['name' => 'Humberto Delgado Airport (Lisbon)', 'iata_code' => 'LIS', 'icao_code' => 'LPPT', 'city_id' => 16, 'country_id' => 36, 'lat' => 38.7813, 'lng' => -9.1363, 'altitude' => 374, 'timezone' => 'Europe/Lisbon', 'dst_timezone' => 'Europe/Lisbon', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Tschechische Republik (country_id: 11)
            ['name' => 'Václav Havel Airport Prague', 'iata_code' => 'PRG', 'icao_code' => 'LKPR', 'city_id' => 17, 'country_id' => 11, 'lat' => 50.1008, 'lng' => 14.2600, 'altitude' => 1247, 'timezone' => 'Europe/Prague', 'dst_timezone' => 'Europe/Prague', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Polen (country_id: 35)
            ['name' => 'Warsaw Chopin Airport', 'iata_code' => 'WAW', 'icao_code' => 'EPWA', 'city_id' => 18, 'country_id' => 35, 'lat' => 52.1657, 'lng' => 20.9671, 'altitude' => 362, 'timezone' => 'Europe/Warsaw', 'dst_timezone' => 'Europe/Warsaw', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Ungarn (country_id: 20)
            ['name' => 'Budapest Ferenc Liszt International Airport', 'iata_code' => 'BUD', 'icao_code' => 'LHBP', 'city_id' => 19, 'country_id' => 20, 'lat' => 47.4369, 'lng' => 19.2556, 'altitude' => 495, 'timezone' => 'Europe/Budapest', 'dst_timezone' => 'Europe/Budapest', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Rumänien (country_id: 37)
            ['name' => 'Henri Coandă International Airport', 'iata_code' => 'OTP', 'icao_code' => 'LROP', 'city_id' => 20, 'country_id' => 37, 'lat' => 44.5711, 'lng' => 26.0850, 'altitude' => 314, 'timezone' => 'Europe/Bucharest', 'dst_timezone' => 'Europe/Bucharest', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Türkei (country_id: 87)
            ['name' => 'Istanbul Airport', 'iata_code' => 'IST', 'icao_code' => 'LTFM', 'city_id' => 21, 'country_id' => 87, 'lat' => 41.2753, 'lng' => 28.7519, 'altitude' => 325, 'timezone' => 'Europe/Istanbul', 'dst_timezone' => 'Europe/Istanbul', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Sabiha Gökçen International Airport', 'iata_code' => 'SAW', 'icao_code' => 'LTFJ', 'city_id' => 21, 'country_id' => 87, 'lat' => 40.8986, 'lng' => 29.3092, 'altitude' => 312, 'timezone' => 'Europe/Istanbul', 'dst_timezone' => 'Europe/Istanbul', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Europa - Russland (country_id: 39)
            ['name' => 'Sheremetyevo International Airport', 'iata_code' => 'SVO', 'icao_code' => 'UUEE', 'city_id' => 22, 'country_id' => 39, 'lat' => 55.9728, 'lng' => 37.4147, 'altitude' => 630, 'timezone' => 'Europe/Moscow', 'dst_timezone' => 'Europe/Moscow', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Domodedovo International Airport', 'iata_code' => 'DME', 'icao_code' => 'UUDD', 'city_id' => 22, 'country_id' => 39, 'lat' => 55.4088, 'lng' => 37.9063, 'altitude' => 588, 'timezone' => 'Europe/Moscow', 'dst_timezone' => 'Europe/Moscow', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Japan (country_id: 61)
            ['name' => 'Tokyo Haneda Airport', 'iata_code' => 'HND', 'icao_code' => 'RJTT', 'city_id' => 23, 'country_id' => 61, 'lat' => 35.5494, 'lng' => 139.7798, 'altitude' => 35, 'timezone' => 'Asia/Tokyo', 'dst_timezone' => 'Asia/Tokyo', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Narita International Airport', 'iata_code' => 'NRT', 'icao_code' => 'RJAA', 'city_id' => 23, 'country_id' => 61, 'lat' => 35.7647, 'lng' => 140.3864, 'altitude' => 141, 'timezone' => 'Asia/Tokyo', 'dst_timezone' => 'Asia/Tokyo', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - China (country_id: 53)
            ['name' => 'Beijing Capital International Airport', 'iata_code' => 'PEK', 'icao_code' => 'ZBAA', 'city_id' => 24, 'country_id' => 53, 'lat' => 40.0801, 'lng' => 116.5846, 'altitude' => 116, 'timezone' => 'Asia/Shanghai', 'dst_timezone' => 'Asia/Shanghai', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Shanghai Pudong International Airport', 'iata_code' => 'PVG', 'icao_code' => 'ZSPD', 'city_id' => 25, 'country_id' => 53, 'lat' => 31.1434, 'lng' => 121.8052, 'altitude' => 13, 'timezone' => 'Asia/Shanghai', 'dst_timezone' => 'Asia/Shanghai', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Hong Kong International Airport', 'iata_code' => 'HKG', 'icao_code' => 'VHHH', 'city_id' => 30, 'country_id' => 53, 'lat' => 22.3080, 'lng' => 113.9185, 'altitude' => 28, 'timezone' => 'Asia/Hong_Kong', 'dst_timezone' => 'Asia/Hong_Kong', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Indien (country_id: 57)
            ['name' => 'Indira Gandhi International Airport', 'iata_code' => 'DEL', 'icao_code' => 'VIDP', 'city_id' => 26, 'country_id' => 57, 'lat' => 28.5562, 'lng' => 77.1000, 'altitude' => 777, 'timezone' => 'Asia/Kolkata', 'dst_timezone' => 'Asia/Kolkata', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Chhatrapati Shivaji International Airport', 'iata_code' => 'BOM', 'icao_code' => 'VABB', 'city_id' => 27, 'country_id' => 57, 'lat' => 19.0896, 'lng' => 72.8656, 'altitude' => 39, 'timezone' => 'Asia/Kolkata', 'dst_timezone' => 'Asia/Kolkata', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Thailand (country_id: 83)
            ['name' => 'Suvarnabhumi Airport', 'iata_code' => 'BKK', 'icao_code' => 'VTBS', 'city_id' => 28, 'country_id' => 83, 'lat' => 13.6900, 'lng' => 100.7501, 'altitude' => 5, 'timezone' => 'Asia/Bangkok', 'dst_timezone' => 'Asia/Bangkok', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Singapur (country_id: 81)
            ['name' => 'Singapore Changi Airport', 'iata_code' => 'SIN', 'icao_code' => 'WSSS', 'city_id' => 29, 'country_id' => 81, 'lat' => 1.3644, 'lng' => 103.9915, 'altitude' => 22, 'timezone' => 'Asia/Singapore', 'dst_timezone' => 'Asia/Singapore', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Südkorea (country_id: 64)
            ['name' => 'Incheon International Airport', 'iata_code' => 'ICN', 'icao_code' => 'RKSI', 'city_id' => 31, 'country_id' => 64, 'lat' => 37.4691, 'lng' => 126.4505, 'altitude' => 23, 'timezone' => 'Asia/Seoul', 'dst_timezone' => 'Asia/Seoul', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Taiwan (country_id: 88)
            ['name' => 'Taiwan Taoyuan International Airport', 'iata_code' => 'TPE', 'icao_code' => 'RCTP', 'city_id' => 32, 'country_id' => 88, 'lat' => 25.0777, 'lng' => 121.2328, 'altitude' => 106, 'timezone' => 'Asia/Taipei', 'dst_timezone' => 'Asia/Taipei', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Philippinen (country_id: 76)
            ['name' => 'Ninoy Aquino International Airport', 'iata_code' => 'MNL', 'icao_code' => 'RPLL', 'city_id' => 33, 'country_id' => 76, 'lat' => 14.5086, 'lng' => 121.0194, 'altitude' => 75, 'timezone' => 'Asia/Manila', 'dst_timezone' => 'Asia/Manila', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Indonesien (country_id: 55)
            ['name' => 'Soekarno-Hatta International Airport', 'iata_code' => 'CGK', 'icao_code' => 'WIII', 'city_id' => 34, 'country_id' => 55, 'lat' => -6.1256, 'lng' => 106.6559, 'altitude' => 34, 'timezone' => 'Asia/Jakarta', 'dst_timezone' => 'Asia/Jakarta', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Malaysia (country_id: 73)
            ['name' => 'Kuala Lumpur International Airport', 'iata_code' => 'KUL', 'icao_code' => 'WMKK', 'city_id' => 35, 'country_id' => 73, 'lat' => 2.7456, 'lng' => 101.7099, 'altitude' => 69, 'timezone' => 'Asia/Kuala_Lumpur', 'dst_timezone' => 'Asia/Kuala_Lumpur', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Vietnam (country_id: 90)
            ['name' => 'Tan Son Nhat International Airport', 'iata_code' => 'SGN', 'icao_code' => 'VVTS', 'city_id' => 36, 'country_id' => 90, 'lat' => 10.8188, 'lng' => 106.6519, 'altitude' => 33, 'timezone' => 'Asia/Ho_Chi_Minh', 'dst_timezone' => 'Asia/Ho_Chi_Minh', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Katar (country_id: 79)
            ['name' => 'Hamad International Airport', 'iata_code' => 'DOH', 'icao_code' => 'OTHH', 'city_id' => 37, 'country_id' => 79, 'lat' => 25.2731, 'lng' => 51.6080, 'altitude' => 13, 'timezone' => 'Asia/Qatar', 'dst_timezone' => 'Asia/Qatar', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Dubai removed - UAE not in countries list, and Dubai city was also removed

            // Asien - Israel (country_id: 56)
            ['name' => 'Ben Gurion Airport', 'iata_code' => 'TLV', 'icao_code' => 'LLBG', 'city_id' => 39, 'country_id' => 56, 'lat' => 32.0114, 'lng' => 34.8867, 'altitude' => 135, 'timezone' => 'Asia/Jerusalem', 'dst_timezone' => 'Asia/Jerusalem', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Asien - Saudi-Arabien (country_id: 80)
            ['name' => 'King Khalid International Airport', 'iata_code' => 'RUH', 'icao_code' => 'OERK', 'city_id' => 40, 'country_id' => 80, 'lat' => 24.9576, 'lng' => 46.6988, 'altitude' => 2049, 'timezone' => 'Asia/Riyadh', 'dst_timezone' => 'Asia/Riyadh', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Afrika - Ägypten (country_id: 93)
            ['name' => 'Cairo International Airport', 'iata_code' => 'CAI', 'icao_code' => 'HECA', 'city_id' => 41, 'country_id' => 93, 'lat' => 30.1219, 'lng' => 31.4056, 'altitude' => 382, 'timezone' => 'Africa/Cairo', 'dst_timezone' => 'Africa/Cairo', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Afrika - Südafrika (country_id: 96)
            ['name' => 'OR Tambo International Airport', 'iata_code' => 'JNB', 'icao_code' => 'FAOR', 'city_id' => 42, 'country_id' => 96, 'lat' => -26.1392, 'lng' => 28.2460, 'altitude' => 5558, 'timezone' => 'Africa/Johannesburg', 'dst_timezone' => 'Africa/Johannesburg', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Cape Town International Airport', 'iata_code' => 'CPT', 'icao_code' => 'FACT', 'city_id' => 43, 'country_id' => 96, 'lat' => -33.9649, 'lng' => 18.6017, 'altitude' => 151, 'timezone' => 'Africa/Johannesburg', 'dst_timezone' => 'Africa/Johannesburg', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Afrika - Nigeria (country_id: 95)
            ['name' => 'Murtala Muhammed International Airport', 'iata_code' => 'LOS', 'icao_code' => 'DNMM', 'city_id' => 44, 'country_id' => 95, 'lat' => 6.5774, 'lng' => 3.3212, 'altitude' => 135, 'timezone' => 'Africa/Lagos', 'dst_timezone' => 'Africa/Lagos', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Afrika - Kenia (country_id: 97)
            ['name' => 'Jomo Kenyatta International Airport', 'iata_code' => 'NBO', 'icao_code' => 'HKJK', 'city_id' => 45, 'country_id' => 97, 'lat' => -1.3192, 'lng' => 36.9278, 'altitude' => 5327, 'timezone' => 'Africa/Nairobi', 'dst_timezone' => 'Africa/Nairobi', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Afrika - Marokko (country_id: 94)
            ['name' => 'Mohammed V International Airport', 'iata_code' => 'CMN', 'icao_code' => 'GMMN', 'city_id' => 46, 'country_id' => 94, 'lat' => 33.3675, 'lng' => -7.5899, 'altitude' => 656, 'timezone' => 'Africa/Casablanca', 'dst_timezone' => 'Africa/Casablanca', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Afrika - Äthiopien (country_id: 99)
            ['name' => 'Addis Ababa Bole International Airport', 'iata_code' => 'ADD', 'icao_code' => 'HAAB', 'city_id' => 47, 'country_id' => 99, 'lat' => 8.9781, 'lng' => 38.7999, 'altitude' => 7625, 'timezone' => 'Africa/Addis_Ababa', 'dst_timezone' => 'Africa/Addis_Ababa', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Nordamerika - USA (country_id: 101)
            ['name' => 'John F. Kennedy International Airport', 'iata_code' => 'JFK', 'icao_code' => 'KJFK', 'city_id' => 48, 'country_id' => 101, 'lat' => 40.6413, 'lng' => -73.7781, 'altitude' => 13, 'timezone' => 'America/New_York', 'dst_timezone' => 'America/New_York', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'LaGuardia Airport', 'iata_code' => 'LGA', 'icao_code' => 'KLGA', 'city_id' => 48, 'country_id' => 101, 'lat' => 40.7769, 'lng' => -73.8740, 'altitude' => 22, 'timezone' => 'America/New_York', 'dst_timezone' => 'America/New_York', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Los Angeles International Airport', 'iata_code' => 'LAX', 'icao_code' => 'KLAX', 'city_id' => 49, 'country_id' => 101, 'lat' => 33.9425, 'lng' => -118.4081, 'altitude' => 125, 'timezone' => 'America/Los_Angeles', 'dst_timezone' => 'America/Los_Angeles', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => "Chicago O'Hare International Airport", 'iata_code' => 'ORD', 'icao_code' => 'KORD', 'city_id' => 50, 'country_id' => 101, 'lat' => 41.9742, 'lng' => -87.9073, 'altitude' => 672, 'timezone' => 'America/Chicago', 'dst_timezone' => 'America/Chicago', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Miami International Airport', 'iata_code' => 'MIA', 'icao_code' => 'KMIA', 'city_id' => 51, 'country_id' => 101, 'lat' => 25.7932, 'lng' => -80.2906, 'altitude' => 8, 'timezone' => 'America/New_York', 'dst_timezone' => 'America/New_York', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'San Francisco International Airport', 'iata_code' => 'SFO', 'icao_code' => 'KSFO', 'city_id' => 52, 'country_id' => 101, 'lat' => 37.6213, 'lng' => -122.3790, 'altitude' => 13, 'timezone' => 'America/Los_Angeles', 'dst_timezone' => 'America/Los_Angeles', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Nordamerika - Kanada (country_id: 100)
            ['name' => 'Toronto Pearson International Airport', 'iata_code' => 'YYZ', 'icao_code' => 'CYYZ', 'city_id' => 53, 'country_id' => 100, 'lat' => 43.6777, 'lng' => -79.6248, 'altitude' => 569, 'timezone' => 'America/Toronto', 'dst_timezone' => 'America/Toronto', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Vancouver International Airport', 'iata_code' => 'YVR', 'icao_code' => 'CYVR', 'city_id' => 54, 'country_id' => 100, 'lat' => 49.1967, 'lng' => -123.1815, 'altitude' => 14, 'timezone' => 'America/Vancouver', 'dst_timezone' => 'America/Vancouver', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Montréal-Pierre Elliott Trudeau International Airport', 'iata_code' => 'YUL', 'icao_code' => 'CYUL', 'city_id' => 55, 'country_id' => 100, 'lat' => 45.4706, 'lng' => -73.7408, 'altitude' => 118, 'timezone' => 'America/Toronto', 'dst_timezone' => 'America/Toronto', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Nordamerika - Mexiko (country_id: 102)
            ['name' => 'Mexico City International Airport', 'iata_code' => 'MEX', 'icao_code' => 'MMMX', 'city_id' => 56, 'country_id' => 102, 'lat' => 19.4363, 'lng' => -99.0721, 'altitude' => 7316, 'timezone' => 'America/Mexico_City', 'dst_timezone' => 'America/Mexico_City', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Südamerika - Brasilien (country_id: 106)
            ['name' => 'São Paulo/Guarulhos–Governador André Franco Montoro International Airport', 'iata_code' => 'GRU', 'icao_code' => 'SBGR', 'city_id' => 57, 'country_id' => 106, 'lat' => -23.4356, 'lng' => -46.4731, 'altitude' => 2459, 'timezone' => 'America/Sao_Paulo', 'dst_timezone' => 'America/Sao_Paulo', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Rio de Janeiro–Galeão International Airport', 'iata_code' => 'GIG', 'icao_code' => 'SBGL', 'city_id' => 58, 'country_id' => 106, 'lat' => -22.8099, 'lng' => -43.2506, 'altitude' => 28, 'timezone' => 'America/Sao_Paulo', 'dst_timezone' => 'America/Sao_Paulo', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Südamerika - Argentinien (country_id: 105)
            ['name' => 'Ministro Pistarini International Airport', 'iata_code' => 'EZE', 'icao_code' => 'SAEZ', 'city_id' => 59, 'country_id' => 105, 'lat' => -34.8222, 'lng' => -58.5358, 'altitude' => 67, 'timezone' => 'America/Argentina/Buenos_Aires', 'dst_timezone' => 'America/Argentina/Buenos_Aires', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Südamerika - Peru (country_id: 109)
            ['name' => 'Jorge Chávez International Airport', 'iata_code' => 'LIM', 'icao_code' => 'SPJC', 'city_id' => 60, 'country_id' => 109, 'lat' => -12.0219, 'lng' => -77.1143, 'altitude' => 113, 'timezone' => 'America/Lima', 'dst_timezone' => 'America/Lima', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Südamerika - Chile (country_id: 107)
            ['name' => 'Arturo Merino Benítez International Airport', 'iata_code' => 'SCL', 'icao_code' => 'SCEL', 'city_id' => 61, 'country_id' => 107, 'lat' => -33.3970, 'lng' => -70.7943, 'altitude' => 1555, 'timezone' => 'America/Santiago', 'dst_timezone' => 'America/Santiago', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Südamerika - Kolumbien (country_id: 108)
            ['name' => 'El Dorado International Airport', 'iata_code' => 'BOG', 'icao_code' => 'SKBO', 'city_id' => 62, 'country_id' => 108, 'lat' => 4.7016, 'lng' => -74.1469, 'altitude' => 8361, 'timezone' => 'America/Bogota', 'dst_timezone' => 'America/Bogota', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Australien/Ozeanien - Australien (country_id: 112)
            ['name' => 'Sydney Kingsford Smith Airport', 'iata_code' => 'SYD', 'icao_code' => 'YSSY', 'city_id' => 63, 'country_id' => 112, 'lat' => -33.9399, 'lng' => 151.1753, 'altitude' => 21, 'timezone' => 'Australia/Sydney', 'dst_timezone' => 'Australia/Sydney', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Melbourne Airport', 'iata_code' => 'MEL', 'icao_code' => 'YMML', 'city_id' => 64, 'country_id' => 112, 'lat' => -37.6690, 'lng' => 144.8410, 'altitude' => 434, 'timezone' => 'Australia/Melbourne', 'dst_timezone' => 'Australia/Melbourne', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Brisbane Airport', 'iata_code' => 'BNE', 'icao_code' => 'YBBN', 'city_id' => 65, 'country_id' => 112, 'lat' => -27.3842, 'lng' => 153.1175, 'altitude' => 13, 'timezone' => 'Australia/Brisbane', 'dst_timezone' => 'Australia/Brisbane', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Perth Airport', 'iata_code' => 'PER', 'icao_code' => 'YPPH', 'city_id' => 66, 'country_id' => 112, 'lat' => -31.9403, 'lng' => 115.9669, 'altitude' => 67, 'timezone' => 'Australia/Perth', 'dst_timezone' => 'Australia/Perth', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],

            // Australien/Ozeanien - Neuseeland (country_id: 113)
            ['name' => 'Auckland Airport', 'iata_code' => 'AKL', 'icao_code' => 'NZAA', 'city_id' => 67, 'country_id' => 113, 'lat' => -37.0082, 'lng' => 174.7850, 'altitude' => 23, 'timezone' => 'Pacific/Auckland', 'dst_timezone' => 'Pacific/Auckland', 'type' => 'large_airport', 'source' => 'OurAirports', 'created_at' => now(), 'updated_at' => now()],
        ];
    }
}