

1)
SELECT E.Name,
	   E.Salary,
	    D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE E.Salary >50000

2)
SELECT C.FirstName,
       C.LastName,
	   O.OrderDate
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID
WHERE O.OrderDate BETWEEN '2023-01-01' AND '2023-12-31'

3)
SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
LEFT JOIN Departments AS D
ON E. DepartmentID = D.DepartmentID

4)
SELECT S.SupplierName,
       P.ProductName
FROM Suppliers AS S
LEFT JOIN Products AS P
ON S.SupplierID = P.SupplierID

5)
SELECT O.OrderID,
       O.OrderDate,
	   P.PaymentDate,
	   P.Amount
FROM Orders AS O
FULL JOIN Payments AS P
ON O.OrderID = P.OrderID


6)
SELECT E.Name AS EMP_MANE,
       M.Name AS MANAGER_NAME
FROM Employees AS E
JOIN Employees AS M
ON E.ManagerID = M.EmployeeID

7)
SELECT S.Name,
       C.CourseName
FROM Students AS S
JOIN Enrollments AS E
ON S.StudentID = E.StudentID

JOIN Courses AS C
ON E.CourseID = C.CourseID
WHERE C.CourseName = 'MATH 101'

8)
SELECT * FROM Customers
SELECT * FROM Orders

SELECT  C.FirstName,
       C.LastName,
	   O.Quantity
FROM Customers AS C
JOIN Orders AS O
ON C. CustomerID = O.CustomerID
WHERE O.Quantity >3


9)
SELECT * FROM Employees
SELECT * FROM Departments

SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources'

10)
SELECT * FROM Employees
SELECT * FROM Departments

SELECT D.DepartmentName,
       COUNT ( E.EMPLOYEEID) AS EmployeeCount
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT ( E.EMPLOYEEID)  > 5

11)
SELECT * FROM Products
SELECT * FROM Sales

SELECT P.ProductName,
       S.SaleID
FROM Products AS P
LEFT JOIN Sales AS S
ON P.ProductID = S.ProductID
WHERE S.SaleID IS NULL

12)
SELECT * FROM Customers
SELECT * FROM Orders

SELECT C.FirstName,
       C.LastName,
	   COUNT (O.OrderID) AS TotalOrders
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName

13)
SELECT * FROM Employees
SELECT * FROM Departments

SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
 JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID

14)
SELECT * FROM Employees

SELECT E1.Name,
       E2.Name
FROM Employees AS E1
JOIN Employees AS E2
ON E1.ManagerID = E2.ManagerID
AND E1.EmployeeID < E2.EmployeeID

15)
SELECT * FROM Orders
SELECT * FROM Customers

SELECT O.OrderID,
       O.OrderDate,
	   C.FirstName,
	   C.LastName
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID = C.CustomerID
WHERE O.OrderDate BETWEEN '2022-01-01' AND '2022-12-31'

16)
SELECT * FROM Employees
SELECT * FROM Departments

SELECT E.Name,
       E.Salary,
	   D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'SALES' AND E.Salary > 60000


17)
SELECT * FROM Orders
SELECT * FROM Payments

SELECT O.OrderID,
       O.OrderDate,
	   P.PaymentDate,
	   P.Amount
FROM Orders AS O
JOIN Payments AS P
ON O.OrderID = P.OrderID


18)
SELECT * FROM Products
SELECT * FROM Orders

SELECT P.ProductID,
       P.ProductName
FROM Products AS P
LEFT JOIN Orders AS O
ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL




19)
SELECT * FROM Employees


SELECT  DepartmentID,
        AVG ( SALARY ) AS SALARY
FROM Employees
GROUP BY DepartmentID 


SELECT
       E.Name,
       E.Salary
FROM Employees AS E

JOIN 

(SELECT  DepartmentID,
        AVG ( SALARY ) AS SALARY
FROM Employees
GROUP BY DepartmentID )   AS D

ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > D.SALARY

20)

SELECT * FROM Orders
SELECT * FROM Payments

SELECT O.OrderID,
       O.OrderDate
FROM Orders AS O
LEFT JOIN Payments AS P
ON O.OrderID = P.OrderID
WHERE O.OrderDate < '2022-01-01' AND O.OrderID IS NULL

21)
SELECT * FROM Products
SELECT * FROM Categories

SELECT P.ProductID,
       P.ProductName
FROM Products AS P
LEFT JOIN Categories AS C
ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL

22)
SELECT * FROM Employees

SELECT  E1.Name,
        E2.Name,
		E1.ManagerID,
		E1.Salary
FROM Employees AS E1
JOIN Employees AS E2
ON E1.ManagerID =E2.ManagerID
AND E1.EmployeeID < E2.EmployeeID
WHERE E1.Salary > 60000

23)
SELECT * FROM Employees
SELECT * FROM Departments

SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%'

24)
SELECT * FROM Products
SELECT * FROM Sales

SELECT S.SaleID,
       P.ProductName,
	   S.SaleAmount
FROM Products AS P
JOIN Sales AS S
ON P.ProductID = S.ProductID
WHERE S.SaleAmount > 500

25)

SELECT * FROM Students
SELECT * FROM Courses
SELECT * FROM Enrollments

SELECT  S.StudentID,
        S.Name
FROM Students AS S
LEFT JOIN Enrollments AS E
ON S.StudentID = E.StudentID

LEFT JOIN Courses AS C
ON E.CourseID = C.CourseID
WHERE C.CourseName != 'MATH 101'

26)

SELECT * FROM Orders
SELECT * FROM Payments

SELECT O.OrderID,
       O.OrderDate,
	   P.PaymentID
FROM Orders AS O
LEFT JOIN Payments AS P
ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL

27)
SELECT * FROM Products
SELECT * FROM Categories

SELECT P.ProductID,
       P.ProductName,
	   C.CategoryName
FROM Products AS P
JOIN Categories AS C
ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics' ,'Furniture')
