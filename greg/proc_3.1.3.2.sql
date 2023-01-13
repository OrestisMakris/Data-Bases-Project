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