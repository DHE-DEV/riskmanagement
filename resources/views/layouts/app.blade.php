<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="h-full overflow-hidden">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>@yield('title', 'Risk Management System')</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=inter:400,500,600,700,800&display=swap" rel="stylesheet" />

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
          integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
          crossorigin=""/>
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="{{ asset('css/custom.css') }}" rel="stylesheet">
    
    <style>
        /* Critical layout fixes */
        * {
            box-sizing: border-box;
        }
        
        html {
            height: 100%;
            overflow: hidden;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            height: 100%;
            overflow: hidden;
            margin: 0;
            padding: 0;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
        
        /* Pulsing animation for event markers - DISABLED */
        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        .pulse-marker {
            /* animation: pulse 2s infinite; - DISABLED */
        }
        
        .pulse-marker-fast {
            /* animation: pulse 1s infinite; - DISABLED */
        }
        
        .pulse-marker-slow {
            /* animation: pulse 3s infinite; - DISABLED */
        }
        
        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 3px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
        
        /* Loading spinner */
        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #3498db;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Map container */
        .map-container {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            overflow: hidden;
        }
        
        /* Main layout */
        .main-container {
            position: absolute;
            top: 64px;
            left: 0;
            right: 0;
            bottom: 0;
            overflow: hidden;
        }
        
        /* Custom popup styles */
        .leaflet-popup-content-wrapper {
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .leaflet-popup-content {
            margin: 0;
            padding: 0;
        }
        
        /* Alert level colors */
        .alert-green { 
            background-color: #22c55e; 
            color: white;
        }
        .alert-orange { 
            background-color: #f97316; 
            color: white;
        }
        .alert-red { 
            background-color: #ef4444; 
            color: white;
        }
        
        /* Event type icons colors */
        .event-earthquake { color: #8b5cf6; }
        .event-hurricane { color: #06b6d4; }
        .event-flood { color: #3b82f6; }
        .event-wildfire { color: #f97316; }
        .event-volcano { color: #dc2626; }
        .event-drought { color: #eab308; }
        .event-other { color: #6b7280; }
        
        /* Update notification animations */
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    </style>
    
    @stack('styles')
</head>

<body class="h-full bg-gray-50 overflow-hidden">
    <!-- Navigation -->
    <nav class="bg-white shadow-sm border-b border-gray-200 fixed top-0 left-0 right-0" style="z-index: 1100;">
        <div class="max-w-full mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <!-- Mobile menu button -->
                    <button id="mobile-menu-button" class="md:hidden mr-3 p-2 rounded-md text-gray-600 hover:bg-gray-100">
                        <i class="fas fa-bars"></i>
                    </button>
                    
                    <div class="flex-shrink-0">
                        <h1 class="text-xl font-bold text-gray-900 flex items-center">
                            <img src="{{ asset('images/logo.png') }}" alt="Logo" class="h-8 w-8 mr-2">
                            <span class="hidden sm:inline">Risk Management System</span>
                            <span class="sm:hidden">RMS</span>
                        </h1>
                    </div>
                </div>
                
                <div class="flex items-center space-x-4">
                    <!-- Country Search -->
                    <div class="relative hidden lg:block country-search-container">
                        <div class="flex items-center relative">
                            <i class="fas fa-search text-gray-400 absolute left-3 top-1/2 transform -translate-y-1/2 z-10"></i>
                            <input 
                                type="text" 
                                id="country-search"
                                placeholder="Land suchen..."
                                class="pl-10 pr-10 py-2 w-56 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                autocomplete="off"
                            >
                            <button 
                                id="clear-search"
                                type="button"
                                class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600 z-10 hidden"
                                title="Suche löschen"
                            >
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        <div id="country-dropdown" class="absolute top-full left-0 right-0 bg-white border border-gray-300 rounded-lg shadow-xl max-h-60 overflow-y-auto hidden" style="z-index: 9999; margin-top: 4px;">
                            <!-- Search results will appear here -->
                        </div>
                    </div>
                    
                    <button id="refresh-data" class="p-2 text-gray-600 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors">
                        <i class="fas fa-sync-alt"></i>
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main style="position: absolute; top: 64px; left: 0; right: 0; bottom: 0; overflow: hidden;">
        @yield('content')
    </main>

    <!-- Loading overlay -->
    <div id="loading-overlay" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
        <div class="bg-white p-6 rounded-lg shadow-xl flex items-center space-x-3">
            <div class="spinner"></div>
            <span class="text-gray-700">Loading events...</span>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
            integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
            crossorigin=""></script>
    
    <!-- Chart.js DISABLED for stability -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->
    
    @stack('scripts')
</body>
</html>