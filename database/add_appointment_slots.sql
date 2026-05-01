-- Appointment slots: define available time blocks per healthworker per day
CREATE TABLE IF NOT EXISTS `appointment_slots` (
  `id`              INT(11) NOT NULL AUTO_INCREMENT,
  `healthworker_id` INT(11) NOT NULL COMMENT 'The healthworker who owns this slot',
  `slot_date`       DATE NOT NULL,
  `start_time`      TIME NOT NULL,
  `end_time`        TIME NOT NULL,
  `max_bookings`    INT(11) NOT NULL DEFAULT 1,
  `current_bookings`INT(11) NOT NULL DEFAULT 0,
  `appointment_type`VARCHAR(100) DEFAULT NULL COMMENT 'NULL = any type',
  `notes`           VARCHAR(255) DEFAULT NULL,
  `is_blocked`      TINYINT(1) DEFAULT 0 COMMENT 'Manually blocked by healthworker',
  `created_at`      DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at`      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_hw_date` (`healthworker_id`, `slot_date`),
  CONSTRAINT `slots_ibfk_1` FOREIGN KEY (`healthworker_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add slot_id and reschedule fields to appointments
ALTER TABLE `appointments`
  ADD COLUMN IF NOT EXISTS `slot_id`           INT(11) DEFAULT NULL AFTER `healthworker_id`,
  ADD COLUMN IF NOT EXISTS `reschedule_reason` TEXT DEFAULT NULL AFTER `notes`,
  ADD COLUMN IF NOT EXISTS `cancelled_by`      ENUM('citizen','admin','healthworker') DEFAULT NULL AFTER `reschedule_reason`,
  ADD COLUMN IF NOT EXISTS `cancel_reason`     TEXT DEFAULT NULL AFTER `cancelled_by`;
