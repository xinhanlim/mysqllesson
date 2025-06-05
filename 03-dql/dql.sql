--https://www.mysqltutorial.org/tryit/
-- SELECT all the rows and all te columns from  a table
SELECT * FROM employees;

--SELECT ONLY AFFECT OUTPUT TABLE, DOESN't CHANGE THE ACTUALY RESULT.

-- to extract specific columns, we say SELECT <col1>, <col2> FROM <table_name>
SELECT firstName, lastName, email FROM employees;

--to show as First Name, Last Name, Email
SELECT firstName AS "First Name", lastName AS "Last Name", email AS "Email" FROM employees;

--FIND ALL EMPLOYESS WITH OFFICECODE 1
SELECT * FROM employees WHERE officeCode = 1;
SELECT firstName, lastName, email, officeCode FROM employees WHERE officeCode = 1;


--show cutomerName, contact lastname, contact firstname, phone and email for customer whose creit limit is above 10k
SELECT customerName, 
	contactFirstName, 
	contactLastName, 
	phone 
FROM customers 
WHERE creditLimit > 10000;

-- We want to ivite the entire sales department
--LIKE allows to match by a string pattern
--% is a wildcard, it means any characters
-- %Sales = ..... Sales, if Sales% = Sales ....., if %Sales% = .... Sales ....
SELECT * FROM employees WHERE jobTitle LIKE "%Sales%";

-- find all orders that have complaints and disputes
SELECT * FROM orders WHERE comments LIKE "%complaints%" OR "%dispute%"

--multiple 
SELECT * FROM employes WHERE jobTitle in ("sales Rep", "VP (Sales)")

-- OR
-- Find all customer from USA or with credit limit >10K
SELECT * From customers WHERE country= "USA" OR creditLimit > 10000;
-- if need find both condition TRUE
SELECT * From customers WHERE country= "USA" AND creditLimit > 10000;

--FIND ALL PRODUCTS that have more than 5000 units store and buy price is above 30
SELECT productName, quantityInStock, buyPrice FROM products WHERE quantityInStock > 5000 AND buyPrice > 30;

--Sorting in SQL is done by ORDER BY, ORDER BY is always at the end
-- by default Sorting is ascending order ( small to big )
SELECT productName, quantityInStock, buyPrice FROM products WHERE quantityInStock > 5000 AND buyPrice > 30 ORDER BY productName; 

-- TO sort by descending order DESC behind ORDER BY.
SELECT productName, quantityInStock, buyPrice 
FROM products 
WHERE quantityInStock > 5000 
AND buyPrice > 30 
ORDER BY quantityInStock DESC;

--LIMIT is to show the first N Result, will only have 3 rows because LIMIT 3
SELECT * FROM products ORDER BY buyPrice DESC LIMIT 3;

-- relative order of clauses
1. FROM/JOIN
2. WHERE
3. SELECT *
4. ORDER BY
5. LIMIT

--AND & OR, AND WILL EXECUTE FIRST

--Show all the customer from USA who has creditlimit >= 5K and from state of NV
--OR any customer any customer with credit limit >= 1k
-- USE () OR () so it don't affect the order of caluses
SELECT * FROM customers WHERE (country ="USA" AND state= "NV" AND creditLimit > 5000) OR (country!= "USA" creditLimit > 1000);


--JOIN TABLE office  and employess, JOIN allows us to combine two or more tabls as in one in a result table
-- JOIN always happens first, FROM & JOIN oncurrent happen.
SELECT * FROM employees JOIN offices
ON employees.officeCode = offices.officeCode;

--for each employee show their name ,find the phone number with extension
SELECT firstName, lastName, phone, extension FROM employees JOIN offices ON employees.officeCode = offices.officeCode;

--ORDER FOR THE EXAMPLE BELOW WHAT HAPPEN FIRST
1. FROM / JOIN ALWAYS HAPPEN FIRST
2. WHERE
-- GROUP BY IS HERE
-- HAVING IS HERE, HAVING IS DEPENADNT ON GROUPBY - COUNT GROUPS
3. SELECT SPECIFIC column
4. ORDER BY
5. LIMIT

-- select country USA, WHERE will happen on the JOIN table
-- USE back ticks for Alias;
SELECT * FROM employees JOIN offices ON employees.officeCode = offices.officeCode;
WHERE country = "USA"
ORDER BY firstName;

SELECT firstName AS `First Name`  FROM employees JOIN offices ON employees.officeCode = offices.officeCode;
WHERE country = "USA"
ORDER BY `First Name`;

--field is column
--connect 3 tables. 3-way joint
SELECT customerName, contactFirstName,contactLastName, creditLimit, customers.country, firstName,lastName, offices.country
FROM customers JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices
ON employees.officeCode = offices.officeCode
WHERE creditLimit > 20000;
ORDER BY creditLimit DESC LIMIT 10;

--COUNT
--ALL JOIN DEFAULT IS INNER JOIN
--INNER JOIN: THE LHS must find a match in the RHS for it to be in the results.
SELECT COUNT(*) FROM customers JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber;

--LEFT JOIN : ALL ROWS IN THE LHS TABLE WILL BE IN THE RESULTS (ORDER MATTERS)
SELECT * FROM customers LEFT JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber;

--RIGHT JOIN(IT'S LIKE LEFT JOIN, but all rows FROM THE RHS table)
-- FULL OTHER JOIN (LEFT + RIGHT JOIN) ->> NOT SUPPORTED MYSQL

-- show all the order number, status, order date, name of customer 
-- in the year 2004
SELECT orderNumber, status, orderDate, customerName
FROM orders JOIN customers
ON orders.customerNumber = customers.customerNumber
WHERE orderDate >= '2004-01-01'AND orderDate < '2005-01-01';

-- For each order, how many days does it need for it to be shipped
select orderNumber, shippedDate - orderDate from orders WHERE status='Shipped';

-- sever time
SELECT CURDATE();

--time now
SELECT NOW();

--SELECTING DAY/MM/YEAR
SELECT * FROM orders WHERE YEAR(orderDate) = '2004'

--aggregrate function ( summarise data in a way )
--Find all the unique countries that customer are from
--SELECT DISTINCT(<colName>) find all the unqie(non-duplicated) values for a colummn (not case-sensitive)
SELECT DISTINCT(country) FROM customers;

-- an aggreate function return from a single value from a table
SELECT AVG(creditLimit) FROM customers WHERE creditLimit > 0 ;

--COUNT (count how many customer are there)
SELECT COUNT(DISTINCT(country)) FROM customers;

--MIN ( min value from the table)
SELECT MIN(creditLimit) FROM customers WHERE creditLimit > 0;

--MAX (max value from table)
SELECT MAX(creditLimit) FROM customers;

--SUM ( add all values together)
SELECT SUM(creditLimit) FROM customers;

--GROUP BY break down into smaller groups always used with aggrevate function. (SUM,AVG,MIN,MAX)
--For each country find out how many customer there are.
--for a column, for each distinct value do some aggreation
--GROUP BY Happen WHERE
SELECT country, COUNT(*) FROM customers GROUP BY country;
--WRITE GROUPBY EASILY
--FOR each officeCode count how many employees there are.
-- per category - > need group by
SELECT ?, COUNT(*) FROM employees 
GROUP BY officeCode;

SELECT officeCode, COUNT(*) FROM employees 
GROUP BY officeCode;

-- HOW MANY orders per year was cancelled 
SELECT COUNT(*), YEAR(orderDate) FROM orders 
WHERE status="cancelled"
GROUP BY YEAR(orderDate);

-- find all countries which have at least 10 customers
-- HAVING IS TO COUNT THE GROUP BY
SELECT COUNT(*), country FROM customers
GROUP BY country 
HAVING COUNT(*) > 10;

-- find the top 10 sales person by their sale performance
SELECT SUM(amount) AS "Revenue", employeeNumber, firstName, lastName FROM employees 
JOIN customers 
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments 
ON customers.customerNumber = payments.customerNumber 
GROUP BY employeeNumber, firstName, lastName
ORDER BY `Revenue` DESC LIMIT 10;

-- find the top 3 sales person by their sale performance(ONLY FOR employees in the US)
SELECT SUM(amount) AS "Revenue", employeeNumber, firstName, lastName FROM employees 
JOIN customers 
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments 
ON customers.customerNumber = payments.customerNumber 
JOIN offices 
ON employees.officeCode = offices.officeCode
WHERE offices.country = "USA"
GROUP BY employeeNumber, firstName, lastName
HAVING COUNT(*) > 3
ORDER BY `Revenue` DESC LIMIT 3;

-- FIND THE BEST PERFORMING PRODUCT LINE IN THE YEAR 2023
-- CONSIDER ONLY SALES IN USA

SELECT SUM(quantityOrdered * priceEach) AS "Revenue" , productlines.productline FROM productlines
JOIN products ON productlines.productLine = products.productLine
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orders.orderNumber = orderdetails.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE country= "USA" AND YEAR(orderDate) = '2003'
GROUP BY productlines.productline
ORDER BY `Revenue` DESC LIMIT 3;