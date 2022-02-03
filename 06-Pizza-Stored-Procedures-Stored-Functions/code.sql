set echo on:
set serveroutput on format wrapped
-- To prevent dbms_output from trimming leading spaces 

@z:/Pizza_DB.sql

REM: ***************************************************************Ex6 - STORED PROCEDURES AND STORED FUNCTIONS***************************************************************
REM: PIZZA ORDERING SYSTEM


REM: Consider the following relations for Pizza Ordering System:
REM: CUSTOMER ( cust_id , cust_name, address, phone, cust_friend)
REM: PIZZA (pizza_id, pizza_type, unit_price)
REM: ORDERS (order_no, cust_id, order_date ,delv_date, total_amt, discount, bill_amt)
REM: ORDER_LIST (order_no, pizza_id, qty)

REM: Write a PL/SQL stored procedure / stored function for the following:
REM: Note:  
REM: a. Use implicit/explicit cursor wherever required. 
REM: b. Handle the error and display appropriate message if the data is non­available.
REM: c. Add necessary attributes to ORDERS. 

ALTER TABLE orders ADD total_amt NUMBER;
ALTER TABLE orders ADD discount NUMBER;
ALTER TABLE orders ADD bill_amt NUMBER;

REM: 1. Write a stored function to display the total number of pizza's ordered 
REM:    by the given  order number.

CREATE OR REPLACE FUNCTION total_pizza(ordernum orders.order_no%TYPE)
	RETURN NUMBER
AS
	tot_qty NUMBER;
BEGIN
	SELECT SUM(ol.qty)
	INTO tot_qty
	FROM orders o, customer c, pizza p, order_list ol 
	WHERE c.cust_id=o.cust_id 
	AND o.order_no=ol.order_no 
	AND ol.pizza_id=p.pizza_id
	AND o.order_no=ordernum;
	
	RETURN tot_qty;
END;
/

VAR tot NUMBER
EXECUTE :tot := total_pizza('OP100');
PRINT tot

REM: 2. Write a PL/SQL block to calculate the total amount, discount and billable amount
REM:	(Amount to be paid) as given below:
REM:	For total amount > 2000 and total amount < 5000:  Discount=5%  
REM:	For total amount > 5000 and total amount < 10000:  Discount=10%  
REM:	For total amount > 10000:  Discount=20%  
REM:	Calculate the billable amount (after the discount) and 
REM:	update the same in orders  table.
REM:	Bill Amount = Total – Discount.

SELECT * FROM orders;

CREATE OR REPLACE PROCEDURE calc_bill(ordernum orders.order_no%TYPE)
AS
	CURSOR c_orders(o_num orders.order_no%TYPE) 
	IS
		SELECT o.order_no, p.pizza_id, p.pizza_type, ol.qty, p.unit_price
		FROM orders o, pizza p, order_list ol 
		WHERE o.order_no=ol.order_no 
		AND ol.pizza_id=p.pizza_id
		AND o.order_no=o_num;
		
	r_orders orders%ROWTYPE;
		
BEGIN
	UPDATE orders SET total_amt=0 WHERE order_no=ordernum;

	FOR record IN c_orders(ordernum)
	LOOP
		IF record.qty IS NULL THEN
			record.qty := 0;
		END IF;
			
		UPDATE orders
		SET total_amt=total_amt+(record.qty * record.unit_price) 
  		WHERE order_no=ordernum; 
	END LOOP;

	SELECT *
	INTO r_orders
	FROM orders
	WHERE order_no=ordernum;
	
	IF r_orders.total_amt BETWEEN 2001 AND 4999 THEN
		UPDATE orders
		SET discount=5
		WHERE order_no=ordernum;
		
	ELSIF r_orders.total_amt BETWEEN 5001 AND 9999 THEN
		UPDATE orders
		SET discount=10
		WHERE order_no=ordernum;
		
	ELSIF r_orders.total_amt > 10000 THEN
		UPDATE orders
		SET discount=20
		WHERE order_no=ordernum;
		
	ELSE
		UPDATE orders
		SET discount=0
		WHERE order_no=ordernum;
	END IF;
	
	UPDATE orders
	SET bill_amt=total_amt-(discount*0.01*total_amt)
	WHERE order_no=ordernum;
			
END;
/

EXEC calc_bill('OP500');
SELECT * FROM orders;

REM: 3. For the given order number, 
REM: write a PL/SQL block to print the order as shown below:
REM: Hint: Use the PL/SQL blocks created in 1 and 2. 

REM: ************************************************************ 
REM: Order Number:OP104			Order Date :29­Jun­2015 
REM: Customer Name: Hari		Phone: 9001200031
REM: ************************************************************
REM: SNo	PizzaType	Qty	Price	Amount
REM: 1. 	Italian		6 	200 	1200
REM: 2. 	Spanish		5 	260 	1300 
REM: ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­ 
REM: Total =  		11 		2500 
REM: ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­ 
REM: Total Amount  :Rs.2500  
REM: Discount (5%) :Rs. 125 
REM: ­­­­­­­­­­­­­­­­­­­­­­­­­­ ­­­
REM: Amount to be paid :Rs.2375 
REM: ­­­­­­­­­­­­­­­­­­­­­­­­­­ ­­­
REM: Great Offers! Discount up to 25% on DIWALI Festival Day...
REM: *************************************************************

CREATE OR REPLACE PROCEDURE print_bill(ordernum orders.order_no%TYPE)
AS
	CURSOR c_orders(o_num orders.order_no%TYPE) 
	IS
		SELECT o.order_no, o.order_date, c.cust_name, c.phone, p.pizza_type, ol.qty, p.unit_price
		FROM orders o, pizza p, order_list ol, customer c 
		WHERE c.cust_id=o.cust_id 
		AND o.order_no=ol.order_no 
		AND ol.pizza_id=p.pizza_id
		AND o.order_no=ordernum;
		
	CURSOR c_cust_details(o_num orders.order_no%TYPE) 
	IS
		SELECT o.order_no, o.order_date, c.cust_name, c.phone
		FROM orders o, customer c 
		WHERE c.cust_id=o.cust_id 
		AND o.order_no=ordernum;
		
	r_orders c_orders%ROWTYPE;
	r_cust_details c_cust_details%ROWTYPE;
	r_table_order orders%ROWTYPE;
	counter NUMBER;
BEGIN

	OPEN c_cust_details(ordernum);
	LOOP
		FETCH c_cust_details INTO r_cust_details;
		EXIT WHEN c_cust_details%NOTFOUND;

		dbms_output.Put_line('************************************************************');
		dbms_output.Put_line('Order Number: '||r_cust_details.order_no||LPAD('Customer Name: ', 36)||r_cust_details.cust_name);
		dbms_output.Put_line('Order Date: '||r_cust_details.order_date||LPAD('Phone: ', 28)||r_cust_details.phone);
		dbms_output.Put_line('************************************************************');
		dbms_output.Put_line('SNo     Pizza Type     Qty   Price     Amount');
						
	END LOOP;
	CLOSE c_cust_details;

	counter := 0;

	OPEN c_orders(ordernum);
	LOOP
		FETCH c_orders INTO r_orders;
		EXIT WHEN c_orders%NOTFOUND;

		IF r_orders.qty IS NULL THEN
			CONTINUE;
		END IF;	
		
		counter:=counter+1;
		dbms_output.Put_line(RPAD(counter||'.', 3)||LPAD(r_orders.pizza_type, 15)||LPAD(r_orders.qty, 8)||LPAD(r_orders.unit_price, 8)||LPAD(r_orders.qty*r_orders.unit_price, 11));
	END LOOP;
	CLOSE c_orders;
	
	calc_bill(ordernum);
	
	SELECT * 
	INTO r_table_order
	FROM orders
	WHERE order_no=ordernum;
	
	dbms_output.Put_line('--------------------------------------------------');
	dbms_output.Put_line(LPAD('   ', 3)||LPAD('Total = ', 15)||LPAD(total_pizza(ordernum), 8)||LPAD('     ', 8)||LPAD(r_table_order.total_amt, 11));
	dbms_output.Put_line('--------------------------------------------------');
	dbms_output.Put_line('Total Amount      :Rs.'||r_table_order.total_amt);
	dbms_output.Put_line('Discount ('||r_table_order.discount||'%)     :Rs.'||r_table_order.total_amt*r_table_order.discount*0.01);
	dbms_output.Put_line('----------------------------------');
	dbms_output.Put_line('Amount to be paid :Rs.'||r_table_order.bill_amt);
	dbms_output.Put_line('----------------------------------');
	
	dbms_output.Put_line('Great Offers! Discount up to 25% on DIWALI Festival Day...');
	dbms_output.Put_line('************************************************************');	
	
END;
/

EXEC print_bill('OP500');


