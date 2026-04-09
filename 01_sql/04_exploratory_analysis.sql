-- ============================================
-- Heart Disease Analysis - Exploratory Queries
-- ============================================

-- 1. Overall Disease Rate
SELECT 
    COUNT(*) AS total_patients,
    SUM(target) AS patients_with_disease,
    ROUND(1.0 * SUM(target) / COUNT(*), 3) AS disease_rate
FROM heart_disease_clean;


-- 2. Disease Rate by Gender
SELECT 
    sex,
    COUNT(*) AS total,
    SUM(target) AS disease_cases,
    ROUND(1.0 * SUM(target) / COUNT(*), 3) AS disease_rate
FROM heart_disease_clean
GROUP BY sex;


-- 3. Disease Rate by Source
SELECT 
    source,
    COUNT(*) AS total,
    SUM(target) AS disease_cases,
    ROUND(1.0 * SUM(target) / COUNT(*), 3) AS disease_rate
FROM heart_disease_clean
GROUP BY source
ORDER BY disease_rate DESC;


-- 4. Disease Rate by Age Group
SELECT age_group, total, disease_cases, disease_rate
FROM (
    SELECT
        CASE
            WHEN age < 40 THEN 'Under 40'
            WHEN age BETWEEN 40 AND 55 THEN '40-55'
            WHEN age BETWEEN 56 AND 70 THEN '56-70'
            ELSE '70+'
        END AS age_group,

        CASE
            WHEN age < 40 THEN 1
            WHEN age BETWEEN 40 AND 55 THEN 2
            WHEN age BETWEEN 56 AND 70 THEN 3
            ELSE 4
        END AS sort_order,

        COUNT(*) AS total,
        SUM(target) AS disease_cases,
        ROUND(1.0 * SUM(target) / COUNT(*), 3) AS disease_rate

    FROM heart_disease_clean
    GROUP BY age_group, sort_order
)
ORDER BY sort_order;


-- 5. Disease Rate by Chest Pain Type
SELECT 
    cp,
    COUNT(*) AS total,
    SUM(target) AS disease_cases,
    ROUND(1.0 * SUM(target) / COUNT(*), 3) AS disease_rate
FROM heart_disease_clean
GROUP BY cp
ORDER BY disease_rate DESC;


-- 6. Average Cholesterol by Target
SELECT 
    target,
    ROUND(AVG(chol), 1) AS avg_cholesterol
FROM heart_disease_clean
WHERE chol IS NOT NULL
GROUP BY target;


-- 7. Average Blood Pressure by Target
SELECT 
    target,
    ROUND(AVG(trestbps), 1) AS avg_bp
FROM heart_disease_clean
WHERE trestbps IS NOT NULL
GROUP BY target;