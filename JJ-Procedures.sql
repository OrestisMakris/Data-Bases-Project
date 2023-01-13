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

DROP PROCEDURE IF EXISTS search_trip;
DELIMITER $
CREATE PROCEDURE search_trip(IN code INT,IN start_date datetime,IN end_date datetime)
BEGIN
DECLARE reservations_number INT;

SELECT COUNT(*) INTO reservations_number FROM reservation INNER JOIN trip ON res_tr_id=tr_id;

SELECT trip.tr_cost,trip.tr_maxseats,(SELECT reservations_number) reservations,(SELECT trip.tr_maxseats-reservations_number FROM trip) 
empty_seats,drv.lname AS driver_lname,drv.name AS driver_name,gui.lname AS guide_lname,gui.name 
AS guide_name,trip.tr_departure,trip.tr_return FROM trip INNER JOIN worker 
AS drv ON tr_br_code=drv.wrk_br_code INNER JOIN worker AS gui ON tr_br_code=gui.wrk_br_code 
WHERE code=tr_br_code AND start_date=<tr_departure AND end_date>=tr_departure;
END$
DELIMITER ;

CALL search_trip(1,'2022-06-05 00:00:00','2022-08-15 23:59:59');

SELECT * FROM trip WHERE '2022-06-05 00:00:00'=<tr_departure AND '2022-08-15 23:59:59'>=tr_departure;