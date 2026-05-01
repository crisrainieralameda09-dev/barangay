ALTER TABLE `ftjs_profiles`
  ADD COLUMN IF NOT EXISTS `cert_photo_path` VARCHAR(255) DEFAULT NULL COMMENT '2x2 photo for certificate' AFTER `cert_path`;
