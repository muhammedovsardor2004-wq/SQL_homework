
1)
;WITH numbers AS
(
SELECT 1 AS N
UNION ALL
SELECT N + 1 FROM numbers
WHERE N + 1 <= 1000
)
SELECT * FROM numbers 
OPTION (MAXRECURSION 1000);

2)
SELECT E.*,
       SA.TOTAL_SALES
FROM Employees AS E
JOIN
(
SELECT  EmployeeID,
        SUM (SalesAmount) AS TOTAL_SALES
FROM Sales
GROUP BY EmployeeID
) AS SA
ON E.EmployeeID = SA.EmployeeID


3)
SELECT * FROM Employees


;WITH AVERAGE AS 
(
SELECT * FROM Employees
)
SELECT AVG(Salary) AS AVG_SALARY FROM AVERAGE

4)
SELECT ProductID, 
       MAX(SalesAmount) AS MAX_SALES
FROM Sales
GROUP BY ProductID


SELECT P.* ,
      ISNULL( MS.MAX_SALES,0) AS MAX_SALES
FROM Products AS P
LEFT JOIN 
(
SELECT ProductID, 
       MAX(SalesAmount) AS MAX_SALES
FROM Sales
GROUP BY ProductID
) AS MS
ON P.ProductID = MS.ProductID;

5)
;WITH numbers AS 
(
SELECT 1 AS N
UNION ALL
SELECT N*2 FROM numbers
WHERE N*2 < 1000000
)
SELECT N FROM numbers

6)

;WITH  TOTAL AS
(
SELECT EmployeeID,
       COUNT (SalesID) AS TOTAL_SALES
FROM Sales
GROUP BY EmployeeID
)
SELECT E.EmployeeID,
       E.FirstName,
       T.TOTAL_SALES
FROM TOTAL AS T
JOIN Employees AS E
ON E.EmployeeID = T.EmployeeID	
WHERE T.TOTAL_SALES > 5


7)

;WITH MORE500 AS
(
SELECT * FROM Sales
WHERE SalesAmount > 500
)
SELECT P.*,
       M.SalesAmount
FROM MORE500 AS M
JOIN Products AS P
ON P.ProductID = M.ProductID


8)

;WITH EMP AS
(
SELECT * FROM Employees
),
AVERAGE AS 
(
SELECT AVG(Salary)AS AVGS FROM EMP
)
SELECT * FROM EMP
WHERE Salary > (SELECT AVG(Salary)AS AVGS FROM EMP)


----MEDIUM TASKS---

1)
SELECT  TOP 5
        S.TOTAL_SALE,
        E.*
FROM Employees AS E
JOIN 
(
SELECT EmployeeID,
       COUNT (SalesID) AS TOTAL_SALE
FROM Sales
GROUP BY EmployeeID
) AS S
ON E.EmployeeID = S.EmployeeID


2)

;WITH TOTAL AS
(
SELECT ProductID,
       SUM (SalesAmount) AS TOTAL_A
FROM Sales
GROUP BY ProductID
) 
SELECT P.CategoryID,
      ISNULL( SUM( T.TOTAL_A),0) AS TOTAL_A
FROM Products AS P
LEFT JOIN TOTAL AS T
ON T.ProductID = P.ProductID
GROUP BY P.CategoryID


3)
SELECT * FROM Numbers1

;WITH FactorialCTE AS (
    -- Anchor: har bir Number uchun i=1, fact=1
    SELECT
        Number AS n,
        1 AS i,
        CAST(1 AS BIGINT) AS fact
    FROM Numbers1

    UNION ALL

    -- Recursive: i ni oshirib, fact ni yangilab boramiz
    SELECT
        n,
        i + 1,
        fact * (i + 1)
    FROM FactorialCTE
    WHERE i < n
)
-- Oxirida faqat i = n bo'lgan qatordan natija olinadi
SELECT
    n AS Number,
    fact AS Factorial
FROM FactorialCTE
WHERE i = n
ORDER BY n
OPTION (MAXRECURSION 0);  -- 0 = cheksiz rekursiya (kichik n lar uchun xavfsiz)


4)
SELECT * FROM Example

;WITH SplitCTE AS
(
    -- 1️⃣ Anchor qismi: birinchi belgi (pozitsiya 1)
    SELECT 
        Id,
        SUBSTRING(String, 1, 1) AS Character,
        1 AS Position,
        LEN(String) AS TotalLength,
        String
    FROM Example

    UNION ALL

    -- 2️⃣ Recursive qismi: keyingi belgilarni olish
    SELECT 
        Id,
        SUBSTRING(String, Position + 1, 1) AS Character,
        Position + 1,
        TotalLength,
        String
    FROM SplitCTE
    WHERE Position + 1 <= TotalLength
)
-- 3️⃣ Yakuniy natija
SELECT 
    Id,
    Position,
    Character
FROM SplitCTE
ORDER BY Id, Position
OPTION (MAXRECURSION 0);


5)


SELECT * FROM Sales



; WITH 
 
 SALES_CTE AS 
(
      SELECT * FROM Sales
),


 MOTH_CTE AS
(
		SELECT SalesAmount,
			 MONTH(SaleDate) AS MONTHS 
		FROM SALES_CTE
),


 MIN_GROUP_CTE AS 
(
			SELECT MONTHS,
				   SUM(SalesAmount) AS MIN_TOTAL
			FROM MOTH_CTE
			WHERE MONTHS = (SELECT MIN(MONTHS) FROM MOTH_CTE)
			GROUP BY MONTHS
),


 MAX_GROUP_CTE AS
(
              SELECT MONTHS,
			  SUM(SalesAmount) AS MAX_TOTAL
			  FROM MOTH_CTE
			  WHERE MONTHS = (SELECT MAX(MONTHS) FROM MOTH_CTE)
			  GROUP BY MONTHS
)


SELECT 
      (MA.MAX_TOTAL - MI.MIN_TOTAL) AS DIFFERENCE
FROM MAX_GROUP_CTE AS MA
CROSS JOIN MIN_GROUP_CTE AS MI;


6)

SELECT a.EmployeeID,
       A.FirstName,
	   A.LastName,
	   Q.Quarters,
	   Q.TOTAL_SALE_Q
FROM Employees AS A
JOIN
(
SELECT EmployeeID,
       CASE 
		    WHEN MONTH (SaleDate) BETWEEN 1 AND 3 THEN 'Q1'
		    WHEN MONTH (SaleDate) BETWEEN 4 AND 6 THEN 'Q2'
		    WHEN MONTH (SaleDate) BETWEEN 7 AND 9 THEN 'Q3'
			ELSE 'Q4'
			END AS Quarters,
	   SUM (SalesAmount) AS TOTAL_SALE_Q
FROM Sales
GROUP BY EmployeeID,
         CASE 
		    WHEN MONTH (SaleDate) BETWEEN 1 AND 3 THEN 'Q1'
		    WHEN MONTH (SaleDate) BETWEEN 4 AND 6 THEN 'Q2'
		    WHEN MONTH (SaleDate) BETWEEN 7 AND 9 THEN 'Q3'
			ELSE 'Q4'
			END    
) AS Q
ON A.EmployeeID = Q.EmployeeID
WHERE Q.TOTAL_SALE_Q > 45000


1)

;WITH 

FIBO_CTE AS 
(
  SELECT NUMBERS AS N,
         1 AS I,
		 1 AS FIBO
  FROM NUM

  UNION ALL

  SELECT N,
         I+1,

  FROM FIBO_CTE

)


;WITH FibonacciCTE AS (
    SELECT
        0 AS n,           
        0 AS fib,         
        1 AS next_fib     

    UNION ALL

    
    SELECT
        n + 1,           
        next_fib,        
        fib + next_fib    
    FROM FibonacciCTE
    WHERE n < 10         
)

SELECT 
    n AS Position,
    fib AS Fibonacci_Number
FROM FibonacciCTE;


2)

SELECT ID,
       Vals
FROM FindSameCharacters
WHERE Vals IS NOT NULL AND
      LEN(Vals) > 1 AND
	  LEN (REPLACE (Vals, LEFT(VALS,1), '')) = 0


3)

; WITH
NUMBERS AS 
(
       SELECT 
	         1 AS N,
			 CAST ('1' AS VARCHAR (90) )AS NUM_STR

	   UNION ALL

	   SELECT      
	         N + 1,
			 CAST ( CONCAT (NUM_STR , CAST (N+1 AS VARCHAR (90))) AS VARCHAR (90))
	   FROM NUMBERS
	   WHERE N < 5
)
SELECT * FROM NUMBERS


4)
SELECT * FROM Employees
SELECT * FROM Sales


; WITH


  SALESS AS
(
SELECT * FROM Sales
),

  MAX_MONTH AS 
(
    SELECT MAX(SaleDate) AS MAX_M FROM SALESS
),
  
  LAST_6_M AS
(
   SELECT DATEADD(MONTH, -6 ,(SELECT * FROM MAX_MONTH)) AS MONTHS 
),

  ORDERS_LAST_6M AS
(
SELECT * FROM SALESS
WHERE SaleDate >= (SELECT MONTHS FROM LAST_6_M)
),

  GROUP_SALE AS
(
SELECT EmployeeID,
       SUM (SalesAmount) AS TOTAL_SALE
FROM ORDERS_LAST_6M
GROUP BY EmployeeID
)

SELECT E.EmployeeID,
       E.FirstName,
	   E.LastName,
       G.TOTAL_SALE
	  
FROM GROUP_SALE AS G
JOIN Employees AS E
ON G.EmployeeID = E.EmployeeID
ORDER BY G.TOTAL_SALE DESC



5)



; WITH 


CTE AS
(
		SELECT * , 
				 SUBSTRING (Pawan_slug_name,( PATINDEX('%[0-9]%',Pawan_slug_name)),LEN (Pawan_slug_name)) AS NUM
		
		FROM  RemoveDuplicateIntsFromNames
),


NULLL AS
(
			SELECT * ,
				   REPLACE (NUM, LEFT (NUM,1),'') AS NULL_COL
			FROM CTE
),


NUMBER AS
(
			SELECT * FROM NULLL
			WHERE NULL_COL NOT LIKE '%[0-9]%'
),


NEW_1 AS
(
			SELECT *,
				   LEFT  (Pawan_slug_name,  PATINDEX('%[0-9]%',Pawan_slug_name)-2) AS NEW1
			FROM NUMBER
),


NEW_NEW1 AS
(
			SELECT PawanName, NEW1 FROM NEW_1
),


NEW_NEW2 AS
(
				SELECT PawanName,
					   Pawan_slug_name
				FROM NULLL
				WHERE NULL_COL  LIKE '%[0-9]%'
)
SELECT * FROM NEW_NEW2
UNION ALL
SELECT * FROM NEW_NEW1
ORDER BY PawanName
