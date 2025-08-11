# 🚀 GDACS - Schnellreferenz

## 🔧 Wichtigste Befehle

| Befehl | Funktion |
|--------|----------|
| `php artisan gdacs:import` | Daten importieren |
| `php artisan gdacs:import --stats` | Statistiken anzeigen |
| `php artisan gdacs:import --dry-run` | Test ohne Speichern |
| `php artisan schedule:run` | Scheduler manuell ausführen |
| `php artisan schedule:list` | Geplante Tasks anzeigen |

## 📋 Scheduler Setup

### Produktionsumgebung (Cron):
```bash
# Crontab bearbeiten
crontab -e

# Diese Zeile hinzufügen:
* * * * * cd /pfad/zum/projekt && php artisan schedule:run >> /dev/null 2>&1
```

### Entwicklung:
```bash
php artisan schedule:work
```

## 📊 Quick Stats

**Aktueller Status:**
```bash
php artisan gdacs:import --stats
```

**Import-Performance:**
```bash
time php artisan gdacs:import
```

## 📁 Log-Dateien

- **Import-Logs:** `storage/logs/gdacs-import.log`
- **Statistik-Logs:** `storage/logs/gdacs-stats.log` 
- **Fehler-Logs:** `storage/logs/laravel.log`

## ⏰ Automatische Ausführung

- **GDACS Import:** Alle 30 Minuten
- **Statistiken:** Täglich um 8:00 Uhr
- **Duplikatsschutz:** ✅ Automatisch
- **Updates:** ✅ Bei Änderungen

## 🆘 Notfall-Befehle

```bash
# Sofortiger Import
php artisan gdacs:import --force

# Verbindung testen  
curl -I https://www.gdacs.org/xml/rss.xml

# Fehler-Analyse
tail -50 storage/logs/laravel.log | grep -i error
```