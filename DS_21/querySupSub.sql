-- vytvoříme si supertype/subtype, který
-- je non-exkluzivní = osoba může být jak zaměstnancem,
-- tak klientem daného podniku.

CREATE TABLE Osoba(
	PK_Osoba int AUTO_INCREMENT,
    prijmeni varchar(40),
    jmeno varchar(40),
    
    CONSTRAINT CPK_Osoba PRIMARY KEY(PK_Osoba)
    );
    
CREATE TABLE Zamestnanec(
	PKFK_Zamestnanec_Osoba int,
    mesicniplat float,
    
    CONSTRAINT CPK_Zamestnanec 
    PRIMARY KEY(PKFK_Zamestnanec_Osoba),
    
    CONSTRAINT CFK_Zamestnanec_Osoba 
    FOREIGN KEY(PKFK_Zamestnanec_Osoba)
    REFERENCES Osoba(PK_Osoba)
    );
    
CREATE TABLE Navstevnik(
	PKFK_Navstevnik_Osoba int,
    datumPosledniNavstevy DATE,
    
    CONSTRAINT CPK_Navstevnik 
    PRIMARY KEY(PKFK_Navstevnik_Osoba),
    
    CONSTRAINT CFK_Navstevnik_Osoba 
    FOREIGN KEY(PKFK_Navstevnik_Osoba)
    REFERENCES Osoba(PK_Osoba)
    );