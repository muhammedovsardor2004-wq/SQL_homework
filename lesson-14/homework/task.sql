
1)

SELECT * FROM TestMultipleColumns

SELECT CHARINDEX (',', Name) FROM TestMultipleColumns
SELECT SUBSTRING (NAME, CHARINDEX (',', Name)+1, LEN (NAME) - CHARINDEX (',', Name) ) AS Surname FROM TestMultipleColumns


SELECT ID,
       LEFT (Name,CHARINDEX (',', Name)-1) AS Name,
       SUBSTRING (NAME, CHARINDEX (',', Name)+1, LEN (NAME) - CHARINDEX (',', Name) ) AS Surname
FROM TestMultipleColumns


2)
SELECT * FROM TestPercent
SELECT CHARINDEX ('%', Strs) FROM TestPercent


3)
SELECT * FROM Splitter

SELECT ID , value FROM Splitter CROSS APPLY string_split (Vals , '.')


4)
SELECT *FROM testDots
WHERE LEN (Vals) - LEN (REPLACE(Vals,'.','')) > 2


5)
SELECT * FROM CountSpaces
SELECT LEN (texts) - LEN (REPLACE (texts , ' ','') ) AS CountSpaces FROM CountSpaces

6)
SELECT E.Id,
       E.Name AS E_NAME,
	   E.Salary AS E_SALARY,
	   M.Id, 
	   M.Name AS M_NAME,
	   M.Salary AS M_SALARY
FROM Employee AS E
JOIN Employee AS M
ON E.ManagerId = M.Id
WHERE E.Salary > M.Salary

7)

SELECT EMPLOYEE_ID, 
        FIRST_NAME,
		LAST_NAME,
		HIRE_DATE , 
		DATEDIFF(YEAR , HIRE_DATE,GETDATE()) AS Years_of_Service 
FROM Employees
WHERE DATEDIFF(YEAR , HIRE_DATE,GETDATE()) > 10 AND
      DATEDIFF(YEAR , HIRE_DATE,GETDATE()) < 15

1)
SELECT T.*
FROM weather AS Y
JOIN weather AS T
ON DATEADD(DAY,1,Y.RecordDate) = T.RecordDate
WHERE T.Temperature> Y.Temperature

2)


SELECT player_id,event_date FROM Activity

SELECT F.*
FROM Activity AS F
JOIN Activity AS L
ON F.player_id = L.player_id
WHERE F.event_date < L.event_date

3)

SELECT * FROM fruits
SELECT 
       SUBSTRING(fruit_list,  CHARINDEX(',', fruit_list,CHARINDEX(',', fruit_list)+1)+1, 
	   CHARINDEX(',', fruit_list,CHARINDEX(',', fruit_list,CHARINDEX(',', fruit_list)+1)+1)-1 -
	   CHARINDEX(',', fruit_list,CHARINDEX(',', fruit_list)+1)
	   ) 
FROM fruits

4)
SELECT HIRE_DATE,
       CASE
	       WHEN DATEDIFF(YEAR, HIRE_DATE,GETDATE()) > 20               THEN 'Veteran'
		   WHEN DATEDIFF(YEAR, HIRE_DATE,GETDATE()) BETWEEN 10 AND 20  THEN 'Senior'
		   WHEN DATEDIFF(YEAR, HIRE_DATE,GETDATE()) BETWEEN  5 AND 10  THEN 'Mid-Level'
		   WHEN DATEDIFF(YEAR, HIRE_DATE,GETDATE()) BETWEEN  1 AND  5  THEN 'Junior'
           ELSE 'New Hire'
		   END AS Employment_Stage
FROM Employees
ORDER BY HIRE_DATE DESC


5)
SELECT LEFT (VALS,1) 
FROM GetIntegers
WHERE VALS LIKE '[0-9]%'


1)

SELECT 
    Id,
    CONCAT(
        PARSENAME(REPLACE(Vals, ',', '.'), 2), ',',  -- birinchi bo‘lak
        PARSENAME(REPLACE(Vals, ',', '.'), 3), ',',  -- ikkinchi bo‘lak
        PARSENAME(REPLACE(Vals, ',', '.'), 1)        -- qolgan bo‘lak
    ) AS SwappedVals
FROM MultipleVals;


2)
DECLARE @str NVARCHAR(100) = 'sdgfhsdgfhs@121313131';

;WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < LEN(@str)
)
SELECT SUBSTRING(@str, n, 1) AS Char
FROM Numbers
OPTION (MAXRECURSION 0);


3)

SELECT F.device_id
FROM Activity AS F
JOIN Activity AS L
ON F.player_id = L.player_id
WHERE F.event_date < L.event_date

4)

SELECT 'rtcfvty34redt'

DECLARE @str NVARCHAR(100) = 'rtcfvty34redt';

;WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < LEN(@str)
)
SELECT
    -- Harflar
    (SELECT STRING_AGG(SUBSTRING(@str, n, 1), '')
     FROM Numbers
     WHERE SUBSTRING(@str, n, 1) LIKE '[a-zA-Z]') AS Letters,

    -- Raqamlar
    (SELECT STRING_AGG(SUBSTRING(@str, n, 1), '')
     FROM Numbers
     WHERE SUBSTRING(@str, n, 1) LIKE '[0-9]') AS Numbers
OPTION (MAXRECURSION 0);

