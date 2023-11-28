SELECT 
	nazev_kategorie AS 'Která kategorie potravin zdražuje nejpomaleji?',
	avg(mezirocni_narust) AS 'Průměrný meziroční nárůst',
	CASE
		WHEN avg(mezirocni_narust) > 0 THEN 'Položka zdražila'
		WHEN avg(mezirocni_narust) = 0 THEN 'Cena je stejná'
		ELSE 'Položka zlevnila'
	END AS zmena_ceny
FROM (
	SELECT
		tk.nazev_kategorie,
		tk.rok AS rok_1,
		tk.prumerna_hodnota AS prumerna_hodnota_1,
		tk1.rok AS rok_2,
		tk1.prumerna_hodnota AS prumerna_hodnota_2,
		tk1.prumerna_hodnota / tk.prumerna_hodnota * 100 - 100 AS mezirocni_narust
	FROM t_katerina_balint_project_sql_primary_final tk
	JOIN t_katerina_balint_project_sql_primary_final tk1 ON tk.rok = tk1.rok - 1
		AND tk.nazev_kategorie = tk1.nazev_kategorie
	WHERE tk.typ_kategorie = 'Zboží'
	GROUP BY tk.nazev_kategorie, tk.rok) AS mezirocni_rust_cen
GROUP BY nazev_kategorie
HAVING zmena_ceny = 'Položka zdražila'
ORDER BY avg(mezirocni_narust)
LIMIT 1;