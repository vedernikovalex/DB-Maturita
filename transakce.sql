create database maturita;

use maturita;


SET IMPLICIT_TRANSACTIONS ON 


begin transaction;
create table Bankovni_ucet(
id int not null identity(1,1) primary key,
zustatek int not null
);
commit;

begin transaction;
insert into Bankovni_ucet(zustatek) values (100),(200);
commit;

select * from Bankovni_ucet;

BEGIN TRANSACTION
	update Bankovni_ucet set zustatek = zustatek + 100 where id = 1;
	update Bankovni_ucet set zustatek = zustatek - 100 where id = 2;
ROLLBACK
COMMIT