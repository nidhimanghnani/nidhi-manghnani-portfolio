SELECT COUNT(*) AS bad_date_rows
FROM `startup_funding.funding`
WHERE SAFE.PARSE_DATE('%d/%m/%Y', Date) IS NULL
AND Date != 'Date dd/mm/yyyy'
AND Date IS NOT NULL