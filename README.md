# Public Health Analytics Pipeline on AWS

> End-to-end ETL and analytics pipeline on 20 years (1999–2018) of US drug-overdose mortality data from HHS. Glue → S3 → EMR/Spark → Redshift → Tableau workflow.

---

## Pipeline Architecture

```
HHS Open Data → S3 (raw)
                  ↓
              AWS Glue (schema discovery + cleaning)
                  ↓
              S3 (curated)
                  ↓
         EMR + Apache Spark (aggregation, demographic joins)
                  ↓
              Amazon Redshift (analytical warehouse)
                  ↓
              Tableau + Python (Jupyter) for analysis
```

## Data

- **Source:** US Department of Health & Human Services open data portal
- **Coverage:** 1999–2018, all states
- **Dimensions:** age band, gender, race, drug category (opioids, synthetic opioids, cocaine, etc.)
- **Volume:** 20 years × demographics × cause-of-death codes

## Key Findings

- Drug-overdose deaths rose steadily from 1999, with **synthetic opioids (fentanyl) driving the post-2013 acceleration**.
- The **25–34 age band** shows the steepest rate increase.
- Significant racial and gender disparities across drug categories.
- Linear and quadratic regression models capture long-term trend and inflection points.

## Tech Stack

- **Cloud:** AWS (Glue, S3, EMR, Lambda, Redshift)
- **Compute:** Apache Spark on EMR
- **Languages:** Python (Pandas, Matplotlib, Seaborn, Statsmodels), R (dplyr, ggplot2), SQL (PostgreSQL/Redshift)
- **Viz:** Tableau, Matplotlib

## Repository Layout

| File | Purpose |
|---|---|
| `Drug_Overdose_Analysis_Notebook.ipynb` | Python analysis + visualizations |
| `Drug_Overdose_Analysis_Script.py` | Standalone Python script |
| `Drug_Overdose_SQL_Queries.sql` | Aggregation + trend queries |
| `Drug_Overdose_Analysis_R_Script.R` | Regression modeling in R |
| `US_Drug_Overdose_Data_1999_2018.csv` | Source data |
| `Drug_Overdose_Analysis_Report.pdf` | Full report |
| `Drug_Overdose_Analysis_Demo.mp4` | Walkthrough video |

## Reproduce Locally

```bash
git clone https://github.com/Rushikesh-S-Ware/public-health-aws-pipeline
cd public-health-aws-pipeline
pip install -r requirements.txt
jupyter notebook Drug_Overdose_Analysis_Notebook.ipynb
```

## Author

Rushikesh S. Ware — George Mason University, AIT 580: Analytics — Big Data to Information.

## License

MIT
