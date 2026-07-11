SELECT
  CASE
    WHEN LOWER(
      TRIM(
        REGEXP_REPLACE(
          REGEXP_REPLACE(
            REGEXP_REPLACE(InvestmentType, r'\\xc2\\xa0', ''),
            r'\\n',
            ' '
          ),
          r'\\',
          ' '
        )
      )
    ) IN (
      'seed funding',
      'seed / angel funding',
      'seed/angel funding',
      'seed /angel funding',
      'seed/ angel funding',
      'seed / angle funding',
      'seed/angle funding',
      'seed / angel',
      'seed angel funding',
      'angel / seed funding'
    ) THEN 'Seed / Angel Funding'

    WHEN LOWER(
      TRIM(
        REGEXP_REPLACE(
          REGEXP_REPLACE(
            REGEXP_REPLACE(InvestmentType, r'\\xc2\\xa0', ''),
            r'\\n',
            ' '
          ),
          r'\\',
          ' '
        )
      )
    ) IN (
      'na',
      'n/a',
      'nan',
      ''
    ) THEN NULL

    WHEN LOWER(
      TRIM(
        REGEXP_REPLACE(
          REGEXP_REPLACE(
            REGEXP_REPLACE(InvestmentType, r'\\xc2\\xa0', ''),
            r'\\n',
            ' '
          ),
          r'\\',
          ' '
        )
      )
    ) = 'seed funding'
    THEN 'Seed Funding'

    ELSE TRIM(
      REGEXP_REPLACE(
        REGEXP_REPLACE(
          REGEXP_REPLACE(InvestmentType, r'\\xc2\\xa0', ''),
          r'\\n',
          ' '
        ),
        r'\\',
        ' '
      )
    )
  END AS Investment_Type,

  COUNT(*) AS Deal_Count

FROM `startup_funding.funding`

WHERE InvestmentType IS NOT NULL

GROUP BY Investment_Type

HAVING Investment_Type IS NOT NULL

ORDER BY Deal_Count DESC

LIMIT 10;