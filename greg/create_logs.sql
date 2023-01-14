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
log_tr_drv_AT char(10) not null,

CONSTRAINT TRIPID FOREIGN KEY (log_tr_id) REFERENCES trip(tr_id)
ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

CREATE TABLE log_reservation(
log_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
log_it_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
log_timestamp DATETIME NOT NULL,
log_res_tr_id int(11),
log_res_seatnum tinyint(4) not null,
log_res_name varchar(20) not null,
log_res_lname varchar(20) not null,
log_res_isadult enum('ADULT','MINOR') not null,

CONSTRAINT RESTRTIP
FOREIGN KEY(log_res_tr_id)
REFERENCES reservation(res_tr_id)
ON DELETE NO ACTION ON UPDATE NO ACTION 
);