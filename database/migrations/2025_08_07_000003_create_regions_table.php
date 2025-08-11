<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
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

    public function down(): void
    {
        Schema::dropIfExists('regions');
    }
};