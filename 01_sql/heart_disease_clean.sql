DROP TABLE IF EXISTS heart_disease_clean;

CREATE TABLE heart_disease_clean AS
SELECT
    age,
    sex,
    cp,
    CASE 
        WHEN trestbps = 0 THEN NULL
        ELSE trestbps
    END AS trestbps,
    CASE 
        WHEN chol = 0 THEN NULL
        ELSE chol
    END AS chol,
    fbs,
    restecg,
    thalach,
    exang,
    oldpeak,
    slope,
    ca,
    thal,
    target,
    source
FROM heart_disease_raw;

SELECT COUNT(*) AS total_rows
FROM heart_disease_clean;

SELECT COUNT(*) AS zero_trestbps_count
FROM heart_disease_clean
WHERE trestbps = 0;

SELECT COUNT(*) AS zero_chol_count
FROM heart_disease_clean
WHERE chol = 0;

SELECT
    SUM(CASE WHEN trestbps IS NULL THEN 1 ELSE 0 END) AS trestbps_nulls,
    SUM(CASE WHEN chol IS NULL THEN 1 ELSE 0 END) AS chol_nulls
FROM heart_disease_clean;