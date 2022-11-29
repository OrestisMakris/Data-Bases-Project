
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
    CONSTRAINT branch_phone FOREIGN KEY (ph_br_code) REFERENCES branch(br_code)
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


