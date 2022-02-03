@z:/Airlines_dataset/air_main.sql

rem: 1.Display the flight number,departure date and time of a flight, its 
--	route details and aircraft name of type either Schweizer or Piper 
--	 that departs during 8.00 PM and 9.00 PM.

	SELECT flno, departs, dtime,routeid,orig_airport,dest_airport,distance,aname
	FROM flights f 
	JOIN fl_schedule fs 
	ON (f.flightno=fs.flno) 
	JOIN routes r 
	ON (r.routeid=f.rid)
	JOIN aircraft a 
	ON(a.aid=f.aid)
	WHERE a.type IN ('Schweizer', 'Piper') and fs.dtime between 2000 and 2100;
-- -------------------------------------------------------------------------------------------------------------------------------

rem : 2.For all the routes, display the flight number, origin and destination airport,
--	 if a flight is assigned for that route.

	SELECT routeid,flightno,orig_airport,dest_airport
	FROM flights f 
	JOIN routes r
	ON(r.routeid=f.rid);

-- -------------------------------------------------------------------------------------------------------------------------------

rem : 3. For all aircraft with cruisingrange over 5,000 miles, find the name of the 
--	aircraft and the average salary of all pilots certified for this aircraft.

	SELECT aname, avg(salary)
	FROM aircraft a
	JOIN CERTIFIED c
	USING (aid)
	JOIN employee e
	USING(eid)
	WHERE cruisingrange > 5000
	GROUP BY aname;

-- -------------------------------------------------------------------------------------------------------------------------------

rem : 4.Show the employee details such as id, name and salary who are not pilots 
--	and whose salary is more than the average salary of pilots.


	SELECT e.eid, ename,salary
	FROM employee e
	WHERE e.eid NOT IN 
		(SELECT c.eid
		FROM certified c)
	AND salary >
		(SELECT avg(salary) 
		 FROM employee join certified USING(eid));

-- -------------------------------------------------------------------------------------------------------------------------------

rem: 5.Find the id and name of pilots who were certified to operate some aircrafts
--	 but at least one of that aircraft is not scheduled from any routes.

	SELECT distinct eid,ename
	FROM employee e
	JOIN certified c
	USING(eid)
	JOIN aircraft a
	USING(aid)
	WHERE aid NOT IN 
		(SELECT f.aid FROM flights f);

-- -------------------------------------------------------------------------------------------------------------------------------
	
rem: 6.Display the origin and destination of the flights having at least 
--	three departures with maximum distance covered.

	SELECT orig_airport, dest_airport
	FROM routes r1
	JOIN flights
	ON(rid=routeid)
	WHERE distance= (SELECT max(distance) 
			FROM routes)
	GROUP BY orig_airport, dest_airport
	HAVING count(*)>=3;

-- -------------------------------------------------------------------------------------------------------------------------------

rem: 7.Display name and salary of pilot whose salary is more than the
--	 average salary of any pilots for each route other than flights
--	 originating from Madison airport.

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

-- -------------------------------------------------------------------------------------------------------------------------------

rem: 8.Display the flight number, aircraft type, source and destination
--	 airport of the aircraft having maximum number of flights to Honolulu.

	SELECT flightno,type, orig_airport,dest_airport 
	FROM aircraft 
	JOIN flights USING(aid) 
	JOIN routes ON(routeid=rid) 
	WHERE aid= 
	    	(SELECT* FROM( 
		    SELECT aid
		    FROM aircraft 
		    JOIN flights USING(aid) 
		    JOIN routes ON(routeid=rid) 
		    WHERE dest_airport='Honolulu' 
		    GROUP BY aid, aname 
		    ORDER BY count(*) desc) 
		    WHERE rownum=1);

-- -------------------------------------------------------------------------------------------------------------------------------

rem: 9.Display the pilot(s) who are certified exclusively to pilot all aircraft in a type

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

-- -------------------------------------------------------------------------------------------------------------------------------
	
rem: 10. Name the employee(s) who is earning the maximum salary 
--	among the airport having maximum number of departures.

	
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

-- -------------------------------------------------------------------------------------------------------------------------------

rem: 11. Display the departure chart as follows:flight number, departure(date,airport,time),
--	 destination airport, arrival time, aircraft name for the flights from New York airport
--	 during 15 to 19th April 2005. 
--	Make sure that the route contains at least two flights in the above specified condition.

	SELECT flightno, departs, orig_airport, dtime, dest_airport, atime, aname
	FROM fl_schedule
	JOIN flights ON(flightno=flno)
	JOIN routes ON(routeid=rid)
	JOIN aircraft USING(aid)
	WHERE orig_airport='New York' AND ( departs BETWEEN '15-APR-05' AND '19-APR-05')
	AND  rid=(SELECT rid
		FROM fl_schedule
		JOIN flights ON(flightno=flno)
		JOIN routes ON(routeid=rid)
		WHERE orig_airport='New York' AND ( departs BETWEEN '15-APR-05' AND '19-APR-05')
		GROUP BY rid
		HAVING count(*) > =2);

-- -------------------------------------------------------------------------------------------------------------------------------

rem : 12. A customer wants to travel from Madison to New York with no more than two changes of flight. 
--	List the flight numbers from Madison if the customer wants to arrive in New York by 6.50 p.m.


	(
	SELECT distinct f.flightNo 
	FROM routes r
	JOIN flights f ON(r.routeid = f.rid) 
	JOIN fl_schedule fl ON(f.flightNo = fl.flno)
	WHERE r.orig_airport = 'Madison' AND
	r.dest_airport = 'New York' AND
	fl.atime <=1850
	)
	UNION
	(
	SELECT distinct f.flightNo 
	FROM 
	(routes r 
	JOIN flights f ON (r.routeid = f.rid) 
	JOIN fl_schedule fl ON(f.flightNo = fl.flno))
	JOIN 
	(routes rm
	JOIN flights fm ON (rm.routeid = fm.rid) 
	JOIN fl_schedule flm ON(fm.flightNo = flm.flno)
	) 
	ON (r.dest_airport = rm.orig_airport)
	WHERE r.orig_airport = 'Madison' AND
	rm.dest_airport = 'New York' AND
	fl.atime <= flm.dtime AND
	flm.atime <=1850
	)
	UNION
	(
	SELECT distinct f.flightNo 
	FROM 
	(
		(routes r join flights f ON (r.routeid = f.rid) 
		 JOIN fl_schedule fl ON(f.flightNo = fl.flno)
		)
		JOIN 
		(routes rm join flights fm ON (rm.routeid = fm.rid) 
		 JOIN fl_schedule flm ON(fm.flightNo = flm.flno)
		) 
		ON (r.dest_airport = rm.orig_airport)
	)
	JOIN 
	(
	  routes rm1 JOIN flights fm1 ON (rm1.routeid = fm1.rid) 
	  JOIN fl_schedule flm1 ON(fm1.flightNo = flm1.flno)
	) 
	ON (rm.dest_airport = rm1.orig_airport)
	WHERE r.orig_airport = 'Madison' AND
	rm1.dest_airport = 'New York' AND
	(fl.atime<=flm.dtime AND flm.atime<=flm1.dtime) AND 
	flm1.atime <=1850);

-- -------------------------------------------------------------------------------------------------------------------------------

rem : 13. Display the id and name  of employee(s) who are not pilots.

	SELECT e.eid,e.ename 
	FROM employee e
	WHERE e.eid IN
		(SELECT e1.eid FROM employee e1
		MINUS
		SELECT c.eid FROM certified c);	

-- -------------------------------------------------------------------------------------------------------------------------------

rem : 14. Display the id and name of employee(s) who pilots the aircraft 
--	from Los Angels and Detroit airport.

	(SELECT distinct eid,e.ename 
	FROM employee e 
	JOIN certified c USING (eid) 
	JOIN flights f USING (aid) 
	JOIN aircraft a USING (aid) 
	JOIN routes r on (r.routeID=f.rID) 
	WHERE 
	r.orig_airport='Los Angeles')
	INTERSECT
	(SELECT distinct eid,e.ename 
	FROM employee e JOIN certified c using (eid) 
	JOIN flights f USING (aid) 
	JOIN aircraft a USING (aid) 
	JOIN routes r on (r.routeID=f.rID) 
	WHERE r.orig_airport='Detroit');