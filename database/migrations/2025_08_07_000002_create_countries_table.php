<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
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

    public function down(): void
    {
        Schema::dropIfExists('countries');
    }
};