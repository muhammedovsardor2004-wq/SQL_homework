1)

;WITH
PRICE AS
(
SELECT S.ProductID,
       P.Price
       
FROM Sales AS S
JOIN  Products AS P
ON S.ProductID= P.ProductID
),

QUANTITTY AS
(
SELECT ProductID,
		COUNT (Quantity) AS TotalQuantity
FROM Sales
GROUP BY ProductID
),
RESULT AS
(
SELECT P.ProductID,
       Q.TotalQuantity,
	   Q.TotalQuantity*P.Price AS TotalRevenue
FROM PRICE AS P
JOIN QUANTITTY AS Q
ON P.ProductID=Q.ProductID
)
SELECT * INTO #MonthlySales FROM RESULT

SELECT * FROM #MonthlySales



2)

CREATE VIEW vw_ProductSalesSummary 
AS

SELECT P.ProductID,
       P.ProductName,
	   P.Category,
	   COUNT (S.Quantity) AS TotalQuantitySold
FROM Sales AS S
JOIN Products AS P
ON S.ProductID=P.ProductID
GROUP BY P.ProductID,
         P.ProductName,
	     P.Category

SELECT * FROM  vw_ProductSalesSummary

3)
SELECT * FROM Sales
SELECT * FROM Products


CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
       DECLARE @Total_Revenue DECIMAL (10,2)
	   SET  @Total_Revenue =(
							     SELECT
								 P.Price*COUNT (S.Quantity) AS Total_Revenue
								 FROM Sales AS S
								 JOIN Products AS P
								 ON S.ProductID=P.ProductID
								 WHERE P.ProductID = @ProductID
								 GROUP BY S.ProductID,
										   P.Price 
							 )
		RETURN @Total_Revenue
END
SELECT [dbo].[fn_GetTotalRevenueForProduct](1) AS Total_Revenue




4)
SELECT * FROM Sales
SELECT * FROM Products

CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE 
AS
 RETURN	
	    SELECT 
				P.ProductName,
			   COUNT (S.Quantity) AS TotalQuantity,
				P.Price*COUNT (S.Quantity) AS TotalRevenue

		FROM Sales AS S
		JOIN Products AS P
		ON S.ProductID=P.ProductID
		WHERE P.Category=@Category
		GROUP BY P.ProductID,
				 P.ProductName,
				  P.Price

SELECT * FROM [dbo].[fn_GetSalesByCategory] ('Electronics')



5)


CREATE FUNCTION fn_IsPrime (@Number INT)
RETURNS VARCHAR (90)
AS
BEGIN
       DECLARE @RESULT VARCHAR (90)
	   DECLARE @N INT =2
       DECLARE @MAX INT = 10

 WHILE @N<@MAX  
   BEGIN  
	     SET @RESULT = 
	                CASE 
					     WHEN @Number% (@N+1) = 0 THEN 'NO'
						 ELSE 'YES'
						 END
            SET @N=@N+1
	 END
	 RETURN @RESULT
END

SELECT [dbo].[fn_IsPrime] (1222) AS Result


6)

CREATE FUNCTION fn_GetNumbersBetween (@Start INT,@End INT)
RETURNS TABLE
AS
      RETURN 
			WITH 
			NUMBER AS
			(
			  SELECT @Start AS N

			  UNION ALL

			  SELECT N+1
			  FROM NUMBER
			  WHERE N < @End 
		    ) 
			
			SELECT * FROM NUMBER

SELECT * FROM [dbo].[fn_GetNumbersBetween](1,10)

DROP FUNCTION [dbo].[fn_GetNumbersBetween]


7)

CREATE TABLE Employee (ID INT,Salary INT)

INSERT INTO Employee VALUES 
(1,100),
(2,200),
(3,300)

CREATE FUNCTION dbo.getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @res INT;

    ;WITH DistinctSalaries AS
    (
        SELECT Salary,
               ROW_NUMBER() OVER (ORDER BY Salary DESC) AS rn
        FROM (SELECT DISTINCT Salary FROM Employee) AS t
    )
    SELECT @res = Salary
    FROM DistinctSalaries
    WHERE rn = @N;

    RETURN @res;
END;

8)
CREATE TABLE Friendship (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

INSERT INTO Friendship (requester_id, accepter_id, accept_date)
VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');


;WITH 

GROUP_CTE AS 
(
SELECT requester_id AS ID,
       COUNT (accepter_id)  AS num
FROM Friendship
GROUP BY requester_id

UNION  ALL

SELECT accepter_id AS ID,
       COUNT (requester_id) AS num 
FROM Friendship
GROUP BY accepter_id
),

MAX_CTE AS
(
SELECT ID,
       SUM (num) AS num
FROM GROUP_CTE
GROUP BY ID
)
SELECT ID,
      num
FROM MAX_CTE
WHERE NUM = (SELECT MAX(NUM) FROM MAX_CTE)


9)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);


9)

CREATE VIEW vw_CustomerOrderSummary
AS

WITH
CUSTUMER AS
(
SELECT C.customer_id,
      C.name,
	  COUNT (O.order_id) AS total_orders,
	  SUM (O.amount) AS total_amount
FROM Customers AS C
JOIN Orders AS O
ON C.customer_id = O.customer_id
GROUP BY C.customer_id,
         C.name 
),

DATE_CTE AS
(
SELECT customer_id,
       order_date 
FROM Orders AS OUTT
WHERE order_date =(SELECT MIN(order_date)
                   FROM Orders AS INS
				   WHERE OUTT.customer_id=INS.customer_id
					)
)
SELECT C.*,
       D.order_date AS last_order_date
FROM CUSTUMER AS C
JOIN DATE_CTE AS D
ON C.customer_id=D.customer_id

SELECT * FROM vw_CustomerOrderSummary


10)

DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL)

SELECT * FROM Gaps

SELECT 
    RowNumber,
    FIRST_VALUE(TestCase) OVER (
        PARTITION BY grp 
        ORDER BY RowNumber
    ) AS Workflow
FROM (
    SELECT *,
           COUNT(TestCase) OVER (ORDER BY RowNumber ROWS UNBOUNDED PRECEDING) AS grp
    FROM Gaps
) AS t;
