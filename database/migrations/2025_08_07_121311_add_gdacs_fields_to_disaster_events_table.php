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
        Schema::table('disaster_events', function (Blueprint $table) {
            $table->string('gdacs_event_id')->nullable()->after('external_id');
            $table->string('gdacs_episode_id')->nullable()->after('gdacs_event_id');
            $table->enum('gdacs_alert_level', ['Green', 'Orange', 'Red'])->nullable()->after('gdacs_episode_id');
            $table->integer('gdacs_alert_score')->nullable()->after('gdacs_alert_level');
            $table->string('gdacs_episode_alert_level')->nullable()->after('gdacs_alert_score');
            $table->integer('gdacs_episode_alert_score')->nullable()->after('gdacs_episode_alert_level');
            $table->string('gdacs_event_name')->nullable()->after('gdacs_episode_alert_score');
            $table->string('gdacs_calculation_type')->nullable()->after('gdacs_event_name');
            $table->decimal('gdacs_severity_value', 8, 2)->nullable()->after('gdacs_calculation_type');
            $table->string('gdacs_severity_unit')->nullable()->after('gdacs_severity_value');
            $table->text('gdacs_severity_text')->nullable()->after('gdacs_severity_unit');
            $table->bigInteger('gdacs_population_value')->nullable()->after('gdacs_severity_text');
            $table->string('gdacs_population_unit')->nullable()->after('gdacs_population_value');
            $table->text('gdacs_population_text')->nullable()->after('gdacs_population_unit');
            $table->decimal('gdacs_vulnerability', 10, 6)->nullable()->after('gdacs_population_text');
            $table->string('gdacs_iso3')->nullable()->after('gdacs_vulnerability');
            $table->string('gdacs_country')->nullable()->after('gdacs_iso3');
            $table->string('gdacs_glide')->nullable()->after('gdacs_country');
            $table->json('gdacs_bbox')->nullable()->after('gdacs_glide');
            $table->text('gdacs_cap_url')->nullable()->after('gdacs_bbox');
            $table->text('gdacs_icon_url')->nullable()->after('gdacs_cap_url');
            $table->integer('gdacs_version')->nullable()->after('gdacs_icon_url');
            $table->boolean('gdacs_temporary')->default(false)->after('gdacs_version');
            $table->boolean('gdacs_is_current')->default(true)->after('gdacs_temporary');
            $table->integer('gdacs_duration_weeks')->nullable()->after('gdacs_is_current');
            $table->json('gdacs_resources')->nullable()->after('gdacs_duration_weeks');
            $table->text('gdacs_map_image')->nullable()->after('gdacs_resources');
            $table->text('gdacs_map_link')->nullable()->after('gdacs_map_image');
            $table->dateTime('gdacs_date_added')->nullable()->after('gdacs_map_link');
            $table->dateTime('gdacs_date_modified')->nullable()->after('gdacs_date_added');
            
            $table->index('gdacs_event_id');
            $table->index('gdacs_episode_id');
            $table->index('gdacs_alert_level');
            $table->index('gdacs_alert_score');
            $table->index('gdacs_iso3');
            $table->index('gdacs_is_current');
            $table->unique(['gdacs_event_id', 'gdacs_episode_id'], 'unique_gdacs_event_episode');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('disaster_events', function (Blueprint $table) {
            $table->dropIndex(['gdacs_event_id', 'gdacs_episode_id']);
            $table->dropIndex(['gdacs_event_id']);
            $table->dropIndex(['gdacs_episode_id']);
            $table->dropIndex(['gdacs_alert_level']);
            $table->dropIndex(['gdacs_alert_score']);
            $table->dropIndex(['gdacs_iso3']);
            $table->dropIndex(['gdacs_is_current']);
            
            $table->dropColumn([
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
                'gdacs_date_modified'
            ]);
        });
    }
};
