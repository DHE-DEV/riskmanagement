# 🌍 GDACS Integration - Benutzeranleitung

## Übersicht
Das GDACS (Global Disaster Alert and Coordination System) Integration System ermöglicht den vollumfänglichen Import von Katastrophendaten direkt in Ihre Datenbank. Das System verhindert Duplikate und aktualisiert bestehende Ereignisse automatisch.

---

## 📋 Verfügbare Befehle

### 1. **Daten Import**
```bash
php artisan gdacs:import
```
Importiert alle aktuellen GDACS Ereignisse von der RSS-Quelle.

**Beispiel Ausgabe:**
```
🌍 Starting GDACS Events Import
=====================================
📅 Import Time: 2025-08-07 12:16:18 UTC
🔗 Source: https://www.gdacs.org/xml/rss.xml

📡 Fetching GDACS RSS feed...

✅ Import completed successfully!
+-----------------------------+-------+
| Metric                      | Count |
+-----------------------------+-------+
| Total Events Processed      | 168   |
| New Events Created          | 167   |
| Existing Events Updated     | 0     |
| Events Skipped (no changes) | 1     |
| Duration (seconds)          | 11.06 |
+-----------------------------+-------+
⚡ Performance: 15.19 events/second
```

### 2. **Statistiken anzeigen**
```bash
php artisan gdacs:import --stats
```
Zeigt detaillierte Statistiken über die aktuell gespeicherten GDACS Daten.

**Beispiel Ausgabe:**
```
📊 Current GDACS Database Statistics:
+--------------------+----------------+
| Metric             | Value          |
+--------------------+----------------+
| Total GDACS Events | 167            |
| Active Events      | 128            |
| Last Update        | 22 minutes ago |
+--------------------+----------------+

🚨 Events by Alert Level:
+-------------+-------+
| Alert Level | Count |
+-------------+-------+
| Green       | 161   |
| Orange      | 6     |
+-------------+-------+

🌪️ Events by Type:
+------------+-------+
| Event Type | Count |
+------------+-------+
| Earthquake | 11    |
| Hurricane  | 10    |
| Flood      | 12    |
| Wildfire   | 118   |
| Volcano    | 2     |
| Drought    | 14    |
+------------+-------+
```

### 3. **Testmodus (Dry Run)**
```bash
php artisan gdacs:import --dry-run
```
Simuliert den Import ohne Daten zu speichern. Nützlich zum Testen.

### 4. **Erzwungener Import**
```bash
php artisan gdacs:import --force
```
Führt Import aus, auch wenn kürzlich bereits importiert wurde.

---

## ⚙️ Automatisierte Imports (Scheduler)

### 1. **Scheduler Status prüfen**
```bash
php artisan schedule:list
```
Zeigt alle geplanten Tasks an, einschließlich GDACS Imports.

### 2. **Scheduler einmalig ausführen**
```bash
php artisan schedule:run
```
Führt alle fälligen geplanten Tasks einmalig aus.

### 3. **Scheduler Test (Einzelner Task)**
```bash
php artisan schedule:test
```
Testet den Scheduler ohne tatsächliche Ausführung.

### 4. **Scheduler dauerhaft aktivieren**

#### Option A: Cron Job (Empfohlen für Produktion)
Fügen Sie folgenden Eintrag zur crontab hinzu:
```bash
# Crontab bearbeiten
crontab -e

# Folgende Zeile hinzufügen:
* * * * * cd /path/to/your/project && php artisan schedule:run >> /dev/null 2>&1
```

#### Option B: Artisan-Befehl (Für Entwicklung)
```bash
php artisan schedule:work
```
⚠️ **Hinweis:** Dieser Befehl läuft dauerhaft und blockiert das Terminal.

---

## 🕐 Automatisierte Schedule-Konfiguration

Das System ist bereits so konfiguriert:

### **Automatischer GDACS Import**
- **Frequenz:** Alle 30 Minuten
- **Funktion:** Importiert neue/geänderte Ereignisse
- **Log:** `storage/logs/gdacs-import.log`
- **Features:** 
  - Verhindert gleichzeitige Ausführung (`withoutOverlapping`)
  - Läuft im Hintergrund (`runInBackground`)

### **Tägliche Statistiken**
- **Zeit:** Täglich um 8:00 Uhr
- **Funktion:** Erstellt Statistik-Reports
- **Log:** `storage/logs/gdacs-stats.log`

---

## 📊 Monitoring & Logs

### 1. **Import Logs anzeigen**
```bash
tail -f storage/logs/gdacs-import.log
```

### 2. **Statistik Logs anzeigen**
```bash
tail -f storage/logs/gdacs-stats.log
```

### 3. **Laravel Logs prüfen**
```bash
tail -f storage/logs/laravel.log
```

### 4. **Fehleranalyse**
```bash
# Die letzten 100 Zeilen der Import-Logs
tail -100 storage/logs/gdacs-import.log

# Nach Fehlern suchen
grep -i error storage/logs/gdacs-import.log
```

---

## 🚨 Troubleshooting

### **Problem: Import schlägt fehl**
```bash
# 1. Verbindung testen
curl -I https://www.gdacs.org/xml/rss.xml

# 2. Verbose Import für Details
php artisan gdacs:import -v

# 3. Logs prüfen
tail -20 storage/logs/laravel.log
```

### **Problem: Scheduler läuft nicht**
```bash
# 1. Scheduler-Konfiguration prüfen
php artisan schedule:list

# 2. Cron Job Status
crontab -l

# 3. Manuelle Ausführung testen
php artisan schedule:run
```

### **Problem: Duplikate in der Datenbank**
```bash
# Duplikate-Analyse
php artisan tinker
>>> \App\Models\DisasterEvent::select('gdacs_event_id', 'gdacs_episode_id')
    ->groupBy('gdacs_event_id', 'gdacs_episode_id')
    ->havingRaw('COUNT(*) > 1')
    ->get();
```

---

## 💡 Best Practices

### **1. Regelmäßige Überwachung**
```bash
# Tägliche Statistik-Checks
php artisan gdacs:import --stats
```

### **2. Performance Monitoring**
```bash
# Import-Performance messen
time php artisan gdacs:import
```

### **3. Datenbank Wartung**
```bash
# Alte Events bereinigen (älter als 1 Jahr)
php artisan tinker
>>> \App\Models\DisasterEvent::where('event_date', '<', now()->subYear())->delete();
```

### **4. Backup vor großen Updates**
```bash
# Datenbank Backup
mysqldump -u user -p database_name disaster_events > gdacs_backup.sql
```

---

## 🎯 Erweiterte Verwendung

### **Daten in PHP verwenden**
```php
use App\Models\DisasterEvent;
use App\Services\GdacsService;

// Aktuelle Ereignisse abrufen
$activeEvents = DisasterEvent::active()->gdacsEvents()->get();

// Hochrisiko-Ereignisse
$highRisk = DisasterEvent::where('gdacs_alert_level', 'Red')
    ->orWhere('gdacs_alert_level', 'Orange')
    ->get();

// Service direkt verwenden
$gdacsService = new GdacsService();
$stats = $gdacsService->getStatistics();
```

### **API Integration Beispiel**
```php
// Controller Beispiel
public function getDisasterEvents()
{
    return DisasterEvent::gdacsEvents()
        ->active()
        ->with(['country', 'city'])
        ->paginate(50);
}
```

---

## 📞 Support

**Bei Problemen:**
1. Logs prüfen: `storage/logs/`
2. Konfiguration validieren: `php artisan gdacs:import --stats`
3. Test-Import: `php artisan gdacs:import --dry-run`

**Datenquelle:** [GDACS.org](https://www.gdacs.org/)
**Update-Frequenz:** Alle 30 Minuten automatisch
**Datenqualität:** ⚠️ Nur für Informationszwecke, nicht für kritische Entscheidungen verwenden