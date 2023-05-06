-- Vytvoříme si tabulku s PK
-- a Unique názvem
CREATE TABLE Kniha(
	PK_Kniha int,
    Nazev varchar(40),
    Cena int,
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha),
    CONSTRAINT CUQ_Nazev UNIQUE(Nazev)
    );

-- Vložíme testovací data
INSERT INTO Kniha VALUES 
(1,'Bible',149),(2,'Korán',149),(3,'Sherlock Holmes',79);

-- Vyzkoušíme najít PK 3
SELECT * FROM Kniha WHERE PK_Kniha = 3;

-- Vyzkoušíme najít knihu 'Korán'
SELECT * FROM Kniha WHERE Nazev = 'Korán';

-- Zkusíme porovnávací logické operace
SELECT * FROM Kniha WHERE PK_Kniha < 3;

-- Nyní zkusme porovnávací logické operace na ceně...
SELECT * FROM Kniha WHERE CENA > 1000;

-- Vytvoříme tedy samostatný index
CREATE INDEX IX_Kniha_Cena ON Kniha(cena);

-- Nyní zkusme znovu logickou operaci na cenu...
SELECT * FROM Kniha WHERE CENA > 1000;