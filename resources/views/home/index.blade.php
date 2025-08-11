@extends('layouts.app')

@section('title', 'Global Disaster Events - Risk Management System')

@section('content')
<div style="display: flex; height: 100%; overflow: hidden;">
    <!-- Mobile overlay -->
    <div id="mobile-overlay" class="fixed inset-0 bg-black bg-opacity-50 z-30 md:hidden hidden"></div>
    
    <!-- Left Sidebar with statistics and filters -->
    <div id="sidebar" class="bg-white shadow-lg border-r border-gray-200 overflow-y-auto sidebar-scroll" 
         style="width: 320px; height: 100%; position: relative; flex-shrink: 0;">
         
        <!-- Hide sidebar on mobile, show via overlay -->
        <style>
            @media (max-width: 768px) {
                #sidebar {
                    position: absolute;
                    left: -320px;
                    z-index: 40;
                    transition: left 0.3s ease;
                }
                #sidebar.mobile-open {
                    left: 0;
                }
            }
        </style>
        <!-- Statistics Panel -->
        <div class="p-6 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-900 mb-4">
                <i class="fas fa-chart-bar mr-2 text-blue-600"></i>
                Live Statistiken
            </h2>
            
            <!-- Quick Stats Grid -->
            <div class="grid grid-cols-2 gap-4 mb-4">
                <div class="bg-blue-50 p-3 rounded-lg">
                    <div class="text-2xl font-bold text-blue-600" id="total-events">
                        {{ number_format($statistics['total_events'] ?? 0) }}
                    </div>
                    <div class="text-xs text-blue-800">Gesamt Events</div>
                </div>
                
                <div class="bg-green-50 p-3 rounded-lg">
                    <div class="text-2xl font-bold text-green-600" id="active-events">
                        {{ number_format($statistics['active_events'] ?? 0) }}
                    </div>
                    <div class="text-xs text-green-800">Aktive Events</div>
                </div>
                
                <div class="bg-yellow-50 p-3 rounded-lg">
                    <div class="text-2xl font-bold text-yellow-600" id="recent-events">0</div>
                    <div class="text-xs text-yellow-800">Letzte 7 Tage</div>
                </div>
                
                <div class="bg-red-50 p-3 rounded-lg">
                    <div class="text-2xl font-bold text-red-600" id="high-risk-events">0</div>
                    <div class="text-xs text-red-800">Hohes Risiko</div>
                </div>
            </div>

            <!-- Alert Level Chart - DISABLED -->
            <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-700 mb-2">Warnstufen</h3>
                <div class="bg-gray-100 p-4 rounded-lg text-center text-gray-500">
                    Diagramme für Stabilität deaktiviert
                </div>
            </div>

            <!-- Event Type Chart - DISABLED -->
            <div>
                <h3 class="text-sm font-medium text-gray-700 mb-2">Event-Typen</h3>
                <div class="bg-gray-100 p-4 rounded-lg text-center text-gray-500">
                    Diagramme für Stabilität deaktiviert
                </div>
            </div>
        </div>

        <!-- Filters Panel -->
        <div class="p-6 border-b border-gray-200">
            <h3 class="text-lg font-semibold text-gray-900 mb-4">
                <i class="fas fa-filter mr-2 text-blue-600"></i>
                Filter
            </h3>
            
            <!-- Alert Level Filter -->
            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-2">Warnstufe</label>
                <div class="space-y-2">
                    <label class="flex items-center">
                        <input type="checkbox" class="alert-filter h-4 w-4 text-red-600 focus:ring-red-500 border-gray-300 rounded" value="Red" checked>
                        <span class="ml-2 text-sm text-gray-700">
                            <span class="inline-block w-3 h-3 bg-red-500 rounded-full mr-2"></span>
                            Rot (Kritisch)
                        </span>
                    </label>
                    <label class="flex items-center">
                        <input type="checkbox" class="alert-filter h-4 w-4 text-orange-600 focus:ring-orange-500 border-gray-300 rounded" value="Orange" checked>
                        <span class="ml-2 text-sm text-gray-700">
                            <span class="inline-block w-3 h-3 bg-orange-500 rounded-full mr-2"></span>
                            Orange (Hoch)
                        </span>
                    </label>
                    <label class="flex items-center">
                        <input type="checkbox" class="alert-filter h-4 w-4 text-green-600 focus:ring-green-500 border-gray-300 rounded" value="Green" checked>
                        <span class="ml-2 text-sm text-gray-700">
                            <span class="inline-block w-3 h-3 bg-green-500 rounded-full mr-2"></span>
                            Grün (Niedrig)
                        </span>
                    </label>
                </div>
            </div>

            <!-- Event Type Filter -->
            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-2">Event-Typ</label>
                <select id="event-type-filter" class="w-full p-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                    <option value="all">Alle Typen</option>
                    <option value="earthquake">🌍 Erdbeben</option>
                    <option value="hurricane">🌪️ Hurrikan</option>
                    <option value="flood">🌊 Überschwemmung</option>
                    <option value="wildfire">🔥 Waldbrand</option>
                    <option value="volcano">🌋 Vulkan</option>
                    <option value="drought">🏜️ Dürre</option>
                </select>
            </div>

            <!-- Time Filter -->
            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-2">Zeitraum</label>
                <select id="time-filter" class="w-full p-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                    <option value="all">Alle</option>
                    <option value="24h">Letzte 24 Stunden</option>
                    <option value="7d">Letzte 7 Tage</option>
                    <option value="30d">Letzte 30 Tage</option>
                </select>
            </div>
            
            <!-- Map Controls -->
            <div class="p-6 border-b border-gray-200">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">
                    <i class="fas fa-map mr-2 text-blue-600"></i>
                    Karten-Steuerung
                </h3>
                
                <button 
                    id="center-map-button" 
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition-colors flex items-center justify-center"
                >
                    <i class="fas fa-crosshairs mr-2"></i>
                    Karte zentrieren
                </button>
            </div>
        </div>
    </div>

    <!-- Right Sidebar with Events List -->
    <div id="events-sidebar" class="bg-white shadow-lg border-r border-gray-200 overflow-y-auto sidebar-scroll" 
         style="width: 400px; height: 100%; position: relative; flex-shrink: 0;">
         
        <!-- Hide events sidebar on mobile -->
        <style>
            @media (max-width: 1024px) {
                #events-sidebar {
                    display: none;
                }
            }
        </style>
        
        <!-- Events List Header -->
        <div class="p-6 border-b border-gray-200 bg-gray-50">
            <h3 class="text-lg font-semibold text-gray-900 mb-2">
                <i class="fas fa-list mr-2 text-blue-600"></i>
                Aktuelle Ereignisse
                <span id="events-count" class="text-sm font-normal text-gray-500"></span>
            </h3>
            <p class="text-sm text-gray-600">Neueste Events zuerst</p>
        </div>
        
        <!-- Events List Content -->
        <div id="recent-events-list" class="p-4">
            <!-- Events will be loaded here -->
            <div class="text-center text-gray-500 py-8">
                <div class="spinner mx-auto mb-3"></div>
                <span>Lade Events...</span>
            </div>
        </div>
    </div>

    <!-- Main Map Area -->
    <div style="flex: 1; position: relative; overflow: hidden;">
        <!-- Map UI Layer (fixed positioning, independent of zoom) -->
        <div class="leaflet-control-container" style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; pointer-events: none; z-index: 1000;">
            <!-- Map Controls (top-right) -->
            <div class="leaflet-top leaflet-right" style="position: absolute; top: 20px; right: 20px; pointer-events: auto;">
                <div class="space-y-2">
                    <!-- Map Style Toggle -->
                    <div class="bg-white rounded-lg shadow-lg p-2">
                        <button id="toggle-satellite" class="w-10 h-10 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors">
                            <i class="fas fa-satellite"></i>
                        </button>
                    </div>
                    
                    <!-- Zoom Controls (custom) -->
                    <div class="bg-white rounded-lg shadow-lg p-2 space-y-1">
                        <button id="zoom-in" class="w-10 h-10 bg-gray-100 text-gray-700 rounded-md hover:bg-gray-200 transition-colors">
                            <i class="fas fa-plus"></i>
                        </button>
                        <button id="zoom-out" class="w-10 h-10 bg-gray-100 text-gray-700 rounded-md hover:bg-gray-200 transition-colors">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Map Legend (bottom-right) -->
            <div class="leaflet-bottom leaflet-right" style="position: absolute; bottom: 80px; right: 20px; pointer-events: auto;">
                <div class="bg-white rounded-lg shadow-lg p-4 max-w-xs">
                    <h4 class="font-semibold text-gray-900 mb-3">Legende</h4>
                    <div class="space-y-2 text-sm">
                        <div class="flex items-center">
                            <div class="w-4 h-4 bg-red-500 rounded-full mr-2"></div>
                            <span>Kritisches Risiko (Rot)</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 bg-orange-500 rounded-full mr-2"></div>
                            <span>Hohes Risiko (Orange)</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 bg-green-500 rounded-full mr-2"></div>
                            <span>Niedriges Risiko (Grün)</span>
                        </div>
                    </div>
                    <div class="mt-3 text-xs text-gray-500">
                        Auf Marker klicken für Details
                    </div>
                </div>
            </div>

            <!-- GDACS Last Update Info (bottom-left) -->
            <div class="leaflet-bottom leaflet-left" style="position: absolute; bottom: 80px; left: 20px; pointer-events: auto; z-index: 1000;">
                <div class="gdacs-info-panel">
                    <div class="flex items-center text-sm text-gray-600">
                        <i class="fas fa-database text-blue-500 mr-2"></i>
                        <div>
                            <div class="text-xs font-medium text-gray-700">GDACS Daten</div>
                            <div id="gdacs-last-update" class="text-xs text-gray-500">
                                Lade...
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- World Map -->
        <div id="world-map" style="position: absolute; top: 0; left: 0; right: 0; bottom: 0;"></div>
    </div>
</div>

<!-- Event Detail Modal -->
<div id="event-modal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[60] hidden">
    <div class="bg-white rounded-lg shadow-xl max-w-2xl w-full mx-4 max-h-[calc(100vh-8rem)] overflow-y-auto">
        <div class="p-6">
            <div class="flex justify-between items-start mb-4">
                <h2 id="modal-title" class="text-xl font-bold text-gray-900"></h2>
                <button id="close-modal" class="text-gray-400 hover:text-gray-600">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>
            
            <div id="modal-content">
                <!-- Event details will be loaded here -->
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Global variables
    let map;
    let eventsData = [];
    let filteredEvents = [];
    let markersLayer;
    let isSatelliteView = false;
    let alertLevelChart, eventTypeChart;
    
    // German country names mapping
    const countryMappings = {
        'Germany': 'Deutschland',
        'Austria': 'Österreich', 
        'Switzerland': 'Schweiz',
        'France': 'Frankreich',
        'Italy': 'Italien',
        'Spain': 'Spanien',
        'Portugal': 'Portugal',
        'Netherlands': 'Niederlande',
        'Belgium': 'Belgien',
        'Luxembourg': 'Luxemburg',
        'United Kingdom': 'Vereinigtes Königreich',
        'Ireland': 'Irland',
        'Denmark': 'Dänemark',
        'Sweden': 'Schweden',
        'Norway': 'Norwegen',
        'Finland': 'Finnland',
        'Poland': 'Polen',
        'Czech Republic': 'Tschechien',
        'Slovakia': 'Slowakei',
        'Hungary': 'Ungarn',
        'Romania': 'Rumänien',
        'Bulgaria': 'Bulgarien',
        'Croatia': 'Kroatien',
        'Slovenia': 'Slowenien',
        'Serbia': 'Serbien',
        'Bosnia and Herzegovina': 'Bosnien und Herzegowina',
        'Montenegro': 'Montenegro',
        'Albania': 'Albanien',
        'North Macedonia': 'Nordmazedonien',
        'Greece': 'Griechenland',
        'Turkey': 'Türkei',
        'Russia': 'Russland',
        'Ukraine': 'Ukraine',
        'Belarus': 'Weißrussland',
        'Lithuania': 'Litauen',
        'Latvia': 'Lettland',
        'Estonia': 'Estland',
        'United States': 'Vereinigte Staaten',
        'Canada': 'Kanada',
        'Mexico': 'Mexiko',
        'Brazil': 'Brasilien',
        'Argentina': 'Argentinien',
        'Chile': 'Chile',
        'Colombia': 'Kolumbien',
        'Venezuela': 'Venezuela',
        'Peru': 'Peru',
        'Ecuador': 'Ecuador',
        'China': 'China',
        'Japan': 'Japan',
        'South Korea': 'Südkorea',
        'North Korea': 'Nordkorea',
        'India': 'Indien',
        'Pakistan': 'Pakistan',
        'Bangladesh': 'Bangladesch',
        'Thailand': 'Thailand',
        'Vietnam': 'Vietnam',
        'Philippines': 'Philippinen',
        'Indonesia': 'Indonesien',
        'Malaysia': 'Malaysia',
        'Singapore': 'Singapur',
        'Australia': 'Australien',
        'New Zealand': 'Neuseeland',
        'South Africa': 'Südafrika',
        'Egypt': 'Ägypten',
        'Morocco': 'Marokko',
        'Algeria': 'Algerien',
        'Tunisia': 'Tunesien',
        'Libya': 'Libyen',
        'Sudan': 'Sudan',
        'Ethiopia': 'Äthiopien',
        'Kenya': 'Kenia',
        'Nigeria': 'Nigeria',
        'Ghana': 'Ghana',
        'Saudi Arabia': 'Saudi-Arabien',
        'Iran': 'Iran',
        'Iraq': 'Irak',
        'Israel': 'Israel',
        'Jordan': 'Jordanien',
        'Lebanon': 'Libanon',
        'Syria': 'Syrien',
        'Afghanistan': 'Afghanistan',
        'Myanmar': 'Myanmar',
        'Sri Lanka': 'Sri Lanka',
        'Nepal': 'Nepal'
    };
    
    // Country coordinates for map centering
    const countryCoordinates = {
        'Deutschland': [51.1657, 10.4515],
        'Österreich': [47.5162, 14.5501],
        'Schweiz': [46.8182, 8.2275],
        'Frankreich': [46.2276, 2.2137],
        'Italien': [41.8719, 12.5674],
        'Spanien': [40.4637, -3.7492],
        'Portugal': [39.3999, -8.2245],
        'Niederlande': [52.1326, 5.2913],
        'Belgien': [50.5039, 4.4699],
        'Luxemburg': [49.8153, 6.1296],
        'Vereinigtes Königreich': [55.3781, -3.4360],
        'Irland': [53.1424, -7.6921],
        'Dänemark': [56.2639, 9.5018],
        'Schweden': [60.1282, 18.6435],
        'Norwegen': [60.4720, 8.4689],
        'Finnland': [61.9241, 25.7482],
        'Polen': [51.9194, 19.1451],
        'Tschechien': [49.8175, 15.4730],
        'Slowakei': [48.6690, 19.6990],
        'Ungarn': [47.1625, 19.5033],
        'Rumänien': [45.9432, 24.9668],
        'Bulgarien': [42.7339, 25.4858],
        'Kroatien': [45.1000, 15.2000],
        'Slowenien': [46.1512, 14.9955],
        'Serbien': [44.0165, 21.0059],
        'Bosnien und Herzegowina': [43.9159, 17.6791],
        'Montenegro': [42.7087, 19.3744],
        'Albanien': [41.1533, 20.1683],
        'Nordmazedonien': [41.6086, 21.7453],
        'Griechenland': [39.0742, 21.8243],
        'Türkei': [38.9637, 35.2433],
        'Russland': [61.5240, 105.3188],
        'Ukraine': [48.3794, 31.1656],
        'Weißrussland': [53.7098, 27.9534],
        'Litauen': [55.1694, 23.8813],
        'Lettland': [56.8796, 24.6032],
        'Estland': [58.5953, 25.0136],
        'Vereinigte Staaten': [37.0902, -95.7129],
        'Kanada': [56.1304, -106.3468],
        'Mexiko': [23.6345, -102.5528],
        'Brasilien': [-14.2350, -51.9253],
        'Argentinien': [-38.4161, -63.6167],
        'Chile': [-35.6751, -71.5430],
        'Kolumbien': [4.5709, -74.2973],
        'Venezuela': [6.4238, -66.5897],
        'Peru': [-9.1900, -75.0152],
        'Ecuador': [-1.8312, -78.1834],
        'China': [35.8617, 104.1954],
        'Japan': [36.2048, 138.2529],
        'Südkorea': [35.9078, 127.7669],
        'Nordkorea': [40.3399, 127.5101],
        'Indien': [20.5937, 78.9629],
        'Pakistan': [30.3753, 69.3451],
        'Bangladesch': [23.6850, 90.3563],
        'Thailand': [15.8700, 100.9925],
        'Vietnam': [14.0583, 108.2772],
        'Philippinen': [12.8797, 121.7740],
        'Indonesien': [-0.7893, 113.9213],
        'Malaysia': [4.2105, 101.9758],
        'Singapur': [1.3521, 103.8198],
        'Australien': [-25.2744, 133.7751],
        'Neuseeland': [-40.9006, 174.8860],
        'Südafrika': [-30.5595, 22.9375],
        'Ägypten': [26.0975, 30.0444],
        'Marokko': [31.7917, -7.0926],
        'Algerien': [28.0339, 1.6596],
        'Tunesien': [33.8869, 9.5375],
        'Libyen': [26.3351, 17.2283],
        'Sudan': [12.8628, 30.2176],
        'Äthiopien': [9.1450, 40.4897],
        'Kenia': [-0.0236, 37.9062],
        'Nigeria': [9.0820, 8.6753],
        'Ghana': [7.9465, -1.0232],
        'Saudi-Arabien': [23.8859, 45.0792],
        'Iran': [32.4279, 53.6880],
        'Irak': [33.2232, 43.6793],
        'Israel': [31.0461, 34.8516],
        'Jordanien': [30.5852, 36.2384],
        'Libanon': [33.8547, 35.8623],
        'Syrien': [34.8021, 38.9968],
        'Afghanistan': [33.9391, 67.7100],
        'Myanmar': [21.9162, 95.9560],
        'Sri Lanka': [7.8731, 80.7718],
        'Nepal': [28.3949, 84.1240]
    };
    
    // Filter state
    let activeFilters = {
        alertLevels: ['Red', 'Orange', 'Green'],
        eventType: 'all',
        timeRange: 'all'
    };

    // Initialize the application
    initializeMap();
    loadEventsData();
    loadGdacsInfo(); // Load GDACS last update info
    // loadStatistics(); // DISABLED - no dynamic statistics
    setupEventListeners();
    setupCountrySearch();
    setupAutoRefresh(); // Setup automatic refresh polling

    // Initialize Leaflet map
    function initializeMap() {
        map = L.map('world-map', {
            center: [20, 0],
            zoom: 3,
            zoomControl: false,
            worldCopyJump: true
        });

        // Force map to resize after initialization
        setTimeout(() => {
            map.invalidateSize();
        }, 100);

        // Add German tile layer with German city/region names
        L.tileLayer('https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap Deutschland - Kartendaten © OpenStreetMap-Mitwirkende',
            maxZoom: 18,
            subdomains: ['a', 'b', 'c']
        }).addTo(map);

        // Initialize markers layer group
        markersLayer = L.layerGroup().addTo(map);
    }

    // Load events data from API
    async function loadEventsData() {
        try {
            showLoading(true);
            const response = await fetch('/api/events');
            const data = await response.json();
            
            eventsData = data.events;
            applyFilters(); // Apply current filters to loaded data
            updateRecentEventsList(); // Now enabled for the new events sidebar
            updateLiveStatistics(); // Update statistics immediately after loading data
            // updateLastUpdateTime(data.last_updated); // DISABLED
            
        } catch (error) {
            console.error('Error loading events:', error);
        } finally {
            showLoading(false);
        }
    }

    // Load GDACS information
    async function loadGdacsInfo() {
        console.log('Loading GDACS info...');
        try {
            const response = await fetch('/api/dashboard/stats');
            const data = await response.json();
            console.log('GDACS data received:', data);
            
            updateGdacsInfo(data);
            
        } catch (error) {
            console.error('Error loading GDACS info:', error);
            updateGdacsInfo({ last_update: 'Fehler beim Laden' });
        }
    }

    // Update GDACS info display
    function updateGdacsInfo(data) {
        const gdacsUpdateEl = document.getElementById('gdacs-last-update');
        console.log('Updating GDACS info element:', gdacsUpdateEl);
        
        if (gdacsUpdateEl) {
            const lastUpdate = data.last_update || 'Unbekannt';
            const updateText = `Letzte Aktualisierung: ${lastUpdate}`;
            gdacsUpdateEl.textContent = updateText;
            console.log('GDACS info updated with:', updateText);
        } else {
            console.error('GDACS update element not found!');
        }
    }

    // Load statistics
    async function loadStatistics() {
        try {
            const response = await fetch('/api/dashboard/stats');
            const data = await response.json();
            
            updateStatistics(data);
            updateCharts(data);
            
        } catch (error) {
            console.error('Error loading statistics:', error);
        }
    }

    // Update event markers on map
    function updateEventMarkers() {
        markersLayer.clearLayers();
        
        filteredEvents.forEach(event => {
            if (event.lat && event.lng) {
                const marker = createEventMarker(event);
                markersLayer.addLayer(marker);
            }
        });
    }

    // Create marker for event
    function createEventMarker(event) {
        const alertColor = getAlertColor(event.alert_level);
        // const pulseSpeed = getPulseSpeed(event.alert_level); // DISABLED
        
        const marker = L.circleMarker([event.lat, event.lng], {
            radius: getMarkerSize(event.alert_level),
            fillColor: alertColor,
            color: alertColor,
            weight: 2,
            opacity: 0.8,
            fillOpacity: 0.6
            // className: pulseSpeed // DISABLED - no more pulse animations
        });

        // Create popup content
        const popupContent = createPopupContent(event);
        marker.bindPopup(popupContent, {
            maxWidth: 300,
            className: 'custom-popup'
        });

        // Click event to zoom and show details
        marker.on('click', function() {
            map.setView([event.lat, event.lng], Math.max(map.getZoom(), 8));
            showEventDetails(event.id);
        });

        return marker;
    }

    // Create popup content
    function createPopupContent(event) {
        const alertClass = `alert-${event.alert_level.toLowerCase()}`;
        const eventIcon = getEventIcon(event.event_type);
        
        return `
            <div class="p-0">
                <div class="${alertClass} px-3 py-2 rounded-t-lg">
                    <div class="flex items-center text-white">
                        <i class="${eventIcon} mr-2"></i>
                        <span class="font-semibold">${event.alert_level} Alert</span>
                    </div>
                </div>
                <div class="p-4">
                    <h3 class="font-bold text-gray-900 mb-2">${event.title}</h3>
                    <div class="space-y-1 text-sm text-gray-600">
                        <div><strong>Country:</strong> ${event.country || 'Unknown'}</div>
                        <div><strong>Type:</strong> ${event.event_type}</div>
                        <div><strong>Date:</strong> ${event.formatted_date}</div>
                        ${event.population_affected ? `<div><strong>Population:</strong> ${event.population_affected}</div>` : ''}
                        ${event.magnitude ? `<div><strong>Magnitude:</strong> ${event.magnitude}</div>` : ''}
                    </div>
                    <button onclick="showEventDetails(${event.id})" 
                            class="mt-3 bg-blue-600 text-white px-4 py-2 rounded text-sm hover:bg-blue-700">
                        View Details
                    </button>
                </div>
            </div>
        `;
    }

    // Update recent events list and statistics
    function updateRecentEventsList() {
        const container = document.getElementById('recent-events-list');
        
        if (!eventsData || eventsData.length === 0) {
            container.innerHTML = `
                <div class="text-center text-gray-500 py-8">
                    <i class="fas fa-info-circle mb-2 text-2xl"></i>
                    <div>Keine Events verfügbar</div>
                </div>
            `;
            // Statistics will be updated by calling function
            return;
        }
        
        // Use filtered events instead of all events
        const eventsToShow = filteredEvents && filteredEvents.length > 0 ? filteredEvents : eventsData;
        
        // Sort events by date (newest first)
        const sortedEvents = [...eventsToShow].sort((a, b) => {
            return new Date(b.event_date) - new Date(a.event_date);
        });
        
        // Take first 20 events
        const recentEvents = sortedEvents.slice(0, 20);
        
        // Update events count in header
        const eventsCountEl = document.getElementById('events-count');
        if (eventsCountEl) {
            const totalFiltered = eventsToShow.length;
            const totalAll = eventsData.length;
            if (totalFiltered < totalAll) {
                eventsCountEl.textContent = `(${totalFiltered}/${totalAll})`;
            } else {
                eventsCountEl.textContent = `(${totalAll})`;
            }
        }
        
        // Statistics will be updated by applyFilters() to avoid duplication
        
        if (recentEvents.length === 0) {
            container.innerHTML = `
                <div class="text-center text-gray-500 py-8">
                    <i class="fas fa-filter mb-2 text-2xl"></i>
                    <div>Keine Events für aktuelle Filter</div>
                    <div class="text-xs mt-2">Filter anpassen für mehr Ergebnisse</div>
                </div>
            `;
            return;
        }
        
        container.innerHTML = recentEvents.map(event => {
            const alertColor = getAlertColor(event.alert_level);
            const eventIcon = getEventIcon(event.event_type);
            
            return `
                <div class="bg-white border border-gray-200 rounded-lg p-4 mb-3 hover:shadow-md transition-shadow cursor-pointer event-card" 
                     onclick="focusEvent(${event.id}, ${event.lat}, ${event.lng})">
                    <div class="flex items-start space-x-3">
                        <div class="flex-shrink-0">
                            <div class="w-3 h-3 rounded-full" style="background-color: ${alertColor}"></div>
                        </div>
                        <div class="flex-1 min-w-0">
                            <div class="flex items-center justify-between mb-1">
                                <span class="text-xs font-medium text-gray-500" style="color: ${alertColor}">
                                    ${event.alert_level.toUpperCase()}
                                </span>
                                <span class="text-xs text-gray-400">${event.formatted_date}</span>
                            </div>
                            <h4 class="text-sm font-medium text-gray-900 mb-1 line-clamp-2">
                                ${event.title.length > 80 ? event.title.substring(0, 80) + '...' : event.title}
                            </h4>
                            <div class="flex items-center text-xs text-gray-500 space-x-3">
                                <span class="flex items-center">
                                    <i class="${eventIcon} mr-1"></i>
                                    ${getEventTypeGerman(event.event_type)}
                                </span>
                                ${event.country ? `<span>${event.country}</span>` : ''}
                            </div>
                            ${event.population_affected ? `
                                <div class="mt-2 text-xs text-gray-600">
                                    <i class="fas fa-users mr-1"></i>
                                    ${event.population_affected}
                                </div>
                            ` : ''}
                        </div>
                    </div>
                </div>
            `;
        }).join('');
    }

    // Update live statistics based on current events data (unfiltered)
    function updateLiveStatistics() {
        if (!eventsData || eventsData.length === 0) {
            updateActiveEventsStats(0);
            updateRecentEventsStats(0);
            updateHighRiskEventsStats(0);
            return;
        }
        
        // Calculate statistics based on ALL events (unfiltered)
        const now = new Date();
        const sevenDaysAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
        
        const activeEventsCount = eventsData.length;
        
        const recentEventsCount = eventsData.filter(event => {
            const eventDate = new Date(event.event_date);
            return eventDate >= sevenDaysAgo;
        }).length;
        
        const highRiskEventsCount = eventsData.filter(event => {
            return event.alert_level === 'Red' || event.alert_level === 'Orange';
        }).length;
        
        // Update the statistics displays
        updateActiveEventsStats(activeEventsCount);
        updateRecentEventsStats(recentEventsCount);
        updateHighRiskEventsStats(highRiskEventsCount);
        
        console.log(`Statistics updated (all events) - Active: ${activeEventsCount}, Recent (7d): ${recentEventsCount}, High Risk: ${highRiskEventsCount}`);
    }

    // Update filtered statistics based on currently filtered events
    function updateFilteredStatistics() {
        const eventsToCalculate = filteredEvents && filteredEvents.length > 0 ? filteredEvents : eventsData;
        
        if (!eventsToCalculate || eventsToCalculate.length === 0) {
            updateActiveEventsStats(0);
            updateRecentEventsStats(0);
            updateHighRiskEventsStats(0);
            return;
        }
        
        // Calculate statistics based on FILTERED events
        const now = new Date();
        const sevenDaysAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
        
        const activeEventsCount = eventsToCalculate.length;
        
        const recentEventsCount = eventsToCalculate.filter(event => {
            const eventDate = new Date(event.event_date);
            return eventDate >= sevenDaysAgo;
        }).length;
        
        const highRiskEventsCount = eventsToCalculate.filter(event => {
            return event.alert_level === 'Red' || event.alert_level === 'Orange';
        }).length;
        
        // Update the statistics displays
        updateActiveEventsStats(activeEventsCount);
        updateRecentEventsStats(recentEventsCount);
        updateHighRiskEventsStats(highRiskEventsCount);
        
        console.log(`Filtered statistics updated - Active: ${activeEventsCount}, Recent (7d): ${recentEventsCount}, High Risk: ${highRiskEventsCount}`);
    }
    
    // Update active events statistics display
    function updateActiveEventsStats(count) {
        const activeEventsEl = document.getElementById('active-events');
        if (activeEventsEl) {
            activeEventsEl.textContent = count.toLocaleString('de-DE');
        }
    }
    
    // Update recent events statistics display
    function updateRecentEventsStats(count) {
        const recentEventsEl = document.getElementById('recent-events');
        if (recentEventsEl) {
            recentEventsEl.textContent = count.toLocaleString('de-DE');
        }
    }
    
    // Update high risk events statistics display  
    function updateHighRiskEventsStats(count) {
        const highRiskEventsEl = document.getElementById('high-risk-events');
        if (highRiskEventsEl) {
            highRiskEventsEl.textContent = count.toLocaleString('de-DE');
        }
    }

    // Update statistics display - DISABLED
    function updateStatistics(data) {
        // DISABLED - no dynamic updates to prevent layout issues
        console.log('Statistics update disabled for stability:', data);
        
        // Only update the last update time in header
        const lastUpdateEl = document.getElementById('last-update');
        if (lastUpdateEl) {
            lastUpdateEl.innerHTML = `<i class="fas fa-clock mr-1"></i><span>Updates disabled</span>`;
        }
    }

    // Update charts - DISABLED
    function updateCharts(data) {
        // DISABLED - no chart updates to prevent layout issues
        console.log('Chart updates disabled for stability:', data);
    }

    // Update alert level chart - DISABLED
    function updateAlertLevelChart(alertData) {
        // DISABLED - no chart rendering
        console.log('Alert level chart disabled:', alertData);
    }

    // Update event type chart - DISABLED
    function updateEventTypeChart(typeData) {
        // DISABLED - no chart rendering
        console.log('Event type chart disabled:', typeData);
    }

    // Setup event listeners
    function setupEventListeners() {
        // Mobile menu toggle
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        if (mobileMenuButton) {
            mobileMenuButton.addEventListener('click', toggleMobileSidebar);
        }
        
        const mobileOverlay = document.getElementById('mobile-overlay');
        if (mobileOverlay) {
            mobileOverlay.addEventListener('click', closeMobileSidebar);
        }
        
        // Refresh button
        const refreshButton = document.getElementById('refresh-data');
        if (refreshButton) {
            refreshButton.addEventListener('click', async function() {
                console.log('Refresh button clicked - fetching fresh GDACS data');
                
                // Show loading state
                this.disabled = true;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                
                try {
                    // First refresh GDACS data from external API
                    const refreshResponse = await fetch('/api/refresh-gdacs', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                        }
                    });
                    
                    const refreshData = await refreshResponse.json();
                    console.log('GDACS refresh result:', refreshData);
                    
                    if (refreshData.success) {
                        // Then reload the UI data
                        await loadEventsData();
                        await loadGdacsInfo();
                        // Statistics will be automatically updated by loadEventsData()
                        console.log('Data successfully refreshed from GDACS API');
                    } else {
                        console.error('Failed to refresh GDACS data:', refreshData.message);
                    }
                    
                } catch (error) {
                    console.error('Error refreshing data:', error);
                } finally {
                    // Restore button state
                    this.disabled = false;
                    this.innerHTML = '<i class="fas fa-sync-alt"></i>';
                }
            });
        }

        // Map controls
        const toggleSatellite = document.getElementById('toggle-satellite');
        if (toggleSatellite) {
            toggleSatellite.addEventListener('click', toggleSatelliteView);
        }
        
        const zoomIn = document.getElementById('zoom-in');
        if (zoomIn) {
            zoomIn.addEventListener('click', () => map.zoomIn());
        }
        
        const zoomOut = document.getElementById('zoom-out');
        if (zoomOut) {
            zoomOut.addEventListener('click', () => map.zoomOut());
        }

        // Modal controls
        const closeModal = document.getElementById('close-modal');
        if (closeModal) {
            closeModal.addEventListener('click', hideEventDetails);
        }

        // Click outside modal to close
        const eventModal = document.getElementById('event-modal');
        if (eventModal) {
            eventModal.addEventListener('click', function(e) {
                if (e.target === this) {
                    hideEventDetails();
                }
            });
        }

        // Center map button
        const centerMapButton = document.getElementById('center-map-button');
        if (centerMapButton) {
            centerMapButton.addEventListener('click', function() {
                centerMapToDefault();
            });
        }

        // Filter controls
        setupFilterListeners();
    }

    // Setup filter listeners
    function setupFilterListeners() {
        // Alert level filters - wait for DOM to be fully ready
        setTimeout(() => {
            const alertCheckboxes = document.querySelectorAll('.alert-filter');
            console.log('Setting up filter listeners for', alertCheckboxes.length, 'alert checkboxes');
            
            if (alertCheckboxes.length === 0) {
                console.error('No alert filter checkboxes found!');
                return;
            }
            
            alertCheckboxes.forEach((checkbox, index) => {
                console.log('Setting up listener for checkbox', index, 'with value:', checkbox.value, 'element:', checkbox);
                
                // Remove any existing listeners first
                checkbox.removeEventListener('change', handleAlertFilterChange);
                
                // Add new listener
                checkbox.addEventListener('change', handleAlertFilterChange);
                
                // Test if checkbox is clickable
                checkbox.addEventListener('click', function(e) {
                    console.log('Checkbox clicked:', this.value, 'checked will be:', !this.checked);
                });
            });
        }, 100);

        // Event type filter
        const eventTypeFilter = document.getElementById('event-type-filter');
        if (eventTypeFilter) {
            eventTypeFilter.addEventListener('change', function() {
                console.log('Event type filter changed:', this.value);
                activeFilters.eventType = this.value;
                applyFilters();
            });
        }

        // Time filter
        const timeFilter = document.getElementById('time-filter');
        if (timeFilter) {
            timeFilter.addEventListener('change', function() {
                console.log('Time filter changed:', this.value);
                activeFilters.timeRange = this.value;
                applyFilters();
            });
        }
    }
    
    // Separate function for alert filter change handling
    function handleAlertFilterChange() {
        console.log('Alert filter changed:', this.value, 'checked:', this.checked);
        updateAlertLevelFilters();
        applyFilters();
    }

    // Update alert level filters based on checkboxes
    function updateAlertLevelFilters() {
        const checkboxes = document.querySelectorAll('.alert-filter');
        const selectedLevels = [];
        
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                selectedLevels.push(checkbox.value);
            }
        });
        
        // If no levels selected, select all three by default
        if (selectedLevels.length === 0) {
            activeFilters.alertLevels = ['Red', 'Orange', 'Green'];
            checkboxes.forEach(checkbox => {
                checkbox.checked = true;
            });
        } else {
            activeFilters.alertLevels = selectedLevels;
        }
        
        console.log('Active alert filters:', activeFilters.alertLevels);
    }

    // Apply filters
    function applyFilters() {
        if (!eventsData || eventsData.length === 0) {
            filteredEvents = [];
            updateEventMarkers();
            updateRecentEventsList();
            updateFilterStatus();
            return;
        }

        // Start with all events
        filteredEvents = eventsData.slice();

        // Apply alert level filter (always apply since we removed 'all' option)
        filteredEvents = filteredEvents.filter(event => 
            activeFilters.alertLevels.includes(event.alert_level)
        );

        // Apply event type filter
        if (activeFilters.eventType !== 'all') {
            filteredEvents = filteredEvents.filter(event => 
                event.event_type && event.event_type === activeFilters.eventType
            );
        }

        // Apply time range filter
        if (activeFilters.timeRange !== 'all') {
            const now = new Date();
            let cutoffDate;
            
            switch (activeFilters.timeRange) {
                case '24h':
                    cutoffDate = new Date(now.getTime() - 24 * 60 * 60 * 1000);
                    break;
                case '7d':
                    cutoffDate = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
                    break;
                case '30d':
                    cutoffDate = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
                    break;
                default:
                    cutoffDate = null;
            }
            
            if (cutoffDate) {
                filteredEvents = filteredEvents.filter(event => {
                    const eventDate = new Date(event.event_date);
                    return eventDate >= cutoffDate;
                });
            }
        }

        // Update the map with filtered events
        updateEventMarkers();
        
        // Update the events list with filtered events
        updateRecentEventsList();
        
        // Update filter status display
        updateFilterStatus();
        
        // Update statistics based on filtered events
        updateFilteredStatistics();
    }

    // Update filter status display
    function updateFilterStatus() {
        // Add filter status to map legend or create a new status area
        const totalEvents = eventsData.length;
        const visibleEvents = filteredEvents.length;
        
        console.log(`Filter applied: ${visibleEvents}/${totalEvents} events visible`, {
            alertLevels: activeFilters.alertLevels,
            eventType: activeFilters.eventType,
            timeRange: activeFilters.timeRange
        });
        
        // Update a status display (we can add this to the legend)
        const legendElement = document.querySelector('.leaflet-bottom .bg-white.rounded-lg.shadow-lg.p-4.max-w-xs');
        if (legendElement) {
            // Remove existing filter status
            const existingStatus = legendElement.querySelector('.filter-status');
            if (existingStatus) {
                existingStatus.remove();
            }
            
            // Add new filter status
            if (visibleEvents !== totalEvents) {
                const statusDiv = document.createElement('div');
                statusDiv.className = 'filter-status mt-3 pt-3 border-t border-gray-200 text-xs text-blue-600';
                statusDiv.innerHTML = `
                    <div class="flex items-center">
                        <i class="fas fa-filter mr-1"></i>
                        <span>${visibleEvents}/${totalEvents} Events angezeigt</span>
                    </div>
                `;
                legendElement.appendChild(statusDiv);
            }
        }
    }

    // Toggle satellite view
    function toggleSatelliteView() {
        // Remove current tile layer
        map.eachLayer(function(layer) {
            if (layer instanceof L.TileLayer) {
                map.removeLayer(layer);
            }
        });

        if (isSatelliteView) {
            // Switch to German street view with German names
            L.tileLayer('https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap Deutschland - Kartendaten © OpenStreetMap-Mitwirkende',
                subdomains: ['a', 'b', 'c']
            }).addTo(map);
            isSatelliteView = false;
        } else {
            // Switch to satellite view
            L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
                attribution: '© Esri'
            }).addTo(map);
            isSatelliteView = true;
        }
    }

    // Focus on specific event
    function focusEvent(eventId, lat, lng) {
        map.setView([lat, lng], 8);
        showEventDetails(eventId);
    }

    // Center map to default position (same as initial load)
    function centerMapToDefault() {
        console.log('Centering map to default position');
        map.setView([20, 0], 3);
    }

    // Show event details modal
    async function showEventDetails(eventId) {
        try {
            const response = await fetch(`/api/events/${eventId}`);
            const data = await response.json();
            
            displayEventModal(data.event);
        } catch (error) {
            console.error('Error loading event details:', error);
        }
    }

    // Display event modal
    function displayEventModal(event) {
        const modal = document.getElementById('event-modal');
        const title = document.getElementById('modal-title');
        const content = document.getElementById('modal-content');
        
        title.textContent = event.title;
        
        const alertClass = `alert-${event.alert_level.toLowerCase()}`;
        const eventIcon = getEventIcon(event.event_type);
        
        content.innerHTML = `
            <div class="space-y-4">
                <div class="flex items-center space-x-4">
                    <div class="${alertClass} px-3 py-1 rounded-full text-white text-sm font-medium">
                        ${event.alert_level} Alert
                    </div>
                    <div class="flex items-center text-gray-600">
                        <i class="${eventIcon} mr-2"></i>
                        <span>${event.event_type}</span>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <h4 class="font-medium text-gray-900 mb-2">Location</h4>
                        <p class="text-gray-600">${event.country}</p>
                        <p class="text-sm text-gray-500">${event.lat.toFixed(4)}, ${event.lng.toFixed(4)}</p>
                    </div>
                    <div>
                        <h4 class="font-medium text-gray-900 mb-2">Date & Time</h4>
                        <p class="text-gray-600">${event.formatted_date}</p>
                        ${event.start_time ? `<p class="text-sm text-gray-500">${event.start_time}</p>` : ''}
                    </div>
                </div>

                ${event.description ? `
                    <div>
                        <h4 class="font-medium text-gray-900 mb-2">Description</h4>
                        <p class="text-gray-600">${event.description}</p>
                    </div>
                ` : ''}

                <div class="grid grid-cols-2 gap-4">
                    ${event.population_affected ? `
                        <div>
                            <h4 class="font-medium text-gray-900 mb-2">Population Affected</h4>
                            <p class="text-gray-600">${event.population_affected}</p>
                        </div>
                    ` : ''}
                    ${event.magnitude ? `
                        <div>
                            <h4 class="font-medium text-gray-900 mb-2">Magnitude</h4>
                            <p class="text-gray-600">${event.magnitude}</p>
                        </div>
                    ` : ''}
                </div>

                <div class="flex space-x-3 pt-4 border-t">
                    ${event.report_url ? `
                        <a href="${event.report_url}" target="_blank" 
                           class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                            View GDACS Report
                        </a>
                    ` : ''}
                    <button onclick="focusEvent(${event.id}, ${event.lat}, ${event.lng}); hideEventDetails();" 
                            class="bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700">
                        Focus on Map
                    </button>
                </div>
            </div>
        `;
        
        modal.classList.remove('hidden');
    }

    // Hide event details modal
    function hideEventDetails() {
        document.getElementById('event-modal').classList.add('hidden');
    }

    // Show/hide loading overlay
    function showLoading(show) {
        const overlay = document.getElementById('loading-overlay');
        if (show) {
            overlay.classList.remove('hidden');
        } else {
            overlay.classList.add('hidden');
        }
    }

    // Update last update time
    function updateLastUpdateTime(timestamp) {
        const date = new Date(timestamp);
        const now = new Date();
        const diffMinutes = Math.floor((now - date) / (1000 * 60));
        
        let timeAgo;
        if (diffMinutes < 1) {
            timeAgo = 'Just now';
        } else if (diffMinutes < 60) {
            timeAgo = `${diffMinutes}m ago`;
        } else if (diffMinutes < 1440) {
            timeAgo = `${Math.floor(diffMinutes / 60)}h ago`;
        } else {
            timeAgo = `${Math.floor(diffMinutes / 1440)}d ago`;
        }
        
        const lastUpdateEl = document.getElementById('last-update');
        lastUpdateEl.innerHTML = `<i class="fas fa-clock mr-1"></i><span>${timeAgo}</span>`;
    }

    // Utility functions
    function getAlertColor(alertLevel) {
        switch (alertLevel) {
            case 'Red': return '#ef4444';
            case 'Orange': return '#f97316';
            case 'Green': return '#22c55e';
            default: return '#6b7280';
        }
    }

    function getPulseSpeed(alertLevel) {
        switch (alertLevel) {
            case 'Red': return 'pulse-marker-fast';
            case 'Orange': return 'pulse-marker';
            case 'Green': return 'pulse-marker-slow';
            default: return 'pulse-marker';
        }
    }

    function getMarkerSize(alertLevel) {
        switch (alertLevel) {
            case 'Red': return 12;
            case 'Orange': return 10;
            case 'Green': return 8;
            default: return 6;
        }
    }

    function getEventIcon(eventType) {
        switch (eventType) {
            case 'earthquake': return 'fas fa-mountain event-earthquake';
            case 'hurricane': return 'fas fa-hurricane event-hurricane';
            case 'flood': return 'fas fa-water event-flood';
            case 'wildfire': return 'fas fa-fire event-wildfire';
            case 'volcano': return 'fas fa-volcano event-volcano';
            case 'drought': return 'fas fa-sun event-drought';
            default: return 'fas fa-exclamation-triangle event-other';
        }
    }

    function getEventTypeGerman(eventType) {
        switch (eventType) {
            case 'earthquake': return 'Erdbeben';
            case 'hurricane': return 'Hurrikan';
            case 'flood': return 'Überschwemmung';
            case 'wildfire': return 'Waldbrand';
            case 'volcano': return 'Vulkan';
            case 'drought': return 'Dürre';
            default: return 'Sonstiges';
        }
    }

    // Mobile sidebar functions
    function toggleMobileSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('mobile-overlay');
        
        sidebar.classList.toggle('mobile-open');
        overlay.classList.toggle('hidden');
    }

    function closeMobileSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('mobile-overlay');
        
        sidebar.classList.remove('mobile-open');
        overlay.classList.add('hidden');
    }

    // Handle window resize
    window.addEventListener('resize', function() {
        if (window.innerWidth >= 768) { // md breakpoint
            closeMobileSidebar();
        }
    });

    // Setup country search functionality
    function setupCountrySearch() {
        const searchInput = document.getElementById('country-search');
        const dropdown = document.getElementById('country-dropdown');
        const clearButton = document.getElementById('clear-search');
        
        if (!searchInput || !dropdown || !clearButton) return;
        
        let searchTimeout;
        
        // Get all unique countries from events data and add German names
        function getAllCountries() {
            const countries = new Set();
            
            // Add countries from events data
            if (eventsData) {
                eventsData.forEach(event => {
                    if (event.country) {
                        const germanName = countryMappings[event.country] || event.country;
                        countries.add(germanName);
                    }
                });
            }
            
            // Add all predefined German country names
            Object.values(countryMappings).forEach(country => {
                countries.add(country);
            });
            
            return Array.from(countries).sort();
        }
        
        // Filter countries based on search term
        function filterCountries(searchTerm) {
            const allCountries = getAllCountries();
            const term = searchTerm.toLowerCase().trim();
            
            if (!term) return [];
            
            return allCountries.filter(country => 
                country.toLowerCase().includes(term)
            ).slice(0, 8); // Limit to 8 results
        }
        
        // Show dropdown with results
        function showResults(countries) {
            if (countries.length === 0) {
                dropdown.classList.add('hidden');
                return;
            }
            
            dropdown.innerHTML = countries.map(country => `
                <div class="px-4 py-2 hover:bg-blue-50 cursor-pointer border-b border-gray-100 last:border-b-0 country-result" 
                     data-country="${country}">
                    <div class="flex items-center">
                        <i class="fas fa-map-marker-alt text-blue-500 mr-3"></i>
                        <span class="text-gray-900">${country}</span>
                    </div>
                </div>
            `).join('');
            
            dropdown.classList.remove('hidden');
            
            // Add click listeners to results
            dropdown.querySelectorAll('.country-result').forEach(item => {
                item.addEventListener('click', function() {
                    const countryName = this.dataset.country;
                    selectCountry(countryName);
                });
            });
        }
        
        // Select a country and center map on it
        function selectCountry(countryName) {
            searchInput.value = countryName;
            dropdown.classList.add('hidden');
            showClearButton();
            
            // Center map on country
            if (countryCoordinates[countryName]) {
                const [lat, lng] = countryCoordinates[countryName];
                map.setView([lat, lng], 6);
                
                // Optional: Show notification
                console.log(`Karte zentriert auf: ${countryName}`);
            }
        }
        
        // Show/hide clear button based on input content
        function showClearButton() {
            if (searchInput.value.trim().length > 0) {
                clearButton.classList.remove('hidden');
            } else {
                clearButton.classList.add('hidden');
            }
        }
        
        // Clear search input and hide dropdown
        function clearSearch() {
            searchInput.value = '';
            clearButton.classList.add('hidden');
            dropdown.classList.add('hidden');
            searchInput.focus();
        }
        
        // Hide dropdown when clicking outside
        function hideDropdown() {
            dropdown.classList.add('hidden');
        }
        
        // Event listeners
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const searchTerm = this.value;
            showClearButton(); // Show/hide clear button based on content
            
            searchTimeout = setTimeout(() => {
                if (searchTerm.length >= 2) {
                    const results = filterCountries(searchTerm);
                    showResults(results);
                } else {
                    hideDropdown();
                }
            }, 300);
        });
        
        searchInput.addEventListener('focus', function() {
            if (this.value.length >= 2) {
                const results = filterCountries(this.value);
                showResults(results);
            }
        });
        
        searchInput.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                hideDropdown();
                this.blur();
            }
        });
        
        // Clear button click event
        clearButton.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            clearSearch();
        });
        
        // Hide dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !dropdown.contains(e.target) && !clearButton.contains(e.target)) {
                hideDropdown();
            }
        });
    }

    // Setup automatic refresh using both polling and Server-Sent Events
    function setupAutoRefresh() {
        let lastUpdateTime = null;
        let useServerSentEvents = true;
        
        // Try Server-Sent Events first (more efficient)
        if (useServerSentEvents && typeof(EventSource) !== "undefined") {
            console.log('🔄 Setting up Server-Sent Events for real-time GDACS updates...');
            
            const eventSource = new EventSource('/api/gdacs-updates');
            
            eventSource.addEventListener('gdacs-updated', function(event) {
                const data = JSON.parse(event.data);
                console.log('📡 Received GDACS update via SSE:', data);
                
                // Show notification and refresh data
                showUpdateNotification('Neue GDACS Daten verfügbar');
                refreshAllData();
            });
            
            eventSource.addEventListener('heartbeat', function(event) {
                console.log('💓 SSE Heartbeat received');
            });
            
            eventSource.onerror = function(event) {
                console.warn('⚠️ SSE connection error, falling back to polling');
                eventSource.close();
                startPollingFallback();
            };
            
            // Cleanup on page unload
            window.addEventListener('beforeunload', function() {
                eventSource.close();
            });
            
        } else {
            startPollingFallback();
        }
        
        // Fallback polling method
        function startPollingFallback() {
            console.log('🔄 Starting polling fallback (checks every 2 minutes)');
            
            setInterval(async function() {
                try {
                    const response = await fetch('/api/dashboard/stats');
                    const data = await response.json();
                    
                    const currentUpdateTime = data.last_update;
                    
                    // If this is the first check, just store the time
                    if (lastUpdateTime === null) {
                        lastUpdateTime = currentUpdateTime;
                        return;
                    }
                    
                    // If the update time has changed, refresh all data
                    if (currentUpdateTime && currentUpdateTime !== lastUpdateTime) {
                        console.log('🔄 New GDACS data detected via polling...');
                        
                        lastUpdateTime = currentUpdateTime;
                        showUpdateNotification('GDACS Daten aktualisiert');
                        refreshAllData();
                    }
                    
                } catch (error) {
                    console.error('Error checking for updates:', error);
                }
            }, 2 * 60 * 1000); // Check every 2 minutes
        }
        
        // Refresh all data function
        async function refreshAllData() {
            try {
                await Promise.all([
                    loadEventsData(),
                    loadGdacsInfo()
                ]);
                console.log('✅ UI refreshed with new GDACS data');
            } catch (error) {
                console.error('Error refreshing data:', error);
            }
        }
    }
    
    // Show brief update notification
    function showUpdateNotification(message = 'GDACS Daten aktualisiert') {
        // Remove any existing notifications
        const existingNotifications = document.querySelectorAll('.gdacs-notification');
        existingNotifications.forEach(notification => {
            document.body.removeChild(notification);
        });
        
        // Create notification element
        const notification = document.createElement('div');
        notification.className = 'gdacs-notification fixed top-20 right-4 bg-blue-600 text-white px-4 py-2 rounded-lg shadow-lg z-[9999] flex items-center';
        notification.style.animation = 'slideIn 0.3s ease-out';
        notification.innerHTML = `
            <i class="fas fa-sync-alt fa-spin mr-2"></i>
            <span>${message}</span>
            <button onclick="this.parentElement.remove()" class="ml-2 text-white hover:text-gray-200">
                <i class="fas fa-times text-sm"></i>
            </button>
        `;
        
        // Add to page
        document.body.appendChild(notification);
        
        // Auto-remove after 4 seconds
        setTimeout(() => {
            if (document.body.contains(notification)) {
                notification.style.animation = 'slideOut 0.3s ease-out';
                setTimeout(() => {
                    if (document.body.contains(notification)) {
                        document.body.removeChild(notification);
                    }
                }, 300);
            }
        }, 4000);
        
        // Flash the GDACS info panel to draw attention
        const gdacsPanel = document.querySelector('.gdacs-info-panel');
        if (gdacsPanel) {
            gdacsPanel.style.animation = 'pulse 0.5s ease-in-out 2';
            setTimeout(() => {
                gdacsPanel.style.animation = '';
            }, 1000);
        }
    }

    // Make functions globally available
    window.showEventDetails = showEventDetails;
    window.focusEvent = focusEvent;
    window.hideEventDetails = hideEventDetails;
    window.toggleMobileSidebar = toggleMobileSidebar;
    window.closeMobileSidebar = closeMobileSidebar;
});
</script>
@endpush