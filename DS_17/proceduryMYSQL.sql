use PV_10;

create table Uzivatel(
id int not null auto_increment,
jmeno varchar(40) not null,
vek int not null,
primary key (id)
);

set autocommit = 0;

delimiter //
create procedure PRC_Insert_Uzivatel ( 
IN IN_jmeno varchar(40),
IN IN_vek int)

	begin
	insert into Uzivatel(jmeno,vek) values(IN_jmeno, IN_vek);
	commit;

	end//
delimiter ;

call PRC_Insert_Uzivatel('pavel',12);
select * from Uzivatel;