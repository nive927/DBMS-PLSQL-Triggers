set echo on:

@z:/air_main.sql

REM: *************************************************************** Ex4-VIEWS ***************************************************************

REM: To create a view based on table(s) or view(s) and observe its behavior while performing update
REM: operations on it.
REM: Use the schema from Assignment – 3 for the following:

SELECT * FROM fl_schedule WHERE flno='HA-1';
SELECT * FROM flights WHERE flightno='HA-1';

REM: 1. Create a view Schedule_15 that display the flight number, route, airport(origin, destination)
REM:    departure (date, time), arrival (date, time) of a flight on 15 apr 2005. Label the view
REM:    column as flight, route, from_airport, to_airport, ddate, dtime, adate, atime respectively.

CREATE OR REPLACE VIEW Schedule_15 (flight, route, from_airport, to_airport, ddate, dtime, adate, atime) AS 
SELECT fl.flno,
r.routeid,
r.orig_airport,
r.dest_airport,
fl.departs,
fl.dtime,
fl.arrives,
fl.atime
FROM flights f, fl_schedule fl, routes r
WHERE fl.flno=f.flightno AND f.rid=r.routeid
AND fl.departs=TO_DATE('15-04-2005', 'dd-mm-yyyy');

SELECT * FROM Schedule_15;

REM: INSERT OPERATION ON VIEW Schedule_15
INSERT INTO Schedule_15 VALUES('NIV-104', 'CH20', 'Tokyo', '27-SEP-2022', 'Seoul', 2100, '27-SEP-2022', 2144);

REM: UPDATE OPERATION ON VIEW Schedule_15
UPDATE Schedule_15 SET from_airport='Tokyo' WHERE flight='HA-1';

REM: DELETE OPERATION ON VIEW Schedule_15
DELETE FROM Schedule_15 WHERE flight='HA-1';

SELECT * FROM Schedule_15;

SELECT * FROM fl_schedule WHERE flno='HA-1';
SELECT * FROM flights WHERE flightno='HA-1';

REM: 2. Define a view Airtype that display the number of aircrafts for each of its type. Label the
REM:    column as craft_type, total.

CREATE OR REPLACE VIEW Airtype AS
SELECT type craft_type, COUNT(*) AS total
FROM aircraft
GROUP BY type;

SELECT * FROM Airtype;

REM: INSERT OPERATION ON VIEW Airtype
INSERT INTO Airtype VALUES('NiveStar', 100);

REM: UPDATE OPERATION ON VIEW Airtype
UPDATE Airtype SET craft_type='NiveStar' WHERE total=1;

REM: DELETE OPERATION ON VIEW Airtype
DELETE FROM Airtype WHERE total=1;
DELETE FROM Airtype WHERE craft_type='Boeing';

REM: 3. Create a view Losangeles_Route that contains Los Angeles in the route. Ensure that the view
REM:    always contain/allows only information about the Los Angeles route.

CREATE OR REPLACE VIEW Losangeles_Route AS
SELECT * FROM routes
WHERE orig_airport='Los Angeles' OR dest_airport='Los Angeles' WITH CHECK OPTION;

SELECT * FROM Losangeles_Route;

REM: INSERT OPERATION ON VIEW Losangeles_Route
INSERT INTO Losangeles_Route VALUES('NIV-27', 'Tokyo', 'Seoul', 27900);
INSERT INTO Losangeles_Route VALUES('NIV-27', 'Los Angeles', 'Seoul', 27900);

SELECT * FROM Losangeles_Route;
SELECT * FROM routes;

REM: UPDATE OPERATION ON VIEW Losangeles_Route
SELECT * FROM Losangeles_Route;
SELECT * FROM routes;

UPDATE Losangeles_Route SET routeid='NIV-99' WHERE routeid='NIV-27';

SELECT * FROM Losangeles_Route;
SELECT * FROM routes;

REM: DELETE OPERATION ON VIEW Losangeles_Route
SELECT * FROM Losangeles_Route;
SELECT * FROM routes;

DELETE FROM Losangeles_Route WHERE routeid='NIV-99';

SELECT * FROM Losangeles_Route;
SELECT * FROM routes;

REM: 4. Create a view named Losangeles_Flight on Schedule_15 (as defined in 1) that display flight,
REM:    departure (date, time), arrival (date, time) of flight(s) from Los Angeles.

CREATE OR REPLACE VIEW Losangeles_Flight AS
SELECT flight, ddate, dtime, adate, atime AS arrival
FROM Schedule_15
WHERE from_airport='Los Angeles';

SELECT * FROM Losangeles_Flight;
SELECT * FROM Schedule_15;
SELECT * FROM fl_schedule WHERE flno='SQ-11';
SELECT * FROM flights WHERE flightno='SQ-11';

REM: INSERT OPERATION ON VIEW Losangeles_Flight
INSERT INTO Losangeles_Flight VALUES('SQ-11', '27-SEP-2020', 1850, '28-SEP-2020', 2100);

SELECT * FROM Losangeles_Flight;
SELECT * FROM Schedule_15;
SELECT * FROM fl_schedule WHERE flno='SQ-11';
SELECT * FROM flights WHERE flightno='SQ-11';

REM: UPDATE OPERATION ON VIEW Losangeles_Flight
SELECT * FROM Losangeles_Flight;
SELECT * FROM Schedule_15;
SELECT * FROM fl_schedule WHERE flno='SQ-11';
SELECT * FROM flights WHERE flightno='SQ-11';

UPDATE Losangeles_Flight SET dtime=1300 WHERE flight='SQ-11';

SELECT * FROM Losangeles_Flight;
SELECT * FROM Schedule_15;
SELECT * FROM fl_schedule WHERE flno='SQ-11';
SELECT * FROM flights WHERE flightno='SQ-11';

REM: DELETE OPERATION ON VIEW Losangeles_Flight
SELECT * FROM Losangeles_Flight;
SELECT * FROM Schedule_15;
SELECT * FROM fl_schedule WHERE flno='SQ-11';
SELECT * FROM flights WHERE flightno='SQ-11';

DELETE FROM Losangeles_Flight WHERE flight='SQ-11';

SELECT * FROM Losangeles_Flight;
SELECT * FROM Schedule_15;
SELECT * FROM fl_schedule WHERE flno='SQ-11';
SELECT * FROM flights WHERE flightno='SQ-11';