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