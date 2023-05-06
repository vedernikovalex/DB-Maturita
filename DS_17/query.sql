-- Vytvoříme si testovaci tabulku
-- Žánr
CREATE TABLE Žánr(
	PK_Žánr int AUTO_INCREMENT,
    Nazev varchar(40),
    
    CONSTRAINT CPK_Žánr PRIMARY KEY(PK_Žánr)
);

-- Vytvoříme si testovací tabulku
-- Kniha
CREATE TABLE Kniha(
	PK_Kniha int AUTO_INCREMENT,
    Nazev varchar(40),
    FK_Žánr int,
    Cena int,
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha),
    CONSTRAINT CFK_Kniha_Žánr FOREIGN KEY(FK_Žánr) REFERENCES Žánr(PK_Žánr)
);

-- Vložíme testovací data
INSERT INTO Žánr VALUES
(1,'Svatá kniha'),(2,'Detektivka');
INSERT INTO Kniha VALUES 
(1,'Bible',1,1000),(2,'Korán',1,1000),(3,'Sherlock Holmes',2,49);

SELECT * FROM Kniha;

-- Pro ukázky využití transakce v proceduře
-- vypneme autocommit
SET autocommit = 0; 

-- Vytvoříme proceduru, která umí vytvořit
-- Žánr i knihu naráz

-- DELIMITER je vždy třeba změnit, aby se
-- mohl použít ukončení kódu (;) v rutině
DELIMITER //
CREATE PROCEDURE PRC_KnihaZanr (
IN nazevKnihy varchar(40), 
IN cenaKnihy INT, 
IN nazevZanru varchar(40))
	BEGIN
    
    INSERT INTO Žánr(nazev) 
    VALUES (nazevZanru);
    
    -- Zde používáme proměnnou @Zanr_ID,
    -- kterou používáme dále v kódu pro čitelnost
    SET @Zanr_ID = (SELECT PK_Žánr FROM Žánr WHERE nazev = nazevZanru);
    
    INSERT INTO Kniha(nazev, cena, FK_Žánr) VALUES
    (nazevKnihy, cenaKnihy, @Zanr_ID);
    
    COMMIT;
    
    END//
DELIMITER ;

-- Zavoláme proceduru
CALL PRC_KnihaZanr ('Maxipes Fík',499,'Pohádka');



-- Chceme vytvořit funkci, která nám
-- vrátí celkový počet knih daného žánru
DELIMITER //
CREATE FUNCTION FC_CelkovyPocet_KnihyZanry (zanr varchar(40))
RETURNS INT READS SQL DATA
	BEGIN

    RETURN(
    SELECT COUNT(*) FROM Kniha INNER JOIN Žánr 
    ON FK_Žánr = PK_Žánr WHERE Žánr.nazev = zanr
    );
    
    END //
DELIMITER ;

-- Zjistíme počet knih například takto
-- (DUAL tabulka je prázdná tabulka)
SELECT FC_CelkovyPocet_KnihyZanry('Svatá kniha') AS Počet_Knih
FROM DUAL;