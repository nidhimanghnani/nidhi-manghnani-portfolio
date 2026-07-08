SELECT
  EXTRACT(YEAR FROM SAFE.PARSE_DATE('%d/%m/%Y', Date)) AS Year,

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
  ⁠ indian-startup-analysis-499911.startup_funding.funding ⁠

WHERE
  SAFE.PARSE_DATE('%d/%m/%Y', Date) IS NOT NULL
  AND Amount_in_USD IS NOT NULL
  AND REGEXP_REPLACE(Amount_in_USD, r'[^0-9]', '') != ''

GROUP BY
  Year

ORDER BY
  Year;