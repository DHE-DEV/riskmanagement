<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_processing_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('disaster_event_id')->constrained('disaster_events')->cascadeOnDelete();
            $table->foreignId('prompt_template_id')->constrained('prompt_templates')->cascadeOnDelete();
            $table->text('input_text')->comment('Input text sent to AI');
            $table->text('output_text')->nullable()->comment('AI response output');
            $table->string('model_used', 50)->comment('AI model that was used');
            $table->unsignedInteger('tokens_used')->default(0)->comment('Number of tokens consumed');
            $table->float('processing_time')->default(0)->comment('Processing time in seconds');
            $table->enum('status', ['pending', 'success', 'failed'])->default('pending')->comment('Processing status');
            $table->text('error_message')->nullable()->comment('Error message if processing failed');
            $table->timestamps();
            $table->softDeletes();
            
            $table->index('disaster_event_id');
            $table->index('prompt_template_id');
            $table->index('status');
            $table->index('model_used');
            $table->index('created_at');
            $table->index(['disaster_event_id', 'created_at']);
            $table->index(['status', 'created_at']);
            $table->index(['prompt_template_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_processing_logs');
    }
};