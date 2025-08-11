<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('disaster_events', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->enum('severity', ['low', 'medium', 'high', 'critical'])->default('low');
            $table->enum('event_type', ['earthquake', 'hurricane', 'flood', 'wildfire', 'volcano', 'tsunami', 'drought', 'tornado', 'other'])->default('other');
            $table->decimal('lat', 10, 8)->nullable();
            $table->decimal('lng', 11, 8)->nullable();
            $table->decimal('radius_km', 8, 2)->nullable();
            $table->foreignId('country_id')->nullable()->constrained('countries');
            $table->foreignId('region_id')->nullable()->constrained('regions');
            $table->foreignId('city_id')->nullable()->constrained('cities');
            $table->json('affected_areas')->nullable();
            $table->date('event_date');
            $table->dateTime('start_time')->nullable();
            $table->dateTime('end_time')->nullable();
            $table->boolean('is_active')->default(true);
            $table->json('impact_assessment')->nullable();
            $table->json('travel_recommendations')->nullable();
            $table->text('official_sources')->nullable();
            $table->text('media_coverage')->nullable();
            $table->json('tourism_impact')->nullable();
            $table->json('external_sources');
            $table->dateTime('last_updated');
            $table->integer('confidence_score')->default(0);
            $table->enum('processing_status', ['pending', 'processed', 'failed', 'none'])->default('none');
            $table->text('ai_summary')->nullable();
            $table->text('ai_recommendations')->nullable();
            $table->text('crisis_communication')->nullable();
            $table->json('keywords')->nullable();
            $table->integer('magnitude')->nullable();
            $table->text('casualties')->nullable();
            $table->text('economic_impact')->nullable();
            $table->text('infrastructure_damage')->nullable();
            $table->text('emergency_response')->nullable();
            $table->text('recovery_status')->nullable();
            $table->string('external_id')->nullable();
            $table->json('weather_conditions')->nullable();
            $table->json('evacuation_info')->nullable();
            $table->json('transportation_impact')->nullable();
            $table->json('accommodation_impact')->nullable();
            $table->json('communication_status')->nullable();
            $table->json('health_services_status')->nullable();
            $table->json('utility_services_status')->nullable();
            $table->json('border_crossings_status')->nullable();
            $table->timestamps();
            
            $table->index('event_type');
            $table->index('severity');
            $table->index('event_date');
            $table->index('is_active');
            $table->index('processing_status');
            $table->index('external_id');
            $table->index(['event_type', 'severity']);
            $table->index(['event_date', 'severity']);
            $table->index(['country_id', 'event_date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('disaster_events');
    }
};