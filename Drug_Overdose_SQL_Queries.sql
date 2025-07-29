CREATE TABLE drug_overdose (
    INDICATOR VARCHAR(255),
    PANEL VARCHAR(255),
    PANEL_NUM INT,
    UNIT VARCHAR(255),
    UNIT_NUM INT,
    STUB_NAME VARCHAR(255),
    STUB_NAME_NUM INT,
    STUB_LABEL VARCHAR(255),
    STUB_LABEL_NUM INT,
    YEAR INT,
    YEAR_NUM INT,
    AGE VARCHAR(255),
    AGE_NUM INT,
    ESTIMATE FLOAT,
    FLAG VARCHAR(10)
);

COPY drug_overdose FROM 'C:\Users\rushi\OneDrive\Desktop\GMU\Spring 24\AIT 580\Project\Drug_overdose.csv' WITH (FORMAT csv, HEADER true);

ALTER TABLE drug_overdose
ALTER COLUMN age_num TYPE DECIMAL;

select panel 


CREATE TABLE drug_overdose_sample AS
SELECT *
FROM (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY UNIT_NUM ORDER BY YEAR) AS rn
  FROM drug_overdose
) t
WHERE t.rn <= 5;


WITH RankedData AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY UNIT_NUM ORDER BY YEAR ASC) as row_num
    FROM drug_overdose
)
SELECT *
FROM RankedData
WHERE row_num <= 5;




SELECT panel as DRUG_TYPE, SUM(ESTIMATE) AS Total_Deaths
FROM drug_overdose
WHERE INDICATOR = 'Drug overdose death rates'
AND panel != 'All drug overdose deaths'  -- Excluding the general category
GROUP BY DRUG_TYPE
ORDER BY Total_Deaths DESC;


------Final 
SELECT 
    CASE
        WHEN panel = 'Drug overdose deaths involving any opioid' THEN 'Opioid'
        WHEN panel = 'Drug overdose deaths involving natural and semisynthetic opioids' THEN 'Natural and semisynthetic opioids'
        WHEN panel = 'Drug overdose deaths involving other synthetic opioids (other than methadone)' THEN 'Other synthetic opioids'
        WHEN panel = 'Drug overdose deaths involving heroin' THEN 'Heroin'
        WHEN panel = 'Drug overdose deaths involving methadone' THEN 'Methadone'
        ELSE panel
    END AS DRUG_TYPE, 
    ROUND(SUM(ESTIMATE)::numeric, 2) AS Total_Deaths
FROM drug_overdose
WHERE INDICATOR = 'Drug overdose death rates'
AND panel != 'All drug overdose deaths'
GROUP BY DRUG_TYPE
ORDER BY Total_Deaths DESC;




