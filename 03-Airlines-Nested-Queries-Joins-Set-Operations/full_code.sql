SQL> @z:/Airlines_dataset/ex3.sql
SQL> @z:/Airlines_dataset/air_main.sql
SQL> --*****************************************************
SQL> -- 	       AIRLINES DATASET
SQL> -- 		Version 1.0
SQL> -- 	       February 05, 2013
SQL> --*****************************************************
SQL> --Sources:
SQL> -- 	To create airlines database run the following
SQL> --      two script files which will create and populate
SQL> --      the databases.
SQL> --
SQL> --******************************************************
SQL> -- run the SQL script files
SQL> 
SQL> @z:/Airlines_dataset/air_cre.sql
SQL> --*****************************************************
SQL> -- 	       AIRLINES DATASET
SQL> -- 		Version 1.0
SQL> -- 	       February 05, 2013
SQL> --*****************************************************
SQL> --Sources:
SQL> -- 	This dataset is prepared for the assignment
SQL> --      on Subqueries and Join in SQL to students. This
SQL> --      is a test dataset.
SQL> --      The below SQL create the relations for airlines
SQL> --      database with constraints.
SQL> --
SQL> --******************************************************
SQL> 
SQL> drop table fl_schedule;

Table dropped.

SQL> drop table flights;

Table dropped.

SQL> drop table routes;

Table dropped.

SQL> drop table certified;

Table dropped.

SQL> drop table employee;

Table dropped.

SQL> drop table aircraft;

Table dropped.

SQL> 
SQL> create table aircraft(
  2  	     aid number(4) constraint aid_pk primary key,
  3  	     aname varchar2(30),
  4  	     type varchar2(10),
  5  	     cruisingrange number(6)
  6  	     );

Table created.

SQL> 
SQL> create table employee(
  2  	     eid number(9) constraint eid_pk primary key,
  3  	     ename varchar2(30),
  4  	     salary number(10,2)
  5  	     );

Table created.

SQL> 
SQL> create table certified(
  2  	     eid number(9),
  3  	     aid number(4),
  4  	     constraint eaid_pk primary key(eid,aid),
  5  	     constraint eid_fk foreign key(eid) references employee,
  6  	     constraint aid_fk foreign key(aid) references aircraft
  7  	     );

Table created.

SQL> 
SQL> create table routes(
  2  	     routeID varchar2(6) constraint rid_pk primary key,
  3  	     orig_airport varchar2(20),
  4  	     dest_airport varchar2(20),
  5  	     distance number(6)
  6  	     );

Table created.

SQL> 
SQL> create table flights(
  2  	     flightNo varchar2(7) constraint fno_pk primary key,
  3  	     rID varchar2(6),
  4  	     aid number(4),
  5  	     constraint fl_aid_fk foreign key(aid) references aircraft,
  6  	     constraint rid_fk foreign key(rid) references routes
  7  	     );

Table created.

SQL> 
SQL> create table fl_schedule(
  2  	     flno varchar2(7),
  3  	     departs date,
  4  	     dtime number(4),
  5  	     arrives date,
  6  	     atime number(4),
  7  	     price number(7,2),
  8  	     constraint fno_dep_pk primary key (flno,departs),
  9  	     constraint fno_fk foreign key(flno) references flights
 10  	     );

Table created.

SQL> 
SQL> --********************END OF CREATE**********************************
SQL> @z:/Airlines_dataset/air_pop.sql
SQL> --*****************************************************
SQL> -- 	       AIRLINES DATASET
SQL> -- 		Version 1.0
SQL> -- 	       February 05, 2013
SQL> --*****************************************************
SQL> --Sources:
SQL> -- 	This dataset is prepared for the assignment
SQL> --      on Subqueries and Join in SQL to students. This
SQL> --      is a test dataset.
SQL> --      The below SQL statements will populate the
SQL> --      airlines database. The flight schedule contains
SQL> --      information pertained to flights during 12 to 22
SQL> --      April 2005. Do NOT MODIFY the instances.
SQL> --
SQL> --******************************************************
SQL> --
SQL> -- Populating Aircraft
SQL> --aircraft(aid, aname, type, cruisingrange)
SQL> 
SQL> INSERT INTO  aircraft VALUES (1,'Boeing 747-400','Boeing',8430);

1 row created.

SQL> INSERT INTO  aircraft VALUES (2,'Boeing 737-800','Boeing',3383);

1 row created.

SQL> INSERT INTO  aircraft VALUES (3,'Airbus A340-300','Airbus',7120);

1 row created.

SQL> INSERT INTO  aircraft VALUES (4,'British Aerospace Jetstream 41','BAe',1502);

1 row created.

SQL> INSERT INTO  aircraft VALUES (5,'Embraer ERJ-145','Embraer',1530);

1 row created.

SQL> INSERT INTO  aircraft VALUES (6,'SAAB 340','Saab',2128);

1 row created.

SQL> INSERT INTO  aircraft VALUES (7,'Piper PA-46 Meridian','Piper',520);

1 row created.

SQL> INSERT INTO  aircraft VALUES (8,'Tupolev Tu-154','Tupolev',4103);

1 row created.

SQL> INSERT INTO  aircraft VALUES (16,'Schweizer 2-33','Schweizer',300);

1 row created.

SQL> INSERT INTO  aircraft VALUES (9,'Lockheed L1011 Tristar','Lockheed',6900);

1 row created.

SQL> INSERT INTO  aircraft VALUES (10,'Boeing 757-300','Boeing',4010);

1 row created.

SQL> INSERT INTO  aircraft VALUES (11,'Boeing 777-300','Boeing',6441);

1 row created.

SQL> INSERT INTO  aircraft VALUES (12,'Boeing 767-400ER','Boeing',6475);

1 row created.

SQL> INSERT INTO  aircraft VALUES (13,'Airbus A320','Airbus',2605);

1 row created.

SQL> INSERT INTO  aircraft VALUES (14,'Airbus A319','Airbus',1805);

1 row created.

SQL> INSERT INTO  aircraft VALUES (15,'Boeing 727','Boeing',1504);

1 row created.

SQL> 
SQL> 
SQL> -- Populating employee relation
SQL> --employee(eid, ename, salary)
SQL> 
SQL> INSERT INTO  employee VALUES (242518965,'James Smith',120433);

1 row created.

SQL> INSERT INTO  employee VALUES (141582651,'Mary Johnson',178345);

1 row created.

SQL> INSERT INTO  employee VALUES (011564812,'John Williams',153972);

1 row created.

SQL> INSERT INTO  employee VALUES (567354612,'Lisa Walker',256481);

1 row created.

SQL> INSERT INTO  employee VALUES (552455318,'Larry West',101745);

1 row created.

SQL> INSERT INTO  employee VALUES (550156548,'Karen Scott',205187);

1 row created.

SQL> INSERT INTO  employee VALUES (390487451,'Lawrence Sperry',212156);

1 row created.

SQL> INSERT INTO  employee VALUES (274878974,'Michael Miller',99890);

1 row created.

SQL> INSERT INTO  employee VALUES (254099823,'Patricia Jones',24450);

1 row created.

SQL> INSERT INTO  employee VALUES (356187925,'Robert Brown',44740);

1 row created.

SQL> INSERT INTO  employee VALUES (355548984,'Angela Martinez',212156);

1 row created.

SQL> INSERT INTO  employee VALUES (310454876,'Joseph Thompson',212156);

1 row created.

SQL> INSERT INTO  employee VALUES (489456522,'Linda Davis',127984);

1 row created.

SQL> INSERT INTO  employee VALUES (489221823,'Richard Jackson',23980);

1 row created.

SQL> INSERT INTO  employee VALUES (548977562,'William Ward',84476);

1 row created.

SQL> INSERT INTO  employee VALUES (310454877,'Chad Stewart',33546);

1 row created.

SQL> INSERT INTO  employee VALUES (142519864,'Betty Adams',227489);

1 row created.

SQL> INSERT INTO  employee VALUES (269734834,'George Wright',289950);

1 row created.

SQL> INSERT INTO  employee VALUES (287321212,'Michael Miller',48090);

1 row created.

SQL> INSERT INTO  employee VALUES (552455348,'Dorthy Lewis',92013);

1 row created.

SQL> INSERT INTO  employee VALUES (248965255,'Barbara Wilson',43723);

1 row created.

SQL> INSERT INTO  employee VALUES (159542516,'William Moore',48250);

1 row created.

SQL> INSERT INTO  employee VALUES (348121549,'Haywood Kelly',32899);

1 row created.

SQL> INSERT INTO  employee VALUES (090873519,'Elizabeth Taylor',32021);

1 row created.

SQL> INSERT INTO  employee VALUES (486512566,'David Anderson',743001);

1 row created.

SQL> INSERT INTO  employee VALUES (619023588,'Jennifer Thomas',54921);

1 row created.

SQL> INSERT INTO  employee VALUES (015645489,'Donald King',18050);

1 row created.

SQL> INSERT INTO  employee VALUES (556784565,'Mark Young',205187);

1 row created.

SQL> INSERT INTO  employee VALUES (573284895,'Eric Cooper',114323);

1 row created.

SQL> INSERT INTO  employee VALUES (574489456,'William Jones',105743);

1 row created.

SQL> INSERT INTO  employee VALUES (574489457,'Milo Brooks',12000);

1 row created.

SQL> 
SQL> 
SQL> -- Populating Certified relation
SQL> --certified(eid, aid)
SQL> 
SQL> INSERT INTO certified VALUES (567354612,1);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,2);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,10);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,11);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,12);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,15);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,7);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,9);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,3);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,4);

1 row created.

SQL> INSERT INTO certified VALUES (567354612,5);

1 row created.

SQL> INSERT INTO certified VALUES (552455318,2);

1 row created.

SQL> INSERT INTO certified VALUES (552455318,14);

1 row created.

SQL> INSERT INTO certified VALUES (550156548,1);

1 row created.

SQL> INSERT INTO certified VALUES (550156548,12);

1 row created.

SQL> INSERT INTO certified VALUES (390487451,3);

1 row created.

SQL> INSERT INTO certified VALUES (390487451,13);

1 row created.

SQL> INSERT INTO certified VALUES (390487451,14);

1 row created.

SQL> INSERT INTO certified VALUES (274878974,10);

1 row created.

SQL> INSERT INTO certified VALUES (274878974,12);

1 row created.

SQL> INSERT INTO certified VALUES (355548984,8);

1 row created.

SQL> INSERT INTO certified VALUES (355548984,9);

1 row created.

SQL> INSERT INTO certified VALUES (310454876,8);

1 row created.

SQL> INSERT INTO certified VALUES (310454876,9);

1 row created.

SQL> INSERT INTO certified VALUES (548977562,7);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,1);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,11);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,12);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,10);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,3);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,2);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,13);

1 row created.

SQL> INSERT INTO certified VALUES (142519864,7);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,1);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,2);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,3);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,4);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,5);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,6);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,7);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,8);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,9);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,10);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,11);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,12);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,13);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,14);

1 row created.

SQL> INSERT INTO certified VALUES (269734834,15);

1 row created.

SQL> INSERT INTO certified VALUES (552455318,7);

1 row created.

SQL> INSERT INTO certified VALUES (556784565,5);

1 row created.

SQL> INSERT INTO certified VALUES (556784565,2);

1 row created.

SQL> INSERT INTO certified VALUES (556784565,3);

1 row created.

SQL> INSERT INTO certified VALUES (573284895,3);

1 row created.

SQL> INSERT INTO certified VALUES (573284895,4);

1 row created.

SQL> INSERT INTO certified VALUES (573284895,5);

1 row created.

SQL> INSERT INTO certified VALUES (574489456,8);

1 row created.

SQL> INSERT INTO certified VALUES (574489456,6);

1 row created.

SQL> INSERT INTO certified VALUES (574489457,16);

1 row created.

SQL> INSERT INTO certified VALUES (287321212,7);

1 row created.

SQL> INSERT INTO certified VALUES (242518965,2);

1 row created.

SQL> INSERT INTO certified VALUES (242518965,10);

1 row created.

SQL> INSERT INTO certified VALUES (141582651,2);

1 row created.

SQL> INSERT INTO certified VALUES (141582651,10);

1 row created.

SQL> INSERT INTO certified VALUES (141582651,12);

1 row created.

SQL> INSERT INTO certified VALUES (011564812,2);

1 row created.

SQL> INSERT INTO certified VALUES (011564812,10);

1 row created.

SQL> INSERT INTO certified VALUES (356187925,6);

1 row created.

SQL> INSERT INTO certified VALUES (159542516,5);

1 row created.

SQL> INSERT INTO certified VALUES (159542516,7);

1 row created.

SQL> INSERT INTO certified VALUES (090873519,6);

1 row created.

SQL> 
SQL> 
SQL> -- Populating Routes relation
SQL> --routes(routeID, orig_airport, dest_airport, distance)
SQL> 
SQL> INSERT INTO routes VALUES ('LW100','Los Angeles','Washington D.C.',2308);

1 row created.

SQL> INSERT INTO routes VALUES ('LC101','Los Angeles','Chicago',1749);

1 row created.

SQL> INSERT INTO routes VALUES ('LD102','Los Angeles','Dallas',1251);

1 row created.

SQL> INSERT INTO routes VALUES ('LB103','Los Angeles','Boston',2606);

1 row created.

SQL> INSERT INTO routes VALUES ('LS104','Los Angeles','Sydney',7487);

1 row created.

SQL> INSERT INTO routes VALUES ('LT105','Los Angeles','Tokyo',5478);

1 row created.

SQL> INSERT INTO routes VALUES ('LH106','Los Angeles','Honolulu',2551);

1 row created.

SQL> INSERT INTO routes VALUES ('CL150','Chicago','Los Angeles',1749);

1 row created.

SQL> INSERT INTO routes VALUES ('CN151','Chicago','New York',802);

1 row created.

SQL> INSERT INTO routes VALUES ('MD200','Madison','Detroit',319);

1 row created.

SQL> INSERT INTO routes VALUES ('DN250','Detroit','New York',470);

1 row created.

SQL> INSERT INTO routes VALUES ('DM251','Detroit','Montreal',517);

1 row created.

SQL> INSERT INTO routes VALUES ('MN204','Madison','New York',789);

1 row created.

SQL> INSERT INTO routes VALUES ('MC201','Madison','Chicago',150);

1 row created.

SQL> INSERT INTO routes VALUES ('MP202','Madison','Pittsburgh',510);

1 row created.

SQL> INSERT INTO routes VALUES ('MM203','Madison','Minneapolis',247);

1 row created.

SQL> INSERT INTO routes VALUES ('MNY300','Minneapolis','New York',991);

1 row created.

SQL> INSERT INTO routes VALUES ('PN350','Pittsburgh','New York',303);

1 row created.

SQL> INSERT INTO routes VALUES ('PC351','Pittsburgh','Chicago',409);

1 row created.

SQL> INSERT INTO routes VALUES ('NYL400','New York','London',3471);

1 row created.

SQL> INSERT INTO routes VALUES ('NYP401','New York','Paris',3631);

1 row created.

SQL> INSERT INTO routes values('LNY107','Los Angeles','New York',2510);

1 row created.

SQL> 
SQL> 
SQL> -- Populating Fligts relations
SQL> --flights(flightNo, rID, aid)
SQL> 
SQL> INSERT INTO flights VALUES ('9E-3749','DM251',4);

1 row created.

SQL> INSERT INTO flights VALUES ('MQ-4477','DN250',5);

1 row created.

SQL> INSERT INTO flights VALUES ('MQ-4565','DN250',5);

1 row created.

SQL> INSERT INTO flights VALUES ('CX-7520','LD102',4);

1 row created.

SQL> INSERT INTO flights VALUES ('WS-5060','LD102',5);

1 row created.

SQL> INSERT INTO flights VALUES ('QF-3045','LD102',15);

1 row created.

SQL> INSERT INTO flights VALUES ('JJ-7456','LW100',13);

1 row created.

SQL> INSERT INTO flights VALUES ('JJ-2482','LW100',13);

1 row created.

SQL> INSERT INTO flights VALUES ('SN-8814','LW100',2);

1 row created.

SQL> INSERT INTO flights VALUES ('WN-484','LC101',14);

1 row created.

SQL> INSERT INTO flights VALUES ('WN-434','LC101',13);

1 row created.

SQL> INSERT INTO flights VALUES ('B6-474','LB103',2);

1 row created.

SQL> INSERT INTO flights VALUES ('B6-482','LB103',2);

1 row created.

SQL> INSERT INTO flights VALUES ('VA-6551','LS104',1);

1 row created.

SQL> INSERT INTO flights VALUES ('VA-2','LS104',1);

1 row created.

SQL> INSERT INTO flights VALUES ('DJ-2','LS104',1);

1 row created.

SQL> INSERT INTO flights VALUES ('SQ-11','LT105',11);

1 row created.

SQL> INSERT INTO flights VALUES ('AI-7205','LT105',12);

1 row created.

SQL> INSERT INTO flights VALUES ('MH-93','LT105',11);

1 row created.

SQL> INSERT INTO flights VALUES ('HA-3','LH106',13);

1 row created.

SQL> INSERT INTO flights VALUES ('HA-1','LH106',13);

1 row created.

SQL> INSERT INTO flights VALUES ('UA-1428','LH106',2);

1 row created.

SQL> INSERT INTO flights VALUES ('A5-3376','CL150',14);

1 row created.

SQL> INSERT INTO flights VALUES ('A5-3246','CN151',4);

1 row created.

SQL> INSERT INTO flights VALUES ('9E-3851','MD200',5);

1 row created.

SQL> INSERT INTO flights VALUES ('9E-3622','MD200',4);

1 row created.

SQL> INSERT INTO flights VALUES ('G7-6205','MN204',4);

1 row created.

SQL> INSERT INTO flights VALUES ('EV-5134','MN204',15);

1 row created.

SQL> INSERT INTO flights VALUES ('RP-5018','MC201',16);

1 row created.

SQL> INSERT INTO flights VALUES ('G7-3664','MC201',5);

1 row created.

SQL> INSERT INTO flights VALUES ('FX-2351','MP202',7);

1 row created.

SQL> INSERT INTO flights VALUES ('AS-5958','MM203',16);

1 row created.

SQL> INSERT INTO flights VALUES ('AS-5062','MM203',7);

1 row created.

SQL> INSERT INTO flights VALUES ('DL-3402','PN350',15);

1 row created.

SQL> INSERT INTO flights VALUES ('CY-1846','NYL400',8);

1 row created.

SQL> INSERT INTO flights VALUES ('BA-178','NYL400',10);

1 row created.

SQL> INSERT INTO flights VALUES ('IB-4618','NYL400',9);

1 row created.

SQL> INSERT INTO flights VALUES ('VS-26','NYL400',8);

1 row created.

SQL> INSERT INTO flights VALUES ('AF-23','NYP401',10);

1 row created.

SQL> INSERT INTO flights VALUES ('AF-11','NYP401',10);

1 row created.

SQL> INSERT INTO flights VALUES ('RJ-7056','NYP401',8);

1 row created.

SQL> INSERT INTO flights values('AF-12','LNY107',10);

1 row created.

SQL> 
SQL> 
SQL> -- Populating Fl_schedule relation
SQL> --fl_schedule(flno, departs, dtime, arrives, atime, price)
SQL> 
SQL> INSERT INTO fl_schedule VALUES ('9E-3851','12-apr-2005',0710,'12-apr-2005',0800,120.40);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('CX-7520','12-apr-2005',0730,'12-apr-2005',0840,225.43);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('JJ-7456','12-apr-2005',0930,'12-apr-2005',1240,235.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WS-5060','12-apr-2005',0930,'12-apr-2005',1042,227.60);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('AI-7205','12-apr-2005',1010,'13-apr-2005',1850,785.19);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('CY-1846','12-apr-2005',1040,'13-apr-2005',0920,250.50);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('DL-3402','12-apr-2005',1140,'12-apr-2005',1220,116.50);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('AS-5958','12-apr-2005',1210,'14-apr-2005',1300,220.15);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('QF-3045','12-apr-2005',1320,'12-apr-2005',1440,227.60);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('9E-3749','12-apr-2005',1940,'14-apr-2005',2020,170.40);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('G7-3664','13-apr-2005',0535,'13-apr-2005',0610,112.45);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WN-484','13-apr-2005',0800,'13-apr-2005',0935,220.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('HA-3','13-apr-2005',1230,'13-apr-2005',1555,375.23);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('AS-5062','13-apr-2005',2010,'14-apr-2005',2100,120.11);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('VA-2','13-apr-2005',2030,'15-apr-2005',0430,1300.50);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('A5-3376','13-apr-2005',2030,'13-apr-2005',2150,220.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('FX-2351','14-apr-2005',0810,'14-apr-2005',0900,208.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('AF-23','14-apr-2005',1020,'15-apr-2005',1210,320.70);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('B6-474','14-apr-2005',1710,'14-apr-2005',2120,261.56);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('G7-6205','22-apr-2005',1725,'22-apr-2005',1850,202.34);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('VA-6551','14-apr-2005',2230,'16-apr-2005',0610,1278.56);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('9E-3851','15-apr-2005',1035,'15-apr-2005',1140,120.40);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('HA-1','15-apr-2005',1110,'15-apr-2005',1445,375.23);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('BA-178','15-apr-2005',1140,'16-apr-2005',1020,250.50);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('SQ-11','15-apr-2005',1230,'16-apr-2005',2055,780.99);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('JJ-2482','15-apr-2005',1230,'15-apr-2005',1540,235.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('MQ-4477','15-apr-2005',1510,'15-apr-2005',1600,180.56);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('A5-3246','15-apr-2005',1810,'15-apr-2005',1900,202.45);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('RP-5018','15-apr-2005',2100,'15-apr-2005',2155,225.45);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WS-5060','16-apr-2005',0930,'16-apr-2005',1042,227.60);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WN-484','16-apr-2005',0940,'16-apr-2005',1110,220.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WN-434','16-apr-2005',1410,'16-apr-2005',1530,225.10);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('MH-93','17-apr-2005',0440,'18-apr-2005',1315,783.30);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('G7-3664','17-apr-2005',0725,'17-apr-2005',0815,112.45);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('CX-7520','17-apr-2005',0730,'17-apr-2005',0840,225.43);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('AF-11','17-apr-2005',1340,'18-apr-2005',1530,320.70);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('9E-3622','17-apr-2005',1655,'17-apr-2005',1750,118.40);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('EV-5134','17-apr-2005',2135,'17-apr-2005',2240,202.34);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('B6-482','18-apr-2005',0330,'18-apr-2005',0740,261.56);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('DL-3402','18-apr-2005',1140,'18-apr-2005',1220,116.50);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('IB-4618','18-apr-2005',1310,'19-apr-2005',1150,250.50);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('UA-1428','18-apr-2005',1420,'18-apr-2005',1740,425.38);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('MQ-4565','18-apr-2005',1810,'18-apr-2005',1900,180.56);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('JJ-7456','19-apr-2005',0930,'19-apr-2005',1240,235.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WN-484','19-apr-2005',1000,'19-apr-2005',1120,220.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('QF-3045','19-apr-2005',1320,'19-apr-2005',1440,227.60);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WS-5060','20-apr-2005',0930,'20-apr-2005',1042,227.60);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('RJ-7056','20-apr-2005',1810,'21-apr-2005',2020,320.70);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('FX-2351','21-apr-2005',0810,'21-apr-2005',0900,208.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('AF-23','21-apr-2005',1020,'22-apr-2005',1210,320.70);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('VS-26','21-apr-2005',1340,'22-apr-2005',1230,250.50);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('VA-6551','21-apr-2005',2230,'23-apr-2005',0610,1278.56);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('G7-3664','22-apr-2005',0535,'22-apr-2005',0610,112.45);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('CX-7520','22-apr-2005',0730,'22-apr-2005',0840,225.43);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('SN-8814','22-apr-2005',1030,'22-apr-2005',1335,245);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WN-484','22-apr-2005',1200,'22-apr-2005',1325,220.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('JJ-2482','22-apr-2005',1230,'22-apr-2005',1540,235.98);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('WN-434','22-apr-2005',1540,'22-apr-2005',1700,225.10);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('B6-474','22-apr-2005',1710,'22-apr-2005',2120,261.56);

1 row created.

SQL> INSERT INTO fl_schedule VALUES ('A5-3246','22-apr-2005',1810,'22-apr-2005',1900,202.45);

1 row created.

SQL> INSERT INTO fl_schedule values('AF-12','22-apr-05',1245,'22-apr-05',1850,450.25);

1 row created.

SQL> 
SQL> --**************************END OF INSERT****************************
SQL> 
SQL> --**********END OF AIRLINES DB CREATION*****************
SQL> 
SQL> rem: 1.Display the flight number,departure date and time of a flight, its
SQL> --      route details and aircraft name of type either Schweizer or Piper
SQL> --       that departs during 8.00 PM and 9.00 PM.
SQL> 
SQL> 	     SELECT flno, departs, dtime,routeid,orig_airport,dest_airport,distance,aname
  2  	     FROM flights f
  3  	     JOIN fl_schedule fs
  4  	     ON (f.flightno=fs.flno)
  5  	     JOIN routes r
  6  	     ON (r.routeid=f.rid)
  7  	     JOIN aircraft a
  8  	     ON(a.aid=f.aid)
  9  	     WHERE a.type IN ('Schweizer', 'Piper') and fs.dtime between 2000 and 2100;

FLNO    DEPARTS        DTIME ROUTEI ORIG_AIRPORT         DEST_AIRPORT           DISTANCE ANAME                                                        
------- --------- ---------- ------ -------------------- -------------------- ---------- ------------------------------                               
AS-5062 13-APR-05       2010 MM203  Madison              Minneapolis                 247 Piper PA-46 Meridian                                         
RP-5018 15-APR-05       2100 MC201  Madison              Chicago                     150 Schweizer 2-33                                               

SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem : 2.For all the routes, display the flight number, origin and destination airport,
SQL> --       if a flight is assigned for that route.
SQL> 
SQL> 	     SELECT routeid,flightno,orig_airport,dest_airport
  2  	     FROM flights f
  3  	     JOIN routes r
  4  	     ON(r.routeid=f.rid);

ROUTEI FLIGHTN ORIG_AIRPORT         DEST_AIRPORT                                                                                                      
------ ------- -------------------- --------------------                                                                                              
DM251  9E-3749 Detroit              Montreal                                                                                                          
DN250  MQ-4477 Detroit              New York                                                                                                          
DN250  MQ-4565 Detroit              New York                                                                                                          
LD102  CX-7520 Los Angeles          Dallas                                                                                                            
LD102  WS-5060 Los Angeles          Dallas                                                                                                            
LD102  QF-3045 Los Angeles          Dallas                                                                                                            
LW100  JJ-7456 Los Angeles          Washington D.C.                                                                                                   
LW100  JJ-2482 Los Angeles          Washington D.C.                                                                                                   
LW100  SN-8814 Los Angeles          Washington D.C.                                                                                                   
LC101  WN-484  Los Angeles          Chicago                                                                                                           
LC101  WN-434  Los Angeles          Chicago                                                                                                           

ROUTEI FLIGHTN ORIG_AIRPORT         DEST_AIRPORT                                                                                                      
------ ------- -------------------- --------------------                                                                                              
LB103  B6-474  Los Angeles          Boston                                                                                                            
LB103  B6-482  Los Angeles          Boston                                                                                                            
LS104  VA-6551 Los Angeles          Sydney                                                                                                            
LS104  VA-2    Los Angeles          Sydney                                                                                                            
LS104  DJ-2    Los Angeles          Sydney                                                                                                            
LT105  SQ-11   Los Angeles          Tokyo                                                                                                             
LT105  AI-7205 Los Angeles          Tokyo                                                                                                             
LT105  MH-93   Los Angeles          Tokyo                                                                                                             
LH106  HA-3    Los Angeles          Honolulu                                                                                                          
LH106  HA-1    Los Angeles          Honolulu                                                                                                          
LH106  UA-1428 Los Angeles          Honolulu                                                                                                          

ROUTEI FLIGHTN ORIG_AIRPORT         DEST_AIRPORT                                                                                                      
------ ------- -------------------- --------------------                                                                                              
CL150  A5-3376 Chicago              Los Angeles                                                                                                       
CN151  A5-3246 Chicago              New York                                                                                                          
MD200  9E-3851 Madison              Detroit                                                                                                           
MD200  9E-3622 Madison              Detroit                                                                                                           
MN204  G7-6205 Madison              New York                                                                                                          
MN204  EV-5134 Madison              New York                                                                                                          
MC201  RP-5018 Madison              Chicago                                                                                                           
MC201  G7-3664 Madison              Chicago                                                                                                           
MP202  FX-2351 Madison              Pittsburgh                                                                                                        
MM203  AS-5958 Madison              Minneapolis                                                                                                       
MM203  AS-5062 Madison              Minneapolis                                                                                                       

ROUTEI FLIGHTN ORIG_AIRPORT         DEST_AIRPORT                                                                                                      
------ ------- -------------------- --------------------                                                                                              
PN350  DL-3402 Pittsburgh           New York                                                                                                          
NYL400 CY-1846 New York             London                                                                                                            
NYL400 BA-178  New York             London                                                                                                            
NYL400 IB-4618 New York             London                                                                                                            
NYL400 VS-26   New York             London                                                                                                            
NYP401 AF-23   New York             Paris                                                                                                             
NYP401 AF-11   New York             Paris                                                                                                             
NYP401 RJ-7056 New York             Paris                                                                                                             
LNY107 AF-12   Los Angeles          New York                                                                                                          

42 rows selected.

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem : 3. For all aircraft with cruisingrange over 5,000 miles, find the name of the
SQL> --      aircraft and the average salary of all pilots certified for this aircraft.
SQL> 
SQL> 	     SELECT aname, avg(salary)
  2  	     FROM aircraft a
  3  	     JOIN CERTIFIED c
  4  	     USING (aid)
  5  	     JOIN employee e
  6  	     USING(eid)
  7  	     WHERE cruisingrange > 5000
  8  	     GROUP BY aname;

ANAME                          AVG(SALARY)                                                                                                            
------------------------------ -----------                                                                                                            
Airbus A340-300                 217597.667                                                                                                            
Boeing 777-300                  257973.333                                                                                                            
Boeing 747-400                   244776.75                                                                                                            
Boeing 767-400ER                    209557                                                                                                            
Lockheed L1011 Tristar           242685.75                                                                                                            

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem : 4.Show the employee details such as id, name and salary who are not pilots
SQL> --      and whose salary is more than the average salary of pilots.
SQL> 
SQL> 
SQL> 	     SELECT e.eid, ename,salary
  2  	     FROM employee e
  3  	     WHERE e.eid NOT IN
  4  		     (SELECT c.eid
  5  		     FROM certified c)
  6  	     AND salary >
  7  		     (SELECT avg(salary)
  8  		      FROM employee join certified USING(eid));

       EID ENAME                              SALARY                                                                                                  
---------- ------------------------------ ----------                                                                                                  
 486512566 David Anderson                     743001                                                                                                  

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem: 5.Find the id and name of pilots who were certified to operate some aircrafts
SQL> --       but at least one of that aircraft is not scheduled from any routes.
SQL> 
SQL> 	     SELECT distinct eid,ename
  2  	     FROM employee e
  3  	     JOIN certified c
  4  	     USING(eid)
  5  	     JOIN aircraft a
  6  	     USING(aid)
  7  	     WHERE aid NOT IN
  8  		     (SELECT f.aid FROM flights f);

       EID ENAME                                                                                                                                      
---------- ------------------------------                                                                                                             
 269734834 George Wright                                                                                                                              
 356187925 Robert Brown                                                                                                                               
  90873519 Elizabeth Taylor                                                                                                                           
 574489456 William Jones                                                                                                                              
 567354612 Lisa Walker                                                                                                                                
 556784565 Mark Young                                                                                                                                 
 573284895 Eric Cooper                                                                                                                                
 390487451 Lawrence Sperry                                                                                                                            
 142519864 Betty Adams                                                                                                                                

9 rows selected.

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem: 6.Display the origin and destination of the flights having at least
SQL> --      three departures with maximum distance covered.
SQL> 
SQL> 	     SELECT orig_airport, dest_airport
  2  	     FROM routes r1
  3  	     JOIN flights
  4  	     ON(rid=routeid)
  5  	     WHERE distance= (SELECT max(distance)
  6  			     FROM routes)
  7  	     GROUP BY orig_airport, dest_airport
  8  	     HAVING count(*)>=3;

ORIG_AIRPORT         DEST_AIRPORT                                                                                                                     
-------------------- --------------------                                                                                                             
Los Angeles          Sydney                                                                                                                           

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem: 7.Display name and salary of pilot whose salary is more than the
SQL> --       average salary of any pilots for each route other than flights
SQL> --       originating from Madison airport.
SQL> 
SQL> 	     SELECT distinct ename,salary
  2  	     FROM employee e
  3  	     JOIN certified c21
  4  	     USING(eid)
  5  	     JOIN flights f1
  6  	     USING(aid)
  7  	     JOIN routes r1
  8  	     ON(rid=routeid)
  9  	     WHERE salary > ( SELECT avg(salary)
 10  			     FROM employee e2
 11  			     JOIN certified c2
 12  			     USING(eid)
 13  			     JOIN flights f2
 14  			     USING(aid)
 15  			     JOIN routes r2
 16  			     ON(rid=routeid)
 17  			     WHERE r2.routeid=r1.routeid)
 18  	     AND orig_airport<>'Madison';

ENAME                              SALARY                                                                                                             
------------------------------ ----------                                                                                                             
George Wright                      289950                                                                                                             
Betty Adams                        227489                                                                                                             
Angela Martinez                    212156                                                                                                             
Lawrence Sperry                    212156                                                                                                             
Joseph Thompson                    212156                                                                                                             
Mark Young                         205187                                                                                                             
Lisa Walker                        256481                                                                                                             

7 rows selected.

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem: 8.Display the flight number, aircraft type, source and destination
SQL> --       airport of the aircraft having maximum number of flights to Honolulu.
SQL> 
SQL> 	     SELECT flightno,type, orig_airport,dest_airport
  2  	     FROM aircraft
  3  	     JOIN flights USING(aid)
  4  	     JOIN routes ON(routeid=rid)
  5  	     WHERE aid=
  6  		     (SELECT* FROM(
  7  			 SELECT aid
  8  			 FROM aircraft
  9  			 JOIN flights USING(aid)
 10  			 JOIN routes ON(routeid=rid)
 11  			 WHERE dest_airport='Honolulu'
 12  			 GROUP BY aid, aname
 13  			 ORDER BY count(*) desc)
 14  			 WHERE rownum=1);

FLIGHTN TYPE       ORIG_AIRPORT         DEST_AIRPORT                                                                                                  
------- ---------- -------------------- --------------------                                                                                          
JJ-7456 Airbus     Los Angeles          Washington D.C.                                                                                               
JJ-2482 Airbus     Los Angeles          Washington D.C.                                                                                               
WN-434  Airbus     Los Angeles          Chicago                                                                                                       
HA-3    Airbus     Los Angeles          Honolulu                                                                                                      
HA-1    Airbus     Los Angeles          Honolulu                                                                                                      

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem: 9.Display the pilot(s) who are certified exclusively to pilot all aircraft in a type
SQL> 
SQL> 	     SELECT distinct eid, ename,type
  2  	     FROM employee
  3  	     JOIN certified USING(eid)
  4  	     JOIN aircraft USING(aid)
  5  	     WHERE eid IN ( SELECT c.eid
  6  			     FROM certified c
  7  			     JOIN aircraft a USING(aid)
  8  			     WHERE c.eid IN ( SELECT c1.eid
  9  					     FROM certified c1
 10  					     JOIN aircraft a1 USING(aid)
 11  					     GROUP BY c1.eid
 12  					     HAVING(count(distinct a1.type))=1)
 13  			     GROUP BY c.eid,a.type
 14  			     HAVING count(*)=(SELECT COUNT (a1.aid)
 15  					     FROM aircraft a1
 16  					     WHERE a1.type=a.type)
 17  		       );

       EID ENAME                          TYPE                                                                                                        
---------- ------------------------------ ----------                                                                                                  
 390487451 Lawrence Sperry                Airbus                                                                                                      
 574489457 Milo Brooks                    Schweizer                                                                                                   
  90873519 Elizabeth Taylor               Saab                                                                                                        
 548977562 William Ward                   Piper                                                                                                       
 356187925 Robert Brown                   Saab                                                                                                        
 287321212 Michael Miller                 Piper                                                                                                       

6 rows selected.

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem: 10. Name the employee(s) who is earning the maximum salary
SQL> --      among the airport having maximum number of departures.
SQL> 
SQL> 
SQL> 	     SELECT eid,ename,salary
  2  	     FROM employee e
  3  	     WHERE salary = (SELECT max(salary)
  4  		     FROM employee
  5  		     JOIN certified c USING (eid)
  6  		     JOIN flights f USING (aid)
  7  		     JOIN routes r ON (rid=routeid)
  8  		     WHERE orig_airport = (SELECT orig_airport
  9  				     FROM routes r
 10  				     JOIN flights f ON (routeid=rid)
 11  				     GROUP BY orig_airport
 12  				     HAVING count(*) = (SELECT max(count(*))
 13  						     FROM routes r
 14  						     JOIN flights f ON (routeid=rid)
 15  						     GROUP BY orig_airport)));

       EID ENAME                              SALARY                                                                                                  
---------- ------------------------------ ----------                                                                                                  
 269734834 George Wright                      289950                                                                                                  

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem: 11. Display the departure chart as follows:flight number, departure(date,airport,time),
SQL> --       destination airport, arrival time, aircraft name for the flights from New York airport
SQL> --       during 15 to 19th April 2005.
SQL> --      Make sure that the route contains at least two flights in the above specified condition.
SQL> 
SQL> 	      SELECT flightno, departs, orig_airport, dtime, dest_airport, atime, aname
  2  	     FROM fl_schedule
  3  	     JOIN flights ON(flightno=flno)
  4  	     JOIN routes ON(routeid=rid)
  5  	     JOIN aircraft USING(aid)
  6  	     WHERE orig_airport='New York' AND ( departs BETWEEN '15-APR-05' AND '19-APR-05')
  7  	     AND  rid=(SELECT rid
  8  		     FROM fl_schedule
  9  		     JOIN flights ON(flightno=flno)
 10  		     JOIN routes ON(routeid=rid)
 11  		     WHERE orig_airport='New York' AND ( departs BETWEEN '15-APR-05' AND '19-APR-05')
 12  		     GROUP BY rid
 13  		     HAVING count(*) > =2);

FLIGHTN DEPARTS   ORIG_AIRPORT              DTIME DEST_AIRPORT              ATIME ANAME                                                               
------- --------- -------------------- ---------- -------------------- ---------- ------------------------------                                      
BA-178  15-APR-05 New York                   1140 London                     1020 Boeing 757-300                                                      
IB-4618 18-APR-05 New York                   1310 London                     1150 Lockheed L1011 Tristar                                              

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem : 12. A customer wants to travel from Madison to New York with no more than two changes of flight.
SQL> --      List the flight numbers from Madison if the customer wants to arrive in New York by 6.50 p.m.
SQL> 
SQL> 
SQL> 	     (
  2  	     SELECT distinct f.flightNo
  3  	     FROM routes r
  4  	     JOIN flights f ON(r.routeid = f.rid)
  5  	     JOIN fl_schedule fl ON(f.flightNo = fl.flno)
  6  	     WHERE r.orig_airport = 'Madison' AND
  7  	     r.dest_airport = 'New York' AND
  8  	     fl.atime <=1850
  9  	     )
 10  	     UNION
 11  	     (
 12  	     SELECT distinct f.flightNo
 13  	     FROM
 14  	     (routes r
 15  	     JOIN flights f ON (r.routeid = f.rid)
 16  	     JOIN fl_schedule fl ON(f.flightNo = fl.flno))
 17  	     JOIN
 18  	     (routes rm
 19  	     JOIN flights fm ON (rm.routeid = fm.rid)
 20  	     JOIN fl_schedule flm ON(fm.flightNo = flm.flno)
 21  	     )
 22  	     ON (r.dest_airport = rm.orig_airport)
 23  	     WHERE r.orig_airport = 'Madison' AND
 24  	     rm.dest_airport = 'New York' AND
 25  	     fl.atime <= flm.dtime AND
 26  	     flm.atime <=1850
 27  	     )
 28  	     UNION
 29  	     (
 30  	     SELECT distinct f.flightNo
 31  	     FROM
 32  	     (
 33  		     (routes r join flights f ON (r.routeid = f.rid)
 34  		      JOIN fl_schedule fl ON(f.flightNo = fl.flno)
 35  		     )
 36  		     JOIN
 37  		     (routes rm join flights fm ON (rm.routeid = fm.rid)
 38  		      JOIN fl_schedule flm ON(fm.flightNo = flm.flno)
 39  		     )
 40  		     ON (r.dest_airport = rm.orig_airport)
 41  	     )
 42  	     JOIN
 43  	     (
 44  	       routes rm1 JOIN flights fm1 ON (rm1.routeid = fm1.rid)
 45  	       JOIN fl_schedule flm1 ON(fm1.flightNo = flm1.flno)
 46  	     )
 47  	     ON (rm.dest_airport = rm1.orig_airport)
 48  	     WHERE r.orig_airport = 'Madison' AND
 49  	     rm1.dest_airport = 'New York' AND
 50  	     (fl.atime<=flm.dtime AND flm.atime<=flm1.dtime) AND
 51  	     flm1.atime <=1850);

FLIGHTN                                                                                                                                               
-------                                                                                                                                               
9E-3851                                                                                                                                               
FX-2351                                                                                                                                               
G7-6205                                                                                                                                               

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem : 13. Display the id and name	of employee(s) who are not pilots.
SQL> 
SQL> 	     SELECT e.eid,e.ename
  2  	     FROM employee e
  3  	     WHERE e.eid IN
  4  		     (SELECT e1.eid FROM employee e1
  5  		     MINUS
  6  		     SELECT c.eid FROM certified c);

       EID ENAME                                                                                                                                      
---------- ------------------------------                                                                                                             
 254099823 Patricia Jones                                                                                                                             
 489456522 Linda Davis                                                                                                                                
 489221823 Richard Jackson                                                                                                                            
 310454877 Chad Stewart                                                                                                                               
 552455348 Dorthy Lewis                                                                                                                               
 248965255 Barbara Wilson                                                                                                                             
 348121549 Haywood Kelly                                                                                                                              
 486512566 David Anderson                                                                                                                             
 619023588 Jennifer Thomas                                                                                                                            
  15645489 Donald King                                                                                                                                

10 rows selected.

SQL> 
SQL> -- -------------------------------------------------------------------------------------------------------------------------------
SQL> 
SQL> rem : 14. Display the id and name of employee(s) who pilots the aircraft
SQL> --      from Los Angels and Detroit airport.
SQL> 
SQL> 	     (SELECT distinct eid,e.ename
  2  	     FROM employee e
  3  	     JOIN certified c USING (eid)
  4  	     JOIN flights f USING (aid)
  5  	     JOIN aircraft a USING (aid)
  6  	     JOIN routes r on (r.routeID=f.rID)
  7  	     WHERE
  8  	     r.orig_airport='Los Angeles')
  9  	     INTERSECT
 10  	     (SELECT distinct eid,e.ename
 11  	     FROM employee e JOIN certified c using (eid)
 12  	     JOIN flights f USING (aid)
 13  	     JOIN aircraft a USING (aid)
 14  	     JOIN routes r on (r.routeID=f.rID)
 15  	     WHERE r.orig_airport='Detroit');

       EID ENAME                                                                                                                                      
---------- ------------------------------                                                                                                             
 159542516 William Moore                                                                                                                              
 269734834 George Wright                                                                                                                              
 556784565 Mark Young                                                                                                                                 
 567354612 Lisa Walker                                                                                                                                
 573284895 Eric Cooper                                                                                                                                

SQL> spool off
