<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_quotas', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->enum('quota_type', ['global', 'user', 'model', 'endpoint'])->default('global');
            $table->string('resource_type');
            $table->string('resource_identifier')->nullable();
            $table->enum('period_type', ['hourly', 'daily', 'weekly', 'monthly', 'yearly'])->default('monthly');
            $table->unsignedInteger('limit_value')->default(0);
            $table->unsignedInteger('used_value')->default(0);
            $table->decimal('cost_limit', 10, 2)->nullable();
            $table->decimal('cost_used', 10, 2)->default(0);
            $table->decimal('cost_per_unit', 8, 6)->nullable();
            $table->boolean('auto_reset')->default(true);
            $table->datetime('period_start');
            $table->datetime('period_end');
            $table->datetime('last_reset_at')->nullable();
            $table->json('alert_thresholds')->nullable();
            $table->json('alert_settings')->nullable();
            $table->enum('status', ['active', 'suspended', 'exceeded', 'expired'])->default('active');
            $table->boolean('enforce_limit')->default(true);
            $table->text('notes')->nullable();
            $table->json('metadata')->nullable();
            $table->timestamps();
            $table->softDeletes();
            
            $table->index('quota_type');
            $table->index('resource_type');
            $table->index('resource_identifier');
            $table->index('period_type');
            $table->index('status');
            $table->index('period_start');
            $table->index('period_end');
            $table->index(['quota_type', 'resource_type']);
            $table->index(['status', 'enforce_limit']);
            $table->index(['period_start', 'period_end']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_quotas');
    }
};