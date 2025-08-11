<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\GdacsService;
use Exception;

class FetchGdacsData extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'gdacs:fetch {--force : Force fetch even if recently updated}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Fetch latest GDACS disaster data from external API';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle(GdacsService $gdacsService)
    {
        $this->info('Starting GDACS data fetch...');
        
        try {
            // Start timing
            $startTime = microtime(true);
            
            // Fetch and process events
            $results = $gdacsService->fetchAndProcessEvents();
            
            // Calculate execution time
            $executionTime = round(microtime(true) - $startTime, 2);
            
            // Display results
            $this->info("GDACS data fetch completed in {$executionTime} seconds:");
            $this->line("  - Total events processed: " . ($results['total_processed'] ?? 0));
            $this->line("  - New events created: " . ($results['new_events'] ?? 0));
            $this->line("  - Updated events: " . ($results['updated_events'] ?? 0));
            $this->line("  - Last update: " . now()->format('Y-m-d H:i:s'));
            
            // Log success
            \Log::info('GDACS data fetch completed successfully', [
                'execution_time' => $executionTime,
                'results' => $results,
                'timestamp' => now()
            ]);
            
            return Command::SUCCESS;
            
        } catch (Exception $e) {
            $this->error('Error fetching GDACS data: ' . $e->getMessage());
            
            // Log error
            \Log::error('GDACS data fetch failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
                'timestamp' => now()
            ]);
            
            return Command::FAILURE;
        }
    }
}