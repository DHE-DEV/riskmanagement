<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
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

    public function down(): void
    {
        Schema::dropIfExists('cities');
    }
};