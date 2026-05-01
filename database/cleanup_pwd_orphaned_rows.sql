-- Remove PWD verification requests that have no matching user (orphaned test data)
DELETE FROM pwd_verification_requests
WHERE user_id NOT IN (SELECT id FROM users);
