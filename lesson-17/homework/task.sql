
1)

; WITH 

CTE_REGION AS
(
	     SELECT * FROM #RegionSales
),

REGION AS
(
		SELECT DISTINCT Region FROM CTE_REGION
),

DISTRUBITOR AS 
(
		SELECT DISTINCT Distributor FROM CTE_REGION
),

CROSS_R_D AS
(
		SELECT * FROM REGION
		CROSS JOIN DISTRUBITOR
)


SELECT  C.Region,
        C.Distributor,
		ISNULL (CR.Sales,0) AS Sales
FROM CROSS_R_D AS C
LEFT JOIN CTE_REGION AS CR
ON C.Region = CR.Region AND C.Distributor = CR.Distributor


2)

;WITH 

GROUP_CTE AS
(
SELECT 
       M.name,
	   COUNT( EMP.id ) AS COUNT_id
FROM Employee AS EMP
JOIN Employee AS M
ON EMP.managerId = M.id
GROUP BY M.name
HAVING COUNT( EMP.id ) >= 5
)
SELECT name FROM GROUP_CTE



3)

SELECT P.product_name,
       O.unit
FROM Products AS P
JOIN
(
		SELECT product_id,
			   SUM (unit) AS unit
		FROM Orders
		WHERE order_date BETWEEN '2020-02-01' AND '2020-02-28'
		GROUP BY product_id
		HAVING   SUM (unit)>=100
) 
AS O
ON P.product_id = O.product_id


  
4)

SELECT OUTT.CustomerID,
       OUTT.Vendor
FROM Orders AS OUTT
WHERE Count = (SELECT MAX(Count)
               FROM Orders AS INS
			   WHERE OUTT.CustomerID=INS.CustomerID
			   )
ORDER BY OUTT.CustomerID


5)

DECLARE @Check_Prime INT = 91
DECLARE @I INT = 2
DECLARE @PRIME INT = 1

WHILE @I < @Check_Prime
BEGIN
      IF @Check_Prime % @I = 0
	  SET @PRIME = 0
	  SET @I= @I+1
END

SELECT @Check_Prime AS Number,
       CASE
	       WHEN @PRIME = 0 THEN 'This number is not prime'
		   WHEN @PRIME = 1 THEN 'This number is prime'
		   END AS Result


6)


;WITH 

CTE_DEVICE AS
(
		SELECT * FROM Device
		
),

COUNT_ID AS
(
		SELECT Device_id,
			   COUNT (DISTINCT Locations) AS no_of_location
		FROM CTE_DEVICE
		GROUP BY Device_id
) ,

SIGNALS AS 
(
		SELECT Device_id,
		       COUNT (Locations) AS no_of_signals 
		FROM CTE_DEVICE
		GROUP BY Device_id
),

LOCATIONS AS
(
		SELECT Device_id,
		       Locations ,
		       COUNT (Device_id) AS TOTAL_DEVICE
		FROM CTE_DEVICE
		GROUP BY Device_id, 
		         Locations
),

GROUP_LOCATIONS AS
(
		SELECT Device_id,
		       Locations
		FROM LOCATIONS AS OUTT
		WHERE TOTAL_DEVICE = (SELECT MAX(TOTAL_DEVICE)
							  FROM LOCATIONS AS INS
							  WHERE OUTT.Device_id = INS.Device_id
							  )

)
SELECT C.Device_id,
       C.no_of_location,
	   G.Locations,
	   S.no_of_signals
FROM COUNT_ID AS C
JOIN GROUP_LOCATIONS AS G
ON C.Device_id = G.Device_id
JOIN SIGNALS AS S
ON G.Device_id = S.Device_id




7)



		SELECT EmpID,
		       EmpName,
			   Salary
		FROM Employee AS OUTT
		WHERE Salary >=(  SELECT 
						 AVG(Salary) AS AVG_SALARY
						 FROM Employee AS INS
						 WHERE OUTT.DeptID = INS.DeptID
						 GROUP BY DeptID
						 )
		ORDER BY EmpID



;WITH 

NUMBER AS
(
		SELECT T.TicketID,
			  COUNT( N.Number) AS NumberS
		FROM Tickets AS T
		LEFT JOIN  Numbers AS N
		ON T.Number = N.Number
GROUP BY T.TicketID
)

SELECT TicketID ,
       CASE
	       WHEN NumberS = 3 THEN 100
		   WHEN NumberS = 2 THEN 10
		   ELSE 0
		   END AS Winnings
FROM NUMBER


9)
;WITH

MOBILE AS
(
SELECT Spend_date,
          Platform,
        SUM(Amount) AS Total_Amount,
		COUNT (DISTINCT User_id) AS	Total_users
FROM Spending
WHERE Platform = 'Mobile'
GROUP BY Spend_date,Platform
),

DISKTOP AS
(
SELECT Spend_date,
        Platform,
        SUM(Amount) AS Total_Amount,
		COUNT (DISTINCT User_id) AS	Total_users
FROM Spending
WHERE Platform = 'Desktop'
GROUP BY Spend_date ,Platform
),

BOTHH AS
(
SELECT Spend_date,
       'Both' AS  Platform,
        SUM(Amount) AS Total_Amount,
		COUNT (DISTINCT User_id) AS	Total_users
FROM Spending
GROUP BY Spend_date
)
SELECT * FROM MOBILE
UNION ALL
SELECT * FROM DISKTOP
UNION ALL
SELECT * FROM BOTHH
ORDER BY Spend_date



; WITH 

CTE AS
(
		SELECT Product,
		       Quantity,
			   1 AS N
		FROM Grouped

		UNION ALL

			SELECT Product,
		       Quantity,
			   N+1 AS N
		FROM CTE
		WHERE N+1<=Quantity
)

SELECT Product,
       1 AS Quantity
FROM CTE
ORDER BY Product
