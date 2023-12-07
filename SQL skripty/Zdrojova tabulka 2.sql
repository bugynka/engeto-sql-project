CREATE TABLE t_katerina_balint_project_SQL_secondary_final AS
SELECT
	c.country,
	e.`year`,
	e.GDP
FROM countries c
JOIN economies e ON c.country = e.country
WHERE c.continent = 'Europe';