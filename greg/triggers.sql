DROP TRIGGER IF EXISTS check_reservations;
DELIMITER $
CREATE TRIGGER check_reservations BEFORE UPDATE ON trip
FOR EACH ROW
BEGIN
IF exists(SELECT * FROM reservation WHERE res_tr_id=OLD.tr_id)
THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='This trip already has reservations therefore updates are restricted!';
END IF;
END$
DELIMITER ;