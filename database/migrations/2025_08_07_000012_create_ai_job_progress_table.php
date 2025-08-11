<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_job_progress', function (Blueprint $table) {
            $table->id();
            $table->string('job_id')->unique();
            $table->string('batch_id')->nullable();
            $table->string('type')->default('single');
            $table->string('status')->default('pending');
            $table->integer('total_items')->default(1);
            $table->integer('processed_items')->default(0);
            $table->integer('failed_items')->default(0);
            $table->decimal('progress_percentage', 5, 2)->default(0);
            $table->json('metadata')->nullable();
            $table->json('error_details')->nullable();
            $table->integer('tokens_used')->default(0);
            $table->decimal('cost_accumulated', 10, 4)->default(0);
            $table->timestamp('started_at')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->timestamps();
            
            $table->index(['status', 'type']);
            $table->index(['batch_id', 'status']);
            $table->index('created_at');
            $table->index('batch_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_job_progress');
    }
};