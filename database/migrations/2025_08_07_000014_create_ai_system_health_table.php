<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_system_health', function (Blueprint $table) {
            $table->id();
            $table->string('service_name');
            $table->string('provider');
            $table->string('model_name')->nullable();
            $table->string('endpoint');
            $table->enum('status', ['healthy', 'degraded', 'unhealthy', 'unknown'])->default('unknown');
            $table->float('response_time_ms')->nullable();
            $table->integer('success_rate_percentage')->nullable();
            $table->integer('error_count_last_hour')->default(0);
            $table->integer('request_count_last_hour')->default(0);
            $table->decimal('cost_last_hour', 8, 4)->default(0);
            $table->json('error_details')->nullable();
            $table->json('performance_metrics')->nullable();
            $table->json('quota_status')->nullable();
            $table->text('health_message')->nullable();
            $table->timestamp('last_check_at');
            $table->timestamp('last_success_at')->nullable();
            $table->timestamp('last_failure_at')->nullable();
            $table->json('configuration')->nullable();
            $table->json('metadata')->nullable();
            $table->timestamps();
            
            $table->index('service_name');
            $table->index('provider');
            $table->index('status');
            $table->index('last_check_at');
            $table->index(['service_name', 'provider']);
            $table->index(['status', 'last_check_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_system_health');
    }
};