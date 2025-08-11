<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
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

    public function down(): void
    {
        Schema::dropIfExists('airports');
    }
};