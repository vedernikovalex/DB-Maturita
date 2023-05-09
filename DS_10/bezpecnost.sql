create database Maturita;
use Maturita;

create user 'maturita'@'localhost' identified by 'heslo';
grant select on maturita.uzivatel to 'maturita'@'localhost';

show grants;
show grants for 'maturita'@'localhost';

create role 'rolerole'@'localhost';
grant insert on maturita.* to 'rolerole'@'localhost';
grant 'rolerole'@'localhost' to 'maturita'@'localhost';
flush privileges; -- potvrdi zmeny v ROLICH
set role all; -- prevzeti role z commitu

revoke select on maturita.uzivatel from 'maturita'@'localhost';
flush privileges;

drop role 'maturita'@'localhost';
flush privileges;