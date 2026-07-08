SELECT
  CASE
    WHEN LOWER(TRIM(REGEXP_REPLACE(InvestmentType, r'\\xc2\\xa0', ''))) IN (
      'seed / angle funding',
      'seed/angle funding',
      'seed / angel funding',
      'seed/angel funding',
      'angel / seed funding'
    ) THEN 'Seed / Angel Funding'

    ELSE TRIM(REGEXP_REPLACE(InvestmentType, r'\\xc2\\xa0', ''))
  END AS Investment_Type,

  ROUND(
    AVG(
      SAFE_CAST(
        REGEXP_REPLACE(Amount_in_USD, r'[^0-9]', '')
        AS INT64
      )
    ) / 1000000,
    2
  ) AS Avg_Funding_Million_USD

FROM
  `indian-startup-analysis-499911.startup_funding.funding`

WHERE
  InvestmentType IS NOT NULL
  AND TRIM(InvestmentType) != ''
  AND InvestmentType != 'InvestmentnType'
  AND Amount_in_USD IS NOT NULL
  AND REGEXP_REPLACE(Amount_in_USD, r'[^0-9]', '') != ''

GROUP BY
  Investment_Type

ORDER BY
  Avg_Funding_Million_USD DESC

LIMIT 10;