-- Vytvoříme si tabulku kniha
CREATE TABLE Kniha(
	PK_Kniha int AUTO_INCREMENT,
    Kniha varchar(40),
    cena int,
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
    );
    
-- Vyplníme daty
INSERT INTO Kniha VALUES (1,"Bible",47),(2,"Korán",199),(3,"SQL Programming",29);

-- Zjistíme všechny knížky, které mají větší
-- cenu jak průměr všech knížek pomocí vnořeného příkazu
SELECT * FROM Kniha WHERE cena > (SELECT AVG(cena) FROM Kniha);

-- Znovu přidáme názvy těch knížek, které mají cenu menší jak
-- průměr ceny všech knížek
INSERT INTO Kniha(Kniha) SELECT Kniha FROM Kniha 
WHERE cena < (SELECT AVG(cena) FROM Kniha);



-- Chceme získat všechny knížky, kromě Bible a Koránu
SELECT * FROM Kniha WHERE Kniha.kniha NOT IN("Bible","Korán");

-- Chceme získat všechny knížky jen pokud
-- Máme v databázi knížku "Optimus Prime"
SELECT * FROM Kniha WHERE EXISTS(SELECT * FROM Kniha WHERE Kniha.kniha = "Optimus Prime");

-- Chceme získat všechny knížky která má
-- alespoň jednou větší cenu ze všech knih
SELECT * FROM Kniha WHERE cena > ANY (SELECT cena FROM Kniha);
