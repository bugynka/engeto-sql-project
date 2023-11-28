CREATE TABLE t_katerina_balint_project_SQL_primary_final AS
SELECT
	cp.payroll_year AS rok,
	cpib.name AS nazev_kategorie,
	CASE
		WHEN cpu.name = 'Kč' THEN 'Odvětví'
		ELSE 'Zboží'
	END AS typ_kategorie,
	avg(cp.value) AS prumerna_hodnota,
	cpu.name AS primarni_jednotka
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib ON cpib.code = cp.industry_branch_code
JOIN czechia_payroll_unit cpu ON cpu.code = cp.unit_code
WHERE cp.value_type_code = 5958
GROUP BY rok, nazev_kategorie
UNION
SELECT
	year(cp2.date_from) AS rok,
	cpc.name AS nazev_kategorie,
	CASE
		WHEN cpc.price_unit = 'Kč' THEN 'Odvětví'
		ELSE 'Zboží'
	END AS typ_kategorie,
	avg(cp2.value) AS prumerna_hodnota,
	cpc.price_unit AS primarni_jednotka
FROM czechia_price cp2
JOIN czechia_price_category cpc ON cpc.code = cp2.category_code
GROUP BY rok, nazev_kategorie;