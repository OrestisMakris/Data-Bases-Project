DROP TABLE IF EXISTS log_trip;
CREATE TABLE log_trip (  
log_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
log_it_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
log_timestamp DATETIME NOT NULL,
log_tr_id int(11) not null,
log_tr_departure datetime not null,
log_tr_return datetime not null,
log_tr_maxseats tinyint(4),
log_tr_cost float(7,2) not null,
log_tr_br_code int(11) not null,
log_tr_gui_AT char(10),
log_tr_drv_AT char(10) not null
);

DROP TABLE IF EXISTS log_reservation;
CREATE TABLE log_reservation(
log_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
log_it_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
log_timestamp DATETIME NOT NULL,
log_res_tr_id INT(11),
log_res_seatnum TINYINT(4) NOT NULL,
log_res_name VARCHAR(20) NOT NULL,
log_res_lname VARCHAR(20) NOT NULL,
log_res_isadult enum('ADULT','MINOR') NOT NULL
);

DROP TABLE IF EXISTS log_event;
CREATE TABLE log_event(
log_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
log_it_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
log_timestamp DATETIME NOT NULL,
log_ev_tr_id INT(11),
log_ev_start DATETIME NOT NULL,
log_ev_end DATETIME NOT NULL,
log_ev_descr TEXT
);

DROP TABLE IF EXISTS log_travel_to;
CREATE TABLE log_travel_to(
log_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
log_it_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
log_timestamp DATETIME NOT NULL,
log_to_tr_id INT(11),
log_to_dst_id INT(11),
log_to_arrival DATETIME,
log_to_departure DATETIME
);

DROP TABLE IF EXISTS log_destination;
CREATE TABLE log_destination(
log_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
log_it_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
log_timestamp DATETIME NOT NULL,
log_dst_id INT(11),
log_dst_name VARCHAR(50) NOT NULL,
log_dst_dscr TEXT,
log_dst_rtype enum('LOCAL', 'ABROAD') NOT NULL,
log_dst_language varchar(30) NOT NULL,
log_dst_location INT(11)
);