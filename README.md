Discord: Kateřina Bálint (katerinabalint_41161)

Projekt z SQL
---
# Struktura projektu
- Průvodní listina
- Soubory s SQL skripty generujícími zdrojové tabulky (Zdrojova tabulka 1.sql, Zdrojova tabulka 2.sql)
- Soubory s SQL skripty generujícími odpovědi na výzkumné otázky, případně datový podklad k odpovězení na výzkumné otázky (Vyzkumna otazka 1.sql, Vyzkumna otazka 2.sql, Vyzkumna otazka 3.sql, Vyzkumna otazka 4.sql, Vyzkumna otazka 5.sql)

# Zadání
V rámci tohoto projektu jsem připravila datové podklady, z nichž je možné vyčíst informace o dostupnosti potravin na základě průměrných mezd v České republice. 
Tyto datové podklady jsem shromáždila do dvou tabulek, které vznikly spojením relevantních informací z několika primárních tabulek.

Pomocí SQL dotazů jsem se následně pokusila nalézt odpovědi na následující výzkumné otázky:
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

# Postup práce
Při práci na projektu jsem v začátcích zvolila možná trochu nestandardní postup - nejprve jsem si napsala první tři SQL dotazy s odpověďmi na výzkumné otázky.
Tyto SQL dotazy odkazovaly na primární tabulky, protože jsem si potřebovala ujasnit, jaká data budu potřebovat zahrnout do své finální tabulky - po přečtení zadání mi to totiž nebylo úplně jasné.
Až poté jsem vytvořila první finální tabulku, které obsahovala jen ta data, která jsem potřebovala. V návaznosti na to jsem upravila již napsané SQL dotazy tak, aby braly data z nově vytvořené tabulky.
Tento postup mi zabral poměrně dost času, ale výsledkem je tabulka, která obsahuje pouze relevantní data.

Další výzvou bylo napsání skriptů tak, aby tabulky obsahovaly porovnání hodnot ve dvou po sobě jdoucích rocích. 
Technicky jsem věděla, jak to udělat, ale pospojovat všechny potřebné tabulky a vytvořit vnořené selecty tak, aby se mi zobrazovaly správně vypočítané hodnoty u správného roku, byl poměrně velký oříšek.
Následovala podrobnější kontrola dat, ujištění, zda hodnoty opravdu poskytují odpovědi na výzkumné otázky, a případná úprava selectů.

Nakonec jsem vytvořila druhou finální tabulku, kterou jsem následně využila pro zodpovězení poslední výzkumné otázky. Pro usnadnění práce jsem si vytvořila i jeden view, díky čemuž je SQL skript o mnoho jednodušší.
V některých letech chyběly údaje o mzdách, cenách potravin či HDP, proto jsem porovnávala pouze ty roky, ve kterých byla data dostupná ve všech třech kategoriích.

# Popis datového souboru

## Zdrojová tabulka 1
Tabulka s názvem t_katerina_balint_project_SQL_primary_final obsahuje data o průměrných mzdách a cenách a je kombinací vybraných dat z následujících primárních tabulek:
- czechia_payroll
- czechia_payroll_industry_branch
- czechia_payroll_unit
- czechia_price
- czechia_price_category

Tato tabulka obsahuje 5 sloupců:
- rok
- nazev_kategorie - v případě mezd název odvětví, v případě zboží název potraviny
- typ_kategorie - 2 kategorie (Odvětví/Zboží)
- prumerna_hodnota - v případě odvětví průměrná mzda v daném roce, v případě potravin průměrná cena v daném roce
- primarni_jednotka - v případě mezd Kč, v případě zboží měrná jednotka (l, kg, ks,...)

## Zdrojová tabulka 2
Tabulka s názvem t_katerina_balint_project_SQL_secondary_final obsahuje data o HDP, GINI a populaci v evropských státech a kombinuje data z následujících primárních tabulek:
- countries
- economies

Tato tabulka obsahuje rovněž 5 sloupců:
- country - název země
- year - rok
- GDP - hodnota HDP v dané zemi v daném roce
- gini - hodnota GINI v dané zemi v daném roce
- population - populace dané země

# Odpovědi na výzkumné otázky

## Výzkumná otázka č. 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Odpověď: V některých odvětvích mzdy v průběhu let klesají.

## Výzkumná otázka č. 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Odpověď: V prvním srovnatelném období (rok 2006) je možné koupit si 1287 kilogramů chleba a 1437 litrů mléka.
	 V posledním srovnatelném období (rok 2018) je možné koupit si 1342 kilogramů chleba a 1641 litrů mléka.

## Výzkumná otázka č. 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
Odpověď: Nejpomaleji zdražuje položka "Banány žluté".

## Výzkumná otázka č. 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Odpověď: Ne, takový rok neexistuje.

## Výzkumná otázka č. 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
Odpověď: V některých letech má vývoj HDP, mezd a cen potravin stejnou tendenci, není tomu tak ale vždy.