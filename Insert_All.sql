-- Active: 1670782097134@@127.0.0.1@3306@travel_agency

INSERT INTO branch VALUES
(null , 'Kifisias ', 355 , 'Athens'),
(null , 'Amarisias Artemidos' , 5 , 'Athens'),
(null , 'Mezonos', 44 , 'Patra'),
(null , 'Aristomenous' , 5 , 'Kalamata'),
(null , 'Tsimiskh' , 55 , 'TsimiskhThesalonikh');

INSERT INTO phones VALUES
(1 , '2101111111'),
(1 ,  '2101222222'),
(2 , '2102222222'),
(2 , '2102333333'),
(3 , '2103333333'),
(4 ,  '2104444444'),
(5 ,  '2105555555');

INSERT INTO worker VALUES
('AK10311111' , 'Giannhs' , 'Vasiliou' ,'1547.55' ,1),
('AK10322222' , 'Artemis' ,'Papadopoulou' ,'1800.34',1),
('AK10333333' ,  'Georgia' ,'Makri' ,'2000',1),
('AK10344444' ,  'Greg' ,'Stephanopoulos' ,'1600',2),
('AK10355555' ,  'Iason', 'Raikos','1800.99',2),
('AK10366666' ,  'Maria', 'Papadopoulou' ,'2000',2),
('AK10377777' ,  'Orestis', 'Makris' , '1600.69',3),
('AK10388888' ,  'Damianos' , 'Papadopoulos' , '1500',3),
('AK10399999' , 'Iris' , 'Oikonomou' , '1400.55',3),
('AK10310000' ,  'John' ,'Politis','1400.55',4 ),
('AK10310111' ,  'Alkis' , 'Eleftheriadis' ,'1200.35',4 ),
('AK10310222' ,  'Andreas' , 'Georgiou' ,'1000.21',4),
('AK10310333' ,  'Giannhs', 'Stathopoulos' , '1900.56',5),
('AK10310444' ,  'Sofia' , 'Politi','1400.86',5),
('AK10310555' , 'Nikos' , 'Vasiliou','1600.96',5),
('AM10410000' , 'Antonis' , 'Kokinos','1000',1),
('AM10410111' , 'Antonis' , 'Eleftheriadis','1100',1),
('AM10410222' , 'Nora' , 'Raikou','750',2),
('AM10410333' , 'John' , 'Oikonomou','1150',2),
('AM10410444' , 'Dimitrios' , 'Gongas','1500',3),
('AM10410555' , 'Fotios' , 'Patrios','1400',4),
('AM10410666' , 'Maria' , 'Papadopoulou','1000',5),
('AM10410777' , 'Andreas' , 'Makris','750',5),
('AK10520010' , 'Damianos' , 'Diasakos','1200',1),
('AK10520020' , 'Greg' , 'Delimpaltadakis','1000',2),
('AK10520030' , 'Orestis' , 'Delimpaltadakis','1000',2),
('AK10520040' , 'Iason' , 'Makris','1200',3),
('AK1052050' , 'Orestis' , 'Diasakos','1000',4),
('AK1052060' , 'Damianos' , 'Delimpaltadakis','1200',5);

INSERT INTO admin VALUES
('AK10311111' , 'LOGISTICS' , 'Dimploma: Logistics Athens School of Business'),
('AK10322222' , 'ACCOUNTING' ,'Dimploma: Accounting Athens School of Business'),
('AK10333333' ,  'ADMINISTRATIVE' ,'Dimploma: Economics and Business Administration Athens School of Business'),
('AK10344444' ,  'LOGISTICS' ,'Dimploma: Economics Ionnina School of Busine'),
('AK10355555' ,  'ACCOUNTING', 'Dimploma: Economics Thesalonikh School of Business'),
('AK10366666' ,  'ADMINISTRATIVE', 'Dimploma: Tour Guide EKPA'),
('AK10377777' ,  'ADMINISTRATIVE', 'Dimploma: Tour Guide Patra School of Business'),
('AK10388888' ,  'ACCOUNTING' , 'Dimploma: Mathematics Thesalonikh APTH'),
('AK10399999' , 'LOGISTICS' , 'Dimploma: Volos Logistics School of Busines'),
('AK10310000' ,  'ADMINISTRATIVE' ,'Dimploma: Business Administration Patra School of Business'),
('AK10310111' ,  'ACCOUNTING' , 'Dimploma: Lamia School of Busines'),
('AK10310222' ,  'LOGISTICS' , 'Dimploma: Mathematics Athens School of Business'),
('AK10310333' ,  'ADMINISTRATIVE', 'Dimploma: Economics and Business Administration Lamia School of Business'),
('AK10310444' ,  'LOGISTICS' , 'Dimploma: Physics Thesalonikh'),
('AK10310555' , 'ACCOUNTING' , 'Dimploma: 53 Lykio Thesalonikhs');

INSERT INTO manages VALUES
('AK10311111' , 1),
('AK10322222' , 1),
('AK10333333' , 1),
('AK10344444' , 2),
('AK10355555' , 2),
('AK10366666' , 2),
('AK10377777' , 3),
('AK10388888' , 3),
('AK10399999' , 3),
('AK10310000' , 4),
('AK10310111' , 4),
('AK10310222' , 4),
('AK10310333' , 5),
('AK10310444' , 5),
('AK10310555' , 5);

insert into driver values 
('AM10410000','D','LOCAL',9),
('AM10410111','D','ABROAD',10),
('AM10410222','D','LOCAL',7),
('AM10410333','D','ABROAD',11),
('AM10410444','D','LOCAL',20),
('AM10410555','D','LOCAL',15),
('AM10410666','D','LOCAL',8),
('AM10410777','B','ABROAD',3);

insert into guide values 
('AK10311111', 'Employment History:\n\t\t1997 - 2000 Accountant at Logistiko Grafeio "H Lysi"
\n\t\t2000 - 2010 Travel Guide at "Joy Tours"'),
('AN10520010', 'Employment History:\n\t\t1999 - 2005 Travel Guide at "Pimenidis Travel"'),
('AN10520020', 'Employment History:\n\t\t1995 - 2002 Travel Guide at "TEMPI HOLIDAY"
\n\t\t2002 - 2011 Travel Guide at "KAVVADIAS TOURS"
\n\t\t2011 - 2017 Travel Guide at "ART TOURS"'),
('AN10520030','Employment History:\n\t\t2005 - 2016 Travel Guide at "DIOTOURS N.G & RED ELEPHANT"'),
('AN10520040','Employment History:\n\t\t2001 - 2019 Travel Guide at "Rania TOURS"'),
('AN10520050','Employment History:\n\t\t1990 - 2002 Travel Guide at "Penguin Travel Tours"'),
('AK10310444','Employment History:\n\t\t1999 - 2006 Accountant at "PANIDIS PAYLOS LOGISTIKO GRAFEIO"
\n\t\t2010 - 2018 Travel Guide at "Herodotus TOURS"'),
('AN10520060','Employment History:\n\t\t1989 - 1999 Travel Guide at "Mazi Travel & Events"
\n\t\t2000 - 2010 Travel Guide at "Prima Holidays"');

insert into languages values 
('AK10311111','Greek,English,French'),
('AN10520010','Greek,English,French,Italian'),
('AN10520020','Greek,English,German'),
('AN10520030','Greek,German,French,Italian'),
('AN10520040','Greek,English,Italian'),
('AN10520050','Greek,English,German,Italian'),
('AK10310444','Greek,English'),
('AN10520060','Greek,English,German,Italian');