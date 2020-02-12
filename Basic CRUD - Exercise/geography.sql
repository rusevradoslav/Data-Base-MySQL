SELECT country_name,country_code,
    IF(currency_code = 'EUR','Euro','Not Euro') AS 'currency'
FROM`countries` AS country
ORDER BY country_name;

SELECT country.country_name, country.population
FROM `countries` AS country
WHERE country.continent_code = 'EU'
ORDER BY country.population DESC , country.country_name
LIMIT 30;