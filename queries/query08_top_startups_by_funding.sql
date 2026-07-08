SELECT
  TRIM(
    REGEXP_REPLACE(Startup_Name, r'\\\\xc2\\\\xa0', '')
  ) AS Startup,

  ROUND(
    SUM(
      SAFE_CAST(
        REGEXP_REPLACE(Amount_in_USD, r'[^0-9]', '')
        AS INT64
      )
    ) / 1000000,
    2
  ) AS Total_Funding_Million_USD

FROM
  `indian-startup-analysis-499911.startup_funding.funding`

WHERE
  Startup_Name IS NOT NULL
  AND TRIM(Startup_Name) != ''
  AND Amount_in_USD IS NOT NULL
  AND REGEXP_REPLACE(Amount_in_USD, r'[^0-9]', '') != ''

GROUP BY
  Startup

ORDER BY
  Total_Funding_Million_USD DESC

LIMIT 10;