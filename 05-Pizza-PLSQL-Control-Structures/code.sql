set echo on:
set serveroutput on

@z:/Pizza_DB.sql

REM: ***************************************************************Ex5 - PL/SQL-CONTROL STRUCTURES***************************************************************
REM: PIZZA ORDERING SYSTEM


REM: Consider the following relations for Pizza Ordering System:
REM: CUSTOMER ( cust_id , cust_name, address, phone, cust_friend)
REM: PIZZA (pizza_id, pizza_type, unit_price)
REM: ORDERS (order_no, cust_id, order_date ,delv_date, total_amt)
REM: ORDER_LIST (order_no, pizza_id, qty)


REM: Write a PL/SQL block for the following:
REM: Note: Use implicit/explicit cursor wherever required.

REM: 1. Check whether the given pizza type is available.
REM:    If not display appropriate message.

DECLARE
	pid pizza.pizza_id%TYPE;
	ptype pizza.pizza_type%TYPE;
	price pizza.unit_price%TYPE;
BEGIN
	ptype:=&pizzatype;
	SELECT pizza_id, pizza_type, unit_price INTO pid, ptype, price FROM pizza WHERE pizza_type=ptype;
	dbms_output.put_line('ID: ' ||pid||' Type: ' ||ptype||' Price: '||price);
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		dbms_output.put_line ('There is no pizza with the type '||ptype);
END;
/

REM: 2. For the given customer name and a range of order date,
REM:    find whether a customer had
REM:    placed any order, if so display the number of orders 
REM:    placed by the customer along
REM:    with the order number(s).

/*
SELECT c.cust_id, c.cust_name, o.order_no, o.order_date
FROM orders o, customer c
WHERE o.cust_id=c.cust_id
AND c.cust_name='Hari'
AND o.order_date BETWEEN TO_DATE('01-01-2015','dd-mm-yyyy') AND TO_DATE('01-10-2015','dd-mm-yyyy');
*/

DECLARE
	CURSOR c_orders(cname VARCHAR2, sdate DATE, edate DATE)
	IS
		SELECT o.order_no
		FROM orders o, customer c
		WHERE o.cust_id=c.cust_id
		AND c.cust_name=cname
		AND o.order_date BETWEEN sdate AND edate;	
	
	r_order c_orders%ROWTYPE;
	
	name customer.cust_name%TYPE;
	stdate orders.order_date%TYPE;
	endate orders.order_date%TYPE;
	
BEGIN
	name:=&name;
	stdate:=&stdate;
	endate:=&endate;
	
	OPEN c_orders(name, stdate, endate);
	LOOP
		FETCH c_orders INTO r_order;
		EXIT WHEN c_orders%NOTFOUND;
		
		dbms_output.put_line('Order Number: '||r_order.order_no);	
	END LOOP;
	
	dbms_output.put_line('Number of Orders Placed: '||c_orders%ROWCOUNT);
	CLOSE c_orders;
		
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		dbms_output.Put_line ('The customer '||name||' did not place any orders !');
END;
/

REM: 3. Display the customer name along with the details of pizza type
REM:    and its quantity ordered for the given order number.
REM:    Also find the total quantity ordered for the given
REM:    order number as shown below:

REM: SQL> /
REM: Enter value for oid: OP100
REM: old 11:	oid:='&oid';
REM: new 11:	oid:='OP100';
REM: Customer name: Hari
REM: Ordered Following Pizza
REM: PIZZA TYPE 	QTY
REM: Pan		3
REM: Grilled		2
REM: Italian		1
REM: Spanish		5
REM: -----------------------------------
REM: Total Qty: 11

/*
SELECT c.cust_name, p.pizza_type, ol.qty
FROM orders o, customer c, pizza p, order_list ol 
WHERE c.cust_id=o.cust_id 
AND o.order_no=ol.order_no 
AND ol.pizza_id=p.pizza_id
AND o.order_no='OP100';

SELECT SUM(ol.qty) as total_qty
FROM orders o, customer c, pizza p, order_list ol 
WHERE c.cust_id=o.cust_id 
AND o.order_no=ol.order_no 
AND ol.pizza_id=p.pizza_id
AND o.order_no='OP100';
*/

DECLARE
	CURSOR c1(ordernum VARCHAR2)
	IS
		SELECT c.cust_name, p.pizza_type, ol.qty
		FROM orders o, customer c, pizza p, order_list ol 
		WHERE c.cust_id=o.cust_id 
		AND o.order_no=ol.order_no 
		AND ol.pizza_id=p.pizza_id
		AND o.order_no=ordernum;	
	
	CURSOR c2(ordernum VARCHAR2)
	IS
		SELECT SUM(ol.qty) as total_qty
		FROM orders o, customer c, pizza p, order_list ol 
		WHERE c.cust_id=o.cust_id 
		AND o.order_no=ol.order_no 
		AND ol.pizza_id=p.pizza_id
		AND o.order_no=ordernum;	
	
	r_line1 c1%ROWTYPE;	
	r_line2 c2%ROWTYPE;
	ordernum orders.order_no%TYPE;
	
BEGIN
	ordernum:=&orderno;
	
	dbms_output.put_line('Ordered Following Pizza');
	dbms_output.put_line('PIZZA TYPE      QTY');
	
	OPEN c1(ordernum);
	LOOP
		FETCH c1 INTO r_line1;
		EXIT WHEN c1%NOTFOUND;
		
		dbms_output.Put_line (RPAD(r_line1.pizza_type, 10)||LPAD(r_line1.qty, 9));
	END LOOP;
	CLOSE c1;
	
	OPEN c2(ordernum);
	FETCH c2 INTO r_line2;
	dbms_output.put_line('------------------------');
	dbms_output.put_line('Total Qty: '||r_line2.total_qty);
	CLOSE c2;
		
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		dbms_output.Put_line ('INVALID order number !');
END;
/

REM: 4. Display the total number of orders that contains one pizza type,
REM: two pizza type and so on.

REM: Number of Orders that contains
REM: Only ONE Pizza type 8
REM: Two Pizza types	 3
REM: Three Pizza types	 2
REM: ALL Pizza types	 1

DECLARE
	typecount NUMBER;
	num NUMBER;
	no_ord NUMBER;
	CURSOR c4 IS
		SELECT COUNT(*) AS num
		FROM order_list
		GROUP BY order_no;
BEGIN
	SELECT COUNT(*) INTO typecount FROM PIZZA;
	DBMS_OUTPUT.PUT_LINE('Number of Orders that contains');
	FOR i in 1..typecount LOOP
		no_ord := 0;
		FOR x IN c4 LOOP
			IF i=x.num THEN
				no_ord := no_ord+1;
			END IF;
		END LOOP;
		
		IF i=typecount THEN
			DBMS_OUTPUT.PUT_LINE('All Pizza Types'|| CHR(9) || no_ord);
           	ELSE
           		DBMS_OUTPUT.PUT_LINE(i||' Pizza Types'|| CHR(9) || no_ord);
           	END IF;
	END LOOP;
END;
/





