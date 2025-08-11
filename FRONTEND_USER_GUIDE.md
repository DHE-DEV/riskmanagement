# 🌍 Risk Management System - Benutzeroberfläche Anleitung

## Übersicht
Das Risk Management System bietet eine interaktive Weltkarte zur Visualisierung von globalen Katastrophenereignissen in Echtzeit, basierend auf GDACS-Daten.

---

## 🖥️ Benutzeroberfläche Features

### **Hauptfunktionen**
- ✅ **Interaktive Weltkarte** mit Zoom- und Panfunktion
- ✅ **Pulsierende Event-Marker** basierend auf Schweregrad
- ✅ **Live-Statistiken** in der Sidebar
- ✅ **Event-Details** in Modal-Fenstern
- ✅ **Responsive Design** für Mobile und Desktop
- ✅ **Echtzeit-Updates** alle 30 Minuten

---

## 🗺️ Weltkarte Funktionen

### **Marker-System**
Die Karte zeigt Event-Marker mit verschiedenen Eigenschaften:

#### **🔴 Rote Marker (Critical Risk)**
- **Pulsgeschwindigkeit:** Schnell (1s)
- **Größe:** Groß (12px)
- **Alert Level:** Red
- **Bedeutung:** Höchste Priorität, sofortige Aufmerksamkeit erforderlich

#### **🟠 Orange Marker (High Risk)** 
- **Pulsgeschwindigkeit:** Normal (2s)
- **Größe:** Mittel (10px)
- **Alert Level:** Orange
- **Bedeutung:** Hohe Priorität, Überwachung empfohlen

#### **🟢 Grüne Marker (Low Risk)**
- **Pulsgeschwindigkeit:** Langsam (3s) 
- **Größe:** Klein (8px)
- **Alert Level:** Green
- **Bedeutung:** Niedrige Priorität, Information

### **Karten-Steuerung**
| Control | Funktion | Beschreibung |
|---------|----------|--------------|
| 🛰️ | Satelliten-Ansicht | Wechsel zwischen Straßenkarte und Satellit |
| ➕ | Zoom In | Karte vergrößern |
| ➖ | Zoom Out | Karte verkleinern |
| 🔄 | Refresh | Aktualisiert Event-Daten |

### **Interaktivität**
- **Klick auf Marker:** Event-Details anzeigen + Zoom zum Event
- **Popup:** Schnelle Event-Information
- **Modal:** Detaillierte Event-Information
- **Pan & Zoom:** Maus/Touch-Navigation

---

## 📊 Statistics Dashboard

### **Quick Stats (4 Karten)**
```
┌─────────────────┬─────────────────┐
│  Total Events   │  Active Events  │
│     167         │      128        │
└─────────────────┴─────────────────┘
┌─────────────────┬─────────────────┐
│ Recent (7 days) │   High Risk     │
│      45         │       6         │
└─────────────────┴─────────────────┘
```

### **Charts**
1. **Alert Level Chart (Donut)**
   - Rot, Orange, Grün Verteilung
   - Prozentuale Aufteilung

2. **Event Type Chart (Bar)**
   - Erdbeben, Hurrikane, Fluten, etc.
   - Absolute Zahlen

### **Live-Status-Indikator**
- 🟢 **Live Data:** System aktiv
- 🕐 **Last Update:** Zeit seit letztem Update

---

## 🔍 Filter & Suche

### **Alert Level Filter**
- ☑️ All Levels (Standard)
- ☑️ Red (Critical)
- ☑️ Orange (High) 
- ☑️ Green (Low)

### **Event Type Filter**
- 🌍 Earthquake
- 🌪️ Hurricane
- 🌊 Flood
- 🔥 Wildfire
- 🌋 Volcano
- 🏜️ Drought

### **Time Range Filter**
- All Time
- Last 24 Hours
- Last 7 Days
- Last 30 Days

---

## 📱 Mobile Funktionen

### **Responsive Design**
- **📱 Mobile:** Hamburger-Menü für Sidebar
- **💻 Tablet:** Angepasste Sidebar-Breite
- **🖥️ Desktop:** Vollständige Sidebar sichtbar

### **Touch-Gesten**
- **Pinch to Zoom:** Karte vergrößern/verkleinern
- **Pan:** Karte verschieben
- **Tap:** Event-Details öffnen
- **Swipe:** Sidebar öffnen/schließen

### **Mobile Navigation**
```
[☰] RMS                    [🔄] [🕐 Update]
──────────────────────────────────────────
│                                      │
│           WELTKARTE                  │
│        [Event Marker]                │
│                                      │
└──────────────────────────────────────┘
```

---

## 🔍 Event Details

### **Popup Information (Quick View)**
```
┌─────────────────────────────────┐
│ 🔴 RED ALERT                    │
├─────────────────────────────────┤
│ Erdbeben Magnitude 7.2          │
│                                 │
│ Country: Japan                  │
│ Type: earthquake                │
│ Date: 2 hours ago               │
│ Population: 2.1M affected       │
│                                 │
│ [View Details]                  │
└─────────────────────────────────┘
```

### **Modal Details (Full View)**
```
┌─────────────────────────────────────────────┐
│ Event Title                           [X]   │
├─────────────────────────────────────────────┤
│ 🔴 RED ALERT    🌍 Earthquake               │
│                                             │
│ Location          │  Date & Time            │
│ Japan             │  2025-08-07             │
│ 35.6762, 139.6503 │  12:34:56 UTC          │
│                                             │
│ Description                                 │
│ Earthquake occurred in Japan...             │
│                                             │
│ Population: 2.1M    │ Magnitude: 7.2M       │
│                                             │
│ [View GDACS Report] [Focus on Map]          │
└─────────────────────────────────────────────┘
```

---

## 📋 Recent Events List

### **Event Card Format**
```
🔴 [Event Title]
   Country • Time ago
   Event Type • Alert Level
```

### **Funktionen**
- **Click:** Karte fokussieren auf Event
- **Live Updates:** Automatische Aktualisierung
- **Sortierung:** Neueste zuerst
- **Limit:** Top 10 Recent Events

---

## ⚙️ System Status

### **Verbindungs-Status**
- 🟢 **Connected:** Normale Funktion
- 🟡 **Loading:** Daten werden geladen
- 🔴 **Offline:** Keine Verbindung

### **Update-Intervall**
- **Automatisch:** Alle 30 Minuten
- **Manuell:** Refresh-Button
- **Status:** "Last Update" Anzeige

### **Performance-Indikatoren**
- **Load Time:** Event-Ladezeit
- **Event Count:** Anzahl geladener Events
- **Response Time:** API-Antwortzeit

---

## 🎨 Visual Design

### **Color Scheme**
- **Primary:** Blue (#3b82f6)
- **Success:** Green (#22c55e)
- **Warning:** Orange (#f97316)
- **Danger:** Red (#ef4444)
- **Gray Scale:** Various grays for backgrounds

### **Typography**
- **Font:** Inter (clean, modern)
- **Headers:** Bold weights
- **Body:** Regular weight
- **Small Text:** Light gray

### **Icons**
- **Source:** Font Awesome 6
- **Style:** Filled icons
- **Context:** Event types, controls, status

---

## 🚀 Performance Features

### **Optimization**
- **Lazy Loading:** Events loaded on demand
- **Marker Clustering:** (Future: für große Event-Mengen)
- **API Caching:** Reduzierte Server-Requests
- **Mobile Optimization:** Touch-friendly interface

### **Browser Support**
- ✅ Chrome 80+
- ✅ Firefox 75+
- ✅ Safari 13+
- ✅ Edge 80+

---

## 🆘 Troubleshooting

### **Häufige Probleme**

#### **Karte lädt nicht**
```bash
# Browser Console öffnen (F12)
# Nach JavaScript-Fehlern suchen
# Netzwerk-Tab prüfen
```

#### **Events werden nicht angezeigt**
1. Refresh-Button klicken 🔄
2. Browser-Cache leeren
3. API-Endpunkt testen: `/api/events`

#### **Mobile Sidebar öffnet nicht**
1. JavaScript aktiviert prüfen
2. Hamburger-Button (☰) klicken
3. Seite neu laden

### **Performance-Probleme**
- **Langsame Karte:** Zoom verringern
- **Lange Ladezeiten:** Netzwerkverbindung prüfen
- **Memory Issues:** Seite neu laden

---

## 📞 Support & Kontakt

**Bei technischen Problemen:**
1. **Browser-Console** prüfen (F12 → Console)
2. **Network-Tab** für API-Fehler überprüfen
3. **Seite neu laden** (Ctrl+F5)
4. **Cache leeren** in Browser-Einstellungen

**Datenquelle:** [GDACS.org](https://www.gdacs.org/)  
**Update-Frequenz:** Alle 30 Minuten  
**Datenqualität:** ⚠️ Nur für Informationszwecke