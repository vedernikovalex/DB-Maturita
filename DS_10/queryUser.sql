-- Zkusíme použít databázi "maturita"
USE maturita;

-- Nyní zkusíme použít databázi "maturita"
-- po získání právu k SELECTU od DBadmina
USE maturita;

-- Vyzkoušíme zda select funguje
SELECT * FROM Kniha;

-- Vyzkoušíme např. INSERT,
-- na který nemáme právo
INSERT INTO Kniha VALUES (3,"HAHA");

-- Za uživatele si aktivujeme (všechny) role,
-- které nám byly přiděleny
SET ROLE ALL;

-- Nyní za uživatele znovu vyzkoušíme INSERT,
-- na který jsme předtím neměli právo.
INSERT INTO Kniha VALUES (3,"HAHA");


-- Po sebrání práv zkusíme uživatelem SELECT, který nám předtím šel
SELECT * FROM Kniha;

-- Možná již nemáme právo na SELECT tabulky jakožto uživatel,
-- každopádně stále máme naší roli, která nám dovoluje
-- INSERT do celé databáze maturita.
INSERT INTO Kniha VALUES (4,"Knížka o insertování");

-- Po smazání role vyzkoušíme za uživatele INSERT
INSERT INTO Kniha VALUES (5,"Knížka o chybějící roli k insertu");