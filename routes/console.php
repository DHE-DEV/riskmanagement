<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

// Schedule GDACS data import every 30 minutes
Schedule::command('gdacs:import')
    ->everyThirtyMinutes()
    ->withoutOverlapping()
    ->runInBackground()
    ->appendOutputTo(storage_path('logs/gdacs-import.log'));

// Schedule to show GDACS statistics daily at 8 AM
Schedule::command('gdacs:import --stats')
    ->dailyAt('08:00')
    ->appendOutputTo(storage_path('logs/gdacs-stats.log'));
