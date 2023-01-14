/*Procedure pou dhmioyrgei enan neo user gia tin vasi travel_agency. Prepei na tin kalesoume afou kanoume insert enan it_admin*/
DROP PROCEDURE IF EXISTS create_user;
DELIMITER $
CREATE PROCEDURE create_user(IN it_username VARCHAR(20),IN it_password CHAR(10))
BEGIN
    #prepei na xrisimopoiisw tin CONCAT() giati den mas epitrepei na ektelesoume tin CREATE USER me metavlites
    SET @cr_user = CONCAT
    ('
    CREATE USER "',it_username,'"@"localhost" IDENTIFIED BY "',it_password,'" '
    );
    PREPARE cr FROM @cr_user;
    EXECUTE cr;
    DEALLOCATE PREPARE cr;
    #omoiws gia to GRANT PRIVILEGES
    SET @gr_user = CONCAT
    ('
    GRANT ALL ON travel_agency.* TO "',it_username,'"@"localhost" '
    );
    PREPARE gr FROM @gr_user;
    EXECUTE gr;
    DEALLOCATE PREPARE gr;
END$
DELIMITER ;

--test
INSERT INTO worker 
VALUES('AT29292929', 'Andrew', 'Tate', 100, 1);
INSERT INTO it_admin 
VALUES('AT29292929', 'password', '2022-03-08 12:30:00', null);
CALL create_user('Tate', 'password');

/*triggers gia ton log_trip*/
DROP TRIGGER IF EXISTS log_trip_insert;
DELIMITER $
CREATE TRIGGER log_trip_insert AFTER INSERT ON trip
FOR EACH ROW
BEGIN
    INSERT INTO log_trip VALUES
    ('INSERT',CURRENT_USER(),NOW(),NEW.tr_id,NEW.tr_departure,NEW.tr_return,
    NEW.tr_maxseats,NEW.tr_cost,NEW.tr_br_code,NEW.tr_gui_AT,NEW.tr_drv_AT);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_trip_update;
DELIMITER $
CREATE TRIGGER log_trip_update AFTER UPDATE ON trip
FOR EACH ROW
BEGIN
    INSERT INTO log_trip VALUES
    ('UPDATE',CURRENT_USER(),NOW(),NEW.tr_id,NEW.tr_departure,NEW.tr_return,
    NEW.tr_maxseats,NEW.tr_cost,NEW.tr_br_code,NEW.tr_gui_AT,NEW.tr_drv_AT);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_trip_delete;
DELIMITER $
CREATE TRIGGER log_trip_delete AFTER DELETE ON trip
FOR EACH ROW
BEGIN
    INSERT INTO log_trip VALUES
    ('DELETE',CURRENT_USER(),NOW(),OLD.tr_id,OLD.tr_departure,OLD.tr_return,
    OLD.tr_maxseats,OLD.tr_cost,OLD.tr_br_code,OLD.tr_gui_AT,OLD.tr_drv_AT);
END$
DELIMITER ;
--test
INSERT INTO trip VALUES
(null, '2022-03-05 15:30:01', 
'2022-03-08 12:30:01', 30, 300, 1, 'AK10311111', 'AM10410000');

UPDATE trip SET tr_departure = '2069-03-05 15:30:06'
WHERE tr_id = 33;

DELETE FROM trip where tr_id = 33;

/*triggers gia ton log_reservation*/
DROP TRIGGER IF EXISTS log_reservation_insert;
DELIMITER $
CREATE TRIGGER log_reservation_insert AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
    INSERT INTO log_reservation VALUES
    ('INSERT',CURRENT_USER(),NOW(),NEW.res_tr_id,NEW.res_seatnum,
    NEW.res_name,NEW.res_lname,NEW.res_isadult);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_reservation_update;
DELIMITER $
CREATE TRIGGER log_reservation_update AFTER UPDATE ON reservation
FOR EACH ROW
BEGIN
    INSERT INTO log_reservation VALUES
    ('UPDATE',CURRENT_USER(),NOW(),NEW.res_tr_id,NEW.res_seatnum,
    NEW.res_name,NEW.res_lname,NEW.res_isadult);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_reservation_delete;
DELIMITER $
CREATE TRIGGER log_reservation_delete AFTER DELETE ON reservation
FOR EACH ROW
BEGIN
    INSERT INTO log_reservation VALUES
    ('DELETE',CURRENT_USER(),NOW(),OLD.res_tr_id,OLD.res_seatnum,
    OLD.res_name,OLD.res_lname,OLD.res_isadult);
END$
DELIMITER ;

/*triggers gia ton log_event*/
DROP TRIGGER IF EXISTS log_event_insert;
DELIMITER $
CREATE TRIGGER log_event_insert AFTER INSERT ON event
FOR EACH ROW
BEGIN
    INSERT INTO log_event VALUES
    ('INSERT',CURRENT_USER(),NOW(),NEW.ev_tr_id,NEW.ev_start, 
    NEW.ev_end,NEW.ev_descr);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_event_update;
DELIMITER $
CREATE TRIGGER log_event_update AFTER UPDATE ON event
FOR EACH ROW
BEGIN
    INSERT INTO log_event VALUES
    ('UPDATE',CURRENT_USER(),NOW(),NEW.ev_tr_id,NEW.ev_start, 
    NEW.ev_end,NEW.ev_descr);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_event_delete;
DELIMITER $
CREATE TRIGGER log_event_delete AFTER DELETE ON event
FOR EACH ROW
BEGIN
    INSERT INTO log_event VALUES
    ('DELETE',CURRENT_USER(),NOW(),OLD.ev_tr_id,OLD.ev_start, 
    OLD.ev_end,OLD.ev_descr);
END$
DELIMITER ;

/*triggers gia ton log_travel_to*/
DROP TRIGGER IF EXISTS log_travel_to_insert;
DELIMITER $
CREATE TRIGGER log_travel_to_insert AFTER INSERT ON travel_to
FOR EACH ROW
BEGIN
    INSERT INTO log_travel_to VALUES
    ('INSERT',CURRENT_USER(),NOW(),NEW.to_tr_id,NEW.to_dst_id,
    NEW.to_arrival,NEW.to_departure);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_travel_to_update;
DELIMITER $
CREATE TRIGGER log_travel_to_update AFTER UPDATE ON travel_to
FOR EACH ROW
BEGIN
    INSERT INTO log_travel_to VALUES
    ('UPDATE',CURRENT_USER(),NOW(),NEW.to_tr_id,NEW.to_dst_id,
    NEW.to_arrival,NEW.to_departure);
END$
DELIMITER ;

DROP TRIGGER IF EXISTS log_travel_to_delete;
DELIMITER $
CREATE TRIGGER log_travel_to_delete AFTER DELETE ON travel_to
FOR EACH ROW
BEGIN
    INSERT INTO log_travel_to VALUES
    ('DELETE',CURRENT_USER(),NOW(),OLD.to_tr_id,OLD.to_dst_id,
    OLD.to_arrival,OLD.to_departure);
END$
DELIMITER ;

/*triggers gia ton log_travel_to*/
DROP TRIGGER IF EXISTS log_trip_insert;
DELIMITER $
CREATE TRIGGER log_trip_insert AFTER INSERT ON trip
FOR EACH ROW
BEGIN
    INSERT INTO log_trip VALUES
    ('INSERT',CURRENT_USER(),NOW(),NEW.tr_id,NEW.tr_departure,NEW.tr_return,
    NEW.tr_maxseats,NEW.tr_cost,NEW.tr_br_code,NEW.tr_gui_AT,NEW.tr_drv_AT);
END$
DELIMITER ;