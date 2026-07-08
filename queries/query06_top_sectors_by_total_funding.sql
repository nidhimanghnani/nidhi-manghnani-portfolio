CASE
    WHEN LOWER(TRIM(REGEXP_REPLACE(Industry_Vertical, r'\\xc2\\xa0', ''))) IN ('ecommerce', 'e commerce')
      THEN 'E-Commerce'
   ELSE TRIM(
       REGEXP_REPLACE(
         REGEXP_REPLACE(Industry_Vertical, r'\\\\xc2\\\\xa0', ''),
         r'\\xc2\\xa0',
         ''
       )
     )
  END AS Industry,

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
  Industry_Vertical IS NOT NULL
  AND TRIM(Industry_Vertical) != ''

GROUP BY
  Industry

ORDER BY
  Total_Funding_Million_USD DESC

LIMIT 10;