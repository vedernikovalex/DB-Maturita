use maturita;

-- nesplneni ENTITNI INTEGRITY
-- PK NESMI BYT NULL
create table Uzivatel(
id int primary key,
jmeno varchar(40) not null,
prijmeni varchar(40) not null,
vek varchar(40) not null
);


-- nesplneni REFERENCNI INTEGRITY

insert into Uzivatel(jmeno,prijmeni,vek) values ('Pavel', 'Martin', 12);

create table Uzivatel(
id int primary key,
jmeno varchar(40) not null,
prijmeni varchar(40) not null,
vek varchar(40) not null,
);

create table Kurz(
id int primary key identity(1,1),
nazev varchar(50),
cena int
);

create table Zanr(
id int primary key identity(1,1),



drop table Uzivatel;

select * from Uzivatel;