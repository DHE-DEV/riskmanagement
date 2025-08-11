<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_usage_tracking', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->cascadeOnDelete();
            $table->string('session_id')->nullable();
            $table->string('request_id')->nullable();
            $table->string('model_name');
            $table->string('provider');
            $table->string('endpoint');
            $table->enum('operation_type', ['classification', 'synthesis', 'communication', 'analysis', 'other'])->default('other');
            $table->json('request_data')->nullable();
            $table->json('response_data')->nullable();
            $table->integer('input_tokens');
            $table->integer('output_tokens');
            $table->integer('total_tokens');
            $table->decimal('cost_usd', 10, 6);
            $table->float('processing_time');
            $table->enum('status', ['success', 'failed', 'timeout', 'cancelled'])->default('success');
            $table->text('error_message')->nullable();
            $table->integer('retry_count')->default(0);
            $table->json('metadata')->nullable();
            $table->timestamps();
            
            $table->index('user_id');
            $table->index('session_id');
            $table->index('model_name');
            $table->index('provider');
            $table->index('operation_type');
            $table->index('status');
            $table->index('created_at');
            $table->index(['user_id', 'created_at']);
            $table->index(['model_name', 'provider']);
            $table->index(['operation_type', 'status']);
            $table->index(['created_at', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_usage_tracking');
    }
};