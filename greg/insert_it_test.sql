INSERT INTO it_admin VALUES
('AK12000003' , 'John' ,'2010-02-06 14:00:00','2015-02-05 14:00:00'),
('AK12000005' , '1234' ,'2007-01-31 14:00:00','2020-03-01 14:00:00');

INSERT INTO it_admin (it_at,it_start_date)VALUES
('AK12000001'  ,'2015-02-06 14:00:00'),
('AK12000002'  ,'2012-01-26 14:00:00'),
('AK12000004'  , '2008-02-06 14:00:00'),
('AK12000010' , '2017-11-11 10:00:00');

INSERT INTO it_admin (it_at,it_password,it_start_date)VALUES
('AK12000006' , '1444' ,'2019-03-06 12:00:00'),
('AK12000007' , 'ff' ,'2012-05-06 10:00:00'),
('AK12000008' , 'AlexAlex' ,'2010-09-06 10:00:00'),
('AK12000009' , 'Nik', '2016-02-04 10:00:00');

--test
2020-01-01 09:00:00

drop user deli@localhost;
SELECT * FROM mysql.user;

SELECT wrk_name,wrk_lname,wrk_br_code FROM admin INNER JOIN worker ON adm_AT=wrk_AT WHERE adm_type='ADMINISTRATIVE';

SELECT wrk_AT,wrk_name,wrk_lname,wrk_salary,wrk_br_code,
                                            it_password,it_start_date,it_end_date,Insert_priv FROM worker 
                                            INNER JOIN it_admin ON it_at = wrk_AT  
                                            INNER JOIN mysql.db ON wrk_lname = User;
