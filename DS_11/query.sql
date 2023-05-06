-- Vytvoříme například tabulku ...
CREATE TABLE Kniha(
	PK_Kniha int,
    Kniha varchar(40),
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
    );
    
-- Můžeme vytvořit i jiný objekt, 
-- například VIEW k tabulce ...
CREATE VIEW VW_Kniha AS
	SELECT * FROM Kniha;

-- Je-li libo Trigger ...
-- musíme nastavit jiný DELIMETER, aby se mohl používat
-- středník v těle Triggeru
DELIMITER //
CREATE TRIGGER TRG_Kniha BEFORE INSERT ON Kniha
	FOR EACH ROW
    BEGIN
	IF NEW.PK_Kniha IS NULL THEN
		SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'PK musí být nastaven.';
	END IF; 
    END; //
DELIMITER ;

DELIMITER //
-- Nebo třeba procedura
CREATE PROCEDURE PRC_VlozKnizku (IN PK int, IN nazev varchar(40))
	BEGIN
		INSERT INTO Kniha VALUES(PK, nazev);
	END //
DELIMITER ;

-- Na všechny objekty se dá použít ještě IF [NOT] EXISTS
-- který nejdříve zkontroluje, jestliže objekt již
-- existuje / neexistuje
CREATE TABLE IF NOT EXISTS Kniha(
	PK_Kniha int,
    Kniha varchar(40),
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
    );
    
-- Smazání například procedury
DROP PROCEDURE PRC_VlozKnizku;

-- Přidání nového sloupce
ALTER TABLE Kniha ADD cena int;

-- Smazání sloupce
ALTER TABLE KNIHA DROP COLUMN cena;

-- Přejmenování sloupce
ALTER TABLE Kniha RENAME COLUMN Kniha TO Nazev;

-- Přeměna datového typu sloupce (Zmenšíme varchar na
-- 20 znaků)
ALTER TABLE Kniha MODIFY COLUMN Nazev varchar(20);

-- Změníme například pohled
ALTER VIEW VW_Kniha AS
	SELECT * FROM KNIHA WHERE Kniha.PK_Kniha > 1;
    
-- Vložíme si něco do tabulky
INSERT INTO Kniha VALUES(2,"Bible");

-- Použijeme TRUNCATE
TRUNCATE TABLE Kniha;

SELECT * FROM KNIHA;

-- Přejmenujeme například Tabulku
RENAME TABLE Kniha TO Knizka;

-- Vložíme data do tabulek (dva způsoby)

-- Bez uvedení atributů - musíme
-- vědět přesný postup atributů, vyplnit
-- všechny a se správným datovým typem
INSERT INTO Knizka VALUES (3,'Sherlock Holmes'),(4,'Maj');

-- S uvedením atributů
INSERT INTO Knizka(PK_Kniha, nazev) VALUES (5,'Tojejedno'),(6,'Korán');

-- Insert do pohledu
INSERT INTO VW_Kniha VALUES (7,'Dasenka');

-- Update názvu knížky, kde je PK 5
UPDATE Knizka SET nazev = "idk" WHERE PK_Kniha = 5;

-- Smazání všech záznamů větší jak 6
DELETE FROM Knizka WHERE PK_Kniha > 6;