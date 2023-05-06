-- Vytvoříme si tabulku Kniha
CREATE TABLE Kniha(
	PK_Kniha int AUTO_INCREMENT,
    Kniha varchar(40),
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
    );
    
-- Přidáme do tabulky testovací data
INSERT INTO Kniha VALUES(1,"Bible"),(2,"Korán");

-- Získáme všechny data z tabulky Kniha
SELECT * FROM Kniha;

-- Získáme pouze názvy z tabulky Kniha
-- + Změníme jméno zobrazení sloupce
SELECT Kniha AS Název FROM Kniha;

-- Vytvoříme si novou tabulku, žánr
CREATE TABLE Žánr(
	PK_Žánr int AUTO_INCREMENT,
    Název varchar(40),
    
    CONSTRAINT CPK_Žánr PRIMARY KEY(PK_Žánr)
    );
    
-- Do tabulky kniha vnoříme vztah
ALTER TABLE Kniha ADD FK_Žánr int;
ALTER TABLE Kniha ADD CONSTRAINT FK_Kniha_Žánr FOREIGN KEY(FK_Žánr) 
REFERENCES Žánr(PK_Žánr);

-- Vložíme základní data do žánru
INSERT INTO Žánr VALUES(1,"Svatá kniha"),(2,"Detektivka");

-- Vložíme jednu knihu do Knih s žánrem, 
-- jednu knihu bez žánru 
-- a přidáme žánry minulým záznamům
INSERT INTO Kniha VALUES(3,"Sherlock Holmes",2);
INSERT INTO Kniha VALUES(4,"Tajemná kniha",null);
UPDATE Kniha SET FK_Žánr = 1 WHERE PK_Kniha < 3;

-- Zkusme si nyní zobrazit oba objekty..
SELECT * FROM Kniha;
SELECT * FROM Žánr;

-- Spojíme obě tabulky a výsledek řádně ukážeme
-- (ŽÁDNÉ PK/FK ČÍSLA!)
SELECT Kniha.kniha AS Kniha, Žánr.název AS Žánr FROM Kniha
INNER JOIN Žánr
ON Kniha.FK_Žánr = Žánr.PK_Žánr;

-- Spojíme obě tabulky a výsledek řádně ukážeme
-- pomocí LEFT JOINU, který nám dá i výsledek mimo spojení knížky.
SELECT Kniha.kniha AS Kniha, Žánr.název AS Žánr FROM Kniha
LEFT JOIN Žánr
ON Kniha.FK_Žánr = Žánr.PK_Žánr;

-- Pro lepší pochopení agregačních funkcí,
-- vytvoříme knihám atribut "cena,"
-- s kterým budeme pracovat.
ALTER TABLE Kniha ADD cena int;

-- Přidáme náhodné cenové hodnoty
-- třem ze čtyř knížek
UPDATE Kniha SET cena = RAND()*100 WHERE PK_Kniha < 4;

-- Získáme průměrnou hodnotu knížek
SELECT AVG(cena) AS Prum_Cena FROM Kniha;

-- Získáme maximální hodnotu knížek
SELECT MAX(cena) AS Max_Cena FROM Kniha;

-- Získáme počet vyskytnutých cen (TUDÍŽ takových,
-- kde není NULL!)
SELECT COUNT(cena) AS Počet_Cen FROM Kniha;

-- Získáme počet vyskytnutých se instancí
-- v celé tabulce Kniha
SELECT COUNT(*) AS Počet_Knih FROM Kniha;

-- Potřebujeme zjistit počet knih, ale
-- ke každému žánru zvlášť!!
SELECT COUNT(*) AS Počet_Knih, Žánr.Název as ŽÁNR
FROM Kniha INNER JOIN Žánr
ON Žánr.PK_Žánr = Kniha.FK_Žánr
GROUP BY ŽÁNR;

-- Potřebujeme zjistit maximální hodnotu
-- ceny ke každému žánru zvlášť
-- (i knih bez žánru, a jakmile kniha nemá cenu,
-- chceme získat 0, ne null)
SELECT MAX(IFNULL(cena,0)) AS Maximální_cena, Žánr.Název AS Žánr FROM Kniha
LEFT JOIN Žánr
ON Žánr.PK_Žánr = Kniha.FK_Žánr
GROUP BY Žánr;

-- Seřadíme knížky dle jejich ceny, od největší po nejmenší
SELECT Kniha.Kniha, Kniha.cena FROM Kniha
ORDER BY cena DESC;

-- Vytvoříme si pohled
CREATE VIEW VW_PocetKnihZanr AS
SELECT COUNT(*) AS Počet_Knih, Žánr.Název as ŽÁNR
FROM Kniha INNER JOIN Žánr
ON Žánr.PK_Žánr = Kniha.FK_Žánr
GROUP BY ŽÁNR;

-- A takto jendoduše získáme požadované data
-- z pohledu..
SELECT * FROM VW_PocetKnihZanr;

-- Jelikož VIEW získáváme selectem, tak s ním můžeme
-- dělat další vymoženosti.
-- Např. seřadit abecedně žánry:
SELECT * FROM VW_PocetKnihZanr
ORDER BY ŽÁNR ASC;

-- Či dokonce chceme vědět jen ty žánry,
-- které mají více jak 1 počet knih:
SELECT ŽÁNR FROM VW_PocetKnihZanr
WHERE Počet_Knih > 1;