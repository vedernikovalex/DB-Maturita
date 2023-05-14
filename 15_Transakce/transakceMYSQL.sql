use PV_10;

create table Kniha(
id int not null auto_increment,
nazev varchar(20) not null,
cena int not null,
constraint PK_Kniha primary key (id),
constraint UNQ_Kniha_nazev UNIQUE(nazev)
);
drop table Kniha;
insert into Kniha(nazev,cena) values ('Bible',120),('Martin',190),('Kamasutra',400),('Hovno',1239);

select * from Kniha where id = 4;
select * from Kniha where nazev = 'Bible';

create index IX_Kniha_cena on Kniha(cena);
drop index IX_Kniha_cena on Kniha;
select * from Kniha where cena > 399;

