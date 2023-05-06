-- Vytvořme si testovací tabulku
CREATE TABLE Kniha(
	PK_Kniha int AUTO_INCREMENT,
    Nazev varchar(40),
    datumVydani DATE,
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
    );
    
-- Představme si, že nemáme v plánu přidávat
-- knihy s nadcházejícím datem vydání,
-- tudíž by nedávalo smysl, aby knížka
-- měla datum vydání větší,
-- jak datum dnešní

DELIMITER //
CREATE TRIGGER TRG_INS_datumVydani
BEFORE INSERT
ON Kniha
FOR EACH ROW
	BEGIN
    
    IF(NEW.datumVydani > CURDATE()) THEN
    -- SIGNAL vyhodí výjimku a tím zastaví exekuci DML příkazu
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = "Datum je větší jak dnešní.";
    END IF;
    
    END //
DELIMITER ;
    
-- Vyzkoušejme přidání instancí do tabulky s tímto TRIGGEREM,
-- pokud je dnešní datum 17.03.2023
INSERT INTO Kniha(nazev, datumVydani) VALUES
 ('Bible','0001-01-01');
    
INSERT INTO Kniha(nazev, datumVydani) VALUES
 ('Nějaká nová Kniha','2023-05-10');
 
-- Vytvoříme ten stejný TRIGGER ale pro UPDATE
DELIMITER //
CREATE TRIGGER TRG_UPD_datumVydani
BEFORE UPDATE
ON Kniha
FOR EACH ROW
	BEGIN
    
    IF(NEW.datumVydani > CURDATE()) THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = "Datum je větší jak dnešní.";
    END IF;
    
    END //
DELIMITER ;

-- Nyní při vyzkoušení UPDATU a
-- datumu větší jak dnešní se také vyhodí
-- výjimka
UPDATE Kniha SET datumVydani = "2023-03-18" WHERE PK_Kniha = 1;

-- Vytvořme si archivní tabulku,
-- ve které nechceme ukládat nic jiného,
-- než např. název (pro ušetření dat,
-- jelikož nás třeba datumVydání nezajíma
-- u archivovaných knih)
CREATE TABLE arch_Kniha (
	PK_Arch_Kniha int AUTO_INCREMENT,
    nazev varchar(40),
    
    CONSTRAINT CPK_Arch_Kniha PRIMARY KEY(PK_Arch_Kniha)
);

-- Přidejme si ještě dvě testovací instance,
-- ať vidíme jak to funguje.
INSERT INTO Kniha(nazev,datumVydani) VALUES 
('Korán',NULL),('Sherlock Holmes',NULL);

-- Nyní vytvořme TRIGGER, který při smazání
-- čehokoliv v tabulce KNIHA pouze přesune data
-- které potřebujeme do archivní tabulky,
-- po úspěšném smazání v tabulce originální

DELIMITER //
CREATE TRIGGER TRG_DEL_archive
AFTER DELETE
ON Kniha
FOR EACH ROW
	BEGIN
    
	INSERT INTO arch_Kniha(nazev) VALUES
    (OLD.nazev);
    
    END //
DELIMITER ;

-- Zkusme vymazat Sherlocka Holmese
DELETE FROM Kniha WHERE PK_Kniha = 3;

SELECT * FROM Kniha;

SELECT * FROM arch_Kniha;