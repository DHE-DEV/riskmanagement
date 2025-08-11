<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_cost_alerts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->cascadeOnDelete();
            $table->foreignId('ai_quota_id')->nullable()->constrained('ai_quotas')->cascadeOnDelete();
            $table->enum('alert_type', ['cost_warning', 'cost_critical', 'quota_exceeded', 'error_threshold', 'system_health', 'daily_report', 'weekly_report'])->default('cost_warning');
            $table->enum('severity', ['info', 'warning', 'critical', 'emergency'])->default('warning');
            $table->string('title');
            $table->text('message');
            $table->string('trigger_source')->nullable();
            $table->decimal('threshold_value', 10, 2)->nullable();
            $table->decimal('current_value', 10, 2)->nullable();
            $table->decimal('limit_value', 10, 2)->nullable();
            $table->string('metric_type')->nullable();
            $table->json('context_data')->nullable();
            $table->string('model')->nullable();
            $table->string('provider')->nullable();
            $table->date('period_date')->nullable();
            $table->enum('status', ['pending', 'sent', 'delivered', 'failed', 'acknowledged', 'resolved'])->default('pending');
            $table->json('channels')->nullable();
            $table->json('delivery_status')->nullable();
            $table->text('delivery_error')->nullable();
            $table->timestamp('triggered_at')->nullable();
            $table->timestamp('sent_at')->nullable();
            $table->timestamp('acknowledged_at')->nullable();
            $table->timestamp('resolved_at')->nullable();
            $table->timestamp('expires_at')->nullable();
            $table->string('alert_key')->nullable();
            $table->integer('occurrence_count')->default(1);
            $table->timestamp('first_occurrence_at')->nullable();
            $table->timestamp('last_occurrence_at')->nullable();
            $table->json('actions_taken')->nullable();
            $table->text('notes')->nullable();
            $table->timestamps();
            
            $table->index(['user_id', 'alert_type', 'status']);
            $table->index(['alert_type', 'severity', 'status']);
            $table->index(['status', 'triggered_at']);
            $table->index(['alert_key', 'status']);
            $table->index(['expires_at', 'status']);
            $table->index(['period_date', 'alert_type']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_cost_alerts');
    }
};