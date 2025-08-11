/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: risk_radar1
-- ------------------------------------------------------
-- Server version	10.6.22-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ai_cost_alerts`
--

DROP TABLE IF EXISTS `ai_cost_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_cost_alerts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ai_quota_id` bigint(20) unsigned DEFAULT NULL,
  `alert_type` enum('cost_warning','cost_critical','quota_exceeded','error_threshold','system_health','daily_report','weekly_report') NOT NULL DEFAULT 'cost_warning',
  `severity` enum('info','warning','critical','emergency') NOT NULL DEFAULT 'warning',
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `trigger_source` varchar(255) DEFAULT NULL,
  `threshold_value` decimal(10,2) DEFAULT NULL,
  `current_value` decimal(10,2) DEFAULT NULL,
  `limit_value` decimal(10,2) DEFAULT NULL,
  `metric_type` varchar(255) DEFAULT NULL,
  `context_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`context_data`)),
  `model` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `period_date` date DEFAULT NULL,
  `status` enum('pending','sent','delivered','failed','acknowledged','resolved') NOT NULL DEFAULT 'pending',
  `channels` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`channels`)),
  `delivery_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`delivery_status`)),
  `delivery_error` text DEFAULT NULL,
  `triggered_at` timestamp NULL DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `acknowledged_at` timestamp NULL DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `alert_key` varchar(255) DEFAULT NULL,
  `occurrence_count` int(11) NOT NULL DEFAULT 1,
  `first_occurrence_at` timestamp NULL DEFAULT NULL,
  `last_occurrence_at` timestamp NULL DEFAULT NULL,
  `actions_taken` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`actions_taken`)),
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_cost_alerts_ai_quota_id_foreign` (`ai_quota_id`),
  KEY `ai_cost_alerts_user_id_alert_type_status_index` (`user_id`,`alert_type`,`status`),
  KEY `ai_cost_alerts_alert_type_severity_status_index` (`alert_type`,`severity`,`status`),
  KEY `ai_cost_alerts_status_triggered_at_index` (`status`,`triggered_at`),
  KEY `ai_cost_alerts_alert_key_status_index` (`alert_key`,`status`),
  KEY `ai_cost_alerts_expires_at_status_index` (`expires_at`,`status`),
  KEY `ai_cost_alerts_period_date_alert_type_index` (`period_date`,`alert_type`),
  CONSTRAINT `ai_cost_alerts_ai_quota_id_foreign` FOREIGN KEY (`ai_quota_id`) REFERENCES `ai_quotas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ai_cost_alerts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_cost_alerts`
--

LOCK TABLES `ai_cost_alerts` WRITE;
/*!40000 ALTER TABLE `ai_cost_alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_cost_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_examples`
--

DROP TABLE IF EXISTS `ai_examples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_examples` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT 'Example description',
  `input_text` text NOT NULL COMMENT 'Input text for the example',
  `expected_output` text NOT NULL COMMENT 'Expected output for the example',
  `prompt_template_id` bigint(20) unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Active status',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_examples_is_active_index` (`is_active`),
  KEY `ai_examples_prompt_template_id_index` (`prompt_template_id`),
  KEY `ai_examples_prompt_template_id_is_active_index` (`prompt_template_id`,`is_active`),
  CONSTRAINT `ai_examples_prompt_template_id_foreign` FOREIGN KEY (`prompt_template_id`) REFERENCES `prompt_templates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_examples`
--

LOCK TABLES `ai_examples` WRITE;
/*!40000 ALTER TABLE `ai_examples` DISABLE KEYS */;
INSERT INTO `ai_examples` VALUES (1,'Mallorca Storm Classification Example','news_article: \"PALMA, Mallorca - Ein schwerer Sturm mit Windgeschwindigkeiten bis zu 120 km/h hat am Dienstag die Baleareninsel Mallorca getroffen. Der Flughafen Palma musste den Betrieb für drei Stunden einstellen, mehrere Hotels in der Playa de Palma wurden evakuiert. Etwa 15.000 Touristen sind betroffen, verletzt wurde niemand. Die Strände bleiben bis Donnerstag geschlossen.\"\ndestination: \"Mallorca\"\nlanguage: \"German\"','{\n  \"tourism_relevance\": 4,\n  \"event_category\": \"Extremwetter\",\n  \"impact_level\": \"HIGH\",\n  \"affected_sectors\": [\"transport\", \"accommodation\", \"beaches\"],\n  \"location_coordinates\": {\"lat\": 39.5696, \"lng\": 2.6502},\n  \"duration_estimate_days\": 3,\n  \"tourist_advisory\": {\n    \"de\": \"HOCH: Reisen nach Mallorca derzeit nicht empfohlen. Flughafen zeitweise geschlossen, Hotels evakuiert. Situation wird überwacht.\",\n    \"en\": \"HIGH: Travel to Mallorca currently not recommended. Airport temporarily closed, hotels evacuated. Situation being monitored.\"\n  },\n  \"confidence_score\": 0.9,\n  \"keywords\": [\"sturm\", \"mallorca\", \"flughafen\", \"evakuierung\", \"touristen\"]\n}',1,1,'2025-08-02 13:22:52','2025-08-02 13:22:52',NULL),(2,'Thailand Flooding Classification Example','news_article: \"BANGKOK - Heavy monsoon rains have caused widespread flooding in central Bangkok, affecting the popular Khao San Road area and Chatuchak Weekend Market. River boat services have been suspended, but Suvarnabhumi Airport remains operational. Tourism authorities estimate 2,000 tourists in affected areas, with hotels providing alternative accommodations.\"\ndestination: \"Bangkok\"\nlanguage: \"English\"','{\n  \"tourism_relevance\": 3,\n  \"event_category\": \"Naturkatastrophe\",\n  \"impact_level\": \"MEDIUM\",\n  \"affected_sectors\": [\"attractions\", \"transport\", \"accommodation\"],\n  \"location_coordinates\": {\"lat\": 13.7563, \"lng\": 100.5018},\n  \"duration_estimate_days\": 5,\n  \"tourist_advisory\": {\n    \"de\": \"MODERAT: Bangkok-Reisen mit Vorsicht. Überschwemmungen in Touristengebieten. Flughafen weiterhin geöffnet.\",\n    \"en\": \"MEDIUM: Travel to Bangkok with caution. Flooding in tourist areas. Airport remains operational.\"\n  },\n  \"confidence_score\": 0.85,\n  \"keywords\": [\"bangkok\", \"flooding\", \"khao san road\", \"monsoon\", \"tourists\"]\n}',1,1,'2025-08-02 13:22:52','2025-08-02 13:22:52',NULL),(3,'Turkey Earthquake Multi-Source Synthesis','news_sources: \n- \"BBC: 6.8 earthquake hits Izmir, Turkey. 12 injured, airport closed for inspection.\"\n- \"CNN: Turkey earthquake affects coastal tourism. Hotels in Bodrum report structural damage.\"\n- \"Turkish Daily News: Kusadasi evacuation ongoing, cruise ships diverted to alternative ports.\"\n- \"Deutsche Welle: German tourists in affected areas urged to contact embassy.\"\n\nregion: \"Aegean Coast, Turkey\"\ntime_period: \"2024-08-15 06:30 - 2024-08-15 18:00\"','**EREIGNIS-ZUSAMMENFASSUNG:**\n- Hauptereignis: 6.8 Magnitude Erdbeben an der türkischen Ägäisküste\n- Schweregrad: HIGH\n- Betroffene Region: Izmir, Bodrum, Kusadasi, weitere Küstengebiete\n\n**QUELLEN-BEWERTUNG:**\n- BBC: Glaubwürdigkeit 5/5\n  Besonderheiten: Erste offizielle Verletzungszahlen und Flughafenstatus\n- CNN: Glaubwürdigkeit 4/5\n  Besonderheiten: Fokus auf Tourismus-Infrastruktur\n- Turkish Daily News: Glaubwürdigkeit 4/5\n  Besonderheiten: Lokale Details zu Evakuierungen\n- Deutsche Welle: Glaubwürdigkeit 5/5\n  Besonderheiten: Konsularische Unterstützung für deutsche Touristen\n\n**TOURISMUS-AUSWIRKUNGEN:**\n- Sofortige Auswirkungen: Flughafenschließung, Hotelevakuierungen, Kreuzfahrtumleitungen\n- Mittelfristige Auswirkungen (1-4 Wochen): Strukturprüfungen, reduzierte Hotelkapazitäten\n- Langfristige Auswirkungen (1+ Monate): Wiederaufbau, Vertrauensrückgewinnung\n\n**REISE-EMPFEHLUNGEN:**\n- Derzeit vor Ort: Botschaft kontaktieren, sichere Unterkünfte aufsuchen\n- Geplante Reisen: Verschiebung für 7-14 Tage empfohlen\n- Alternative Destinationen: Antalya, griechische Inseln\n\n**MONITORING-EMPFEHLUNGEN:**\n- Zu verfolgende Indikatoren: Nachbeben, Flughafenstatus, Hotelwiedereröffnungen\n- Empfohlene Aktualisierungsfrequenz: Alle 6 Stunden für 48h, dann täglich',2,1,'2025-08-02 13:22:52','2025-08-02 13:22:52',NULL),(4,'Mallorca Storm Crisis Communication','news_content: \"Schwerer Sturm auf Mallorca: Flughafen geschlossen, Hotels evakuiert, 15.000 Touristen betroffen\"\ndestination: \"Mallorca\"\nseverity_level: \"HIGH\"\ntarget_languages: [\"German\", \"English\"]','**DEUTSCH:**\n\n# 🚨 WICHTIGE REISEINFORMATION: Sturm auf Mallorca\n\n**Aktuelle Situation (Stand: 15.08.2024, 14:30 Uhr):**\nEin schwerer Sturm mit Windgeschwindigkeiten bis zu 120 km/h betrifft derzeit Mallorca. Der Flughafen Palma ist vorübergehend geschlossen, mehrere Hotels wurden als Vorsichtsmaßnahme evakuiert.\n\n**SOFORTMASSNAHMEN - SCHWEREGRAD HOCH:**\n• Geplante Reisen nach Mallorca verschieben oder stornieren\n• Bereits vor Ort: Sichere Bereiche im Hotel aufsuchen, Anweisungen des Hotelpersonals befolgen\n• Regelmäßige Updates von offiziellen Quellen verfolgen\n• Bei Notfällen: Spanische Notrufnummer 112\n\n**PRAKTISCHE INFORMATIONEN:**\n• Betroffene Gebiete: Gesamte Insel, besonders Playa de Palma\n• Transport-Status: Flughafen Palma geschlossen, Wiedereröffnung geplant für Donnerstag\n• Unterkünfte: Evakuierte Hotels bieten alternative Unterbringung\n• Strände: Gesperrt bis Donnerstag\n\n**KONTAKT-INFORMATIONEN:**\n• Spanische Notrufnummer: 112\n• Deutsche Botschaft Madrid: +34 91 557 90 00\n• Reiseversicherung: Prüfen Sie Ihre Policen-Bedingungen\n• Airline-Hotlines: Kontaktieren Sie Ihre Fluggesellschaft\n\n**Haftungsausschluss:** Diese Information basiert auf aktuell verfügbaren Daten. Situation kann sich schnell ändern.\n\n---\n\n**ENGLISH:**\n\n# 🚨 URGENT TRAVEL ALERT: Storm in Mallorca\n\n**Current Situation (Updated: 15.08.2024, 2:30 PM):**\nA severe storm with wind speeds up to 120 km/h is currently affecting Mallorca. Palma Airport is temporarily closed, several hotels have been evacuated as precautionary measure.\n\n**IMMEDIATE ACTIONS - HIGH SEVERITY:**\n• Postpone or cancel planned travel to Mallorca\n• Currently on location: Seek safe areas in hotel, follow staff instructions\n• Monitor official sources for regular updates\n• In emergencies: Spanish emergency number 112\n\n**PRACTICAL INFORMATION:**\n• Affected areas: Entire island, especially Playa de Palma\n• Transport status: Palma Airport closed, reopening planned for Thursday\n• Accommodation: Evacuated hotels providing alternative lodging\n• Beaches: Closed until Thursday\n\n**CONTACT INFORMATION:**\n• Spanish Emergency Number: 112\n• Your Embassy: Contact your local embassy\n• Travel Insurance: Check your policy conditions\n• Airline Hotlines: Contact your airline directly\n\n**Disclaimer:** This information is based on currently available data. Situation may change rapidly.',3,1,'2025-08-02 13:22:52','2025-08-02 13:22:52',NULL),(5,'Bangkok Flooding Crisis Communication','news_content: \"Bangkok floods affect tourist areas including Khao San Road. Airport operational, river boats suspended.\"\ndestination: \"Bangkok\"\nseverity_level: \"MEDIUM\"\ntarget_languages: [\"English\", \"German\"]','**ENGLISH:**\n\n# ⚠️ TRAVEL UPDATE: Flooding in Bangkok Tourist Areas\n\n**Current Situation (Updated: 28.07.2024, 10:00 AM):**\nHeavy monsoon rains have caused localized flooding in central Bangkok tourist areas. Khao San Road and surrounding areas are affected, but Suvarnabhumi Airport remains fully operational.\n\n**PRECAUTIONARY MEASURES - MEDIUM SEVERITY:**\n• Exercise increased caution when traveling in Bangkok\n• Contact local authorities or hotel for area-specific guidance\n• Keep travel plans flexible and monitor weather updates\n• Avoid flooded areas and use alternative routes\n\n**PRACTICAL INFORMATION:**\n• Affected areas: Khao San Road, Chatuchuk area, some riverside locations\n• Transport status: Airport operational, river boats suspended, BTS/MRT running\n• Accommodation: Hotels providing alternative arrangements where needed\n• Medical services: Available, emergency services operational\n\n**CONTACT INFORMATION:**\n• Thai Emergency Services: 191 (Police), 199 (Fire/Rescue)\n• Tourist Hotline: 1672\n• Your Embassy: Contact for assistance if needed\n• Hotel Concierge: Best source for local conditions\n\n**Disclaimer:** Monsoon flooding is common and typically resolves within 24-48 hours.\n\n---\n\n**DEUTSCH:**\n\n# ⚠️ REISE-UPDATE: Überschwemmungen in Bangkok Touristengebieten\n\n**Aktuelle Situation (Stand: 28.07.2024, 10:00 Uhr):**\nStarke Monsunregen haben zu lokalen Überschwemmungen in zentralen Bangkok Touristengebieten geführt. Die Khao San Road und Umgebung sind betroffen, aber der Flughafen Suvarnabhumi ist voll funktionsfähig.\n\n**VORSICHTSMAßNAHMEN - MITTLERER SCHWEREGRAD:**\n• Erhöhte Vorsicht bei Reisen in Bangkok\n• Lokale Behörden oder Hotel für gebietsspezifische Hinweise kontaktieren\n• Reisepläne flexibel halten und Wetterupdates verfolgen\n• Überflutete Gebiete meiden und alternative Routen nutzen\n\n**PRAKTISCHE INFORMATIONEN:**\n• Betroffene Gebiete: Khao San Road, Chatuchuk-Gebiet, einige Flussufer-Standorte\n• Transport-Status: Flughafen funktionsfähig, Flussboote ausgesetzt, BTS/MRT fahren\n• Unterkünfte: Hotels bieten bei Bedarf alternative Arrangements\n• Medizinische Versorgung: Verfügbar, Rettungsdienste einsatzbereit\n\n**KONTAKT-INFORMATIONEN:**\n• Thai Notdienste: 191 (Polizei), 199 (Feuerwehr/Rettung)\n• Touristen-Hotline: 1672\n• Deutsche Botschaft: Bei Bedarf um Unterstützung bitten\n• Hotel-Concierge: Beste Quelle für lokale Bedingungen\n\n**Haftungsausschluss:** Monsun-Überschwemmungen sind üblich und lösen sich typischerweise binnen 24-48 Stunden auf.',3,1,'2025-08-02 13:22:52','2025-08-02 13:22:52',NULL);
/*!40000 ALTER TABLE `ai_examples` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_job_progress`
--

DROP TABLE IF EXISTS `ai_job_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_job_progress` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` varchar(255) NOT NULL,
  `batch_id` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'single',
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `total_items` int(11) NOT NULL DEFAULT 1,
  `processed_items` int(11) NOT NULL DEFAULT 0,
  `failed_items` int(11) NOT NULL DEFAULT 0,
  `progress_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `error_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`error_details`)),
  `tokens_used` int(11) NOT NULL DEFAULT 0,
  `cost_accumulated` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ai_job_progress_job_id_unique` (`job_id`),
  KEY `ai_job_progress_status_type_index` (`status`,`type`),
  KEY `ai_job_progress_batch_id_status_index` (`batch_id`,`status`),
  KEY `ai_job_progress_created_at_index` (`created_at`),
  KEY `ai_job_progress_batch_id_index` (`batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_job_progress`
--

LOCK TABLES `ai_job_progress` WRITE;
/*!40000 ALTER TABLE `ai_job_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_job_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_processing_logs`
--

DROP TABLE IF EXISTS `ai_processing_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_processing_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `disaster_event_id` bigint(20) unsigned NOT NULL,
  `prompt_template_id` bigint(20) unsigned NOT NULL,
  `input_text` text NOT NULL COMMENT 'Input text sent to AI',
  `output_text` text DEFAULT NULL COMMENT 'AI response output',
  `model_used` varchar(50) NOT NULL COMMENT 'AI model that was used',
  `tokens_used` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Number of tokens consumed',
  `processing_time` float NOT NULL DEFAULT 0 COMMENT 'Processing time in seconds',
  `status` enum('pending','success','failed') NOT NULL DEFAULT 'pending' COMMENT 'Processing status',
  `error_message` text DEFAULT NULL COMMENT 'Error message if processing failed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_processing_logs_disaster_event_id_index` (`disaster_event_id`),
  KEY `ai_processing_logs_prompt_template_id_index` (`prompt_template_id`),
  KEY `ai_processing_logs_status_index` (`status`),
  KEY `ai_processing_logs_model_used_index` (`model_used`),
  KEY `ai_processing_logs_created_at_index` (`created_at`),
  KEY `ai_processing_logs_disaster_event_id_created_at_index` (`disaster_event_id`,`created_at`),
  KEY `ai_processing_logs_status_created_at_index` (`status`,`created_at`),
  KEY `ai_processing_logs_prompt_template_id_status_index` (`prompt_template_id`,`status`),
  CONSTRAINT `ai_processing_logs_disaster_event_id_foreign` FOREIGN KEY (`disaster_event_id`) REFERENCES `disaster_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ai_processing_logs_prompt_template_id_foreign` FOREIGN KEY (`prompt_template_id`) REFERENCES `prompt_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_processing_logs`
--

LOCK TABLES `ai_processing_logs` WRITE;
/*!40000 ALTER TABLE `ai_processing_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_processing_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_quotas`
--

DROP TABLE IF EXISTS `ai_quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_quotas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `quota_type` varchar(255) NOT NULL DEFAULT 'user',
  `period` varchar(255) NOT NULL DEFAULT 'monthly',
  `model` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `user_tier` varchar(255) NOT NULL DEFAULT 'basic',
  `cost_limit_usd` decimal(12,2) NOT NULL DEFAULT 0.00,
  `token_limit` bigint(20) NOT NULL DEFAULT 0,
  `request_limit` int(11) NOT NULL DEFAULT 0,
  `current_cost_usd` decimal(12,2) NOT NULL DEFAULT 0.00,
  `current_tokens` bigint(20) NOT NULL DEFAULT 0,
  `current_requests` int(11) NOT NULL DEFAULT 0,
  `cost_usage_percentage` decimal(5,2) GENERATED ALWAYS AS (case when `cost_limit_usd` > 0 then `current_cost_usd` / `cost_limit_usd` * 100 else 0 end) STORED,
  `token_usage_percentage` decimal(5,2) GENERATED ALWAYS AS (case when `token_limit` > 0 then `current_tokens` / `token_limit` * 100 else 0 end) STORED,
  `request_usage_percentage` decimal(5,2) GENERATED ALWAYS AS (case when `request_limit` > 0 then `current_requests` / `request_limit` * 100 else 0 end) STORED,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_exceeded` tinyint(1) NOT NULL DEFAULT 0,
  `alerts_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `hard_limit` tinyint(1) NOT NULL DEFAULT 1,
  `last_reset_at` timestamp NULL DEFAULT NULL,
  `next_reset_at` timestamp NULL DEFAULT NULL,
  `period_start` date DEFAULT NULL,
  `period_end` date DEFAULT NULL,
  `warning_threshold` decimal(5,2) NOT NULL DEFAULT 75.00,
  `critical_threshold` decimal(5,2) NOT NULL DEFAULT 90.00,
  `last_warning_sent_at` timestamp NULL DEFAULT NULL,
  `last_critical_sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_quota` (`user_id`,`quota_type`,`period`,`model`,`provider`) USING HASH,
  KEY `ai_quotas_user_id_period_is_active_index` (`user_id`,`period`,`is_active`),
  KEY `ai_quotas_quota_type_period_index` (`quota_type`,`period`),
  KEY `ai_quotas_model_period_index` (`model`,`period`),
  KEY `ai_quotas_provider_period_index` (`provider`,`period`),
  KEY `ai_quotas_is_exceeded_is_active_index` (`is_exceeded`,`is_active`),
  KEY `ai_quotas_next_reset_at_is_active_index` (`next_reset_at`,`is_active`),
  CONSTRAINT `ai_quotas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_quotas`
--

LOCK TABLES `ai_quotas` WRITE;
/*!40000 ALTER TABLE `ai_quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_system_health`
--

DROP TABLE IF EXISTS `ai_system_health`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_system_health` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_name` varchar(255) NOT NULL DEFAULT 'ai_service',
  `instance_id` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `status` enum('healthy','degraded','unhealthy','maintenance') NOT NULL DEFAULT 'healthy',
  `cpu_usage` decimal(5,2) DEFAULT NULL,
  `memory_usage` decimal(5,2) DEFAULT NULL,
  `memory_used_mb` bigint(20) DEFAULT NULL,
  `memory_total_mb` bigint(20) DEFAULT NULL,
  `avg_response_time` decimal(8,3) DEFAULT NULL,
  `p95_response_time` decimal(8,3) DEFAULT NULL,
  `p99_response_time` decimal(8,3) DEFAULT NULL,
  `requests_per_minute` int(11) DEFAULT NULL,
  `successful_requests` int(11) DEFAULT NULL,
  `failed_requests` int(11) DEFAULT NULL,
  `error_rate` decimal(5,2) DEFAULT NULL,
  `queue_size` int(11) DEFAULT NULL,
  `avg_queue_wait_time` decimal(8,3) DEFAULT NULL,
  `active_jobs` int(11) DEFAULT NULL,
  `failed_jobs` int(11) DEFAULT NULL,
  `provider_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`provider_status`)),
  `provider_response_times` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`provider_response_times`)),
  `provider_error_rates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`provider_error_rates`)),
  `hourly_cost` decimal(10,4) DEFAULT NULL,
  `daily_cost` decimal(10,2) DEFAULT NULL,
  `daily_requests` int(11) DEFAULT NULL,
  `daily_tokens` bigint(20) DEFAULT NULL,
  `alerts_triggered` tinyint(1) NOT NULL DEFAULT 0,
  `active_alerts` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`active_alerts`)),
  `last_alert_at` timestamp NULL DEFAULT NULL,
  `db_connections_active` int(11) DEFAULT NULL,
  `db_connections_max` int(11) DEFAULT NULL,
  `db_query_time_avg` decimal(8,3) DEFAULT NULL,
  `db_slow_queries` int(11) DEFAULT NULL,
  `cache_hit_rate` decimal(5,2) DEFAULT NULL,
  `cache_memory_used` bigint(20) DEFAULT NULL,
  `cache_keys_count` int(11) DEFAULT NULL,
  `custom_metrics` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`custom_metrics`)),
  `notes` text DEFAULT NULL,
  `checked_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_system_health_service_name_status_checked_at_index` (`service_name`,`status`,`checked_at`),
  KEY `ai_system_health_status_checked_at_index` (`status`,`checked_at`),
  KEY `ai_system_health_checked_at_service_name_index` (`checked_at`,`service_name`),
  KEY `ai_system_health_alerts_triggered_checked_at_index` (`alerts_triggered`,`checked_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_system_health`
--

LOCK TABLES `ai_system_health` WRITE;
/*!40000 ALTER TABLE `ai_system_health` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_system_health` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_usage_tracking`
--

DROP TABLE IF EXISTS `ai_usage_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_usage_tracking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ai_processing_log_id` bigint(20) unsigned DEFAULT NULL,
  `model` varchar(255) NOT NULL,
  `provider` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL DEFAULT 'standard',
  `request_type` text DEFAULT NULL,
  `input_tokens` int(11) NOT NULL DEFAULT 0,
  `output_tokens` int(11) NOT NULL DEFAULT 0,
  `total_tokens` int(11) GENERATED ALWAYS AS (`input_tokens` + `output_tokens`) STORED,
  `input_cost_usd` decimal(10,6) NOT NULL DEFAULT 0.000000,
  `output_cost_usd` decimal(10,6) NOT NULL DEFAULT 0.000000,
  `total_cost_usd` decimal(10,6) GENERATED ALWAYS AS (`input_cost_usd` + `output_cost_usd`) STORED,
  `currency` varchar(3) NOT NULL DEFAULT 'USD',
  `exchange_rate` decimal(8,4) NOT NULL DEFAULT 1.0000,
  `total_cost_local` decimal(10,6) NOT NULL DEFAULT 0.000000,
  `processing_time` decimal(8,3) DEFAULT NULL,
  `queue_wait_time` decimal(8,3) DEFAULT NULL,
  `response_time` decimal(8,3) DEFAULT NULL,
  `status` enum('pending','processing','success','failed','timeout') NOT NULL DEFAULT 'pending',
  `error_message` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `usage_date` date GENERATED ALWAYS AS (cast(`created_at` as date)) STORED,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_usage_tracking_ai_processing_log_id_foreign` (`ai_processing_log_id`),
  KEY `ai_usage_tracking_user_id_usage_date_index` (`user_id`,`usage_date`),
  KEY `ai_usage_tracking_model_usage_date_index` (`model`,`usage_date`),
  KEY `ai_usage_tracking_provider_usage_date_index` (`provider`,`usage_date`),
  KEY `ai_usage_tracking_status_created_at_index` (`status`,`created_at`),
  KEY `ai_usage_tracking_usage_date_index` (`usage_date`),
  CONSTRAINT `ai_usage_tracking_ai_processing_log_id_foreign` FOREIGN KEY (`ai_processing_log_id`) REFERENCES `ai_processing_logs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ai_usage_tracking_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_usage_tracking`
--

LOCK TABLES `ai_usage_tracking` WRITE;
/*!40000 ALTER TABLE `ai_usage_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_usage_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `iata_code` varchar(3) DEFAULT NULL COMMENT 'IATA airport code',
  `icao_code` varchar(4) DEFAULT NULL COMMENT 'ICAO airport code',
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Multilingual airport name' CHECK (json_valid(`name`)),
  `latitude` decimal(10,8) NOT NULL COMMENT 'Latitude coordinate',
  `longitude` decimal(11,8) NOT NULL COMMENT 'Longitude coordinate',
  `elevation_m` int(11) DEFAULT NULL COMMENT 'Elevation in meters',
  `type` varchar(50) NOT NULL DEFAULT 'airport' COMMENT 'Type: airport, heliport, seaplane_base, etc.',
  `size` varchar(20) DEFAULT NULL COMMENT 'Size classification: large, medium, small',
  `is_international` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'International airport status',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Currently operational',
  `city_id` bigint(20) unsigned DEFAULT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `timezone` varchar(50) DEFAULT NULL COMMENT 'IANA timezone identifier',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `airports_iata_code_unique` (`iata_code`),
  UNIQUE KEY `airports_icao_code_unique` (`icao_code`),
  KEY `airports_iata_code_index` (`iata_code`),
  KEY `airports_icao_code_index` (`icao_code`),
  KEY `airports_latitude_index` (`latitude`),
  KEY `airports_longitude_index` (`longitude`),
  KEY `airports_latitude_longitude_index` (`latitude`,`longitude`),
  KEY `airports_city_id_index` (`city_id`),
  KEY `airports_country_id_index` (`country_id`),
  KEY `airports_type_index` (`type`),
  KEY `airports_size_index` (`size`),
  KEY `airports_is_international_index` (`is_international`),
  KEY `airports_is_active_index` (`is_active`),
  KEY `airports_country_id_is_international_is_active_index` (`country_id`,`is_international`,`is_active`),
  KEY `airports_city_id_type_is_active_index` (`city_id`,`type`,`is_active`),
  KEY `airports_coordinates_idx` (`latitude`,`longitude`),
  KEY `airports_country_active_idx` (`country_id`,`is_active`),
  KEY `airports_city_active_idx` (`city_id`,`is_active`),
  KEY `airports_international_active_idx` (`is_international`,`is_active`),
  KEY `airports_type_size_idx` (`type`,`size`),
  KEY `airports_iata_idx` (`iata_code`),
  KEY `airports_icao_idx` (`icao_code`),
  KEY `airports_country_type_size_active_idx` (`country_id`,`type`,`size`,`is_active`),
  KEY `airports_city_international_active_idx` (`city_id`,`is_international`,`is_active`),
  KEY `airports_location_active_idx` (`latitude`,`longitude`,`is_active`),
  FULLTEXT KEY `airports_name_fulltext` (`name`),
  FULLTEXT KEY `name` (`name`),
  CONSTRAINT `airports_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL,
  CONSTRAINT `airports_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Multilingual city name' CHECK (json_valid(`name`)),
  `latitude` decimal(10,8) NOT NULL COMMENT 'Latitude coordinate',
  `longitude` decimal(11,8) NOT NULL COMMENT 'Longitude coordinate',
  `population` bigint(20) DEFAULT NULL COMMENT 'City population',
  `is_capital` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is national capital',
  `is_regional_capital` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is regional/state capital',
  `region_id` bigint(20) unsigned DEFAULT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `timezone` varchar(50) DEFAULT NULL COMMENT 'IANA timezone identifier',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cities_latitude_index` (`latitude`),
  KEY `cities_longitude_index` (`longitude`),
  KEY `cities_latitude_longitude_index` (`latitude`,`longitude`),
  KEY `cities_country_id_index` (`country_id`),
  KEY `cities_region_id_index` (`region_id`),
  KEY `cities_is_capital_index` (`is_capital`),
  KEY `cities_is_regional_capital_index` (`is_regional_capital`),
  KEY `cities_population_index` (`population`),
  KEY `cities_timezone_index` (`timezone`),
  KEY `cities_coordinates_idx` (`latitude`,`longitude`),
  KEY `cities_country_population_idx` (`country_id`,`population`),
  KEY `cities_region_population_idx` (`region_id`,`population`),
  KEY `cities_capital_population_idx` (`is_capital`,`population`),
  KEY `cities_regional_capital_population_idx` (`is_regional_capital`,`population`),
  KEY `cities_country_capital_population_idx` (`country_id`,`is_capital`,`population`),
  KEY `cities_region_capital_population_idx` (`region_id`,`is_regional_capital`,`population`),
  KEY `cities_timezone_population_idx` (`timezone`,`population`),
  KEY `cities_location_population_idx` (`latitude`,`longitude`,`population`),
  KEY `cities_location_covering_idx` (`latitude`,`longitude`,`country_id`,`population`,`is_capital`,`is_regional_capital`),
  FULLTEXT KEY `cities_name_fulltext` (`name`),
  FULLTEXT KEY `name` (`name`),
  CONSTRAINT `cities_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cities_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `continents`
--

DROP TABLE IF EXISTS `continents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `continents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(2) NOT NULL COMMENT 'Two-letter continent code',
  `area_km2` decimal(12,2) DEFAULT NULL COMMENT 'Area in square kilometers',
  `population` bigint(20) DEFAULT NULL COMMENT 'Estimated population',
  `latitude` decimal(10,8) DEFAULT NULL COMMENT 'Latitude coordinate',
  `longitude` decimal(11,8) DEFAULT NULL COMMENT 'Longitude coordinate',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `continents_name_unique` (`name`),
  UNIQUE KEY `continents_code_unique` (`code`),
  KEY `continents_name_index` (`name`),
  KEY `continents_code_index` (`code`),
  KEY `continents_coordinates_idx` (`latitude`,`longitude`),
  KEY `continents_code_idx` (`code`),
  FULLTEXT KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continents`
--

LOCK TABLES `continents` WRITE;
/*!40000 ALTER TABLE `continents` DISABLE KEYS */;
INSERT INTO `continents` VALUES (1,'{\"en\":\"Europe\",\"de\":\"Europa\"}','EU',NULL,NULL,50.00000000,10.00000000,'2025-08-02 12:59:42','2025-08-02 12:59:42',NULL);
/*!40000 ALTER TABLE `continents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `iso_code` varchar(2) NOT NULL COMMENT 'ISO 3166-1 alpha-2 code',
  `iso3_code` varchar(3) NOT NULL COMMENT 'ISO 3166-1 alpha-3 code',
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Multilingual country name' CHECK (json_valid(`name`)),
  `eu_member` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'European Union membership status',
  `schengen_member` tinyint(1) NOT NULL DEFAULT 0,
  `official_languages` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`official_languages`)),
  `spoken_languages` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`spoken_languages`)),
  `english_proficiency` varchar(20) DEFAULT NULL,
  `climate_zone` varchar(30) DEFAULT NULL,
  `best_travel_months` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`best_travel_months`)),
  `rainy_season_months` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`rainy_season_months`)),
  `avg_temp_min` int(11) DEFAULT NULL,
  `avg_temp_max` int(11) DEFAULT NULL,
  `travel_notes` text DEFAULT NULL,
  `population` bigint(20) DEFAULT NULL COMMENT 'Total population',
  `area_km2` decimal(12,2) DEFAULT NULL COMMENT 'Total area in square kilometers',
  `latitude` decimal(10,8) DEFAULT NULL COMMENT 'Latitude coordinate',
  `longitude` decimal(11,8) DEFAULT NULL COMMENT 'Longitude coordinate',
  `continent_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `countries_iso_code_unique` (`iso_code`),
  UNIQUE KEY `countries_iso3_code_unique` (`iso3_code`),
  KEY `countries_iso_code_index` (`iso_code`),
  KEY `countries_iso3_code_index` (`iso3_code`),
  KEY `countries_eu_member_index` (`eu_member`),
  KEY `countries_continent_id_index` (`continent_id`),
  KEY `countries_population_index` (`population`),
  KEY `countries_area_km2_index` (`area_km2`),
  KEY `countries_coordinates_idx` (`latitude`,`longitude`),
  KEY `countries_continent_population_idx` (`continent_id`,`population`),
  KEY `countries_iso_codes_idx` (`iso_code`,`iso3_code`),
  KEY `countries_continent_population_area_idx` (`continent_id`,`population`,`area_km2`),
  KEY `countries_codes_idx` (`iso_code`,`iso3_code`),
  KEY `countries_basic_covering_idx` (`iso_code`,`iso3_code`,`continent_id`,`population`),
  FULLTEXT KEY `countries_name_fulltext` (`name`),
  FULLTEXT KEY `name` (`name`),
  CONSTRAINT `countries_continent_id_foreign` FOREIGN KEY (`continent_id`) REFERENCES `continents` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'ES','ESP','{\"en\":\"Spain\",\"de\":\"Spanien\"}',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,47000000,505370.00,40.00000000,-4.00000000,1,'2025-08-02 12:59:42','2025-08-02 12:59:42',NULL);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disaster_events`
--

DROP TABLE IF EXISTS `disaster_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `disaster_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `severity_level` varchar(50) NOT NULL,
  `event_type` varchar(255) NOT NULL DEFAULT 'unknown',
  `latitude` decimal(10,8) DEFAULT NULL COMMENT 'Latitude coordinate',
  `longitude` decimal(11,8) DEFAULT NULL COMMENT 'Longitude coordinate',
  `affected_radius_km` decimal(8,2) DEFAULT NULL,
  `affected_area` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Multilingual affected area description' CHECK (json_valid(`affected_area`)),
  `casualties` int(10) unsigned DEFAULT NULL COMMENT 'Number of casualties',
  `economic_damage` decimal(15,2) DEFAULT NULL,
  `impact_description` text DEFAULT NULL,
  `date` date NOT NULL COMMENT 'Date of the disaster event',
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `is_ongoing` tinyint(1) NOT NULL DEFAULT 1,
  `casualties_min` int(11) DEFAULT NULL,
  `casualties_max` int(11) DEFAULT NULL,
  `people_affected_min` int(11) DEFAULT NULL,
  `people_affected_max` int(11) DEFAULT NULL,
  `economic_damage_usd` decimal(15,2) DEFAULT NULL,
  `source_urls` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`source_urls`)),
  `verified_at` timestamp NULL DEFAULT NULL,
  `tourism_impact` tinyint(1) NOT NULL DEFAULT 0,
  `tourism_impact_level` enum('none','low','medium','high','critical') NOT NULL DEFAULT 'none',
  `affected_tourism_sectors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`affected_tourism_sectors`)),
  `travel_restrictions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`travel_restrictions`)),
  `tourist_advisory` text DEFAULT NULL,
  `alternative_routes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`alternative_routes`)),
  `affects_popular_destinations` tinyint(1) NOT NULL DEFAULT 0,
  `gdacs_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`gdacs_data`)),
  `estimated_tourists_affected` int(11) DEFAULT NULL,
  `estimated_economic_impact_tourism` decimal(15,2) DEFAULT NULL,
  `tourism_recovery_days` int(11) DEFAULT NULL,
  `tourism_recovery_date` timestamp NULL DEFAULT NULL,
  `verified_by` bigint(20) unsigned DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `time` time DEFAULT NULL COMMENT 'Time of the disaster event',
  `source` varchar(255) DEFAULT NULL COMMENT 'Source of information',
  `continent_id` bigint(20) unsigned DEFAULT NULL,
  `country_id` bigint(20) unsigned DEFAULT NULL,
  `region_id` bigint(20) unsigned DEFAULT NULL,
  `city_id` bigint(20) unsigned DEFAULT NULL,
  `airport_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `disaster_events_severity_level_index` (`severity_level`),
  KEY `disaster_events_date_index` (`date`),
  KEY `disaster_events_date_severity_level_index` (`date`,`severity_level`),
  KEY `disaster_events_casualties_index` (`casualties`),
  KEY `disaster_events_latitude_index` (`latitude`),
  KEY `disaster_events_longitude_index` (`longitude`),
  KEY `disaster_events_latitude_longitude_index` (`latitude`,`longitude`),
  KEY `disaster_events_continent_id_index` (`continent_id`),
  KEY `disaster_events_country_id_index` (`country_id`),
  KEY `disaster_events_region_id_index` (`region_id`),
  KEY `disaster_events_city_id_index` (`city_id`),
  KEY `disaster_events_airport_id_index` (`airport_id`),
  KEY `disaster_events_coordinates_idx` (`latitude`,`longitude`),
  KEY `disaster_events_country_severity_idx` (`country_id`,`severity_level`),
  KEY `disaster_events_date_severity_idx` (`date`,`severity_level`),
  KEY `disaster_events_country_severity_date_idx` (`country_id`,`severity_level`,`date`),
  KEY `disaster_events_location_severity_idx` (`latitude`,`longitude`,`severity_level`),
  KEY `disaster_events_location_covering_idx` (`latitude`,`longitude`,`severity_level`,`date`,`country_id`),
  KEY `idx_disaster_events_verified_at` (`verified_at`),
  KEY `idx_disaster_events_event_type` (`event_type`),
  KEY `idx_disaster_events_start_date` (`start_date`),
  KEY `idx_disaster_events_is_ongoing` (`is_ongoing`),
  KEY `disaster_events_country_ongoing_idx` (`country_id`,`is_ongoing`),
  KEY `disaster_events_severity_ongoing_idx` (`severity_level`,`is_ongoing`),
  KEY `disaster_events_type_verified_idx` (`event_type`,`verified_at`),
  KEY `disaster_events_date_ongoing_idx` (`start_date`,`is_ongoing`),
  KEY `disaster_events_type_severity_status_idx` (`event_type`,`severity_level`,`is_ongoing`),
  KEY `disaster_events_country_type_date_idx` (`country_id`,`event_type`,`start_date`),
  KEY `disaster_events_verified_status_severity_idx` (`verified_at`,`is_ongoing`,`severity_level`),
  KEY `disaster_events_date_range_type_idx` (`start_date`,`end_date`,`event_type`),
  KEY `disaster_events_verified_by_foreign` (`verified_by`),
  KEY `disaster_events_tourism_impact_index` (`tourism_impact`),
  KEY `disaster_events_tourism_impact_level_index` (`tourism_impact_level`),
  KEY `disaster_events_affects_popular_destinations_index` (`affects_popular_destinations`),
  FULLTEXT KEY `disaster_events_title_fulltext` (`title`),
  FULLTEXT KEY `disaster_events_description_fulltext` (`description`),
  FULLTEXT KEY `disaster_events_affected_area_fulltext` (`affected_area`),
  CONSTRAINT `disaster_events_airport_id_foreign` FOREIGN KEY (`airport_id`) REFERENCES `airports` (`id`) ON DELETE SET NULL,
  CONSTRAINT `disaster_events_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL,
  CONSTRAINT `disaster_events_continent_id_foreign` FOREIGN KEY (`continent_id`) REFERENCES `continents` (`id`) ON DELETE SET NULL,
  CONSTRAINT `disaster_events_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `disaster_events_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `disaster_events_verified_by_foreign` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disaster_events`
--

LOCK TABLES `disaster_events` WRITE;
/*!40000 ALTER TABLE `disaster_events` DISABLE KEYS */;
INSERT INTO `disaster_events` VALUES (104,'Tropical Cyclone GIL-25','Alert Score: 1','low','hurricane',18.30000000,-128.60000000,200.00,NULL,NULL,NULL,NULL,'2025-07-31','2025-07-31 07:00:00','2025-08-02 13:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=TC&eventid=1001187&episodeid=10\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1001187&episodeid=10&eventtype=TC\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=TC&eventid=1001187\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1001187',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(105,'Earthquake in ','Alert Score: 1','low','earthquake',51.53490000,159.82330000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 12:31:59','2025-08-02 12:31:59',1,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493604&episodeid=1652584\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493604&episodeid=1652584&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493604\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493604',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 15:30:40'),(106,'Earthquake in Russia','Alert Score: 1','low','earthquake',49.74690000,155.87880000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 12:26:03','2025-08-02 12:26:03',1,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493601&episodeid=1652580\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493601&episodeid=1652580&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493601\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493601',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 15:30:40'),(107,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.58290000,159.53560000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 12:18:46','2025-08-02 12:18:46',1,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493598&episodeid=1652577\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493598&episodeid=1652577&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493598\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493598',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 15:30:40'),(108,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.60810000,159.54680000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 12:14:04','2025-08-02 12:14:04',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493589&episodeid=1652572\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493589&episodeid=1652572&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493589\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493589',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(109,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.26950000,160.32050000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 11:51:50','2025-08-02 11:51:50',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493587&episodeid=1652585\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493587&episodeid=1652585&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493587\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493587',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(110,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.67650000,159.74780000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 11:36:25','2025-08-02 11:36:25',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493586&episodeid=1652561\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493586&episodeid=1652561&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493586\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493586',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(111,'Earthquake in Papua New Guinea','Alert Score: 1','low','earthquake',-6.27040000,154.99700000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 11:35:37','2025-08-02 11:35:37',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493584&episodeid=1652557\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493584&episodeid=1652557&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493584\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493584',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(112,'Tropical Cyclone THIRTEEN-25','Alert Score: 1','low','hurricane',29.60000000,139.60000000,200.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-01 22:00:00','2025-08-02 10:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=TC&eventid=1001188&episodeid=3\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1001188&episodeid=3&eventtype=TC\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=TC&eventid=1001188\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1001188',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(113,'Tropical Cyclone KROSA-25','Alert Score: 1','low','hurricane',38.30000000,145.80000000,200.00,NULL,NULL,NULL,NULL,'2025-07-23','2025-07-23 16:00:00','2025-08-02 10:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=TC&eventid=1001184&episodeid=40\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1001184&episodeid=40&eventtype=TC\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=TC&eventid=1001184\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1001184',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(114,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.55270000,159.49770000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 09:52:19','2025-08-02 09:52:19',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493571&episodeid=1652547\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493571&episodeid=1652547&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493571\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493571',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(115,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.56750000,159.56130000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 09:15:00','2025-08-02 09:15:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493568&episodeid=1652541\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493568&episodeid=1652541&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493568\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493568',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(116,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.64000000,159.55620000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 09:06:03','2025-08-02 09:06:03',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493564&episodeid=1652534\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493564&episodeid=1652534&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493564\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493564',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(117,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.21530000,160.59160000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 07:52:39','2025-08-02 07:52:39',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493566&episodeid=1652537\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493566&episodeid=1652537&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493566\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493566',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(118,'Earthquake in Russian Federation','Alert Score: 1','low','earthquake',53.08840000,159.65500000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 07:31:18','2025-08-02 07:31:18',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493555&episodeid=1652529\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493555&episodeid=1652529&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493555\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493555',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(119,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.26380000,160.66970000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 06:55:56','2025-08-02 06:55:56',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493550&episodeid=1652518\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493550&episodeid=1652518&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493550\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493550',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(120,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.15810000,160.36770000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 06:44:29','2025-08-02 06:44:29',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493552&episodeid=1652519\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493552&episodeid=1652519&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493552\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493552',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(121,'Earthquake in Russia','Alert Score: 1','low','earthquake',49.12000000,155.55460000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 06:33:57','2025-08-02 06:33:57',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493549&episodeid=1652520\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493549&episodeid=1652520&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493549\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493549',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(122,'Earthquake in ','Alert Score: 1','low','earthquake',51.80320000,160.19220000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 05:42:28','2025-08-02 05:42:28',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493547&episodeid=1652512\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493547&episodeid=1652512&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493547\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493547',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(123,'Earthquake in ','Alert Score: 1','low','earthquake',51.96130000,161.33700000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 05:37:47','2025-08-02 05:37:47',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493541&episodeid=1652511\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493541&episodeid=1652511&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493541\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493541',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(124,'Earthquake in Chile','Alert Score: 1','low','earthquake',-29.05110000,-71.57780000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 04:48:12','2025-08-02 04:48:12',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493532&episodeid=1652507\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493532&episodeid=1652507&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493532\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493532',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(125,'Earthquake in ','Alert Score: 1','low','earthquake',49.00790000,158.09000000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 04:36:46','2025-08-02 04:36:46',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493544&episodeid=1652505\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493544&episodeid=1652505&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493544\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493544',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(126,'Earthquake in ','Alert Score: 1','low','earthquake',50.11560000,159.44790000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 03:35:32','2025-08-02 03:35:32',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493526&episodeid=1652487\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493526&episodeid=1652487&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493526\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493526',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(127,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.34170000,160.45420000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 03:08:55','2025-08-02 03:08:55',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493523&episodeid=1652480\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493523&episodeid=1652480&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493523\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493523',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(128,'Earthquake in Russia','Alert Score: 1','low','earthquake',49.29050000,156.42960000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 02:42:47','2025-08-02 02:42:47',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493519&episodeid=1652482\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493519&episodeid=1652482&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493519\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493519',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(129,'Earthquake in Russian Federation','Alert Score: 1','low','earthquake',51.32730000,157.59540000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 01:42:30','2025-08-02 01:42:30',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493512&episodeid=1652468\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493512&episodeid=1652468&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493512\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493512',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(130,'Tropical Cyclone ONE-C-25','Alert Score: 1','low','hurricane',15.80000000,-179.50000000,200.00,NULL,NULL,NULL,NULL,'2025-07-27','2025-07-27 07:00:00','2025-08-02 01:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=TC&eventid=1001185&episodeid=24\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1001185&episodeid=24&eventtype=TC\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=TC&eventid=1001185\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1001185',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(131,'Earthquake in Russia','Alert Score: 1','low','earthquake',50.81060000,159.18680000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-02 00:00:20','2025-08-02 00:00:20',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493505&episodeid=1652460\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493505&episodeid=1652460&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493505\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493505',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(132,'Earthquake in Russia','Alert Score: 1','low','earthquake',49.24260000,156.34780000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-01 23:24:48','2025-08-01 23:24:48',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493483&episodeid=1652439\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493483&episodeid=1652439&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493483\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493483',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(133,'Earthquake in Russia','Alert Score: 1','low','earthquake',50.99050000,159.08320000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-01 23:11:52','2025-08-01 23:11:52',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493484&episodeid=1652456\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493484&episodeid=1652456&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493484\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493484',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(134,'Earthquake in Russia','Alert Score: 1','low','earthquake',50.25870000,157.80270000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-01 23:00:02','2025-08-01 23:00:02',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493481&episodeid=1652433\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493481&episodeid=1652433&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493481\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493481',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(135,'Flood in United States','Alert Score: 1','low','flood',39.11345620,-94.62649700,100.00,NULL,NULL,NULL,NULL,'2025-07-03','2025-07-02 23:00:00','2025-08-01 23:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=FL&eventid=1103366&episodeid=4\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1103366&episodeid=4&eventtype=FL\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=FL&eventid=1103366\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1103366',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(136,'Earthquake in Russia','Alert Score: 1','low','earthquake',50.66410000,158.13140000,50.00,NULL,NULL,NULL,NULL,'2025-08-02','2025-08-01 22:22:06','2025-08-01 22:22:06',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493476&episodeid=1652429\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493476&episodeid=1652429&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493476\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493476',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(137,'Forest fires in Canada','Alert Score: 1','moderate','wildfire',54.51662379,-106.37802548,80.00,NULL,NULL,NULL,NULL,'2025-07-29','2025-07-28 22:00:00','2025-08-01 22:00:00',1,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024422&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024422&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024422\"}]','2025-08-02 14:56:07',1,'medium',NULL,NULL,'Outdoor activities restricted due to wildfire activity.',NULL,0,NULL,2315,NULL,NULL,NULL,NULL,'gdacs_1024422',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 15:32:37'),(138,'Forest fires in Canada','Alert Score: 1','high','wildfire',51.67956770,-95.70291258,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',1,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024423&episodeid=4\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024423&episodeid=4&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024423\"}]','2025-08-02 14:56:07',1,'high',NULL,NULL,'Outdoor activities restricted due to wildfire activity.',NULL,0,NULL,947,NULL,NULL,NULL,NULL,'gdacs_1024423',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 15:32:37'),(139,'Forest fires in Canada','Alert Score: 1','high','wildfire',55.93374475,-105.12383930,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',1,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024424&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024424&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024424\"}]','2025-08-02 14:56:07',1,'critical',NULL,NULL,'Outdoor activities restricted due to wildfire activity.',NULL,0,NULL,1396,NULL,NULL,NULL,NULL,'gdacs_1024424',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 15:32:37'),(140,'Forest fires in Australia','Alert Score: 1','severe','wildfire',-17.95556257,131.35910782,80.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-07-31 22:00:00','2025-08-01 22:00:00',1,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024425&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024425&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024425\"}]','2025-08-02 14:56:07',1,'high',NULL,NULL,'Outdoor activities restricted due to wildfire activity.',NULL,0,NULL,2722,NULL,NULL,NULL,NULL,'gdacs_1024425',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 15:32:37'),(141,'Forest fires in Australia','Alert Score: 1','low','wildfire',-14.44048272,127.49961369,80.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-07-31 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024426&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024426&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024426\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024426',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(142,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-5.89121532,25.39202390,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024427&episodeid=1\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024427&episodeid=1&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024427\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024427',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(143,'Forest fires in Australia','Alert Score: 1','low','wildfire',-15.91797298,128.25260873,80.00,NULL,NULL,NULL,NULL,'2025-07-31','2025-07-30 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024428&episodeid=1\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024428&episodeid=1&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024428\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024428',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(144,'Forest fires in Australia','Alert Score: 1','low','wildfire',-14.47457148,127.59956599,80.00,NULL,NULL,NULL,NULL,'2025-07-30','2025-07-29 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024429&episodeid=1\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024429&episodeid=1&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024429\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024429',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(145,'Forest fires in Canada','Alert Score: 1','low','wildfire',54.15199049,-94.46434038,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024430&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024430&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024430\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024430',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(146,'Forest fires in Canada','Alert Score: 1','low','wildfire',56.05230889,-98.50397651,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024431&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024431&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024431\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024431',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(147,'Forest fires in Canada','Alert Score: 1','low','wildfire',56.80126269,-102.21109194,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024432&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024432&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024432\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024432',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(148,'Forest fires in Canada','Alert Score: 1','low','wildfire',57.42984494,-100.30028794,80.00,NULL,NULL,NULL,NULL,'2025-07-27','2025-07-26 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024433&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024433&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024433\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024433',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(149,'Forest fires in Canada','Alert Score: 1','low','wildfire',54.02879487,-94.43101577,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024434&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024434&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024434\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024434',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(150,'Forest fires in Canada','Alert Score: 1','low','wildfire',55.43808407,-104.00314406,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024435&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024435&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024435\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024435',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(151,'Forest fires in Canada','Alert Score: 1','low','wildfire',56.77487863,-102.79931725,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024436&episodeid=1\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024436&episodeid=1&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024436\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024436',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(152,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-5.20762015,25.89076601,80.00,NULL,NULL,NULL,NULL,'2025-07-29','2025-07-28 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024382&episodeid=6\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024382&episodeid=6&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024382\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024382',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(153,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-7.01710768,26.25954956,80.00,NULL,NULL,NULL,NULL,'2025-07-26','2025-07-25 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024389&episodeid=6\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024389&episodeid=6&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024389\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024389',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(154,'Forest fires in Russian Federation','Alert Score: 1','low','wildfire',66.26773900,158.36706754,80.00,NULL,NULL,NULL,NULL,'2025-07-30','2025-07-29 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024395&episodeid=9\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024395&episodeid=9&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024395\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024395',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(155,'Forest fires in Angola','Alert Score: 1','low','wildfire',-11.12737010,15.54644941,80.00,NULL,NULL,NULL,NULL,'2025-07-25','2025-07-24 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024398&episodeid=5\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024398&episodeid=5&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024398\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024398',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(156,'Forest fires in Canada','Alert Score: 1','low','wildfire',55.60655497,-101.48902068,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024399&episodeid=9\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024399&episodeid=9&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024399\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024399',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(157,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-5.31513603,24.17962992,80.00,NULL,NULL,NULL,NULL,'2025-07-26','2025-07-25 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024400&episodeid=3\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024400&episodeid=3&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024400\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024400',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(158,'Forest fires in Canada','Alert Score: 1','low','wildfire',54.98249216,-100.06804326,80.00,NULL,NULL,NULL,NULL,'2025-07-30','2025-07-29 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024401&episodeid=8\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024401&episodeid=8&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024401\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024401',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(159,'Forest fires in Canada','Alert Score: 1','low','wildfire',54.92321327,-107.98290552,80.00,NULL,NULL,NULL,NULL,'2025-07-29','2025-07-28 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024402&episodeid=7\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024402&episodeid=7&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024402\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024402',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(160,'Forest fires in Canada','Alert Score: 1','low','wildfire',56.84467299,-109.03734131,80.00,NULL,NULL,NULL,NULL,'2025-07-29','2025-07-28 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024403&episodeid=8\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024403&episodeid=8&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024403\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024403',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(161,'Forest fires in Canada','Alert Score: 1','low','wildfire',59.36258134,-111.82514090,80.00,NULL,NULL,NULL,NULL,'2025-07-26','2025-07-25 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024404&episodeid=7\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024404&episodeid=7&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024404\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024404',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(162,'Forest fires in Canada','Alert Score: 1','low','wildfire',54.58179041,-104.56297132,80.00,NULL,NULL,NULL,NULL,'2025-07-23','2025-07-22 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024405&episodeid=8\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024405&episodeid=8&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024405\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024405',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(163,'Forest fires in Canada','Alert Score: 1','low','wildfire',55.27133759,-106.98992781,80.00,NULL,NULL,NULL,NULL,'2025-07-29','2025-07-28 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024406&episodeid=7\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024406&episodeid=7&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024406\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024406',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(164,'Forest fires in Canada','Alert Score: 1','low','wildfire',55.18096053,-107.86703951,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024407&episodeid=7\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024407&episodeid=7&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024407\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024407',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(165,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-6.50289928,21.64890547,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024409&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024409&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024409\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024409',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(166,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-4.81052137,24.19022282,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024410&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024410&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024410\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024410',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(167,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-7.59880648,26.18379185,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024412&episodeid=2\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024412&episodeid=2&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024412\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024412',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(168,'Forest fires in Angola','Alert Score: 1','low','wildfire',-10.35523049,14.71696896,80.00,NULL,NULL,NULL,NULL,'2025-07-27','2025-07-26 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024413&episodeid=3\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024413&episodeid=3&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024413\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024413',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(169,'Forest fires in Angola','Alert Score: 1','low','wildfire',-10.12661645,15.24486848,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024415&episodeid=3\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024415&episodeid=3&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024415\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024415',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(170,'Forest fires in Australia','Alert Score: 1','low','wildfire',-18.06930460,131.36102745,80.00,NULL,NULL,NULL,NULL,'2025-07-30','2025-07-29 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024417&episodeid=3\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024417&episodeid=3&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024417\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024417',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(171,'Forest fires in Russian Federation','Alert Score: 1','low','wildfire',66.59437751,155.32623525,80.00,NULL,NULL,NULL,NULL,'2025-07-30','2025-07-29 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024418&episodeid=5\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024418&episodeid=5&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024418\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024418',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(172,'Forest fires in Australia','Alert Score: 1','low','wildfire',-16.41920223,129.55572935,80.00,NULL,NULL,NULL,NULL,'2025-07-25','2025-07-24 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024335&episodeid=17\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024335&episodeid=17&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024335\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024335',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(173,'Forest fires in Australia','Alert Score: 1','low','wildfire',-14.99390254,131.95543623,80.00,NULL,NULL,NULL,NULL,'2025-07-23','2025-07-22 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024319&episodeid=19\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024319&episodeid=19&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024319\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024319',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(174,'Forest fires in Bolivia','Alert Score: 1','low','wildfire',-14.56227759,-63.53748225,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024330&episodeid=18\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024330&episodeid=18&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024330\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024330',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(175,'Forest fires in Australia','Alert Score: 1','low','wildfire',-23.16467440,120.24579021,80.00,NULL,NULL,NULL,NULL,'2025-07-30','2025-07-29 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024372&episodeid=5\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024372&episodeid=5&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024372\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024372',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(176,'Forest fires in Canada','Alert Score: 1','low','wildfire',55.70973873,-107.54912455,80.00,NULL,NULL,NULL,NULL,'2025-07-29','2025-07-28 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024373&episodeid=10\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024373&episodeid=10&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024373\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024373',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(177,'Forest fires in Canada','Alert Score: 1','low','wildfire',56.67883335,-109.51353070,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024374&episodeid=12\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024374&episodeid=12&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024374\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024374',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(178,'Forest fires in Russian Federation','Alert Score: 1','low','wildfire',68.07882372,157.85444780,80.00,NULL,NULL,NULL,NULL,'2025-07-27','2025-07-26 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024375&episodeid=10\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024375&episodeid=10&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024375\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024375',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(179,'Forest fires in Portugal','Alert Score: 1','low','wildfire',41.80973449,-8.24592771,80.00,NULL,NULL,NULL,NULL,'2025-07-27','2025-07-26 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024376&episodeid=9\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024376&episodeid=9&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024376\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024376',NULL,NULL,NULL,1,1,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(180,'Forest fires in Angola','Alert Score: 1','low','wildfire',-10.90873929,15.64008119,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024377&episodeid=8\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024377&episodeid=8&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024377\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024377',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(181,'Forest fires in Australia','Alert Score: 1','low','wildfire',-16.61996137,128.39914240,80.00,NULL,NULL,NULL,NULL,'2025-07-27','2025-07-26 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024371&episodeid=8\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024371&episodeid=8&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024371\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024371',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(182,'Forest fires in The Democratic Republic of Congo','Alert Score: 1','low','wildfire',-6.85451655,26.19156229,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024368&episodeid=6\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024368&episodeid=6&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024368\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024368',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(183,'Forest fires in Angola','Alert Score: 1','low','wildfire',-9.91671246,15.58433706,80.00,NULL,NULL,NULL,NULL,'2025-07-27','2025-07-26 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024370&episodeid=11\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024370&episodeid=11&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024370\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024370',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(184,'Forest fires in Canada','Alert Score: 1','low','wildfire',61.64389958,-117.66383380,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024364&episodeid=11\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024364&episodeid=11&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024364\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024364',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(185,'Forest fires in Canada','Alert Score: 1','low','wildfire',61.69279865,-120.81594344,80.00,NULL,NULL,NULL,NULL,'2025-07-24','2025-07-23 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024365&episodeid=8\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024365&episodeid=8&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024365\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024365',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(186,'Forest fires in Canada','Alert Score: 1','low','wildfire',62.39060393,-117.79373127,80.00,NULL,NULL,NULL,NULL,'2025-07-26','2025-07-25 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024360&episodeid=17\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024360&episodeid=17&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024360\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024360',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(187,'Forest fires in Australia','Alert Score: 1','low','wildfire',-18.35272937,131.69273315,80.00,NULL,NULL,NULL,NULL,'2025-07-28','2025-07-27 22:00:00','2025-08-01 22:00:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=WF&eventid=1024361&episodeid=9\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1024361&episodeid=9&eventtype=WF\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=WF&eventid=1024361\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1024361',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(188,'Earthquake in Venezuela','Alert Score: 1','low','earthquake',10.71730000,-62.81530000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 21:52:31','2025-08-01 21:52:31',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493474&episodeid=1652437\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493474&episodeid=1652437&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493474\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493474',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(189,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.29380000,160.77340000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 20:51:30','2025-08-01 20:51:30',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493463&episodeid=1652396\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493463&episodeid=1652396&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493463\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493463',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(190,'Earthquake in Japan','Alert Score: 1','low','earthquake',42.35730000,145.65640000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 20:27:35','2025-08-01 20:27:35',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493460&episodeid=1652397\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493460&episodeid=1652397&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493460\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493460',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(191,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.07350000,160.17100000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 20:03:02','2025-08-01 20:03:02',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493456&episodeid=1652398\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493456&episodeid=1652398&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493456\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(192,'Earthquake in Japan','Alert Score: 1','low','earthquake',43.23240000,146.35490000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 19:18:20','2025-08-01 19:18:20',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493451&episodeid=1652399\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493451&episodeid=1652399&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493451\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493451',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(193,'Earthquake in Afghanistan','Alert Score: 1','low','earthquake',36.06820000,70.05280000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 19:03:34','2025-08-01 19:03:34',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493449&episodeid=1652400\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493449&episodeid=1652400&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493449\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493449',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(194,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.10550000,158.51830000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 18:32:24','2025-08-01 18:32:24',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493447&episodeid=1652401\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493447&episodeid=1652401&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493447\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493447',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(195,'Earthquake in Russian Federation','Alert Score: 1','low','earthquake',50.37770000,156.33870000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 18:07:54','2025-08-01 18:07:54',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493446&episodeid=1652403\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493446&episodeid=1652403&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493446\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493446',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(196,'Earthquake in Costa Rica','Alert Score: 1','low','earthquake',10.34850000,-84.39850000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 17:33:11','2025-08-01 17:33:11',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493438&episodeid=1652404\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493438&episodeid=1652404&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493438\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493438',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(197,'Earthquake in Russia','Alert Score: 1','low','earthquake',52.79260000,161.45030000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 16:53:10','2025-08-01 16:53:10',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493430&episodeid=1652405\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493430&episodeid=1652405&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493430\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493430',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(198,'Earthquake in ','Alert Score: 1','low','earthquake',52.19630000,160.79470000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 16:51:56','2025-08-01 16:51:56',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493428&episodeid=1652406\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493428&episodeid=1652406&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493428\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493428',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(199,'Earthquake in Russia','Alert Score: 1','low','earthquake',50.23520000,159.14010000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 16:20:45','2025-08-01 16:20:45',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493422&episodeid=1652407\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493422&episodeid=1652407&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493422\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493422',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(200,'Earthquake in ','Alert Score: 1','low','earthquake',49.94310000,158.43900000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 15:43:50','2025-08-01 15:43:50',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493458&episodeid=1652408\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493458&episodeid=1652408&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493458\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493458',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(201,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.41040000,159.63920000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 15:41:00','2025-08-01 15:41:00',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493415&episodeid=1652409\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493415&episodeid=1652409&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493415\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493415',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(202,'Earthquake in Russia','Alert Score: 1','low','earthquake',51.46330000,159.08640000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 15:39:08','2025-08-01 15:39:08',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493419&episodeid=1652410\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493419&episodeid=1652410&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493419\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493419',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07'),(203,'Earthquake in Russia','Alert Score: 1','low','earthquake',50.98600000,158.12410000,50.00,NULL,NULL,NULL,NULL,'2025-08-01','2025-08-01 14:36:55','2025-08-01 14:36:55',0,NULL,NULL,NULL,NULL,NULL,'[{\"geometry\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/polygons\\/getgeometry?eventtype=EQ&eventid=1493410&episodeid=1652411\",\"report\":\"https:\\/\\/www.gdacs.org\\/report.aspx?eventid=1493410&episodeid=1652411&eventtype=EQ\",\"details\":\"https:\\/\\/www.gdacs.org\\/gdacsapi\\/api\\/events\\/geteventdata?eventtype=EQ&eventid=1493410\"}]','2025-08-02 14:56:07',0,'none',NULL,NULL,'',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'gdacs_1493410',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-02 14:56:07','2025-08-02 14:56:07');
/*!40000 ALTER TABLE `disaster_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_01_01_000001_create_continents_table',1),(5,'2025_01_01_000002_create_countries_table',1),(6,'2025_01_01_000003_create_regions_table',1),(7,'2025_01_01_000004_create_cities_table',1),(8,'2025_01_01_000005_create_airports_table',1),(9,'2025_08_01_112536_create_personal_access_tokens_table',1),(10,'2025_08_01_120001_create_disaster_events_table',1),(11,'2025_08_01_120002_create_prompt_templates_table',1),(12,'2025_08_01_120003_create_ai_examples_table',1),(13,'2025_08_01_120004_create_ai_processing_logs_table',1),(14,'2025_08_01_120005_create_user_language_preferences_table',1),(15,'2025_08_01_123532_create_ai_usage_tracking_table',1),(16,'2025_08_01_123547_create_ai_quotas_table',1),(17,'2025_08_01_123556_create_ai_cost_alerts_table',1),(18,'2025_08_01_123605_create_ai_job_progress_table',1),(19,'2025_08_01_123608_create_ai_system_health_table',1),(20,'2025_08_01_134620_add_spatial_indexes_for_geographic_search',1),(21,'2025_08_01_140000_add_performance_optimization_indexes',1),(22,'2025_08_01_174746_add_verified_at_to_disaster_events_table',1),(23,'2025_08_01_192535_add_missing_columns_to_disaster_events_table',1),(24,'2025_08_01_192611_add_date_column_to_disaster_events_table',1),(25,'2025_08_01_192748_fix_severity_level_column_type',1),(26,'2025_08_01_192844_add_soft_deletes_to_geographic_tables',1),(27,'2025_08_01_205620_create_notifications_table',1),(28,'2025_08_01_205814_add_deleted_at_to_prompt_templates_table',1),(29,'2025_08_01_205951_add_deleted_at_to_ai_processing_logs_table',1),(30,'2025_08_01_212403_add_name_to_prompt_templates_table',1),(31,'2025_08_01_212520_add_deleted_at_to_ai_examples_table',1),(32,'2025_08_01_212556_add_deleted_at_to_user_language_preferences_table',1),(33,'2025_08_02_045603_add_schengen_member_to_countries_table',1),(34,'2025_08_02_045927_add_travel_info_to_countries_table',1),(35,'2025_08_02_050636_add_tourism_info_to_regions_table',1),(37,'2025_08_02_145541_add_tourism_fields_to_disaster_events_table',2),(38,'2025_08_02_170116_fix_disaster_events_json_fields_to_text',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prompt_templates`
--

DROP TABLE IF EXISTS `prompt_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prompt_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Name of the template',
  `prompt_text` text NOT NULL COMMENT 'Prompt with placeholders',
  `model` varchar(50) NOT NULL DEFAULT 'gpt-4o' COMMENT 'AI model to use',
  `description` text DEFAULT NULL COMMENT 'Description of the template',
  `use_examples` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Whether to use few-shot examples',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Active status',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prompt_templates_title_unique` (`name`),
  KEY `prompt_templates_is_active_index` (`is_active`),
  KEY `prompt_templates_model_index` (`model`),
  KEY `prompt_templates_is_active_model_index` (`is_active`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prompt_templates`
--

LOCK TABLES `prompt_templates` WRITE;
/*!40000 ALTER TABLE `prompt_templates` DISABLE KEYS */;
INSERT INTO `prompt_templates` VALUES (1,'Tourism News Classification','Analysiere den folgenden Nachrichtenartikel und bewerte dessen Relevanz für den Tourismus.\n\nNACHRICHTENARTIKEL:\n{{news_article}}\n\nZIELREGION: {{destination}}\nSPRACHE: {{language}}\n\nBEWERTUNGSKRITERIEN:\n\n1. TOURISMUS-RELEVANZ (1-5 Skala):\n   - 1: Keine Tourismus-Relevanz\n   - 2: Minimale indirekte Auswirkungen\n   - 3: Moderate Auswirkungen auf Touristen\n   - 4: Erhebliche Auswirkungen, Reisewarnung empfohlen\n   - 5: Kritische Auswirkungen, sofortige Evakuierung erforderlich\n\n2. EREIGNIS-KATEGORIE:\n   - Naturkatastrophe (Erdbeben, Überschwemmung, Sturm, etc.)\n   - Politische Unruhen/Sicherheit\n   - Gesundheitsnotfall (Epidemie, Pandemie-Maßnahmen)\n   - Infrastruktur (Streiks, Flughafenschließungen)\n   - Extremwetter\n   - Kriminalität/Terrorismus\n\n3. BETROFFENE TOURISMUS-BEREICHE:\n   - Unterkünfte (Hotels, Resorts)\n   - Transport (Flüge, Züge, Schiffe)\n   - Sehenswürdigkeiten (Museen, Parks, Denkmäler)\n   - Aktivitäten (Touren, Sport, Events)\n   - Dienstleistungen (Restaurants, Shopping)\n\nAUSGABEFORMAT (JSON):\n{\n  \"tourism_relevance\": 1-5,\n  \"event_category\": \"string\",\n  \"impact_level\": \"LOW|MEDIUM|HIGH|CRITICAL\",\n  \"affected_sectors\": [\"array\"],\n  \"location_coordinates\": {\"lat\": float, \"lng\": float},\n  \"duration_estimate_days\": integer,\n  \"tourist_advisory\": {\n    \"de\": \"Deutsche Reiseempfehlung\",\n    \"en\": \"English travel advisory\" \n  },\n  \"confidence_score\": 0.0-1.0,\n  \"keywords\": [\"relevante\", \"suchbegriffe\"]\n}\n\nBewerte objektiv und berücksichtige sowohl direkte als auch indirekte Auswirkungen auf Touristen.','gpt-4','Klassifiziert Nachrichtenartikel nach Tourismus-Relevanz und Auswirkungen',1,1,'2025-08-02 13:22:49','2025-08-02 13:22:49',NULL),(2,'Multi-Source News Synthesis','Analysiere und fasse mehrere Nachrichtenquellen zu einem Ereignis zusammen.\n\nNACHRICHTENQUELLEN:\n{{news_sources}}\n\nEREIGNIS-REGION: {{region}}\nZEITRAUM: {{time_period}}\n\nSYNTHESEAUFGABEN:\n\n1. FAKTEN-EXTRAKTION:\n   - Bestätige konsistente Informationen aus mehreren Quellen\n   - Identifiziere Widersprüche zwischen den Quellen\n   - Bewerte die Glaubwürdigkeit jeder Quelle (1-5)\n\n2. TOURISMUS-IMPACT ZUSAMMENFASSUNG:\n   - Aktuelle Situation für Touristen\n   - Betroffene Gebiete und Infrastruktur\n   - Empfohlene Maßnahmen für Reisende\n   - Zeitrahmen für Normalisierung\n\n3. TREND-ANALYSE:\n   - Verschlechtert oder verbessert sich die Situation?\n   - Saisonale Faktoren berücksichtigen\n   - Ähnliche historische Ereignisse als Referenz\n\nAUSGABEFORMAT:\n\n**EREIGNIS-ZUSAMMENFASSUNG:**\n- Hauptereignis: [Kurze Beschreibung]\n- Schweregrad: [LOW/MEDIUM/HIGH/CRITICAL]\n- Betroffene Region: [Spezifische Gebiete]\n\n**QUELLEN-BEWERTUNG:**\n{{#each sources}}\n- {{source_name}}: Glaubwürdigkeit {{credibility}}/5\n  Besonderheiten: {{unique_info}}\n{{/each}}\n\n**TOURISMUS-AUSWIRKUNGEN:**\n- Sofortige Auswirkungen: [Liste]\n- Mittelfristige Auswirkungen (1-4 Wochen): [Liste]\n- Langfristige Auswirkungen (1+ Monate): [Liste]\n\n**REISE-EMPFEHLUNGEN:**\n- Derzeit vor Ort: {{current_visitor_advice}}\n- Geplante Reisen: {{planned_travel_advice}}\n- Alternative Destinationen: {{alternatives}}\n\n**MONITORING-EMPFEHLUNGEN:**\n- Zu verfolgende Indikatoren: [Liste]\n- Empfohlene Aktualisierungsfrequenz: [Zeitintervall]','gpt-4','Fasst mehrere Nachrichtenquellen zu einem Ereignis zusammen und bewertet Widersprüche',1,1,'2025-08-02 13:22:49','2025-08-02 13:22:49',NULL),(3,'Crisis Communication Generator','Erstelle eine professionelle Krisenkommunikation für Touristen basierend auf aktuellen Nachrichten.\n\nEINGANGSDATEN:\nNACHRICHT: {{news_content}}\nBETROFFENE DESTINATION: {{destination}}\nSCHWEREGRAD: {{severity_level}}\nZIELSPRACHEN: {{target_languages}}\n\nKOMMUNIKATIONSZIELE:\n- Informative, aber nicht panikmachende Kommunikation\n- Klare Handlungsanweisungen\n- Kulturell angemessene Sprache\n- Rechtlich abgesicherte Formulierungen\n\nAUSGABE-KOMPONENTEN:\n\n1. **SITUATION UPDATE** (je Sprache):\n   - Aktuelle Lage in 2-3 Sätzen\n   - Zeitstempel der letzten Aktualisierung\n   - Offizielle Quellen referenzieren\n\n2. **SOFORTMASSNAHMEN** (nach Schweregrad):\n   \n   CRITICAL:\n   - Sofortige Evakuierung/Abreise\n   - Notfallkontakte\n   - Sichere Aufenthaltsorte\n   \n   HIGH:\n   - Reise verschieben/abbrechen\n   - Bereits vor Ort: Sichere Bereiche aufsuchen\n   - Regelmäßige Updates verfolgen\n   \n   MEDIUM:\n   - Erhöhte Vorsicht\n   - Lokale Behörden kontaktieren\n   - Reisepläne flexibel halten\n   \n   LOW:\n   - Informiert bleiben\n   - Standard-Vorsichtsmaßnahmen\n\n3. **PRAKTISCHE INFORMATIONEN**:\n   - Betroffene Gebiete (spezifische Orte/Regionen)\n   - Transport-Status (Flughäfen, Straßen, öff. Verkehr)\n   - Verfügbare Unterkünfte\n   - Medizinische Versorgung\n   - Kommunikationsinfrastruktur\n\n4. **KONTAKT-INFORMATIONEN**:\n   - Lokale Notdienste\n   - Touristische Hotlines\n   - Botschaften/Konsulate\n   - Versicherungen\n   - Rückholung-Services\n\nAUSGABEFORMAT:\nFür jede Zielsprache separate, vollständige Mitteilung mit:\n- Überschrift (aufmerksamkeitsstark aber sachlich)\n- Strukturierter Inhalt mit Bullet Points\n- Call-to-Action\n- Haftungsausschluss\n- Kontaktdaten für weitere Informationen\n\nSTIL-RICHTLINIEN:\n- Professionell und vertrauenswürdig\n- Kurze, prägnante Sätze\n- Aktive Formulierungen\n- Vermeidung von Panik-Begriffen\n- Kulturelle Sensibilität für internationale Touristen','gpt-4','Generiert mehrsprachige Krisenkommunikation für Touristen basierend auf Nachrichten',1,1,'2025-08-02 13:22:49','2025-08-02 13:22:49',NULL);
/*!40000 ALTER TABLE `prompt_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Multilingual region/state/province name' CHECK (json_valid(`name`)),
  `code` varchar(10) DEFAULT NULL COMMENT 'Region code (e.g., state abbreviation)',
  `type` varchar(50) DEFAULT NULL COMMENT 'Region type: state, province, territory, etc.',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`description`)),
  `attractions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attractions`)),
  `tourism_type` varchar(50) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `country_id` bigint(20) unsigned NOT NULL,
  `area_km2` decimal(12,2) DEFAULT NULL COMMENT 'Area in square kilometers',
  `population` bigint(20) DEFAULT NULL COMMENT 'Regional population',
  `latitude` decimal(10,8) DEFAULT NULL COMMENT 'Latitude coordinate',
  `longitude` decimal(11,8) DEFAULT NULL COMMENT 'Longitude coordinate',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `regions_country_id_code_unique` (`country_id`,`code`),
  KEY `regions_country_id_index` (`country_id`),
  KEY `regions_code_index` (`code`),
  KEY `regions_type_index` (`type`),
  KEY `regions_country_id_code_index` (`country_id`,`code`),
  KEY `regions_coordinates_idx` (`latitude`,`longitude`),
  KEY `regions_country_population_idx` (`country_id`,`population`),
  KEY `regions_country_type_idx` (`country_id`,`type`),
  KEY `regions_country_type_population_idx` (`country_id`,`type`,`population`),
  KEY `regions_type_idx` (`type`),
  FULLTEXT KEY `regions_name_fulltext` (`name`),
  FULLTEXT KEY `name` (`name`),
  CONSTRAINT `regions_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_language_preferences`
--

DROP TABLE IF EXISTS `user_language_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_language_preferences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `language_code` varchar(5) NOT NULL COMMENT 'Language code (e.g., de, en, en-US)',
  `is_primary` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Primary language preference',
  `priority` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'Language priority order',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_language_preferences_user_id_language_code_unique` (`user_id`,`language_code`),
  KEY `user_language_preferences_user_id_index` (`user_id`),
  KEY `user_language_preferences_language_code_index` (`language_code`),
  KEY `user_language_preferences_user_id_is_primary_index` (`user_id`,`is_primary`),
  KEY `user_language_preferences_user_id_priority_index` (`user_id`,`priority`),
  CONSTRAINT `user_language_preferences_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_language_preferences`
--

LOCK TABLES `user_language_preferences` WRITE;
/*!40000 ALTER TABLE `user_language_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_language_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin User','admin@risk-radar.com',NULL,'$2y$12$aHUNrgOigp6v3.X7aYtRje/itMLIr1VkanyUXz0a94f.HV5Okg9lK',NULL,'2025-08-02 12:49:12','2025-08-02 12:49:12');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-04 15:45:12
