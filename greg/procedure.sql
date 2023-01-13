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
    HAVING COUNT(rsv_offer_id)>1;
    DECLARE singleResCurs CURSOR FOR
    SELECT rsv_offer_id, COUNT(rsv_offer_id)
    FROM reservation_offers
    WHERE rsv_lastname=lname
    GROUP BY rsv_offer_id
    HAVING COUNT(rsv_offer_id)=1;
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
CALL res_names('deli');

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
DECLARE no_of_reservations INT; 
/*vriskw ton arithmo twn reservations gia to branch kai tis hmeromhnies pou elegxoume*/
SELECT COUNT(*) INTO no_of_reservations FROM reservation 
INNER JOIN trip ON res_tr_id=tr_id
WHERE tr_departure >= start_date 
AND tr_departure <= end_date
AND tr_br_code = code;

SELECT trip.tr_cost,trip.tr_maxseats,
(SELECT reservations_number) reservations,
(SELECT trip.tr_maxseats-reservations_number FROM trip) 
empty_seats,drv.lname AS driver_lname,drv.name AS driver_name,gui.lname 
AS guide_lname,gui.name AS guide_name,trip.tr_departure,trip.tr_return 
FROM trip 
INNER JOIN worker AS drv ON tr_br_code=drv.wrk_br_code 
INNER JOIN worker AS gui ON tr_br_code=gui.wrk_br_code 
WHERE code=tr_br_code AND start_date <= tr_departure 
AND end_date >= tr_departure;

END$
DELIMITER ;

CALL search_trip(1,'2022-06-05 00:00:00','2022-08-15 23:59:59');

SELECT * FROM trip WHERE '2022-06-05 00:00:00'<=tr_departure AND '2022-08-15 23:59:59'>=tr_departure;

--testing

--plirofories apo pinaka trip edw kanw fetch cursor
SELECT * FROM trip
WHERE tr_departure>='2022-06-05 00:00:00' 
AND tr_departure<='2022-08-15 23:59:59'
AND tr_br_code = 4;

--plirof apo pinaka reservations
SELECT tr_id, res_seatnum FROM reservation 
INNER JOIN trip ON res_tr_id=tr_id
WHERE tr_departure>='2022-06-05 00:00:00' 
AND tr_departure<='2022-08-15 23:59:59'
AND tr_br_code = 4;

--number of reservations gia to kathe trip pou elegxoume 
DECLARE no_of_reservations INT; 
/*vriskw ton arithmo twn reservations gia to branch kai tis hmeromhnies pou elegxoume*/
SELECT COUNT(*) INTO no_of_reservations FROM reservation 
INNER JOIN trip ON res_tr_id=tr_id
--trip_id metavliti cursor
WHERE tr_id = 19;

--test tou parapanw
SELECT COUNT(*) FROM reservation 
INNER JOIN trip ON res_tr_id=tr_id
WHERE tr_id = 19;

--select driver gia to trip pou elegxoume 
SELECT wrk_name, wrk_lname
FROM trip 
INNER JOIN worker
ON tr_drv_AT = wrk_AT
WHERE tr_id = trip_id

--select guide gia to trip pou elegxoume
SELECT wrk_name, wrk_lname
FROM trip 
INNER JOIN worker
ON tr_gui_AT = wrk_AT
WHERE tr_id = trip_id

--setup cursor
