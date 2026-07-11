SELECT
  CASE
    WHEN UPPER(TRIM(Investors_Name)) IN (
      'UNDISCLOSED',
      'UNDISCLOSED INVESTOR',
      'UNDISCLOSED INVESTORS',
      'UNDISCLOSED INVESTOR(S)'
    ) THEN 'UNDISCLOSED INVESTORS'
    ELSE UPPER(TRIM(Investors_Name))
  END AS Investors_Name,
  COUNT(*) AS investments_made
FROM `startup_funding.funding`
WHERE Investors_Name IS NOT NULL
  AND TRIM(Investors_Name) != ''
  AND UPPER(TRIM(Investors_Name)) != 'N/A'
GROUP BY Investors_Name
ORDER BY investments_made DESC
LIMIT 10;