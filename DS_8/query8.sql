CREATE TABLE Kniha(
	PK_Kniha int AUTO_INCREMENT,
    nazev varchar(40),
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha)
    );
    
INSERT INTO Kniha(nazev) VALUES ("Bible"),("Korán");