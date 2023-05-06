-- Vytvoøíme si základní tabulky
CREATE TABLE tblZanr(
    PK_Zanr int,
    nazev varchar(40),
    
    CONSTRAINT CPK_Zanr PRIMARY KEY(PK_Zanr)
    );
    
CREATE TABLE tblKniha(
    PK_Kniha int,
    nazev varchar(40) NOT NULL,
    FK_Kniha_Zanr int,
    
    CONSTRAINT CPK_Kniha PRIMARY KEY(PK_Kniha),
    
    CONSTRAINT CFK_Kniha_Zanr FOREIGN KEY(FK_Kniha_Zanr) 
    REFERENCES tblZanr(PK_Zanr)
    );

INSERT ALL
    INTO tblZanr(nazev) VALUES ('Svata kniha')
    INTO tblZanr(nazev) VALUES ('Detektivka')
    
    INTO tblKniha(nazev,FK_Kniha_Zanr) VALUES ('Bible',
    (SELECT PK_Zanr FROM tblZanr WHERE tblZanr.nazev = 'Svata kniha'))
    INTO tblKniha(nazev,FK_Kniha_Zanr) VALUES ('Koran',
    (SELECT PK_Zanr FROM tblZanr WHERE tblZanr.nazev = 'Svata kniha'))
    INTO tblKniha(nazev,FK_Kniha_Zanr) VALUES ('Sherlock Holmes',
    (SELECT PK_Zanr FROM tblZanr WHERE tblZanr.nazev = 'Detektivka'))
SELECT 1 FROM dual;

SELECT * FROM tblkniha;