<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_language_preferences', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->string('language_code', 5);
            $table->string('country_code', 2)->nullable();
            $table->string('timezone')->nullable();
            $table->json('notification_preferences')->nullable();
            $table->boolean('is_primary')->default(false);
            $table->timestamps();
            
            $table->unique(['user_id', 'language_code']);
            $table->index('user_id');
            $table->index('language_code');
            $table->index(['user_id', 'is_primary']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_language_preferences');
    }
};