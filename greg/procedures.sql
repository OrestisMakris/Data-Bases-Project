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
    DECLARE fistname VARCHAR(20);
    DECLARE lastname VARCHAR(20);
    DECLARE offer_id INT;
    DECLARE no_of_res INT;
    DECLARE finishedFlag INT;
    DECLARE resCurs CURSOR FOR
    SELECT rsv_offer_id, COUNT(rsv_offer_id)
    FROM reservation_offers
    WHERE rsv_lastname=lname
    GROUP BY rsv_offer_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
    OPEN resCurs;
    SET finishedFlag=0;
    FETCH resCurs INTO offer_id, no_of_res;
    WHILE(finishedFlag=0) DO
        IF(no_of_res>1) THEN
            SELECT 'Reserved offers for last name' AS '', lname AS '';
            SELECT offer_id AS 'Offer Id', no_of_res AS 'Number of reserved offers';
        END IF;
        FETCH resCurs INTO offer_id,no_of_res; 
    END WHILE;
    CLOSE resCurs;
    OPEN resCurs;
    SET finishedFlag = 0;
    FETCH resCurs INTO offer_id, no_of_res;
    WHILE(finishedFlag=0) DO
        IF(no_of_res=1) THEN
            SELECT 'Reserved offers with one reservation per offer' AS '';
            SELECT t1.rsv_name, t1.rsv_lastname, t2.rsv_offer_id
            FROM 
            (SELECT rsv_name, rsv_lastname, rsv_offer_id
            FROM reservation_offers
            WHERE rsv_lastname=lname) AS t1
            INNER JOIN 
            (SELECT rsv_offer_id, COUNT(rsv_offer_id)
            FROM reservation_offers
            WHERE rsv_lastname=lname
            GROUP BY rsv_offer_id
            HAVING COUNT(rsv_offer_id)=1) AS t2
            ON t1.rsv_offer_id = t2.rsv_offer_id;
        
        END IF;
        FETCH resCurs INTO offer_id,no_of_res;
    END WHILE;
END$
DELIMITER ;
CALL res_names('Deli');

--without count
SELECT rsv_name, rsv_lastname, rsv_offer_id
FROM reservation_offers
WHERE rsv_lastname='Deli'
ORDER BY rsv_offer_id;

--with count
SELECT 'Reserved offers for last name' AS '', lname AS '';
    SELECT rsv_offer_id AS 'Offer Id',COUNT(rsv_offer_id) AS 'Number of reserved offers', rsv_lastname
    FROM reservation_offers
    WHERE rsv_lastname='Deli'
    GROUP BY rsv_offer_id
    HAVING COUNT(rsv_offer_id)=1;