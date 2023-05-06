-- Vytvoříme si uživatele
CREATE USER 'maturitaUser'@'localhost' IDENTIFIED BY 'heslo';

-- Jakožto root přidáme uživateli právo k SELECT tabulky Kniha v databázi maturita
GRANT SELECT ON maturita.Kniha TO 'maturitaUser'@'localhost';

-- Můžeme použít tento příkaz,
-- který zajistí správné
-- nastavení práv.
FLUSH PRIVILEGES;

-- Můžeme zjistit, jaké máme aktuální práva
-- tímto příkazem
SHOW GRANTS;
-- Nebo můžeme zjistit, jaké má práva
-- jakýkoliv jiný uživatel/role
SHOW GRANTS FOR 'maturitaUser'@'localhost';

-- Jakožto root vytvoříme roli
CREATE ROLE 'maturitaRole'@'localhost';

-- Přidáme roli možnost INSERTU do celé databáze maturita 
-- (Ne jen tabulky Kniha)
GRANT INSERT ON maturita.* TO 'maturitaRole'@'localhost';

-- Dáme roli našemu uživateli
GRANT 'maturitaRole'@'localhost' TO 'maturitaUser'@'localhost';

-- Můžeme použít tento příkaz,
-- který zajistí správné
-- nastavení práv.
FLUSH PRIVILEGES;



-- Jakožto root sebereme právo SELECTU našemu uživateli
REVOKE SELECT ON maturita.Kniha FROM 'maturitaUser'@'localhost';

-- Můžeme použít tento příkaz,
-- který zajistí správné
-- nastavení práv.
FLUSH PRIVILEGES;

-- Jakožto root kompletně smažeme roli maturitaRole
DROP ROLE 'maturitaRole'@'localhost';

-- Můžeme použít tento příkaz,
-- který zajistí správné
-- nastavení práv.
FLUSH PRIVILEGES;