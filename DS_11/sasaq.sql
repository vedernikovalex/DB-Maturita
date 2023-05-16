use PV_10;

select * from testovaci;

create table if not exists testovaci2(
id int not null
);


delete from testovaci where id = 12;

select * from testovaci2;





