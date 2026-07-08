SELECT
  CASE
    WHEN LOWER(TRIM(REGEXP_REPLACE(City_Location, r'\\xc2\\xa0', ''))) IN (
      'bangalore',
      'bengaluru'
    ) THEN 'Bangalore'

    WHEN LOWER(TRIM(REGEXP_REPLACE(City_Location, r'\\xc2\\xa0', ''))) IN (
      'gurgaon',
      'gurugram'
    ) THEN 'Gurgaon'

    WHEN LOWER(TRIM(REGEXP_REPLACE(City_Location, r'\\xc2\\xa0', ''))) IN (
      'na',
      'n/a',
      'nan',
      ''
    ) THEN NULL

    ELSE TRIM(REGEXP_REPLACE(City_Location, r'\\xc2\\xa0', ''))
  END AS City,

  COUNT(*) AS deals

FROM `startup_funding.funding`

WHERE Amount_in_USD NOT IN ('N/A', 'undisclosed', 'Undisclosed', 'nan', '')
  AND Amount_in_USD IS NOT NULL
  AND City_Location IS NOT NULL

GROUP BY City

HAVING City IS NOT NULL

ORDER BY deals DESC

LIMIT 10;