-- procedure 3.1.3.1
DROP PROCEDURE IF EXISTS insert_driver;
DELIMITER $
CREATE PROCEDURE insert_driver(IN AT char(10),IN name varchar(20),
IN lname varchar(20),IN salary float(7,2),IN license ENUM('A','B','C','D'),
IN route ENUM('LOCAL','ABROAD'),IN experience tinyint(4))

BEGIN
DECLARE code INT;

SELECT branch.br_code INTO code FROM branch 
INNER JOIN worker ON br_code=wrk_br_code 
INNER JOIN driver ON wrk_AT=drv_AT 
GROUP BY br_code ORDER BY count(*) ASC LIMIT 1;

INSERT INTO worker VALUES (AT,name,lname,salary,code);

INSERT INTO driver VALUES (AT,license,route,experience);
END$
DELIMITER ;

CALL insert_driver('AX10322102','Takis','Kapakis','1500.32','C','LOCAL',4);

SELECT * FROM driver;

-- procedure 3.1.3.2
DROP PROCEDURE IF EXISTS search_trip;
DELIMITER $
CREATE PROCEDURE search_trip(IN code INT,IN start_date datetime,IN end_date datetime)
BEGIN 
    DECLARE trip_id INT;
    DECLARE dep DATETIME;
    DECLARE ret DATETIME;
    DECLARE maxseats TINYINT;
    DECLARE cost FLOAT(7,2);
    DECLARE br_code INT;
    DECLARE guide_AT CHAR(10);
    DECLARE driver_AT CHAR(10);
    DECLARE finishedFlag INT;
    DECLARE no_of_reservations INT; #arithmos reservations gia to kathe trip
    DECLARE driver_name VARCHAR(20); #o driver tou trip
    DECLARE driver_lname VARCHAR(20);
    DECLARE guide_name VARCHAR(20); #o guide tou trip
    DECLARE guide_lname VARCHAR(20);
    DECLARE empty_seats INT;
    /*cursor ston trips*/
    DECLARE tripCurs CURSOR FOR
    SELECT * FROM trip
    WHERE tr_departure>=start_date 
    AND tr_departure<=end_date
    AND tr_br_code = code;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
    OPEN tripCurs;
    SET finishedFlag=0;
    FETCH tripCurs INTO trip_id, dep, ret, maxseats, cost,
    br_code, guide_AT, driver_AT;
    WHILE(finishedFlag=0) DO
        /*get the number of reservations*/
        SELECT COUNT(*) INTO no_of_reservations 
        FROM reservation 
        INNER JOIN trip ON res_tr_id=tr_id
        WHERE tr_departure >= start_date 
        AND tr_departure <= end_date
        AND tr_br_code = code;
        /*get the driver of the trip*/
        SELECT wrk_name, wrk_lname INTO driver_name, driver_lname
        FROM trip 
        INNER JOIN worker
        ON tr_drv_AT = wrk_AT
        WHERE tr_id = trip_id;
        /*get the guide of the trip*/
        SELECT wrk_name, wrk_lname INTO guide_name, guide_lname
        FROM trip 
        INNER JOIN worker
        ON tr_gui_AT = wrk_AT
        WHERE tr_id = trip_id;
        SET empty_seats = maxseats-no_of_reservations;
        /*final select*/
        SELECT trip_id AS 'Trip Id',cost AS 'Cost',maxseats AS 'Maxseats',
        no_of_reservations AS 'Number of Reservations', empty_seats AS 'Empty Seats',
        driver_lname AS 'Driver Lastname', driver_name AS 'Driver Name', 
        guide_lname AS 'Guide Lastname', guide_name AS 'Guide Name' ,dep AS 'Departure',
        ret AS 'Return';
    FETCH tripCurs INTO trip_id, dep, ret, maxseats, cost,
    br_code, guide_AT, driver_AT;
    END WHILE;
END$
DELIMITER ;

CALL search_trip(4,'2022-06-05 00:00:00','2022-08-15 23:59:59');

SELECT * FROM trip WHERE '2022-06-05 00:00:00'<=tr_departure AND '2022-08-15 23:59:59'>=tr_departure;

/*procedure 3.1.3.3*/
DROP PROCEDURE IF EXISTS delete_worker;
DELIMITER $
CREATE PROCEDURE delete_worker(IN name varchar(20),IN lname varchar(20))
BEGIN
IF exists(SELECT * FROM worker INNER JOIN admin ON wrk_AT=adm_AT WHERE wrk_lname=lname AND wrk_name=name)
THEN
SELECT "This person is an admin in a branch therefore the deletion is restricted!" AS Error;
ELSEIF exists(SELECT * FROM worker WHERE wrk_lname=lname AND wrk_name=name) 
THEN 
DELETE FROM worker WHERE wrk_lname=lname AND wrk_name=name;
ELSE 
SELECT "This person isn't a worker in any branch!" AS Error;
END IF;
END$
DELIMITER ;

--index 
DROP INDEX res_ind ON reservation_offers;
CREATE INDEX res_ind ON reservation_offers(rsv_lastname,deposit_amount);

-- procedure 3.1.3.4 a)
DROP PROCEDURE IF EXISTS res_range;
DELIMITER $
CREATE PROCEDURE res_range(IN r1 INT, IN r2 INT)
BEGIN
    SELECT rsv_name AS 'Firstname', rsv_lastname AS 'Lastname'
    FROM reservation_offers
    WHERE deposit_amount >= r1 AND deposit_amount<=r2;
END$
DELIMITER ;

-- procedure 3.1.3.4 b)
--me cursor
DROP PROCEDURE IF EXISTS res_names;
DELIMITER $
CREATE PROCEDURE res_names(IN lname VARCHAR(20))
BEGIN
    DECLARE flag INT; 
    DECLARE offer_id INT;
    DECLARE no_of_res INT;
    DECLARE finishedFlag INT;
    DECLARE multResCurs CURSOR FOR
    SELECT rsv_offer_id, COUNT(rsv_offer_id)
    FROM reservation_offers
    WHERE rsv_lastname=lname
    GROUP BY rsv_offer_id
    HAVING COUNT(rsv_offer_id)>1
    ORDER BY rsv_offer_id;

    DECLARE singleResCurs CURSOR FOR
    SELECT rsv_offer_id, COUNT(rsv_offer_id)
    FROM reservation_offers
    WHERE rsv_lastname=lname
    GROUP BY rsv_offer_id
    HAVING COUNT(rsv_offer_id)=1
    ORDER BY rsv_offer_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
    OPEN multResCurs;
    SET finishedFlag=0;
    FETCH multResCurs INTO offer_id, no_of_res;
    SET flag = 0;
    WHILE(finishedFlag=0) DO
        IF(flag = 0) THEN
            SELECT 'Reserved offers for last name' AS '', lname AS '';
        END IF;
        SELECT offer_id AS 'Offer Id', no_of_res AS 'Number of reserved offers';
        FETCH multResCurs INTO offer_id,no_of_res; 
        SET flag =  1;
    END WHILE;
    CLOSE multResCurs;
    OPEN singleResCurs;
    SET finishedFlag=0;
    SET flag = 0;
    FETCH singleResCurs INTO offer_id, no_of_res;
    WHILE(finishedFlag=0) DO
        IF(flag = 0) THEN
            SELECT 'Reserved offers with one reservation per offer' AS '';
        END IF;
        SELECT rsv_name, rsv_lastname, rsv_offer_id
        FROM reservation_offers
        WHERE rsv_offer_id = offer_id AND rsv_lastname = lname;
        SET flag = 1;
        FETCH singleResCurs INTO offer_id,no_of_res;
    END WHILE;
END$
DELIMITER ;

CALL res_names('Berger');

INSERT INTO reservation_offers VALUES(null,'Greg','Deli',50,1);
INSERT INTO reservation_offers VALUES(null,'Maria','Deli',50,1);
INSERT INTO reservation_offers VALUES(null,'Greg','Deli',50,2);
INSERT INTO reservation_offers VALUES(null,'Greg','Deli',50,3);


