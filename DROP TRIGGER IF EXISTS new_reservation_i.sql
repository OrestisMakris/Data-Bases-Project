DROP TRIGGER IF EXISTS new_reservation_insert_check;
DELIMITER $
CREATE TRIGGER new_reservation_insert_check
BEFORE INSERT 
ON reservation
FOR EACH ROW
BEGIN
DECLARE con INT;

CALL check_reservations_trip(NEW.res_tr_id,con);

IF (con=0) THEN
 SIGNAL SQLSTATE VALUE '45000'
 SET MESSAGE_TEXT = ' Invalid trip reservation , there are no available seats for this Trip.';
END IF;
END$

DELIMITER ;

