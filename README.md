# Namaste Mart — Analisis Performa Penjualan

Studi kasus analytics retail Data Cleaning (SQL/BigQuery), eksplorasi data, dan dashboard interaktif (Data Studio), dibuat sebagai portofolio data analyst.

**[Lihat dashboard interaktif →](https://datastudio.google.com/reporting/4948e125-8ec7-422c-ae16-12654452ae15)**

**[Baca studi kasus lengkap (rumusan masalah, metodologi, temuan, rekomendasi) →](https://drive.google.com/file/d/1e0XvnDrwNE1Vb66Apwm6NTPkBd0fegZt/view?usp=sharing)**

---

## Ringkasan

Project ini menganalisis ±4.300 transaksi retail (2020–2024) untuk menjawab: *kategori mana yang menyumbang revenue dan profit terbesar, apakah strategi diskon saat ini efektif, dan di mana revenue banyak hilang akibat retur/pembatalan?*

**Temuan utama:**
- Electronics menyumbang revenue terbesar (110,1 juta) namun memiliki profit margin terendah (±11,92%) di antara semua kategori.
- Diskon yang lebih besar tidak meningkatkan rata-rata nilai transaksi. Nilai transaksi tertinggi justru terjadi saat *tanpa* diskon.
- 47,2 juta (±20% dari total revenue) hilang akibat retur/pembatalan, dengan tingkat retur yang konsisten di semua kategori dan metode pembayaran (mengindikasikan masalah sistemik, bukan masalah produk tertentu).

Lihat [studi kasus lengkap](https://drive.google.com/file/d/1e0XvnDrwNE1Vb66Apwm6NTPkBd0fegZt/view?usp=sharing) untuk metodologi, seluruh temuan, dan rekomendasi.

## Struktur Project

| File / Link | Deskripsi |
|---|---|
| [`raw_data/retail_sales_dataset.csv`](./raw_data/retail_sales_dataset.csv) | Dataset mentah asli (±4.310 baris, sengaja dibuat "kotor") |
| [`sql/00_data_quality_check.sql`](./sql/00_data_quality_check.sql) | Mengecek missing values, duplikasi, dan data tidak valid sebelum cleaning |
| [`sql/01_data_cleaning.sql`](./sql/01_data_cleaning,sql) | Pipeline pembersihan data: parsing tanggal, dedup, penanganan outlier, imputasi |
| [`sql/02_sales_analysis.sql`](./sql/02_sales_analysis.sql) | Query analisis utama (revenue, margin, tier diskon, return rate) |
| [Dashboard Data Studio](https://datastudio.google.com/reporting/4948e125-8ec7-422c-ae16-12654452ae15) | Dashboard interaktif. Filter berdasarkan tanggal, wilayah, kategori, metode pembayaran |
| [Dokumen studi kasus](https://drive.google.com/file/d/1e0XvnDrwNE1Vb66Apwm6NTPkBd0fegZt/view?usp=sharing) | Laporan lengkap: rumusan masalah, proses pembersihan data, temuan, rekomendasi, keterbatasan |

## Tools

- **BigQuery (SQL)** — Pembersihan dan transformasi data
- **Data Studio** — Dashboard interaktif
- **File PDF** — Laporan studi kasus

## Catatan Kualitas Data

Dataset mentah memiliki format tanggal yang tidak konsisten, penulisan kategori yang bervariasi, order_id duplikat, nilai negatif/sentinel yang tidak valid, dan data kosong seluruhnya diidentifikasi dan diselesaikan sebagai bagian dari project ini. Detail lengkap ada di dokumen studi kasus, Bagian 3 (Proses Pembersihan Data).

## Penulis

Reza Arrachman Dzulkarnain — Portofolio Data Analyst, [08/2026].
