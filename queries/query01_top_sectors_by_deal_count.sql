SELECT
  CASE
    WHEN LOWER(TRIM(REGEXP_REPLACE(Industry_Vertical, r'\\xc2\\xa0', ''))) IN (
      'ecommerce',
      'e commerce',
      'e-commerce'
    ) THEN 'E-Commerce'

    WHEN LOWER(TRIM(REGEXP_REPLACE(Industry_Vertical, r'\\xc2\\xa0', ''))) IN (
      'na',
      'n/a',
      'nan',
      ''
    ) THEN NULL

    ELSE TRIM(REGEXP_REPLACE(Industry_Vertical, r'\\xc2\\xa0', ''))
  END AS Industry,

  COUNT(*) AS deals

FROM `startup_funding.funding`

WHERE Amount_in_USD NOT IN ('N/A', 'undisclosed', 'Undisclosed', 'nan', '')
  AND Amount_in_USD IS NOT NULL
  AND Industry_Vertical IS NOT NULL

GROUP BY Industry

HAVING Industry IS NOT NULL

ORDER BY deals DESC

LIMIT 10;