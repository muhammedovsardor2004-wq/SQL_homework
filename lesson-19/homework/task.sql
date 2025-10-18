1)

CREATE PROC sp_GetEmployeeBonuses 
AS 
BEGIN
       SELECT * INTO #EmployeeBonus 
	   FROM 
	       (
		 SELECT A.EmployeeID,
				   CONCAT_WS (' ',FirstName, LastName) AS FullName,
				   D.Department,
				   A.Salary,
				   CAST ( A.Salary*D.BonusPercentage/100 AS DECIMAL (10,2) )AS BonusAmount
			FROM Employees AS A
			JOIN DepartmentBonus AS D
			ON A.Department = D.Department
		  ) AS TEMP

		  SELECT * FROM #EmployeeBonus

END;

EXEC sp_GetEmployeeBonuses


2)

SELECT * FROM Employees
SELECT * FROM DepartmentBonus


CREATE PROC sp_INCREAS_BY_PERCENT @PERCENT INT
AS
BEGIN 
      SELECT EmployeeID,
	         FirstName,
			 LastName,
			 Department,
			 CAST( Salary + Salary*@PERCENT/100 AS DECIMAL (10,2)) AS TotalAmount
	  FROM Employees
END


EXEC sp_INCREAS_BY_PERCENT 10



3)

MERGE Products_Current AS TARGET
USING Products_New     AS SOURCE
ON TARGET.ProductID = SOURCE.ProductID

WHEN MATCHED THEN 
     UPDATE
	 SET ProductName = SOURCE.ProductName,
	     Price       = SOURCE.Price

WHEN NOT MATCHED BY TARGET THEN 
     INSERT 
	 VALUES (SOURCE.ProductID,SOURCE.ProductName,SOURCE.Price)

WHEN NOT MATCHED BY SOURCE THEN
     DELETE ;


SELECT * FROM Products_Current
SELECT * FROM Products_New


4)

; WITH 

PARENT AS
(
		SELECT ID,
			   COUNT (p_id) AS PARENT
		FROM Tree
		GROUP BY ID
),

CHILD AS 
(
		SELECT p_id,
			   COUNT (ID) AS CHILD
		FROM Tree
		GROUP BY p_id
),

GROUP_CTE AS
(
		SELECT P.*,
		       CH.CHILD
		FROM PARENT AS P
		LEFT JOIN CHILD AS CH
		ON P.id = CH.p_id
)


SELECT ID,
        CASE 
		    WHEN PARENT = 0 THEN 'Root'
			WHEN CHILD IS NOT NULL THEN 'Inner'
			ELSE 'Leaf'
        END AS type
FROM GROUP_CTE


5)

;WITH

GROUP_CTE AS
(
		SELECT user_id,
			  time_stamp,
			   CASE
				  WHEN action = 'timeout' THEN 0
				  ELSE 1
				  END AS ACTION_LEVEL
		FROM Confirmations
),

GURUH AS
(
		SELECT user_id,
			   COUNT (time_stamp) AS time_stamp,
			   SUM (ACTION_LEVEL) AS ACTION_LEVEL   
		FROM GROUP_CTE
		GROUP BY user_id
),

TAYYOR AS
(
		SELECT user_id,
			   CAST (1.00*ACTION_LEVEL/time_stamp AS DECIMAL (10,2)) AS confirmation_rate
		FROM GURUH
)

SELECT S.user_id,
       ISNULL (T.confirmation_rate,0.00) AS confirmation_rate
FROM Signups AS S
LEFT JOIN TAYYOR AS T
ON S.user_id = T.user_id

6)
SELECT * FROM employees0
WHERE salary = (SELECT MIN (salary) 
                FROM employees0
                 )

7)

CREATE PROC GetProductSalesSummary @ProductID INT
AS

BEGIN

;WITH	

QUATITY AS
(
		SELECT ProductID,
			   SUM (Quantity) AS TOTAL_QUANTITY
		FROM Sales
		GROUP BY ProductID
),

FIRST_SALE AS
(
		SELECT ProductID,
			   SaleDate AS First_Sale_Date
		FROM Sales AS OUTT
		WHERE SaleDate = ( SELECT MIN (SaleDate)
							FROM Sales AS INS
							WHERE OUTT.ProductID=INS.ProductID
						 )
),

LAST_SALE AS
(
		SELECT ProductID,
			   SaleDate AS Last_Sale_Date
		FROM Sales AS OUTT
		WHERE SaleDate = ( SELECT MAX (SaleDate)
							FROM Sales AS INS
							WHERE OUTT.ProductID=INS.ProductID
						 )
),

TOTAL AS
(
		SELECT Q.ProductID,
			   Q.TOTAL_QUANTITY AS Total_Quantity_Sold,
			   F.First_Sale_Date,
			   L.Last_Sale_Date
		FROM QUATITY AS Q
		JOIN FIRST_SALE AS F
		ON Q.ProductID=F.ProductID
		JOIN LAST_SALE AS L
		ON F.ProductID=L.ProductID
)


SELECT P.ProductName,
      T.Total_Quantity_Sold,
	  P.Price*T.Total_Quantity_Sold AS Total_Sales_Amount,
	  T.First_Sale_Date,
	  T.Last_Sale_Date
FROM ProductsS AS P
LEFT JOIN TOTAL AS T
ON P.ProductID = T.ProductID
WHERE P.ProductID = @ProductID

END

EXEC GetProductSalesSummary 9



