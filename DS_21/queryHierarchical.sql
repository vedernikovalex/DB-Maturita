-- Vytvoříme zaměstnance, který
-- má na sebe sama FK, tudíž bude
-- tvořit hierarchii (strom)
CREATE TABLE Zamestnanec(
	PK_Zamestnanec int AUTO_INCREMENT,
    prijmeni varchar(40),
    FK_Zamestnanec int,
    
    CONSTRAINT CPK_Zamestnanec PRIMARY KEY(PK_Zamestnanec),
    
    CONSTRAINT CFK_Zamestnanec FOREIGN KEY (FK_Zamestnanec)
    REFERENCES Zamestnanec(PK_Zamestnanec)
    );
    
    