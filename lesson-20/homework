1)

IF EXISTS (SELECT 1 FROM #Sales
			WHERE SaleDate BETWEEN '2024-02-01' AND '2024-02-28')

SELECT * FROM #Sales
WHERE SaleDate BETWEEN '2024-02-01' AND '2024-02-28' 

2)



SELECT   Product,
         SUM (Quantity*Price) AS TOTAL
FROM #Sales 
GROUP BY Product
HAVING SUM (Quantity*Price) = ( SELECT MAX (TOTAL)
								FROM ( SELECT  
										 SUM (Quantity*Price) AS TOTAL
								         FROM #Sales
										 GROUP BY Product
									  ) AS SUPQUREY
										
								)

OFFSET 1 ROW FETCH NEXT 1 ROW ONLY
3)

SELECT Product,
       SUM(Quantity*Price) AS TOTAL
FROM #Sales
GROUP BY Product
HAVING  SUM(Quantity*Price)= 
						    ( SELECT TOTAL
                               FROM
							   ( SELECT Product,
									   SUM(Quantity*Price) AS TOTAL
								FROM #Sales
								GROUP BY Product
								ORDER BY TOTAL DESC
								OFFSET 1 ROW FETCH NEXT 1 ROW ONLY
							   ) AS SAB
							)


4)


SELECT  
      MONTH(SaleDate) AS Sale_Month,
	  SUM (Quantity) AS TOTAL_SALE
FROM #Sales AS OUTT
GROUP BY MONTH(SaleDate)
    



5)
SELECT * FROM #Sales


SELECT 
	OUTT.CustomerName,
	OUTT.Product
FROM #Sales OUTT
WHERE EXISTS 
			(
			 SELECT * FROM #Sales INS
			 WHERE OUTT.Product=INS.Product AND
			 OUTT.CustomerName<>INS.CustomerName
			)
ORDER BY OUTT.Product,OUTT.CustomerName


6)
create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')



;WITH

APLE AS
(
		SELECT NAME,
			  COUNT (Fruit) AS Apple
		FROM Fruits
		WHERE Fruit='Apple'
		GROUP BY Name
),

BANAN AS
(
		SELECT NAME,
			  COUNT (Fruit) AS Banana
		FROM Fruits
		WHERE Fruit='Banana'
		GROUP BY Name
),

ORANG AS
(
		SELECT NAME,
			  COUNT (Fruit) AS Orange
		FROM Fruits
		WHERE Fruit='Orange'
		GROUP BY Name
)

SELECT A.Name,
		A.Apple,
		O.Orange,
		B.Banana
FROM APLE AS A
JOIN BANAN AS B
ON A.Name = B.Name
JOIN ORANG AS O
ON B.Name=O.Name



SELECT Name,
			SUM (CASE
					WHEN Fruit = 'Apple' THEN 1
					ELSE 0
					END ) AS Apple,

			SUM (CASE
			         WHEN Fruit = 'Orange' THEN 1
					 ELSE 0
					 END ) AS Orange,
			    
			SUM (CASE
			         WHEN Fruit = 'Banana' THEN 1
					 ELSE 0
					 END ) AS Banana 
					 
FROM Fruits
GROUP BY Name


7)

create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

SELECT * FROM Family



;WITH

FAMILY_CTE  AS
(
		SELECT ParentId,
		       ChildID
		FROM Family

		UNION ALL

		SELECT F.ParentId,
		       C.ChildID
		FROM Family AS F
		JOIN FAMILY_CTE AS C
		ON F.ChildID = C.ParentId
)
SELECT * FROM FAMILY_CTE
ORDER BY ParentId



CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);



SELECT * FROM #Orders
WHERE DeliveryState = 'TX' AND
      CustomerID IN (SELECT DISTINCT CustomerID
					FROM #Orders
					WHERE DeliveryState = 'CA')


9)
SELECT * FROM #residents

UPDATE #residents 
SET fullname = SUBSTRING(address,   CHARINDEX('NAME=',address)+LEN('NAME='),    CHARINDEX('AGE=',address)-CHARINDEX('NAME=',address)-LEN('NAME=')     )
WHERE fullname IS NULL OR fullname = ''



UPDATE #residents
SET address = address + 'name='+fullname
WHERE address NOT LIKE '%name=%'




10)
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

SELECT * FROM #Routes

;WITH

ROUT_CTE AS
(
  SELECT *
  FROM #Routes

  UNION ALL

  SELECT *
  FROM #Routes AS R
  JOIN ROUT_CTE AS C
  ON R.ArrivalCity=C.DepartureCity
  
)
SELECT * FROM ROUT_CTE



;WITH

ROUTS AS 
(
SELECT BIR.DepartureCity,
       BIR.ArrivalCity AS BIR,
	   BIR.Cost AS  BIR_COST,
	   IKKI.ArrivalCity AS IKKI,
	   IKKI.Cost AS IKKI_COST,
	   UCH.ArrivalCity AS UCH,
	   UCH.Cost AS UCH_COST,
	   TURT.ArrivalCity AS TURT,
	   TURT.Cost AS TURT_COST
FROM #Routes AS BIR
JOIN #Routes AS IKKI
ON BIR.ArrivalCity = IKKI.DepartureCity

LEFT JOIN #Routes AS UCH
ON IKKI.ArrivalCity=UCH.DepartureCity

LEFT JOIN #Routes AS TURT
ON UCH.ArrivalCity= TURT.DepartureCity
),

GROUP_CTE AS
(
SELECT CONCAT_WS(' - ',DepartureCity,BIR,IKKI,UCH,TURT) AS Route,
       BIR_COST + IKKI_COST + ISNULL (UCH_COST,0) + ISNULL (TURT_COST,0) AS Cost
FROM ROUTS
WHERE DepartureCity= 'Tashkent'
AND ('Khorezm' IN (BIR, IKKI, UCH, TURT)) 
)

SELECT * FROM GROUP_CTE
WHERE Cost = (
				SELECT MIN(Cost) FROM GROUP_CTE
              )

UNION ALL

SELECT * FROM GROUP_CTE
WHERE Cost = (
				SELECT MAX(Cost) FROM GROUP_CTE
              )

	CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

SELECT * FROM #RankingPuzzle
;WITH CTE AS
(
    SELECT 
        ID,
        Vals,
        -- Har safar 'Product' chiqsa, yangi guruh boshlanganini belgilaymiz
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
            OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductGroup
    FROM #RankingPuzzle
)
SELECT 
    ProductGroup AS ProductRank,
    Vals
FROM CTE
WHERE Vals <> 'Product'
ORDER BY ProductGroup, ID;

12)
CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);


12)

SELECT * FROM #EmployeeSales AS OUT
WHERE SalesAmount > (SELECT AVG(SalesAmount)
					 FROM #EmployeeSales AS INS
					 WHERE OUT.Department=INS.Department)



13)


SELECT * FROM #EmployeeSales AS BIR
WHERE EXISTS ( SELECT 1 FROM #EmployeeSales AS IKKI
               WHERE BIR.SalesMonth = IKKI.SalesMonth
			   AND IKKI.SalesAmount = (SELECT MAX(SalesAmount) FROM #EmployeeSales AS UCH
										WHERE IKKI.SalesMonth=UCH.SalesMonth
										)
			   AND BIR.EmployeeID = IKKI.EmployeeID
			 )


14)

CREATE TABLE ProductsS (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO ProductsS (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);



SELECT E.EmployeeID
FROM #EmployeeSales AS E
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth FROM #EmployeeSales) AS M
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales AS S
        WHERE S.EmployeeID = E.EmployeeID
          AND S.SalesMonth = M.SalesMonth
    )
)



15)

SELECT * FROM ProductsS 
WHERE Price > ( SELECT AVG(Price)
				FROM ProductsS 
				)


16)
SELECT * FROM ProductsS 
WHERE Stock < (SELECT MAX(Stock) FROM ProductsS)

17)
SELECT * FROM ProductsS
WHERE Category = (SELECT Category
				  FROM ProductsS
				  WHERE Name='Laptop')


18)
SELECT * FROM ProductsS
WHERE Price > (SELECT MIN(Price)
				FROM ProductsS
				WHERE Category = 'Electronics')


19)
SELECT * FROM ProductsS AS T
WHERE Price > (SELECT AVG(Price) 
				FROM ProductsS AS I
				WHERE T.Category=I.Category)


CREATE TABLE OrdersS (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
);

INSERT INTO OrdersS (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');

SELECT * FROM OrdersS


20)

SELECT * 
FROM ProductsS AS P
JOIN OrdersS AS O
ON P.ProductID = O.ProductID


21)

SELECT P.Name
FROM ProductsS AS P
JOIN OrdersS AS O
ON P.ProductID = O.ProductID
WHERE Quantity > (SELECT AVG(Quantity) FROM OrdersS )


22)
SELECT *
FROM ProductsS AS P
LEFT JOIN OrdersS AS O
ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL

23)



SELECT *
FROM ProductsS AS P
JOIN OrdersS AS O
ON P.ProductID = O.ProductID
WHERE Quantity = (SELECT MAX(Quantity) FROM OrdersS)
