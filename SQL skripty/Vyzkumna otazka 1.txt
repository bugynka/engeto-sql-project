SELECT DISTINCT
	CASE
	WHEN zmena_mzdy = 'Mzda klesá' THEN 'Ano, mzdy v některých odvětvích klesají'
	ELSE 'Ne, mzdy pouze rostou'
	END AS 'Klesá někdy mzda?'
FROM (
SELECT
	tkb.nazev_kategorie AS odvetvi,
	tkb.rok AS rok_1,
	tkb.prumerna_hodnota AS prumerna_mzda_1,
	tkb2.rok AS rok_2,
	tkb2.prumerna_hodnota AS prumerna_mzda_2,
	CASE 
		WHEN tkb2.prumerna_hodnota - tkb.prumerna_hodnota > 0 THEN 'Mzda roste'
		WHEN tkb2.prumerna_hodnota - tkb.prumerna_hodnota = 0 THEN 'Mzda je stejná'
		ELSE 'Mzda klesá'
	END AS zmena_mzdy
FROM t_katerina_balint_project_sql_primary_final tkb
JOIN t_katerina_balint_project_sql_primary_final tkb2 ON tkb.rok = tkb2.rok -1
	AND tkb.nazev_kategorie = tkb2.nazev_kategorie
	AND tkb.primarni_jednotka = tkb2.primarni_jednotka
WHERE tkb.typ_kategorie = 'Odvětví'
GROUP BY rok_1, odvetvi) tabulka_zmen_mezd
WHERE zmena_mzdy = 'Mzda klesá';