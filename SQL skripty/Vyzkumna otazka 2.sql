SELECT
	rok AS 'Srovnatelné období',
	prumerna_mzda DIV prumerna_cena_chleba AS 'Kolik kilogramů chleba si lze koupit za průměrnou mzdu?',
	prumerna_mzda DIV prumerna_cena_mleka AS 'Kolik litrů mléka si lze koupit za průměrnou mzdu?'
FROM (
	SELECT
		rok,
		avg(prumerna_hodnota) AS prumerna_mzda,
		(SELECT avg(prumerna_hodnota)
			FROM t_katerina_balint_project_sql_primary_final tk
			WHERE tk.nazev_kategorie LIKE ('%chléb%') AND tk.rok = t_katerina_balint_project_sql_primary_final.rok GROUP BY tk.rok) AS prumerna_cena_chleba,
		(SELECT avg(prumerna_hodnota)
			FROM t_katerina_balint_project_sql_primary_final tk
			WHERE tk.nazev_kategorie LIKE ('%mléko%') AND tk.rok = t_katerina_balint_project_sql_primary_final.rok GROUP BY tk.rok) AS prumerna_cena_mleka
	FROM t_katerina_balint_project_sql_primary_final
	WHERE typ_kategorie = 'Odvětví'
	GROUP BY rok
	HAVING prumerna_cena_chleba IS NOT NULL
	ORDER BY rok 
	LIMIT 1
) prumerne_ceny_a_mzdy
UNION
SELECT
	rok AS 'Srovnatelné období',
	prumerna_mzda DIV prumerna_cena_chleba AS 'Kolik kilogramů chleba si lze koupit za průměrnou mzdu?',
	prumerna_mzda DIV prumerna_cena_mleka AS 'Kolik litrů mléka si lze koupit za průměrnou mzdu?'
FROM (
	SELECT
		rok,
		avg(prumerna_hodnota) AS prumerna_mzda,
		(SELECT avg(prumerna_hodnota)
			FROM t_katerina_balint_project_sql_primary_final tk
			WHERE tk.nazev_kategorie LIKE ('%chléb%') AND tk.rok = t_katerina_balint_project_sql_primary_final.rok GROUP BY tk.rok) AS prumerna_cena_chleba,
		(SELECT avg(prumerna_hodnota)
			FROM t_katerina_balint_project_sql_primary_final tk
			WHERE tk.nazev_kategorie LIKE ('%mléko%') AND tk.rok = t_katerina_balint_project_sql_primary_final.rok GROUP BY tk.rok) AS prumerna_cena_mleka
	FROM t_katerina_balint_project_sql_primary_final
	WHERE typ_kategorie = 'Odvětví'
	GROUP BY rok
	HAVING prumerna_cena_chleba IS NOT NULL
	ORDER BY rok DESC
	LIMIT 1
) prumerne_ceny_a_mzdy;