SELECT DISTINCT
	CASE 
		WHEN abs(mezirocni_narust_potraviny - mezirocni_narust_mzdy) > 10 THEN 'Ano, takový rok existuje'
		ELSE 'Ne, takový rok neexistuje'
	END AS 'Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd?'
FROM (
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
		GROUP BY tk2.rok) AS mezirocni_narust_potraviny
	FROM t_katerina_balint_project_sql_primary_final tk
	JOIN t_katerina_balint_project_sql_primary_final tk1 ON tk.rok = tk1.rok - 1
		AND tk.nazev_kategorie = tk1.nazev_kategorie
	WHERE tk.typ_kategorie = 'Odvětví'
	GROUP BY tk.rok
	HAVING mezirocni_narust_potraviny IS NOT NULL) sjednocene_rozdily;