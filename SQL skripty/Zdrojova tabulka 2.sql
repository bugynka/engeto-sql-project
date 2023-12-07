CREATE TABLE t_katerina_balint_project_SQL_secondary_final AS
SELECT
	c.country,
	e.`year`,
	e.GDP,
	e.gini,
	c.population
FROM countries c
JOIN economies e ON c.country = e.country
WHERE c.continent = 'Europe'
	AND e.YEAR BETWEEN 2000 AND 2021;