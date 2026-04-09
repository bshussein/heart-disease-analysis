-- This step creates a cleaned version of the dataset by handling known data quality issues.
-- Specifically, invalid values (e.g., 0 for blood pressure and cholesterol) are converted to NULL
-- to ensure more accurate analysis in downstream queries.

-- Drop old version if it exists
DROP TABLE IF EXISTS heart_disease_clean;

-- Create cleaned table
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

-- Validate row count
SELECT COUNT(*) AS total_rows
FROM heart_disease_clean;