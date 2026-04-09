-- Data Quality Checks for heart_disease_raw table
SELECT *
FROM heart_disease_raw
LIMIT 10;

SELECT 
    COUNT(*) AS total_rows
FROM heart_disease_raw;

-- Check for NULL values in each column
SELECT
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
    SUM(CASE WHEN sex IS NULL THEN 1 ELSE 0 END) AS sex_nulls,
    SUM(CASE WHEN cp IS NULL THEN 1 ELSE 0 END) AS cp_nulls,
    SUM(CASE WHEN trestbps IS NULL THEN 1 ELSE 0 END) AS trestbps_nulls,
    SUM(CASE WHEN chol IS NULL THEN 1 ELSE 0 END) AS chol_nulls,
    SUM(CASE WHEN fbs IS NULL THEN 1 ELSE 0 END) AS fbs_nulls,
    SUM(CASE WHEN restecg IS NULL THEN 1 ELSE 0 END) AS restecg_nulls,
    SUM(CASE WHEN thalach IS NULL THEN 1 ELSE 0 END) AS thalach_nulls,
    SUM(CASE WHEN exang IS NULL THEN 1 ELSE 0 END) AS exang_nulls,
    SUM(CASE WHEN oldpeak IS NULL THEN 1 ELSE 0 END) AS oldpeak_nulls,
    SUM(CASE WHEN slope IS NULL THEN 1 ELSE 0 END) AS slope_nulls,
    SUM(CASE WHEN ca IS NULL THEN 1 ELSE 0 END) AS ca_nulls,
    SUM(CASE WHEN thal IS NULL THEN 1 ELSE 0 END) AS thal_nulls,
    SUM(CASE WHEN target IS NULL THEN 1 ELSE 0 END) AS target_nulls,
    SUM(CASE WHEN source IS NULL THEN 1 ELSE 0 END) AS source_nulls
FROM heart_disease_raw;

-- Check for invalid values in trestbps and chol columns (0 is not a valid value for these)
SELECT
    COUNT(*) AS zero_trestbps_count
FROM heart_disease_raw
WHERE trestbps = 0;

SELECT
    COUNT(*) AS zero_chol_count
FROM heart_disease_raw
WHERE chol = 0;

-- Check for outliers in oldpeak column
SELECT
    MIN(oldpeak) AS min_oldpeak,
    MAX(oldpeak) AS max_oldpeak
FROM heart_disease_raw;

-- Check distribution of target variable
SELECT
    source,
    COUNT(*) AS row_count
FROM heart_disease_raw
GROUP BY source
ORDER BY row_count DESC;