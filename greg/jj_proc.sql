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
SELECT COUNT(*) INTO total_of_reservations FROM reservation 
INNER JOIN trip ON res_tr_id=tr_id 
WHERE tr_br_code=branch_code;

SELECT wrk_name,wrk_lname INTO admin_name,admin_lname FROM admin 
INNER JOIN worker ON adm_AT=wrk_AT 
WHERE wrk_br_code=branch_code AND adm_type='ADMINISTRATIVE';

SET income=(SELECT SUM(tr_cost*res_count) FROM trip JOIN (SELECT res_tr_id, COUNT(*) as res_count FROM reservation GROUP BY res_tr_id) as res_counts ON trip.tr_id = res_counts.res_tr_id WHERE tr_br_code = branch_code);

SELECT branch_code AS 'Branch code',branch_street AS 'Street',branch_num AS 'Number',branch_city AS 'City',admin_name AS 'Admin name',admin_lname AS 'Admin last name',total_of_reservations AS 'Total of Reservations',income AS 'Income';

FETCH branchCurs INTO branch_code,branch_street,branch_num,branch_city;
END WHILE;

CLOSE branchCurs;
END$
DELIMITER ;

--test
SELECT wrk_name,wrk_lname,wrk_br_code FROM admin 
INNER JOIN worker ON adm_AT=wrk_AT 
WHERE adm_type='ADMINISTRATIVE'
ORDER BY wrk_br_code;