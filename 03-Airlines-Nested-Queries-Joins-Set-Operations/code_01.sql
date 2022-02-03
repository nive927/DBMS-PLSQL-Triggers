
REM:****************************ADVANCED DML: Nested Queries, Joins, Set Operations****************************

REM:1. Display the flight number,departure date and time of a flight, its route details and aircraft
REM:   name of type either Schweizer or Piper that departs during 8.00 PM and 9.00 PM.

SELECT fs.flno, fs.departs, fs.dtime, r.routeid, r.orig_airport, r.dest_airport, r.distance, a.aname
FROM fl_schedule fs
JOIN flights f
ON(fs.flno = f.flightno)
JOIN routes r
ON(f.rid = r.routeid)
JOIN aircraft a
ON(f.aid = a.aid)
WHERE (a.type='Schweizer' OR a.type='Piper') AND fs.dtime BETWEEN 2000 AND 2100;

REM:2. For all the routes, display the flight number, origin and destination airport, if a flight is
REM:   assigned for that route.

SELECT f.flightno, r.orig_airport, r.dest_airport
FROM flights f
JOIN routes r
ON(f.rid = r.routeid);

REM:3. For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the
REM:   average salary of all pilots certified for this aircraft.

SELECT a.aname, AVG(salary)
FROM aircraft a
JOIN certified c
ON(a.aid = c.aid)
JOIN employee e
ON(e.eid = c.eid)
WHERE a.cruisingrange > 5000
GROUP BY a.aname;

REM: 4. Show the employee details such as id, name and salary who are not pilots and whose salary
REM:    is more than the average salary of pilots.

SELECT e.eid, e.ename, e.salary
FROM employee e
WHERE e.eid NOT IN
(SELECT eid FROM certified)
AND e.salary > (SELECT AVG(e.salary) FROM employee e JOIN certified c ON(c.eid = e.eid));

REM: 5. Find the id and name of pilots who were certified to operate some aircrafts but at least one
REM:    of that aircraft is not scheduled from any routes.

SELECT DISTINCT e.eid, e.ename
FROM employee e, certified c
WHERE e.eid=c.eid AND NOT EXISTS (SELECT * FROM flights f WHERE c.aid=f.aid);

REM: 6. Display the origin and destination of the flights having at least three departures with
REM:    maximum distance covered

SELECT DISTINCT(orig_airport), dest_airport 
FROM routes
JOIN flights 
ON (routeid=rid) 
WHERE distance = (SELECT MAX(distance) FROM routes HAVING COUNT(*) > 3);

REM: 7. Display name and salary of pilot whose salary is more than the average salary of any pilots
REM:    for each route other than flights originating from Madison airport.

SELECT distinct ename,salary
	FROM employee e
	JOIN certified c21
	USING(eid)
	JOIN flights f1
	USING(aid)
	JOIN routes r1
	ON(rid=routeid)
	WHERE salary > ( SELECT avg(salary) 
			FROM employee e2
			JOIN certified c2
			USING(eid)
			JOIN flights f2
			USING(aid)
			JOIN routes r2
			ON(rid=routeid)
			WHERE r2.routeid=r1.routeid)
	AND orig_airport<>'Madison';

REM: 8. Display the flight number, aircraft type, source and destination airport of the aircraft having
REM:    maximum number of flights to Honolulu.

SELECT fl.flno, a.type, r.orig_airport, r.dest_airport
FROM fl_schedule fl, aircraft a, flights f, routes r
WHERE a.aid=f.aid AND f.flightno=fl.flno AND f.rid=r.routeid
AND r.dest_airport='Honolulu';

REM: 9. Display the pilot(s) who are certified exclusively to pilot all aircraft in a type.

SELECT distinct eid, ename,type 
	FROM employee
	JOIN certified USING(eid)
	JOIN aircraft USING(aid)
	WHERE eid IN ( SELECT c.eid
			FROM certified c
			JOIN aircraft a USING(aid)
			WHERE c.eid IN ( SELECT c1.eid
					FROM certified c1
					JOIN aircraft a1 USING(aid)
					GROUP BY c1.eid
					HAVING(count(distinct a1.type))=1)
			GROUP BY c.eid,a.type
			HAVING count(*)=(SELECT COUNT (a1.aid) 
					FROM aircraft a1
					WHERE a1.type=a.type)
		  );

REM: 10. Name the employee(s) who is earning the maximum salary among the airport having
REM: maximum number of departures.

	SELECT eid,ename,salary
	FROM employee e
	WHERE salary = (SELECT max(salary)
		FROM employee
		JOIN certified c USING (eid)
		JOIN flights f USING (aid)
		JOIN routes r ON (rid=routeid)
		WHERE orig_airport = (SELECT orig_airport
				FROM routes r
				JOIN flights f ON (routeid=rid)
				GROUP BY orig_airport
				HAVING count(*) = (SELECT max(count(*))
						FROM routes r
						JOIN flights f ON (routeid=rid)
						GROUP BY orig_airport)));

REM: 11. Display the departure chart as follows:
REM:     flight number, departure(date,airport,time), destination airport, arrival time, aircraft name
REM:     for the flights from New York airport during 15 to 19th April 2005. Make sure that the route
REM:     contains at least two flights in the above specified condition.

SELECT flno, departs, orig_airport, dtime, dest_airport, atime, aname
FROM flights f
JOIN aircraft a
ON(f.aid = a.aid)
JOIN fl_schedule fl
ON(f.flightno = fl.flno)
JOIN routes r 
ON(r.routeid=f.rid)
WHERE orig_airport='New York'
AND departs BETWEEN TO_DATE('15-04-2005', 'dd-mm-yyyy') AND TO_DATE('19-04-2005', 'dd-mm-yyyy');

REM: Use SET operators (any one operator) for each of the following:

REM: 12. A customer wants to travel from Madison to New York with no more than two changes of
REM:     flight. List the flight numbers from Madison if the customer wants to arrive in New York by
REM:     6.50 p.m.

SELECT f.flightno 
FROM flights f
WHERE f.flightno
IN (( SELECT fl.flno
	FROM fl_schedule fl, flights f, routes r
	WHERE fl.flno = f.flightno AND f.rid = r.routeid
	AND r.orig_airport = 'Madison' AND r.dest_airport = 'New York' 
	AND fl.atime < 1850)
       UNION
     (SELECT fl1.flno
	FROM fl_schedule fl1, fl_schedule fl2, flights f, routes r1, routes r2 
	WHERE fl1.flno=f.flightno AND f.rid=r1.routeid
	AND r1.orig_airport = 'Madison'
	AND r1.dest_airport <> 'New York'
	AND r1.dest_airport = r2.orig_airport
	AND r2 .dest_airport = 'New York'
	AND fl2.dtime > fl1.atime
	AND fl2.atime < 1850 )
	UNION
     (SELECT fl1.flno
	FROM fl_schedule fl1, fl_schedule fl2, fl_schedule fl3, flights f, routes r1, routes r2, routes r3
	WHERE fl1.flno=f.flightno AND f.rid=r1.routeid
	AND r1.orig_airport = 'Madison'
	AND r1.dest_airport = r2.orig_airport
	AND r2.dest_airport = r3.orig_airport
	AND r3.dest_airport = 'New York'
	AND r1.dest_airport <> 'New York'
	AND r2.dest_airport <> 'New York'
	AND fl2.dtime > fl1.atime
	AND fl3.dtime > fl2.atime
	AND fl3.atime < 1850 ));

REM: 13. Display the id and name of employee(s) who are not pilots.

SELECT eid, ename FROM employee
MINUS
SELECT eid, ename FROM employee WHERE eid IN (SELECT eid FROM certified);

REM: 14. Display the id and name of employee(s) who pilots the aircraft from Los Angels and Detroit
REM:     airport.

SELECT e.eid, e.ename FROM employee e, certified c, aircraft a, flights f, routes r 
WHERE e.eid=c.eid AND c.aid = a.aid
AND a.aid = f.aid AND f.rid=r.routeid
AND r.orig_airport='Los Angeles'
INTERSECT
SELECT e.eid, e.ename FROM employee e, certified c, aircraft a, flights f, routes r 
WHERE e.eid=c.eid AND c.aid = a.aid
AND a.aid = f.aid AND f.rid=r.routeid
AND r.orig_airport='Detroit';