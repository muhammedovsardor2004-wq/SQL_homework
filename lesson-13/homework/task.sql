
1)
SELECT CONCAT (EMPLOYEE_ID, '-' ,FIRST_NAME, ' ', LAST_NAME) AS EMPLOYEE FROM Employees

2)
SELECT REPLACE (PHONE_NUMBER , 124,999) AS NEW_PHONE_NUMBER FROM Employees

3)
SELECT FIRST_NAME , LEN(FIRST_NAME) AS LEN_FIRST_NAME FROM Employees
WHERE FIRST_NAME LIKE '[AJM]%'
ORDER BY FIRST_NAME

4)
SELECT MANAGER_ID , 
       SUM (SALARY) AS TOTAL_SALRY 
FROM Employees
GROUP BY MANAGER_ID

5)

SELECT Year1,
CASE 
    WHEN Max1 > Max2 AND Max1 > Max3 THEN Max1
	WHEN Max2 > Max1 AND Max2 > Max3 THEN Max2
	WHEN Max3 > Max1 AND Max3 > MAX1 THEN Max3
	END AS HighestValue
FROM TestMax

6)
SELECT * FROM cinema
WHERE ID % 2 = 1 AND description NOT LIKE 'boring'

7)
SELECT Id, Vals FROM SingleOrder
ORDER BY 
CASE
    WHEN ID= 0 THEN 999999 
	ELSE Id
	END 

8)
SELECT ID,
COALESCE( SSN,PASSPORTID,ITIN) AS FirstNonNullValue
FROM person


9)

 SELECT 
LEFT(
          FullName,
          CHARINDEX (' ',FullName)-1
) AS Firstname,


SUBSTRING(
          FullName,
          CHARINDEX(' ',FullName) + 1,
          CHARINDEX(' ',FullName,CHARINDEX(' ',FullName) + 1) - CHARINDEX (' ',FullName)-1
) AS Middlename,


SUBSTRING(
          FullName,
          CHARINDEX(' ',FullName,CHARINDEX(' ',FullName)+1) +1,
          LEN(FullName)
 ) AS Lastname
 FROM Students

 

 10)

 SELECT * FROM Orders

 SELECT * FROM Orders
 WHERE DeliveryState = 'CA'

 SELECT * FROM Orders
 WHERE DeliveryState = 'TX'


 SELECT T.CustomerID,
        T.OrderID,
		T.DeliveryState,
		T.Amount
 FROM 
 (
  SELECT * FROM Orders
 WHERE DeliveryState = 'CA'
 ) AS C

 JOIN
 (
 SELECT * FROM Orders
 WHERE DeliveryState = 'TX'
 ) AS T
 ON C.CustomerID = T.CustomerID

 11)

SELECT STRING_AGG(String, ' ') WITHIN GROUP (ORDER BY SequenceNumber) AS FullQuery
FROM DMLTable;

12)
SELECT CONCAT_WS(' ', FIRST_NAME,LAST_NAME) AS FULL_NAME FROM Employees
WHERE CONCAT_WS(' ', FIRST_NAME,LAST_NAME) LIKE '%a%a%a%'

13)
SELECT * FROM Employees


SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS total_employees,
    SUM(CASE 
            WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 
            THEN 1 ELSE 0 
        END) AS employees_over_3_years,
    CAST(
        (SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 
                  THEN 1 ELSE 0 END) * 100.0) / COUNT(*) 
        AS DECIMAL(5,2)
    ) AS percentage_over_3_years
FROM Employees
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

14)

SELECT
  StudentID,
  FullName,
  Grade,
  ROUND(SUM(Grade) OVER (ORDER BY StudentID), 2) AS RunningTotal
FROM Students
ORDER BY StudentID;


15)

SELECT N.StudentName,
       B.StudentName,
	   B.Birthday
FROM Student AS N
JOIN 
Student AS B
ON N.Birthday = B.Birthday
WHERE N.StudentName > B.StudentName


16)
SELECT * FROM PlayerScores

---CROSS BUGAN QISMINI OLDIM ---
SELECT A.PlayerA,
       B.PlayerB
FROM PlayerScores AS A
CROSS JOIN 
PlayerScores AS B
WHERE A.PlayerA <> B.PlayerB


---A DAGILARNI SCORLARI ----
SELECT PlayerA,
       Score
FROM PlayerScores


---B DAGILARNI SCORLARI----
SELECT PlayerB,
       Score
FROM PlayerScores



---3 TA TBALENII ULAYMAN----
SELECT * FROM PlayerScores

SELECT C.PlayerA,
       C.PlayerB,
	   SUM( A.Score + B.Score) AS TOTAL_SCORE
FROM
(
SELECT A.PlayerA,
       B.PlayerB
FROM PlayerScores AS A
CROSS JOIN 
PlayerScores AS B
) AS C

JOIN 
(
SELECT PlayerA,
       Score
FROM PlayerScores
) AS A
ON C.PlayerA = A.PlayerA

JOIN 
(
SELECT PlayerB,
       Score
FROM PlayerScores
) AS B
ON C.PlayerB = B.PlayerB

GROUP BY C.PlayerA,
         C.PlayerB


17)

CREATE PROCEDURE dbo.SplitString_WHILE
    @input_str VARCHAR(8000)  
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @len INT = LEN(@input_str);
    DECLARE @ch CHAR(1);
    DECLARE @code INT;

    DECLARE @uppercase VARCHAR(8000) = '';
    DECLARE @lowercase VARCHAR(8000) = '';
    DECLARE @numbers VARCHAR(8000)   = '';
    DECLARE @other VARCHAR(8000)     = '';

    WHILE @i <= @len
    BEGIN
        SET @ch = SUBSTRING(@input_str, @i, 1);
        SET @code = ASCII(@ch); -- ASCII kodi (faqat ASCII belgilar uchun ishonchli)

        IF @code BETWEEN 65 AND 90       -- A..Z
            SET @uppercase = @uppercase + @ch;
        ELSE IF @code BETWEEN 97 AND 122 -- a..z
            SET @lowercase = @lowercase + @ch;
        ELSE IF @code BETWEEN 48 AND 57  -- 0..9
            SET @numbers = @numbers + @ch;
        ELSE
            SET @other = @other + @ch;

        SET @i = @i + 1;
    END

    SELECT
        @input_str    AS original_string,
        @uppercase    AS uppercase_letters,
        @lowercase    AS lowercase_letters,
        @numbers      AS numbers,
        @other        AS other_chars;
END
GO
EXEC dbo.SplitString_WHILE 'tf56sd#%OqH';
