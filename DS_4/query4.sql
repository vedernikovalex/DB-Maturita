-- PŘÍKLAD: PK nesmí být null
CREATE TABLE Kniha(
	PK_Kniha int,
    Kniha varchar(40),
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
    );
    
    -- Error, PK nesmí být null
	INSERT INTO Kniha(PK_Kniha, Kniha) VALUES (NULL,"Bible");
    
    

-- PŘÍKLAD: Entita musí obsahovat PK
-- I přes to, že tato tabulka nebude házet error, nesplňuje Entitní integritu - 
-- nemá ani jeden unikátní atribut (takže nemůže mít PK),
-- tudíž na ní nemůže žádná jiná entita odkázat. 
CREATE TABLE Kniha(
		Kniha varchar(40)
    ); 
    
    Insert into Kniha(Kniha) Values ("Bible"),("Korán"),("Bible");
    
-- ---------------------------------------------------------------------------
    
-- PŘÍKLAD: Datový typ FK je stejný jako odkazovaný PK
-- Vytváření tabulky "Žánr" se vyvede
CREATE TABLE Žánr(
	PK_Žánr int,
    název varchar(40),
    
    CONSTRAINT CPK_Žánr PRIMARY KEY(PK_Žánr)
);

-- Kvůli nesplnění pravidel referenční integrity dostaneme při vytváření tabulky "Kniha" error
CREATE TABLE Kniha(
	Kniha varchar(40),
    FK_Kniha_Žánr varchar(10),
    
    CONSTRAINT CFK_Kniha_Žánr FOREIGN KEY(FK_Kniha_Žánr) REFERENCES Žánr(PK_Žánr)
    );
    
    
-- PŘÍKLAD: Odkazovaný PK ve FK musí také jakožto PK existovat v entitě
CREATE TABLE Žánr(
	PK_Žánr int,
    název varchar(40),
    
    CONSTRAINT CPK_Žánr PRIMARY KEY(PK_Žánr)
);

CREATE TABLE Kniha(
	Kniha varchar(40),
    FK_Kniha_Žánr int,
    
    CONSTRAINT CFK_Kniha_Žánr FOREIGN KEY(FK_Kniha_Žánr) REFERENCES Žánr(PK_Žánr)
    );

-- Vložíme jedinou hodnotu "Detektivka" s PK 1
INSERT INTO Žánr VALUES (1,"Detektitvka");

-- ERROR, pokoušíme se přidat Knížku "Sherlock Holmes" k žánru který má PK 2
-- - žádný takový neexistuje.
INSERT INTO Kniha VALUES ("Sherlock Holmes",2);

-- ---------------------------------------------------------------------------

-- PŘÍKLAD: Každý atribut má svůj datový typ který platí
-- pro každou instanci
CREATE TABLE Kniha(
    Kniha varchar(40),
    pocetKs int
);

-- "čtyřicet" je varchar, nikoliv int.
INSERT INTO Kniha VALUES ("Bible","čtyřicet");


-- PŘÍKLAD: Každý atribut splňuje rozmezí/nastavení
-- pro každou instanci

-- Decimal je nastaven na maximálně 6 celkových číslich 
-- (včetně nevyplněných plovoucích) a dvě plovoucí.
CREATE TABLE Kniha(
	Kniha varchar(40),
    cena decimal(6,2)
);

-- Číslo které se snažíme vložit má 6 číslic, ale má ještě
-- jednu neviditelnou, a to nevyplněné druhé místo plovoucí
-- číslice, za které se automaticky doplní "0", tudíž má
-- 7 číslic.
INSERT INTO Kniha VALUES ("Sherlock Holmes", 29999.4 );

-- ---------------------------------------------------------------------------

-- PŘÍKLAD: User-defined cena nemůže být nulová a menší jak nula
CREATE TABLE Kniha(
	Kniha varchar(40),
    cena int,
    
    CONSTRAINT CCHK_uvedeniDoSystemu_DnesniDatum CHECK (cena > 0)
    );
    
-- Jelikož se snažíme přidat negativní cenu, vyhodí se error
INSERT INTO Kniha VALUES ("Bible", -1);
