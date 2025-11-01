CREATE TABLE Dates (
    Id INT,
    Dt DATETIME
);
INSERT INTO Dates VALUES
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');



SELECT 
    Id,
    Dt,
	RIGHT('0'+ CAST (MONTH(DT) AS VARCHAR ),2) AS MonthPrefixedWithZero
FROM Dates;


2)
CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);


; WITH
CTE AS 
(
		SELECT  DISTINCT ID,
				  MAX (Vals) OVER (PARTITION BY ID ) AS MAX_VAL
		FROM MyTabel
),

TOTAL AS
(
		SELECT SUM (MAX_VAL) AS TotalOfMaxVals FROM CTE
),

ID AS 
(
		SELECT 
			   COUNT (DISTINCT Id) AS Distinct_Ids
		FROM MyTabel
),

RID AS 
(
		SELECT DISTINCT rID FROM MyTabel
)

SELECT * 
FROM ID AS I
CROSS JOIN RID AS R
CROSS JOIN TOTAL AS T


3)

CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');

;WITH 
CTE AS 
(
SELECT * ,
			CASE 
				WHEN LEN(Vals) BETWEEN 6 AND 10 THEN 1
				ELSE 0
				END AS LENG
FROM TestFixLengths
)

SELECT ID ,
       Vals
FROM CTE 
WHERE LENG = 1
 

4)

CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);


;WITH 
CTE AS 
(
SELECT ID,
		MAX (Vals) AS MAXX
FROM TestMaximum
GROUP BY ID
)
SELECT T.ID,
		T.Item,
		T.Vals
FROM CTE AS C
JOIN TestMaximum AS T
ON C.ID = T.ID AND C.MAXX=T.Vals
ORDER BY T.Item


5)

CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);


;WITH 
CTE AS
(
SELECT DetailedNumber,
      MAX (Vals) AS MAX_VAL
FROM SumOfMax

GROUP BY DetailedNumber
),

CTE2 AS
(
SELECT C.*,
       S.Id
FROM CTE AS C
JOIN SumOfMax AS S
ON C.DetailedNumber = S.DetailedNumber
    AND C.MAX_VAL=S.Vals
)

SELECT Id,
		SUM (MAX_VAL) AS SumofMax
FROM CTE2
GROUP BY Id


6)
CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

;WITH 
CTE AS 
(
SELECT *,
        CAST (a-b AS VARCHAR (90) ) AS OUTPUT	  
FROM TheZeroPuzzle
)

SELECT ID,
		A,
		B,
		CASE  
			WHEN OUTPUT = '0' THEN ''
			ELSE OUTPUT
			END AS AUTPUT
FROM CTE


DROP TABLE sales

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT,
);

INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID)
VALUES
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North', 1),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North', 2),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East', 3),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West', 4),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South', 5),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South', 6),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East', 7),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North', 8),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West', 9),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East', 10),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South', 1),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North', 2),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West', 3),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South', 4),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East', 5),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North', 6),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South', 7),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East', 8),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West', 9),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North', 10);


7)
SELECT SUM (QuantitySold*UnitPrice) AS TOTAL
FROM Sales

8)
SELECT AVG (UnitPrice) AS AVG_PRICE
FROM Sales

9)

SELECT COUNT (SaleID) AS SALES
FROM Sales

10)
SELECT MAX (QuantitySold) AS MAX_SOLD
FROM Sales


11)
SELECT Category,
		SUM(QuantitySold) AS TOTAL_SOLD
FROM Sales
GROUP BY Category

12)	
SELECT Region,
		SUM (QuantitySold*UnitPrice ) AS TOTAL
FROM Sales
GROUP BY Region

13)

;WITH 
CTE AS 
(
SELECT Product,
		QuantitySold*UnitPrice AS TOTAL
FROM Sales
)

SELECT * FROM CTE
WHERE TOTAL = (SELECT MAX(TOTAL) FROM CTE)



14)

;WITH
CTE AS
(
SELECT Category,
		QuantitySold*UnitPrice AS TOTAL
FROM Sales
)
SELECT Category,
       SUM (TOTAL) AS TOTAL
FROM CTE
GROUP BY Category




CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);

INSERT INTO Customers (CustomerName, Region, JoinDate)
VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');


17)

SELECT S.*
FROM Sales AS S
JOIN Customers AS  C
ON S.CustomerID=C.CustomerID


18)
SELECT C.* 
FROM Customers AS C
LEFT JOIN Sales AS S
ON C.CustomerID=S.CustomerID
WHERE S.CustomerID IS NULL

19)
SELECT * FROM Customers

;WITH
CTE AS
(
SELECT CustomerID,
		QuantitySold*UnitPrice AS TOTAL
FROM Sales
),

JOINC AS 
(
SELECT CustomerID,
		SUM(TOTAL) AS TOTAL_REVENUE
FROM CTE
GROUP BY CustomerID
)

SELECT C.*,
		J.TOTAL_REVENUE
FROM JOINC AS J
JOIN Customers AS C
ON J.CustomerID = C.CustomerID


20)
;WITH
CTE AS
(
SELECT CustomerID,
		QuantitySold*UnitPrice AS TOTAL
FROM Sales
),

JOINC AS 
(
SELECT CustomerID,
		SUM(TOTAL) AS TOTAL_REVENUE
FROM CTE
GROUP BY CustomerID
),

FINAL AS
(
SELECT C.*,
		J.TOTAL_REVENUE
FROM JOINC AS J
JOIN Customers AS C
ON J.CustomerID = C.CustomerID
)

SELECT * FROM FINAL
WHERE TOTAL_REVENUE = (SELECT MAX (TOTAL_REVENUE)_ FROM FINAL)


21)
SELECT CustomerID,
		COUNT (SaleID) AS TOTAL
FROM Sales
GROUP BY CustomerID



CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);
INSERT INTO Products (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);


22)

SELECT S.* 
FROM Products AS P
JOIN Sales AS S
ON P.ProductName =S.Product

23)
SELECT * FROM Products
WHERE CostPrice = (SELECT MAX(CostPrice) FROM Products)

24)
SELECT * FROM Products
WHERE SellingPrice > (SELECT AVG(SellingPrice) FROM Products)
