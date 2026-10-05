-- 03_hardening_roles.sql
-- Illustrative hardening configuration.
-- Validate syntax against the exact MariaDB version used in the laboratory.

USE db_statistik;

-- Least privilege: remove broad privileges from the application account.
REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'app_user'@'%';

-- Re-apply only the privileges required by the simulated application.
GRANT SELECT, INSERT, UPDATE ON db_statistik.data_statistik
TO 'app_user'@'localhost';

GRANT SELECT ON db_statistik.instansi
TO 'app_user'@'localhost';

GRANT SELECT ON db_statistik.wilayah
TO 'app_user'@'localhost';

FLUSH PRIVILEGES;

-- Network/host restriction is represented by changing '%' to a specific
-- trusted host. Apply only after verifying the lab source address.
-- Example:
-- CREATE USER 'app_user'@'192.168.56.101' IDENTIFIED BY '...';
-- GRANT SELECT, INSERT, UPDATE ON db_statistik.data_statistik
-- TO 'app_user'@'192.168.56.101';
