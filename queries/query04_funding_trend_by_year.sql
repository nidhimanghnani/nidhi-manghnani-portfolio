SELECT EXTRACT(YEAR FROM SAFE.PARSE_DATE('%d/%m/%Y', Date)) AS year,
COUNT(*) AS total_deals
FROM `startup_funding.funding`
WHERE Date IS NOT NULL
AND Date != 'Date dd/mm/yyyy'
GROUP BY year
ORDER BY year