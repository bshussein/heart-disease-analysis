-- Create a new table with engineered features for heart disease analysis python and Tableau. This includes age grouping and retains all original features for flexibility in analysis.

DROP TABLE IF EXISTS heart_disease_features;

CREATE TABLE heart_disease_features AS
SELECT
    age,

    -- Age grouping for better analysis in Tableau
    CASE 
        WHEN age < 40 THEN 'Under 40'
        WHEN age BETWEEN 40 AND 55 THEN '40-55'
        WHEN age BETWEEN 56 AND 70 THEN '56-70'
        ELSE '70+'
    END AS age_group,

    sex,
    cp,
    trestbps,
    chol,
    thalach,
    exang,
    oldpeak,
    slope,
    ca,
    thal,
    target,
    source
FROM heart_disease_clean;