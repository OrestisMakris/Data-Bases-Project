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
SELECT * FROM trip WHERE '2022-01-05 00:00:00'<=tr_departure AND '2022-08-15 23:59:59'>=tr_departure AND tr_br_code=3;

drop user deli@localhost;
SELECT * FROM mysql.user;

SELECT wrk_name,wrk_lname,wrk_br_code FROM admin INNER JOIN worker ON adm_AT=wrk_AT WHERE adm_type='ADMINISTRATIVE';

SELECT wrk_AT,wrk_name,wrk_lname,wrk_salary,wrk_br_code,
                                            it_password,it_start_date,it_end_date,Insert_priv FROM worker 
                                            INNER JOIN it_admin ON it_at = wrk_AT  
                                            INNER JOIN mysql.db ON wrk_lname = User;

DROP DATABASE IF EXISTS travel_agency;
CREATE DATABASE travel_agency;
USE travel_agency;


select count(*),wrk_br_code from worker where wrk_br_code = 5;
select adm_AT, adm_type, wrk_br_code from admin inner join worker on adm_AT=wrk_AT where wrk_br_code = 5; -- admins
select it_at, it_password,wrk_br_code from it_admin inner join worker on it_at=wrk_AT where wrk_br_code = 5; --it_admin
select drv_AT, drv_license,drv_route, drv_experience,wrk_br_code from driver inner join worker on drv_AT=wrk_AT where wrk_br_code = 5; --drivers
select gui_AT,wrk_br_code,lng_language from guide inner join worker on gui_AT=wrk_AT inner join languages on lng_gui_AT = gui_AT where wrk_br_code = 5; --guide

select count(*) distinct tr_br_code from trip;

--ola ta trips mazi me ta destinations
select tr_id,tr_drv_AT,tr_gui_AT,tr_br_code,dst_id,dst_name#ev_descr
from trip
inner join travel_to on to_tr_id = tr_id
inner join destination on to_dst_id = dst_id 
#inner join event on ev_tr_id = tr_id
inner join branch on tr_br_code = br_code
#where tr_id = 8
where tr_br_code = 1
order by tr_id; 

inner join event on ev_tr_id = tr_id

dst_id,dst_name,dst_rtype, dst_language, 
inner join destination on to_dst_id = dst_id 

--drivers sta trips 
select tr_id,tr_maxseats,tr_drv_AT,drv_license,dst_name,dst_rtype
from trip
inner join travel_to on to_tr_id = tr_id
inner join destination on to_dst_id = dst_id 
inner join branch on tr_br_code = br_code
inner join driver on drv_AT= tr_drv_AT
where tr_id>=20
order by tr_id; 

--gia ta events 
select tr_id,tr_departure,to_arrival,ev_start,ev_end,to_departure,tr_return,dst_name
from trip
inner join travel_to on to_tr_id = tr_id
inner join destination on to_dst_id = dst_id 
inner join event on ev_tr_id = tr_id
inner join branch on tr_br_code = br_code
where tr_id = 26
order by tr_id; 

select tr_id,tr_br_code,dst_id,dst_name,ev_descr
from trip
inner join travel_to on to_tr_id = tr_id
inner join destination on to_dst_id = dst_id 
inner join event on ev_tr_id = tr_id
inner join branch on tr_br_code = br_code
where tr_id = 15

order by tr_id; 

select tr_id,dst_name, ev_descr
from trip
inner join travel_to on to_tr_id = tr_id
inner join destination on to_dst_id = dst_id 
inner join event on ev_tr_id = tr_id
inner join branch on tr_br_code = br_code
where tr_id = 26
order by tr_id; 

2022-03-17 18:30:00
2022-10-08 16:30:00

SELECT tr_br_code,distinct(COUNT(res_tr_id)) as 'Number of Reservations'  FROM reservation 
INNER JOIN trip ON res_tr_id=tr_id;

SELECT br_code,COUNT(*) AS total_of_reservations FROM reservation INNER JOIN trip ON res_tr_id=tr_id INNER JOIN branch ON tr_br_code=br_code GROUP BY br_code;

 insert_driver('AT87653490', 'Mike', 'Ravazoulas', 1000, 'D', 'LOCAL', 5);
 SELECT wrk_AT , wrk_name,wrk_lname,wrk_salary,wrk_br_code,drv_license, drv_route ,drv_experience 
 FROM worker 
 INNER JOIN driver ON drv_AT = wrk_AT;

 delete_worker(IN name varchar(20),IN lname varchar(20))