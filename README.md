# Indian Startup Funding Analysis (2015–2019)

Exploratory SQL analysis of **3,045 Indian startup funding records** using **Google BigQuery**. The project explores funding trends across industries, cities, investors, investment types, startups, and years while addressing common real-world data quality issues.
---

## Dataset Source

- **Source:** Kaggle – Indian Startup Funding Dataset
- **Link:** https://www.kaggle.com/datasets/sudalairajkumar/indian-startup-funding
- **Period:** January 2015 – August 2019
- **Total Records:** 3,045 startup funding records
- **Tool:** Google BigQuery (SQL)

---

## Folder Structure

```text
Indian-Startup-Funding-Analysis/
│
├── dashboard/
├── dataset/
│   └── dataset_link.md
├── images/
├── queries/
├── screenshots/
└── README.md
```
---

## Queries & Findings

| # | Query | Finding | Screenshot |
|---|---|---|---|
| 1 | Top sectors by deal count | Consumer Internet led with 589 deals | query01_top_sectors_by_deal_count.png |
| 2 | Top cities by deal count | Bangalore dominated, followed by Mumbai and Delhi | query02_top_cities.png |
| 3 | Top investors by deal count | "Undisclosed Investor(s)" appeared most — retained as a data observation, not cleaned | query03_top_investors.png |
| 4 | Funding trend by year (deals) | Peaked in 2016 (993 deals), declined sharply through 2019 | query04_funding_trend_by_year.png |
| 4B | Bad date verification | Only 7 of 3,045 rows had malformed dates (0.23%) — negligible | query04b_bad_date_check.png |
| 5 | Investment type distribution | Seed / Angel was most common round type by deal count | query05_investment_types.png |
| 6 | Top sectors by total funding ($M) | Sector rankings shift when measured by dollars vs deal count | query06_top_sectors_by_total_funding.png |
| 7 | Top cities by total funding ($M) | Bangalore led by dollar volume; city name variants normalised before grouping | query07_top_cities_by_total_funding.png |
| 8 | Top startups by total funding ($M) | Top entries are late-stage companies with multiple rounds aggregated | query08_top_startups_by_funding.png |
| 9 | Avg deal size by investment type | Private Equity rounds had highest average; Seed rounds lowest | query09_average_funding_by_investment_type.png |
| 10 | Total funding by year ($M) | Dollar volume vs deal count reveals shift toward fewer, larger rounds post-2016 | query10_top_funding_by_year.png |

---

## Data Quality Notes

**Amount_in_USD** contained "undisclosed", "N/A", "nan", and
comma-formatted numbers. Cleaned using REGEXP_REPLACE to strip
non-numeric characters and SAFE_CAST to convert safely. Rows
that return empty after stripping are excluded from all
dollar-value queries.

**Investor names** had case and spacing inconsistencies.
Standardised with UPPER() and TRIM(). "Undisclosed Investor(s)"
retained in results — it reflects genuinely undisclosed rounds,
not a data entry error.

**Dates** — 7 rows had formats SAFE.PARSE_DATE could not parse.
Verified and excluded. No material impact on trend analysis.

**City names** — "Bengaluru/Bangalore" and "Gurugram/Gurgaon"
normalised via CASE statements before grouping to avoid
double-counting.

---

## Key Takeaways

- Consumer Internet dominated by deal count; rankings shift when
  measured by total dollars invested
- Bangalore is India's clear startup capital — by both deals and
  funding volume
- 2016 was peak deal activity; post-2016 shows consistent decline
- Seed / Angel was the most frequent round type, but Private Equity
  rounds were largest by average deal size
- A significant share of rounds have undisclosed amounts or investors
  — an inherent dataset limitation, not a cleaning gap