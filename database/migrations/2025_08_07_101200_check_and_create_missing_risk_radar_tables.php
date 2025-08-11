<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Check existing tables and only create what's missing
        $this->ensureContinentsTable();
        $this->ensureCountriesTable();
        $this->ensureRegionsTable();
        $this->ensureCitiesTable();
        $this->ensureAirportsTable();
    }

    public function down(): void
    {
        // Only drop tables that were created by this migration
        $tablesToDrop = ['continents', 'countries', 'regions', 'cities', 'airports'];
        
        foreach (array_reverse($tablesToDrop) as $table) {
            Schema::dropIfExists($table);
        }
    }

    private function ensureContinentsTable(): void
    {
        if (!Schema::hasTable('continents')) {
            Schema::create('continents', function (Blueprint $table) {
                $table->id();
                $table->json('name_translations');
                $table->string('code', 5);
                $table->text('description')->nullable();
                $table->text('keywords')->nullable();
                $table->decimal('lat', 10, 8)->nullable();
                $table->decimal('lng', 11, 8)->nullable();
                $table->timestamps();
                $table->softDeletes();
            });
        }
    }

    private function ensureCountriesTable(): void
    {
        if (!Schema::hasTable('countries')) {
            Schema::create('countries', function (Blueprint $table) {
                $table->id();
                $table->string('iso_code', 2);
                $table->string('iso3_code', 3);
                $table->json('name_translations');
                $table->boolean('is_eu_member')->default(false);
                $table->string('currency_code', 3)->nullable();
                $table->string('currency_name')->nullable();
                $table->string('currency_symbol', 5)->nullable();
                $table->string('phone_prefix', 10)->nullable();
                $table->json('languages')->nullable();
                $table->string('timezone')->nullable();
                $table->json('risk_factors')->nullable();
                $table->json('travel_advisories')->nullable();
                $table->json('climate_zones')->nullable();
                $table->unsignedInteger('population')->nullable();
                $table->decimal('area_km2', 12, 2)->nullable();
                $table->decimal('lat', 10, 8)->nullable();
                $table->decimal('lng', 11, 8)->nullable();
                $table->foreignId('continent_id')->constrained('continents');
                $table->timestamps();
                $table->softDeletes();
                
                $table->index('iso_code');
                $table->index('iso3_code');
                $table->index('continent_id');
            });
        }
    }

    private function ensureRegionsTable(): void
    {
        if (!Schema::hasTable('regions')) {
            Schema::create('regions', function (Blueprint $table) {
                $table->id();
                $table->json('name_translations');
                $table->string('code', 10);
                $table->foreignId('country_id')->constrained('countries');
                $table->text('description')->nullable();
                $table->json('keywords')->nullable();
                $table->decimal('lat', 10, 8)->nullable();
                $table->decimal('lng', 11, 8)->nullable();
                $table->timestamps();
                $table->softDeletes();
                
                $table->index('code');
                $table->index('country_id');
            });
        }
    }

    private function ensureCitiesTable(): void
    {
        if (!Schema::hasTable('cities')) {
            Schema::create('cities', function (Blueprint $table) {
                $table->id();
                $table->json('name_translations');
                $table->foreignId('country_id')->constrained('countries');
                $table->foreignId('region_id')->nullable()->constrained('regions');
                $table->unsignedInteger('population')->nullable();
                $table->decimal('lat', 10, 8)->nullable();
                $table->decimal('lng', 11, 8)->nullable();
                $table->timestamps();
                $table->softDeletes();
                
                $table->index('country_id');
                $table->index('region_id');
            });
        }
    }

    private function ensureAirportsTable(): void
    {
        if (!Schema::hasTable('airports')) {
            Schema::create('airports', function (Blueprint $table) {
                $table->id();
                $table->string('name');
                $table->string('iata_code', 3)->nullable();
                $table->string('icao_code', 4)->nullable();
                $table->foreignId('city_id')->constrained('cities');
                $table->foreignId('country_id')->constrained('countries');
                $table->decimal('lat', 10, 8)->nullable();
                $table->decimal('lng', 11, 8)->nullable();
                $table->integer('altitude')->nullable();
                $table->string('timezone')->nullable();
                $table->string('dst_timezone')->nullable();
                $table->string('type', 50)->nullable();
                $table->string('source', 50)->nullable();
                $table->timestamps();
                $table->softDeletes();
                
                $table->index('iata_code');
                $table->index('icao_code');
                $table->index('city_id');
                $table->index('country_id');
            });
        }
    }
};
