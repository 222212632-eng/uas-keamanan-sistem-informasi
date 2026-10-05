-- 02_baseline_users.sql
-- LAB ONLY. Do not use these example credentials in production.
-- Credentials are intentionally simple for an isolated security laboratory.

USE db_statistik;

-- Deliberately broad account for baseline testing.
GRANT ALL PRIVILEGES ON db_statistik.* TO 'app_user'@'%'
IDENTIFIED BY 'LabApp#2026!';

-- More restricted account used for comparison.
GRANT SELECT, INSERT, UPDATE ON db_statistik.* TO 'analyst'@'localhost'
IDENTIFIED BY 'LabAnalyst#2026!';

FLUSH PRIVILEGES;
