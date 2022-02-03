set echo on:
set serveroutput on format wrapped
-- To prevent dbms_output from trimming leading spaces 

@z:/air_main.sql

REM: ***************************************************************Ex7 - PL/SQL TRIGGERS***************************************************************
REM: INTEGRITY THRUOGH TRIGGERS

REM: 1. The date of arrival should be always
REM:	later than or on the same date of departure.

CREATE OR REPLACE TRIGGER arrives_trg
BEFORE INSERT OR UPDATE OF arrives
ON fl_schedule
FOR EACH ROW
WHEN (NEW.arrives < NEW.departs)
BEGIN
	raise_application_error(-20001, 'The date of arrival should be always later than or on the same date of departure !');
END;
/

--FIRES TRIGGER
INSERT INTO fl_schedule VALUES('WN-484', '13-SEP-2005', 800, '12-SEP-2005', 935, 220.98);

--DOESN'T FIRE TRIGGER

/*
INSERT INTO fl_schedule VALUES('WN-484', '11-SEP-2005', 800, '12-SEP-2005', 935, 220.98);
SELECT * FROM fl_schedule WHERE flno='WN-484';
*/

REM: 2. Flight number CX-7520 is scheduled only on 
REM:    Tuesday, Friday and Sunday.

CREATE OR REPLACE TRIGGER fl_trg2
BEFORE INSERT OR UPDATE OF departs
ON fl_schedule
FOR EACH ROW
WHEN (to_char(NEW.departs,'DY') NOT IN ('TUE','FRI','SUN'))
BEGIN
	raise_application_error(-20002, 'Flight number CX-7520 should be scheduled only on Tuesday, Friday and Sunday !');
END;
/

-- FIRES TRIGGER
INSERT INTO fl_schedule VALUES('CX-7520', '12-SEP-2005', 800, '12-SEP-2005', 935, 220.98);

-- DOESN'T FIRE TRIGGER
/*
INSERT INTO fl_schedule VALUES('CX-7520', '11-SEP-2005', 800, '12-SEP-2005', 935, 220.98);
SELECT * FROM fl_schedule WHERE flno='CX-7520';
*/

REM: 3. An aircraft is assigned to a flight only 
REM:    if its cruising range is more than the
REM:    distance of the flight's route.

CREATE OR REPLACE TRIGGER cruising_trg
BEFORE INSERT OR UPDATE OF flightno
ON flights
FOR EACH ROW
DECLARE
	r_aircraft aircraft%ROWTYPE;
	r_routes routes%ROWTYPE;
BEGIN
	SELECT * INTO r_aircraft
	FROM aircraft
	WHERE aid=:NEW.aid;
	
	SELECT * INTO r_routes
	FROM routes
	WHERE routeid=:NEW.rid;
	
	IF (r_aircraft.cruisingrange < r_routes.distance) THEN
		raise_application_error(-20003, 'Cruising range is more than the distance of the flight route !');
	END IF;
END;
/

-- FIRES TRIGGER
INSERT INTO flights VALUES('NIV-927', 'LW100', 4);

--DOESN'T FIRE TRIGGER
/*
INSERT INTO flights VALUES('NIV-927', 'LW100', 10);
SELECT * FROM flights WHERE flightno='NIV-927';
SELECT * FROM aircraft WHERE aid=10;
SELECT * FROM routes WHERE routeid='LW100';
*/
