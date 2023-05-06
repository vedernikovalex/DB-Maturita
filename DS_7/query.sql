use testdb;

-- Vytvoøíme tabulku Kniha
CREATE TABLE Kniha(
	PK_Kniha int,
	kniha varchar(40),

	CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
	);

-- Vložíme první data
INSERT INTO Kniha VALUES (1,'Korán'),(2,'Bible');

-- Vložíme data po FULL BACKUPU
INSERT INTO Kniha VALUES (3,'Sherlock Holmes');

-- Vymažeme všechny data z tabulky
TRUNCATE TABLE Kniha;

-- Znovu vymažeme všechny data z tabulky
TRUNCATE TABLE Kniha;

SELECT * FROM Kniha;