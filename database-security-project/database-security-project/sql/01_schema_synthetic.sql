-- 01_schema_synthetic.sql
-- Synthetic database for Database Security Hardening laboratory.
-- No real personal/BPS/organizational data is used.

CREATE DATABASE IF NOT EXISTS db_statistik
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

USE db_statistik;

DROP TABLE IF EXISTS dokumen_internal;
DROP TABLE IF EXISTS data_statistik;
DROP TABLE IF EXISTS wilayah;
DROP TABLE IF EXISTS instansi;

CREATE TABLE instansi (
    id_instansi INT AUTO_INCREMENT PRIMARY KEY,
    nama_instansi VARCHAR(150) NOT NULL,
    jenis VARCHAR(50) NOT NULL
);

CREATE TABLE wilayah (
    id_wilayah INT AUTO_INCREMENT PRIMARY KEY,
    nama_wilayah VARCHAR(100) NOT NULL,
    provinsi VARCHAR(100) NOT NULL
);

CREATE TABLE data_statistik (
    id_data INT AUTO_INCREMENT PRIMARY KEY,
    id_instansi INT NOT NULL,
    id_wilayah INT NOT NULL,
    indikator VARCHAR(150) NOT NULL,
    tahun INT NOT NULL,
    nilai DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (id_instansi) REFERENCES instansi(id_instansi),
    FOREIGN KEY (id_wilayah) REFERENCES wilayah(id_wilayah)
);

CREATE TABLE dokumen_internal (
    id_dokumen INT AUTO_INCREMENT PRIMARY KEY,
    id_instansi INT NOT NULL,
    nama_dokumen VARCHAR(200) NOT NULL,
    secret_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_instansi) REFERENCES instansi(id_instansi)
);

INSERT INTO instansi (nama_instansi, jenis) VALUES
('Instansi Statistik Sintetis', 'Pusat'),
('Dinas Statistik Sintetis', 'Daerah');

INSERT INTO wilayah (nama_wilayah, provinsi) VALUES
('Wilayah A', 'Provinsi A'),
('Wilayah B', 'Provinsi B');

INSERT INTO data_statistik (id_instansi, id_wilayah, indikator, tahun, nilai) VALUES
(1,1,'Indeks Produksi',2024,102.40),
(1,2,'Indeks Produksi',2024,98.70),
(2,1,'Tingkat Pengangguran',2024,5.20),
(2,2,'Tingkat Pengangguran',2024,4.80);

INSERT INTO dokumen_internal (id_instansi, nama_dokumen, secret_value) VALUES
(1,'Dokumen Sintetis 01','NilaiRahasia_Statistik_01'),
(2,'Dokumen Sintetis 02','NilaiRahasia_Statistik_02');
