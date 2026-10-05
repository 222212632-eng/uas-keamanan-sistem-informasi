-- 04_test_cases.sql
-- Test cases for before/after comparison.
-- Execute only inside the isolated laboratory.

-- S1: Unauthorized DB access
-- Expected after hardening: connection from an unauthorized host is denied.

-- S2: Privilege abuse
-- Expected after hardening:
-- DROP TABLE db_statistik.data_statistik;
-- should be denied for analyst/app_user when not required.

-- S3: Data exposure
SELECT id_dokumen, nama_dokumen, secret_value
FROM db_statistik.dokumen_internal;

-- Expected after encryption design:
-- direct unauthorized read should not expose plaintext.

-- S4: Unauthorized modification
UPDATE db_statistik.data_statistik
SET nilai = nilai + 1
WHERE id_data = 1;

-- Expected after least privilege:
-- operation should be denied for an account without UPDATE privilege.

-- S5: Version/vulnerability status
-- Record:
-- SELECT VERSION();
-- and compare with current vendor security advisories.
