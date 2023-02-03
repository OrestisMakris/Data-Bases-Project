-- procedure 3.1.3.1
DROP PROCEDURE IF EXISTS insert_driver;
DELIMITER $
CREATE PROCEDURE insert_driver(IN AT char(10),IN name varchar(20),IN lname varchar(20),IN salary float(7,2),IN license ENUM('A','B','C','D'),IN route ENUM('LOCAL','ABROAD'),IN experience tinyint(4))
BEGIN
DECLARE code INT;

SELECT br_code INTO code FROM (SELECT branch.br_code,IFNULL(count(wrk_AT),0) AS 'Number of Drivers' FROM driver INNER JOIN worker ON drv_AT=wrk_AT RIGHT JOIN branch ON br_code=wrk_br_code GROUP BY br_code ORDER BY IFNULL(count(wrk_AT),0) ASC LIMIT 1) AS minimum_drivers;

INSERT INTO worker VALUES (AT,name,lname,salary,code);

INSERT INTO driver VALUES (AT,license,route,experience);
END$
DELIMITER ;

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
DECLARE no_of_reservations INT; 
DECLARE driver_name VARCHAR(20); 
DECLARE driver_lname VARCHAR(20);
DECLARE guide_name VARCHAR(20); 
DECLARE guide_lname VARCHAR(20);
DECLARE empty_seats INT;

DECLARE tripCurs CURSOR FOR SELECT * FROM trip WHERE tr_departure>=start_date AND tr_departure<=end_date AND tr_br_code = code;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;

OPEN tripCurs;

SET finishedFlag=0;

FETCH tripCurs INTO trip_id,dep,ret,maxseats,cost,br_code,guide_AT,driver_AT;
WHILE(finishedFlag=0) 
DO
SELECT COUNT(*) INTO no_of_reservations FROM reservation INNER JOIN trip ON res_tr_id=trip_id WHERE tr_departure>=start_date AND tr_departure<=end_date AND tr_br_code=code AND res_tr_id=tr_id;

SELECT wrk_name,wrk_lname INTO driver_name,driver_lname FROM trip INNER JOIN worker ON tr_drv_AT=wrk_AT WHERE tr_id=trip_id;

SELECT wrk_name,wrk_lname INTO guide_name,guide_lname FROM trip INNER JOIN worker ON tr_gui_AT=wrk_AT WHERE tr_id=trip_id;

SET empty_seats=maxseats-no_of_reservations;

SELECT trip_id AS 'Trip Id',cost AS 'Cost',maxseats AS 'Maxseats',no_of_reservations AS 'Number of Reservations',empty_seats AS 'Empty Seats',driver_lname AS 'Driver Lastname',driver_name AS 'Driver Name',guide_lname AS 'Guide Lastname',guide_name AS 'Guide Name',dep AS 'Departure',ret AS 'Return';

FETCH tripCurs INTO trip_id,dep,ret,maxseats,cost,br_code,guide_AT,driver_AT;
END WHILE;

CLOSE tripCurs;
END$
DELIMITER ;

/*procedure 3.1.3.3*/
DROP PROCEDURE IF EXISTS delete_worker;
DELIMITER $
CREATE PROCEDURE delete_worker(IN name varchar(20),IN lname varchar(20))
BEGIN
IF exists(SELECT * FROM worker INNER JOIN admin ON wrk_AT=adm_AT WHERE wrk_lname=lname AND wrk_name=name AND adm_type="ADMINISTRATIVE")
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

/*index */
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

/*Procedure που βλέπει για κάθε υποκατάστημα τα στοιχεία του, το ονοματεπώνυμο του διευθυντή του, το σύνολο κρατήσεων και το σύνολο εσόδων (κράτηση επί κόστος ταξιδιού)*/
DROP PROCEDURE IF EXISTS branch_info;
DELIMITER $
CREATE PROCEDURE branch_info()
BEGIN 
DECLARE branch_code INT(11); 
DECLARE branch_street VARCHAR(30); 
DECLARE branch_num INT(4);
DECLARE branch_city VARCHAR(30);
DECLARE finishedFlag INT;
DECLARE admin_name VARCHAR(20); 
DECLARE admin_lname VARCHAR(20);
DECLARE total_of_reservations INT;
DECLARE income FLOAT;

DECLARE branchCurs CURSOR FOR SELECT * FROM branch;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;

OPEN branchCurs;

SET finishedFlag=0;

FETCH branchCurs INTO branch_code,branch_street,branch_num,branch_city;
WHILE(finishedFlag=0) 
DO
SELECT COUNT(*) INTO total_of_reservations FROM reservation INNER JOIN trip ON res_tr_id=tr_id WHERE tr_br_code=branch_code;

SELECT wrk_name,wrk_lname INTO admin_name,admin_lname FROM admin INNER JOIN worker ON adm_AT=wrk_AT WHERE wrk_br_code=branch_code AND adm_type='ADMINISTRATIVE';

SET income=(SELECT SUM(tr_cost*res_count) FROM trip JOIN (SELECT res_tr_id, COUNT(*) as res_count FROM reservation GROUP BY res_tr_id) as res_counts ON trip.tr_id = res_counts.res_tr_id WHERE tr_br_code = branch_code);

SELECT branch_code AS 'Branch code',branch_street AS 'Street',branch_num AS 'Number',branch_city AS 'City',admin_name AS 'Admin name',admin_lname AS 'Admin last name',total_of_reservations AS 'Total of Reservations',income AS 'Income';

FETCH branchCurs INTO branch_code,branch_street,branch_num,branch_city;
END WHILE;

CLOSE branchCurs;
END$
DELIMITER ;