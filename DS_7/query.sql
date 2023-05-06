use testdb;

-- Vytvo��me tabulku Kniha
CREATE TABLE Kniha(
	PK_Kniha int,
	kniha varchar(40),

	CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
	);

-- Vlo��me prvn� data
INSERT INTO Kniha VALUES (1,'Kor�n'),(2,'Bible');

-- Vlo��me data po FULL BACKUPU
INSERT INTO Kniha VALUES (3,'Sherlock Holmes');

-- Vyma�eme v�echny data z tabulky
TRUNCATE TABLE Kniha;

-- Znovu vyma�eme v�echny data z tabulky
TRUNCATE TABLE Kniha;

SELECT * FROM Kniha;