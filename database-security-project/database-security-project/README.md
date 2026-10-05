# Database Security Hardening Laboratory

**Project:** Implementasi dan Pengujian Database Hardening pada MariaDB terhadap Akses Tidak Sah dan Penyalahgunaan Hak Akses

**Author:** Hafizh Shah Firdaus  
**NIM:** 222212632  
**Institution:** Politeknik Statistika STIS  
**Course:** Keamanan Sistem Informasi

## 1. Project overview

Project ini membahas pengamanan database menggunakan pendekatan **defense-in-depth**.
Fokus utama adalah mengurangi risiko:

- unauthorized database access;
- excessive privilege / privilege abuse;
- sensitive data exposure;
- unauthorized modification;
- outdated/vulnerable DBMS.

## 2. Security controls

1. Account hardening
2. Least privilege / access control
3. Network restriction
4. Encryption
5. Audit logging
6. Patch/update management

## 3. Methodology

```text
Problem
   ↓
Baseline Assessment
   ↓
Vulnerability / Weakness Identification
   ↓
Controlled Security Testing
   ↓
Hardening / Remediation
   ↓
Retesting
   ↓
Before–After Evaluation
   ↓
Risk & Recommendation
```

## 4. Repository structure

```text
database-security-project/
├── README.md
├── docs/
│   ├── arsitektur/
│   └── threat-analysis/
├── evidence/
│   ├── baseline/
│   ├── hardening/
│   └── retest/
├── results/
│   ├── findings_simulasi.csv
│   └── before_after_results_simulasi.csv
├── sql/
│   ├── 01_schema_synthetic.sql
│   ├── 02_baseline_users.sql
│   ├── 03_hardening_roles.sql
│   ├── 04_test_cases.sql
│   └── db_statistik_lab_original.sql
├── tests/
│   └── TEST_PLAN.md
└── report/
    └── Laporan_UAS_Database_Security_Hardening_Hafizh_LENGKAP_SIMULASI.docx
```

## 5. Laboratory environment

The intended laboratory uses a virtualized, isolated environment. The target database contains
synthetic data only.

Example network:

- Tester VM: `192.168.56.101`
- Database VM: `192.168.56.102`
- Network: VirtualBox Host-only Adapter
- Database service: MariaDB/MySQL-compatible service on TCP/3306

## 6. Quick start

### Step 1 — Create synthetic database

```bash
mariadb -u root < sql/01_schema_synthetic.sql
```

### Step 2 — Create baseline accounts

```bash
mariadb -u root < sql/02_baseline_users.sql
```

### Step 3 — Capture baseline

Record:

```bash
mariadb --version
ss -lntp | grep 3306
mariadb -u root -e "SHOW GRANTS FOR 'app_user'@'%';"
mariadb -u root -e "SELECT user,host FROM mysql.user;"
```

### Step 4 — Apply hardening

Review and adapt:

```bash
mariadb -u root < sql/03_hardening_roles.sql
```

Network restriction and encryption/audit configuration must be adapted to the exact MariaDB
version installed in the laboratory.

### Step 5 — Run test cases

See:

`tests/TEST_PLAN.md`

## 7. Results

The current `results/` files are **SIMULATION / BENCHMARK** values prepared for report
formatting. They are not measurements from a production system.

Illustrative outcome:

| Scenario | Before ASR | After ASR |
|---|---:|---:|
| S1 | 100% | 0% |
| S2 | 100% | 0% |
| S3 | 100% | 0% |
| S4 | 100% | 0% |
| S5 | 100% | 100%* |

`*` S5 requires patch/upgrade rather than only configuration hardening.

## 8. Evidence policy

The current screenshots are explicitly labelled **SIMULASI / BENCHMARK**. When the laboratory
experiment is actually performed, replace the simulated images with genuine screenshots and
logs generated from the isolated VM.

## 9. Academic / ethical boundary

All testing must remain inside an isolated laboratory and only target systems controlled by the
project author. Do not scan, exploit, or test public systems, campus infrastructure, or third-party
systems without explicit authorization.

## 10. Disclaimer

This repository is an academic laboratory project. It uses synthetic data and simulated results
in its current report package. It is not intended to represent the security posture of a real
production database.
