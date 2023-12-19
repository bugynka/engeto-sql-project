CREATE VIEW v_katerina_balint_project_SQL_final AS
SELECT
	tk.rok AS rok_1,
	tk1.rok AS rok_2,
	avg(tk1.prumerna_hodnota / tk.prumerna_hodnota * 100 - 100) AS mezirocni_narust_mzdy,
	(SELECT
		avg(tk3.prumerna_hodnota / tk2.prumerna_hodnota * 100 - 100)
		FROM t_katerina_balint_project_sql_primary_final tk2 
		JOIN t_katerina_balint_project_sql_primary_final tk3 ON tk2.rok = tk3.rok - 1 
			AND tk2.nazev_kategorie = tk3.nazev_kategorie 
		WHERE tk2.typ_kategorie = 'Zboží' 
			AND tk.rok = tk2.rok 
		GROUP BY tk2.rok) AS mezirocni_narust_potraviny,
	(SELECT
		tkb2.gdp / tkb.gdp * 100 - 100
		FROM t_katerina_balint_project_sql_secondary_final tkb
		JOIN t_katerina_balint_project_sql_secondary_final tkb2 ON tkb.YEAR = tkb2.YEAR - 1 
			AND tkb.country = tkb2.country
		WHERE tkb.country = 'Czech Republic' 
			AND tkb.GDP IS NOT NULL
			AND tkb.YEAR = tk.rok) AS mezirocni_narust_hdp
FROM t_katerina_balint_project_sql_primary_final tk
JOIN t_katerina_balint_project_sql_primary_final tk1 ON tk.rok = tk1.rok - 1
	AND tk.nazev_kategorie = tk1.nazev_kategorie
JOIN t_katerina_balint_project_sql_secondary_final tk4 ON tk.rok = tk4.YEAR
WHERE tk.typ_kategorie = 'Odvětví'
GROUP BY tk.rok;

SELECT *,
	CASE
		WHEN mezirocni_narust_mzdy < 0 THEN 'Pokes'
		WHEN mezirocni_narust_mzdy BETWEEN 0 AND 5 THEN 'Nižší nárůst'
		ELSE 'Vyšší nárůst'
	END AS zmena_mzdy,
	CASE 
		WHEN mezirocni_narust_potraviny < 0 THEN 'Pokles'
		WHEN mezirocni_narust_potraviny BETWEEN 0 AND 5 THEN 'Nižší nárůst'
		ELSE 'Vyšší nárůst'
	END AS zmena_potraviny,
	CASE
		WHEN mezirocni_narust_hdp < 0 THEN 'Pokles'
		WHEN mezirocni_narust_hdp BETWEEN 0 AND 4 THEN 'Nižší nárůst'
		ELSE 'Vyšší nárůst'
	END AS zmena_hdp,
	CASE
		WHEN mezirocni_narust_mzdy < 0 AND mezirocni_narust_potraviny < 0 AND mezirocni_narust_hdp < 0 THEN 'Stejný vývoj'
		WHEN mezirocni_narust_mzdy BETWEEN 0 AND 5 AND mezirocni_narust_potraviny BETWEEN 0 AND 5 AND mezirocni_narust_hdp BETWEEN 0 AND 4 THEN 'Stejný vývoj'
		WHEN mezirocni_narust_mzdy > 5 AND mezirocni_narust_potraviny > 5 AND mezirocni_narust_hdp > 4 THEN 'Stejný vývoj'
		ELSE 'Odlišný vývoj'
	END AS srovnani_vyvoje
FROM v_katerina_balint_project_sql_final vkbpsf
WHERE mezirocni_narust_mzdy IS NOT NULL
	AND mezirocni_narust_potraviny IS NOT NULL 
	AND mezirocni_narust_hdp IS NOT NULL;