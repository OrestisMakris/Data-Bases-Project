-- Active: 1670782097134@@127.0.0.1@3306
DELIMITER $ 
DROP PROCEDURE IF EXISTS check_reservations_trip$
CREATE PROCEDURE check_reservations_trip(IN trip_id INT , OUT flag INT) 
BEGIN
DECLARE max_seats INT;
DECLARE same_res_tr_id INT;

SET same_res_tr_id=0;
SET max_seats=0;

SET flag=0;

SELECT COUNT(*) INTO same_res_tr_id FROM reservation INNER JOIN trip ON reservation.res_tr_id = trip.tr_id WHERE trip_id = res_tr_id;

SELECT tr_maxseats INTO max_seats FROM trip WHERE trip_id = tr_id;

IF (max_seats > same_res_tr_id)
THEN
SET flag=1;
END IF;

END$
DELIMITER ;

CALL check_reservations_trip(31,@flag);

SELECT @flag;
