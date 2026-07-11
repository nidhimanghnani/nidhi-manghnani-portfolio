SELECT
  CASE
    WHEN TRIM(REGEXP_REPLACE(City_Location, r'\\\\xc2\\\\xa0', '')) = 'Bengaluru' THEN 'Bangalore'
    WHEN TRIM(REGEXP_REPLACE(City_Location, r'\\\\xc2\\\\xa0', '')) = 'Gurugram' THEN 'Gurgaon'
    ELSE TRIM(REGEXP_REPLACE(City_Location, r'\\\\xc2\\\\xa0', ''))
  END AS City,

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
  City_Location IS NOT NULL
  AND TRIM(City_Location) != ''
  AND LOWER(TRIM(City_Location)) != 'nan'

GROUP BY
  City

ORDER BY
  Total_Funding_Million_USD DESC

LIMIT 10;