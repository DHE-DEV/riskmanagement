<?php

namespace App\Console\Commands;

use App\Services\GdacsService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;

class ImportGdacsEvents extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'gdacs:import 
                           {--force : Force import even if recent import exists}
                           {--dry-run : Show what would be imported without saving}
                           {--stats : Show current GDACS statistics}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Import disaster events from GDACS (Global Disaster Alert and Coordination System)';

    private GdacsService $gdacsService;

    public function __construct(GdacsService $gdacsService)
    {
        parent::__construct();
        $this->gdacsService = $gdacsService;
    }

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $startTime = microtime(true);

        // Show current statistics if requested
        if ($this->option('stats')) {
            $this->showStatistics();
            return 0;
        }

        $this->info('🌍 Starting GDACS Events Import');
        $this->info('=====================================');

        // Check for dry run mode
        if ($this->option('dry-run')) {
            $this->warn('🧪 DRY RUN MODE - No data will be saved');
        }

        try {
            // Display current time and source
            $this->info('📅 Import Time: ' . now()->format('Y-m-d H:i:s T'));
            $this->info('🔗 Source: https://www.gdacs.org/xml/rss.xml');
            
            $this->newLine();

            // Start progress indication
            $this->info('📡 Fetching GDACS RSS feed...');
            
            if ($this->option('dry-run')) {
                $this->warn('   ⚠️  Dry run mode: would fetch and process data');
                $stats = ['total' => 0, 'new' => 0, 'updated' => 0, 'skipped' => 0];
            } else {
                // Perform the actual import
                $stats = $this->gdacsService->fetchAndProcessEvents();
            }

            $this->newLine();
            $this->displayResults($stats, $startTime);
            
            // Show updated statistics
            $this->newLine();
            $this->info('📊 Updated Database Statistics:');
            $this->showStatistics();

            return 0;

        } catch (\Exception $e) {
            $this->error('❌ Import failed: ' . $e->getMessage());
            
            Log::error('GDACS import command failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return 1;
        }
    }

    /**
     * Display import results
     */
    private function displayResults(array $stats, float $startTime): void
    {
        $duration = round(microtime(true) - $startTime, 2);
        
        $this->info('✅ Import completed successfully!');
        $this->table(
            ['Metric', 'Count'],
            [
                ['Total Events Processed', $stats['total']],
                ['New Events Created', $stats['new']],
                ['Existing Events Updated', $stats['updated']],
                ['Events Skipped (no changes)', $stats['skipped']],
                ['Duration (seconds)', $duration],
            ]
        );

        // Show performance metrics
        if ($stats['total'] > 0) {
            $eventsPerSecond = round($stats['total'] / $duration, 2);
            $this->info("⚡ Performance: {$eventsPerSecond} events/second");
        }

        // Show warnings for important events
        if ($stats['new'] > 10) {
            $this->warn("⚠️  High number of new events detected ({$stats['new']}). Please review for significant disasters.");
        }
    }

    /**
     * Show current GDACS statistics
     */
    private function showStatistics(): void
    {
        try {
            $stats = $this->gdacsService->getStatistics();
            
            $this->info('📊 Current GDACS Database Statistics:');
            $this->table(
                ['Metric', 'Value'],
                [
                    ['Total GDACS Events', number_format($stats['total_events'])],
                    ['Active Events', number_format($stats['active_events'])],
                    ['Last Update', $stats['last_update'] ? \Carbon\Carbon::parse($stats['last_update'])->diffForHumans() : 'Never'],
                ]
            );

            // Alert levels breakdown
            if (!empty($stats['by_alert_level'])) {
                $this->newLine();
                $this->info('🚨 Events by Alert Level:');
                $alertData = [];
                foreach ($stats['by_alert_level'] as $level => $count) {
                    $alertData[] = [$level ?: 'Unknown', number_format($count)];
                }
                $this->table(['Alert Level', 'Count'], $alertData);
            }

            // Event types breakdown
            if (!empty($stats['by_event_type'])) {
                $this->newLine();
                $this->info('🌪️ Events by Type:');
                $typeData = [];
                foreach ($stats['by_event_type'] as $type => $count) {
                    $typeData[] = [ucfirst($type), number_format($count)];
                }
                $this->table(['Event Type', 'Count'], $typeData);
            }

        } catch (\Exception $e) {
            $this->error('Failed to retrieve statistics: ' . $e->getMessage());
        }
    }
}
