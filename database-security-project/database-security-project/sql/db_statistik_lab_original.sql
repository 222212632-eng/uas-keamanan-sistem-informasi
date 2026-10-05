-- DATABASE LAB UAS KSI
-- Fokus: Database Security / Database Hardening
-- Target: MySQL pada Metasploitable 2
-- CATATAN: seluruh data bersifat sintetis untuk laboratorium.
-- Akun app_user sengaja dibuat terlalu permisif sebagai BASELINE
-- untuk pengujian hardening. Jangan gunakan di sistem nyata.

CREATE DATABASE IF NOT EXISTS db_statistik
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

USE db_statistik;

DROP TABLE IF EXISTS dokumen_internal;
DROP TABLE IF EXISTS data_statistik;
DROP TABLE IF EXISTS wilayah;
DROP TABLE IF EXISTS instansi;

CREATE TABLE instansi (
    id_instansi INT NOT NULL AUTO_INCREMENT,
    kode_instansi VARCHAR(20) NOT NULL,
    nama_instansi VARCHAR(150) NOT NULL,
    PRIMARY KEY (id_instansi),
    UNIQUE KEY uk_instansi_kode (kode_instansi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE wilayah (
    id_wilayah INT NOT NULL AUTO_INCREMENT,
    kode_wilayah VARCHAR(20) NOT NULL,
    nama_wilayah VARCHAR(100) NOT NULL,
    level_wilayah VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_wilayah),
    UNIQUE KEY uk_wilayah_kode (kode_wilayah)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE data_statistik (
    id_data INT NOT NULL AUTO_INCREMENT,
    id_instansi INT NOT NULL,
    id_wilayah INT NOT NULL,
    indikator VARCHAR(150) NOT NULL,
    tahun INT NOT NULL,
    nilai DECIMAL(18,2) NOT NULL,
    satuan VARCHAR(50) NOT NULL,
    klasifikasi_data VARCHAR(30) NOT NULL DEFAULT 'Publik',
    status_rilis VARCHAR(30) NOT NULL DEFAULT 'Dirilis',
    PRIMARY KEY (id_data),
    KEY idx_data_instansi (id_instansi),
    KEY idx_data_wilayah (id_wilayah),
    CONSTRAINT fk_data_instansi
        FOREIGN KEY (id_instansi) REFERENCES instansi(id_instansi),
    CONSTRAINT fk_data_wilayah
        FOREIGN KEY (id_wilayah) REFERENCES wilayah(id_wilayah)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE dokumen_internal (
    id_dokumen INT NOT NULL AUTO_INCREMENT,
    id_instansi INT NOT NULL,
    jenis_dokumen VARCHAR(100) NOT NULL,
    nomor_dokumen VARCHAR(50) NOT NULL,
    keterangan VARCHAR(255) NOT NULL,
    tingkat_akses VARCHAR(30) NOT NULL DEFAULT 'Terbatas',
    PRIMARY KEY (id_dokumen),
    KEY idx_dokumen_instansi (id_instansi),
    CONSTRAINT fk_dokumen_instansi
        FOREIGN KEY (id_instansi) REFERENCES instansi(id_instansi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO instansi (kode_instansi, nama_instansi) VALUES
('INS-001', 'Pusat Data Statistik Nasional'),
('INS-002', 'Dinas Statistik Daerah'),
('INS-003', 'Unit Analisis Data Pemerintah');

INSERT INTO wilayah (kode_wilayah, nama_wilayah, level_wilayah) VALUES
('W-01', 'Provinsi A', 'Provinsi'),
('W-02', 'Provinsi B', 'Provinsi'),
('W-03', 'Provinsi C', 'Provinsi'),
('W-04', 'Provinsi D', 'Provinsi'),
('W-05', 'Provinsi E', 'Provinsi');

INSERT INTO data_statistik
(id_instansi, id_wilayah, indikator, tahun, nilai, satuan, klasifikasi_data, status_rilis)
VALUES
(1, 1, 'Indeks Pembangunan Manusia', 2022, 72.45, 'Indeks', 'Publik', 'Dirilis'),
(1, 2, 'Indeks Pembangunan Manusia', 2022, 69.82, 'Indeks', 'Publik', 'Dirilis'),
(1, 3, 'Indeks Pembangunan Manusia', 2022, 74.16, 'Indeks', 'Publik', 'Dirilis'),
(1, 4, 'Indeks Pembangunan Manusia', 2022, 67.94, 'Indeks', 'Publik', 'Dirilis'),
(1, 5, 'Indeks Pembangunan Manusia', 2022, 71.38, 'Indeks', 'Publik', 'Dirilis'),

(1, 1, 'Tingkat Pengangguran Terbuka', 2023, 5.21, 'Persen', 'Publik', 'Dirilis'),
(1, 2, 'Tingkat Pengangguran Terbuka', 2023, 6.14, 'Persen', 'Publik', 'Dirilis'),
(1, 3, 'Tingkat Pengangguran Terbuka', 2023, 4.87, 'Persen', 'Publik', 'Dirilis'),
(1, 4, 'Tingkat Pengangguran Terbuka', 2023, 7.03, 'Persen', 'Publik', 'Dirilis'),
(1, 5, 'Tingkat Pengangguran Terbuka', 2023, 5.66, 'Persen', 'Publik', 'Dirilis'),

(2, 1, 'Pertumbuhan Ekonomi', 2024, 4.92, 'Persen', 'Publik', 'Dirilis'),
(2, 2, 'Pertumbuhan Ekonomi', 2024, 5.31, 'Persen', 'Publik', 'Dirilis'),
(2, 3, 'Pertumbuhan Ekonomi', 2024, 4.45, 'Persen', 'Publik', 'Dirilis'),
(2, 4, 'Pertumbuhan Ekonomi', 2024, 3.98, 'Persen', 'Publik', 'Dirilis'),
(2, 5, 'Pertumbuhan Ekonomi', 2024, 5.08, 'Persen', 'Publik', 'Dirilis');

INSERT INTO dokumen_internal
(id_instansi, jenis_dokumen, nomor_dokumen, keterangan, tingkat_akses)
VALUES
(1, 'Dokumen Metodologi', 'MET-001/2026', 'Metodologi pengolahan indikator statistik internal', 'Terbatas'),
(1, 'Rencana Kegiatan', 'REN-002/2026', 'Rencana kegiatan pengumpulan data statistik', 'Terbatas'),
(2, 'Evaluasi Internal', 'EVA-003/2026', 'Evaluasi kualitas data internal', 'Terbatas'),
(3, 'Dokumen Teknis', 'TEK-004/2026', 'Dokumen teknis pipeline pengolahan data', 'Terbatas');

-- BASELINE ACCOUNT
-- Sengaja terlalu permisif dan dapat digunakan dari host mana pun.
-- Dipakai hanya untuk membuktikan temuan excessive privilege/
-- remote access pada laboratorium.
GRANT ALL PRIVILEGES ON db_statistik.* TO 'app_user'@'%' IDENTIFIED BY 'LabApp#2026!';

-- Akun analis yang lebih terbatas untuk pembanding.
GRANT SELECT, INSERT, UPDATE ON db_statistik.* TO 'analyst'@'localhost'
IDENTIFIED BY 'LabAnalyst#2026!';

FLUSH PRIVILEGES;

-- Verifikasi awal:
-- SHOW DATABASES;
-- USE db_statistik;
-- SHOW TABLES;
-- SELECT COUNT(*) FROM data_statistik;
-- SELECT COUNT(*) FROM dokumen_internal;
