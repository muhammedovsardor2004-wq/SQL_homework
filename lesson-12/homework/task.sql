1)
SELECT P.firstName,
       P.lastName,
	   A.city,
	   A.state
FROM Person AS P
LEFT JOIN Address AS A
ON P.personId = A.personId


2)
SELECT E1.name AS EMP_NAME
FROM Employee AS E1
JOIN Employee AS E2
ON E1.managerId = E2.id
WHERE E1.salary > E2.salary


3)
TRUNCATE TABLE PERSON

INSERT INTO Person VALUES 
(1,'a@b.com'),
(2,'c@d.com'),
(3,'a@b.com')

SELECT * FROM Person

SELECT P1.EMAIL AS email
FROM Person AS P1
JOIN Person AS P2
ON P1.EMAIL = P2.EMAIL
WHERE P1.ID < P2.ID


4)
UPDATE PERSON 
SET EMAIL = 'john@example.com '
WHERE EMAIL  = 'a@b.com'

UPDATE PERSON 
SET EMAIL = 'bob@example.com'
WHERE EMAIL = 'c@d.com'

SELECT * FROM  Person 

SELECT P2.ID
FROM Person AS P1
JOIN Person AS P2
ON P1.EMAIL = P2.EMAIL
WHERE P1.ID < P2.ID

DELETE FROM PERSON
WHERE ID = 3


5)
SELECT DISTINCT G.ParentName
FROM girls AS G
LEFT JOIN boys AS B
ON G.ParentName = B.ParentName
WHERE B.Id IS NULL



6)
SELECT custid,
       SUM ( CASE
	         WHEN freight > 50  THEN freight 
			 ELSE 0
			 END ) AS TOTAL_FREIGHT,
	   MIN (freight)
FROM [TSQL2012].[Sales].[Orders]
GROUP BY custid
ORDER BY custid


7)

SELECT C1.Item AS [ Item Cart 1],
       C2.Item AS [ Item Cart 2]
FROM Cart1 AS C1
FULL JOIN Cart2 AS C2
ON C1.Item = C2.Item
ORDER BY C1.Item DESC


8)

SELECT C.name
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.id = O.customerId
WHERE O.id IS NULL


9)


-----ID---
SELECT * FROM Students



-----COMBINATION---

SELECT S.student_name,
       SUB.subject_name
FROM Students AS S
CROSS JOIN Subjects AS SUB



-----ATTENDANCES----

SELECT S.student_name,
       E.subject_name,
	   COUNT (S.student_id) AS attended_exams 
FROM Students AS S
JOIN Examinations AS E
ON S.student_id = E.student_id
GROUP BY S.student_name,
       E.subject_name



----COD---

SELECT S.student_id,
       COM.*,
	   ISNULL (ATT.attended_exams, 0) AS attended_exams
FROM Students AS S

JOIN
(
SELECT S.student_name,
       SUB.subject_name
FROM Students AS S
CROSS JOIN Subjects AS SUB
) AS COM
ON S.student_name = COM.student_name

LEFT JOIN
(
SELECT S.student_name,
       E.subject_name,
	   COUNT (S.student_id) AS attended_exams 
FROM Students AS S
JOIN Examinations AS E
ON S.student_id = E.student_id
GROUP BY S.student_name,
       E.subject_name
) AS ATT
ON COM.student_name = ATT.student_name AND COM.subject_name = ATT.subject_name

ORDER BY S.student_id,COM.subject_name

