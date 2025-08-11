<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;

// Main routes
Route::get('/', [HomeController::class, 'index'])->name('home');

// API routes for map data
Route::prefix('api')->group(function () {
    Route::get('events', [HomeController::class, 'getEventsData'])->name('api.events');
    Route::get('events/{id}', [HomeController::class, 'getEventDetails'])->name('api.events.details');
    Route::get('dashboard/stats', [HomeController::class, 'getDashboardStats'])->name('api.dashboard.stats');
    Route::post('refresh-gdacs', [HomeController::class, 'refreshGdacsData'])->name('api.refresh.gdacs');
    Route::get('gdacs-updates', [HomeController::class, 'gdacsUpdatesStream'])->name('api.gdacs.updates');
});
