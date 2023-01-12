DROP PROCEDURE IF EXISTS insert_driver;
DELIMITER $
CREATE PROCEDURE insert_driver(IN AT char(10),IN name varchar(20),IN lname varchar(20),IN salary float(7,2),IN license ENUM('A','B','C','D'),IN route ENUM('LOCAL','ABROAD'),IN experience tinyint(4))
BEGIN
DECLARE code INT;

SELECT branch.br_code INTO code FROM branch INNER JOIN worker ON br_code=wrk_br_code INNER JOIN driver ON wrk_AT=drv_AT GROUP BY br_code ORDER BY count(*) ASC LIMIT 1;

INSERT INTO worker VALUES (AT,name,lname,salary,code);

INSERT INTO driver VALUES (AT,license,route,experience);
END$
DELIMITER ;

--CALL insert_driver('AX10354100','Thanasaskhs','Legitsas','1500.32','D','LOCAL',10);

--SELECT * FROM driver;

