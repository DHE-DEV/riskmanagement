<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

// Schedule GDACS data import every 15 minutes
Schedule::command('gdacs:import')
    ->everyFifteenMinutes()
    ->withoutOverlapping()
    ->onOneServer()
    ->runInBackground()
    ->appendOutputTo(storage_path('logs/gdacs-import.log'))
    ->emailOutputOnFailure(env('ADMIN_EMAIL'));

// Schedule to show GDACS statistics daily at 8 AM
Schedule::command('gdacs:import --stats')
    ->dailyAt('08:00')
    ->appendOutputTo(storage_path('logs/gdacs-stats.log'));
