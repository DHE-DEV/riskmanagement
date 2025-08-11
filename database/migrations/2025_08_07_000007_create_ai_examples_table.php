<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_examples', function (Blueprint $table) {
            $table->id();
            $table->string('title')->comment('Example description');
            $table->text('input_text')->comment('Input text for the example');
            $table->text('expected_output')->comment('Expected output for the example');
            $table->foreignId('prompt_template_id')->nullable()->constrained('prompt_templates')->nullOnDelete();
            $table->boolean('is_active')->default(true)->comment('Active status');
            $table->timestamps();
            $table->softDeletes();
            
            $table->index('is_active');
            $table->index('prompt_template_id');
            $table->index(['prompt_template_id', 'is_active']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_examples');
    }
};