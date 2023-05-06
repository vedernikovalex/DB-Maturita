-- Vytvoříme si testovacího USERA
CREATE USER 'DCLUser'@'localhost' IDENTIFIED BY 'heslo';

-- GLOBAL LEVEL
-- Dáme uživateli právo na vytváření uživatelů
GRANT CREATE USER ON *.* 
TO 'DCLUser'@'localhost';

-- DATABASE LEVEL
-- Dáme uživateli právo na vytváření a mazání
-- tabulek v databázi maturita
GRANT CREATE, DROP ON maturita.* 
TO 'DCLUser'@'localhost';

-- TABLE LEVEL
-- Dáme uživateli právo na ALTER, INSERT A UPDATE
-- tabulky Kniha  v databázi maturita
GRANT ALTER, INSERT, UPDATE ON maturita.Kniha 
TO 'DCLUser'@'localhost';

-- COLUMN LEVEL
-- Dáme uživateli právo na SELECT sloupce cena
-- v tabulce Kniha v databázi maturita
GRANT SELECT(cena) ON maturita.Kniha 
TO 'DCLUser'@'localhost';

-- Nyní provedeme REVOKE např. na práva u TABLE Levelu
REVOKE ALTER,INSERT,UPDATE ON maturita.Kniha 
FROM 'DCLUser'@'localhost';

-- Podíváme se, jaké práva uživatel má
SHOW GRANTS FOR 'DCLUser'@'localhost';



-- Role se vytváří stejně jako uživatelé,
-- dávají se jim stejně práva jako uživatelům,
-- a poté se GRANTUJÍ stejně jako práva uživatelům.
CREATE ROLE 'testRole'@'localhost';

-- Přidáme například TABLE LEVEL
GRANT INSERT ON maturita.Kniha TO 'testRole'@'localhost';

-- Přidáme roli uživateli
GRANT 'testRole'@'localhost' TO 'DCLUser'@'localhost';

-- Nastavíme ji jakožto defaultní
SET DEFAULT ROLE 'testRole'@'localhost' TO 'DCLUser'@'localhost';

-- Podíváme se, jaké práva role má
SHOW GRANTS FOR 'testRole'@'localhost';




-- Vypneme autocommit (Zapneme možnost transakcí)
SET autocommit = 0;

-- Vložíme knížku do tabulky
INSERT INTO Kniha VALUES (71,'Random kniha',490);

-- Vytvoříme SAVEPOINT
SAVEPOINT PoInsertu;

-- Ale ne! Chtěli jsme vymazat pouze Korán,
-- ale místo '=' jsme napsali '>' ...
-- Teď jsme ztratili mnoho dat!
DELETE FROM Kniha WHERE PK_Kniha > 2;

-- Naštěstí jsme vytvořili SAVEPOINT,
-- do kterého se teď vrátíme
ROLLBACK TO PoInsertu;

-- Vymažeme Korán, tak jak jsme
-- chtěli původně
DELETE FROM Kniha WHERE PK_Kniha = 2;

-- Nyní, když je DB ve stavu ve kterém
-- jsme chtěli, můžeme provést tvrdé
-- zapsání dat do DB COMMITEM
COMMIT;

-- Pokus o Rollback do SAVEPOINTU
-- se nepovede, jelikož jsme provedli commit.
ROLLBACK TO PoInsertu;