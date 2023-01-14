/*create tables*/
CREATE TABLE branch (  
    br_code INT(11) NOT NULL AUTO_INCREMENT ,
    br_street VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    br_num INT(4) DEFAULT 0 NOT NULL,
    br_city VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY (br_code)
) ;

CREATE TABLE phones (  
    ph_br_code INT(11) NOT NULL ,
    ph_number CHAR(10)  DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY (ph_br_code , ph_number),
    CONSTRAINT branch_Phone FOREIGN KEY (ph_br_code) REFERENCES branch(br_code)
    ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE worker (  
    wrk_AT CHAR(10) NOT NULL ,
    wrk_name VARCHAR(20) DEFAULT 'unknown' NOT NULL,
    wrk_lname VARCHAR(20) DEFAULT 'unknown' NOT NULL,
    wrk_salary float(7,2)  DEFAULT 0 NOT NULL,
    wrk_br_code Int(11) NOT NULL,
    PRIMARY KEY (wrk_AT),
    CONSTRAINT branch_Worker FOREIGN KEY (wrk_br_code) REFERENCES branch(br_code)
    ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE driver (  
    drv_AT CHAR(10) NOT NULL,
    drv_license ENUM('A','B', 'C' , 'D') NOT NULL,
    drv_route ENUM('LOCAL','ABROAD') NOT NULL,
    drv_experience TINYINT(4)  DEFAULT 0 NOT NULL ,
    PRIMARY KEY (drv_AT),
    CONSTRAINT Worker_Driver FOREIGN KEY ( drv_AT) REFERENCES worker(wrk_AT)
    ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE guide (  
    gui_AT CHAR(10) NOT NULL,
    gui_cv TEXT NOT NULL,
    PRIMARY KEY (gui_AT),
    CONSTRAINT Worker_Guide FOREIGN KEY (gui_AT) REFERENCES worker(wrk_AT)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE languages (  
    lng_gui_AT CHAR(10) NOT NULL,
    lng_language varchar(30),
    PRIMARY KEY (lng_gui_AT , lng_language),
    CONSTRAINT Guide_Languages FOREIGN KEY (lng_gui_AT) REFERENCES guide( gui_AT)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE admin (
    adm_AT CHAR(10) NOT NULL,
    adm_type ENUM('LOGISTICS' ,'ADMINISTRATIVE', 'ACCOUNTING') NOT NULL ,
    adm_diploma VARCHAR(200) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY (adm_AT),
    CONSTRAINT Worker_admin FOREIGN KEY (adm_AT) REFERENCES worker(wrk_AT)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE manages (
    mng_adm_AT CHAR(10) NOT NULL,
    mng_br_code INT(11) NOT NULL,
    PRIMARY KEY (mng_adm_AT , mng_br_code),
    CONSTRAINT Admin_Managers FOREIGN KEY (mng_adm_AT) REFERENCES admin(adm_AT)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Branch_Managers FOREIGN KEY (mng_br_code) REFERENCES branch(br_code)
    ON DELETE CASCADE ON UPDATE CASCADE
);

create table trip (
tr_id int(11) not null auto_increment,
tr_departure datetime not null,
tr_return datetime not null,
tr_maxseats tinyint(4),
tr_cost float(7,2) not null default 0,
tr_br_code int(11) not null,
tr_gui_AT char(10),
tr_drv_AT char(10) not null,

primary key(tr_id),
constraint BRCH
foreign key(tr_br_code)
references branch(br_code)
on delete cascade on update cascade,

constraint DRVR
foreign key(tr_drv_AT)
references driver(drv_AT)
on delete cascade on update cascade,

constraint GUID
foreign key(tr_gui_AT)
references guide(gui_AT)
on delete cascade on update cascade
);

create table event(
ev_tr_id int(11),
ev_start datetime not null,
ev_end datetime not null,
ev_descr text,

primary key(ev_tr_id, ev_start),
constraint TRIP
foreign key(ev_tr_id)
references trip(tr_id)
on delete cascade
on update cascade
);

create table destination(
dst_id int(11) auto_increment ,
dst_name varchar(50) not null,
dst_dscr text,
dst_rtype enum('LOCAL', 'ABROAD') not null,
dst_language varchar(30) not null,
dst_location int(11) ,

primary key(dst_id),
constraint LOC
foreign key(dst_location)
references destination(dst_id)
on delete cascade 
on update cascade 
);

create table travel_to(
to_tr_id int(11),
to_dst_id int(11),
to_arrival datetime,
to_departure datetime, 

primary key(to_tr_id, to_dst_id),
constraint TRP
foreign key(to_tr_id)
references trip(tr_id)
on delete cascade on update cascade,

constraint DEST
foreign key(to_dst_id)
references destination(dst_id)
on delete cascade on update cascade
);

create table reservation(
res_tr_id int(11),
res_seatnum tinyint(4) not null,
res_name varchar(20) not null default 'unknown',
res_lname varchar(20) not null default 'unknown',
res_isadult enum('ADULT','MINOR') not null,

primary key(res_tr_id, res_seatnum),
constraint TR
foreign key(res_tr_id)
references trip(tr_id)
on delete cascade on update cascade 
);

create table it_admin(
it_at CHAR(10) NOT NULL,
it_password CHAR(10) not null default 'password',
it_start_date datetime not null,
it_end_date datetime null,
primary key(it_at),
constraint ITADMWORK foreign key(it_at)
references worker(wrK_AT)
on delete cascade on update cascade 
);

create table it_log(
log_it_at CHAR(10) NOT NULL,
primary key(log_it_at),
constraint LOG foreign key(log_it_at)
references it_admin(it_at)
on delete cascade on update cascade 
);

create table offers(
offer_id int(11) AUTO_INCREMENT,
offer_trip_start_date datetime not null,
offer_trip_end_date datetime not null,
Price_per_Person int(6),
offer_dst_id int(11) ,
primary key(offer_id),
constraint DSTOFFERS foreign key(offer_dst_id)
references destination(dst_id)
on delete cascade on update cascade 
);

create table reservation_offers(
rsv_id int(11) AUTO_INCREMENT,
rsv_name varchar(20) not null default 'unknown',
rsv_lastname varchar(20) not null default 'unknown' ,
deposit_amount int(11),
rsv_offer_id int(11) ,
primary key(rsv_id),
constraint RSVOFFE foreign key(rsv_offer_id)
references offers(offer_id)
on delete cascade on update cascade 
);