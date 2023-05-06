-- Podíváme se, jakou máme aktivní roli
SELECT CURRENT_ROLE();

-- Podíváme se na práva, které máme,
-- včetně díky roli
SHOW GRANTS FOR 'DCLUser'@'localhost' 
USING 'testRole'@'localhost';

-- Vyzkoušíme povolený SELECT
-- pro uživatele na sloupec cena
SELECT cena FROM Kniha;

-- Vyzkoušíme například DELETE tabulky
-- (Role ani uživatel nemají právo na tuto akci)
DELETE FROM Kniha WHERE cena = 47;

-- Vyzkoušíme povolený INSERT
-- pro roli do tabulky Kniha
INSERT INTO Kniha VALUES(69,'Kniha o ničem',490);

-- Roli můžeme deaktivovat
SET ROLE NONE;

-- Nyní vyzkoušíme INSERT znovu...
INSERT INTO Kniha VALUES(70,'Kniha o rolích',790);