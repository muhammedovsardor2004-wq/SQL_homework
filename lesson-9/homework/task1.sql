



1)
SELECT Products.ProductName, Suppliers.SupplierName FROM Products CROSS JOIN Suppliers

2)
SELECT DepartmentNAME, NAME FROM Departments CROSS JOIN Employees

3)
SELECT  SupplierNAME , PRODUCTNAME FROM Products AS P   JOIN Suppliers AS S
                                                        ON P.SupplierID = S.SupplierID
ORDER BY SupplierName

4)
SELECT FirstName , OrderID FROM Customers AS C JOIN Orders AS O
                                               ON C.CustomerID=O.CustomerID 

5)
SELECT Name , CourseName FROM Students CROSS JOIN Courses

6)
SELECT P.ProductName, O.OrderID FROM Products AS P JOIN Orders AS O 
                                                   ON P.ProductID = O.ProductID

7)
SELECT E.Name FROM Employees AS E JOIN Departments AS D
                             ON E.DepartmentID = D.DepartmentID

8)
SELECT S.Name,E.EnrollmentID FROM Students AS S JOIN Enrollments  AS E
                                                ON S.StudentID= E.StudentID

9)
SELECT O.OrderID FROM Payments AS P JOIN Orders AS O
                                    ON P.OrderID = O.OrderID
10)
SELECT * FROM Orders AS O JOIN Products AS P
                           ON P.ProductID = O.ProductID
WHERE Price > 100

11)
SELECT A.Name , D.DepartmentName  FROM Employees AS A CROSS JOIN Departments AS D
WHERE A.DepartmentID <> D.DepartmentID




12)
SELECT * FROM Orders AS O JOIN Products AS P 
                     ON O.Quantity > P.StockQuantity

13)
SELECT C.FirstName, S.ProductID FROM Customers AS C JOIN Sales AS S
                             ON C. CustomerID = S.CustomerID
WHERE S.SaleAmount >=500

14)
SELECT S.Name, C.CourseName FROM Students AS S
                            JOIN Enrollments AS E
                            ON S.StudentID = E.StudentID
							JOIN Courses AS C
							ON E.CourseID = C.CourseID

15)
SELECT S.SupplierName,
       P.ProductName 
FROM Products AS P  JOIN Suppliers AS S
ON P.SupplierID = S. SupplierID
WHERE S.SupplierName LIKE '%TECH%'

16)
SELECT * 
 FROM Orders AS O JOIN Payments AS P
 ON P.Amount < O.TotalAmount

 17)
SELECT D.DepartmentName,
       A.Name
FROM Employees AS A JOIN Departments AS D
ON A.DepartmentID = D.DepartmentID
ORDER BY D.DepartmentName


18)
SELECT C.CategoryName,
       P.ProductName
FROM Products AS P JOIN Categories AS C
ON P.Category = C.CategoryID
WHERE C.CategoryName = 'Electronics' OR C.CategoryName = 'Furniture'
ORDER BY C.CategoryName

19)
SELECT S.* , 
       C.Country
FROM Sales AS S JOIN Customers AS C
ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA'

20)
SELECT O.*,
       C.Country
FROM Orders AS O JOIN Customers AS C 
ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' and O.TotalAmount > 100



21)



SELECT  E1.Name,
        E2.Name
FROM Employees E1
JOIN Employees E2
ON E1.DepartmentID < E2.DepartmentID


22)
SELECT P.*
FROM Payments AS P
JOIN Orders AS O
ON P.OrderID = O.OrderID
JOIN Products AS PR
ON O.ProductID = PR.ProductID
WHERE P.Amount <> (O.Quantity*PR.Price)

23)
SELECT S.Name,
       C.CourseName
FROM Students AS S
LEFT JOIN Enrollments AS EN
ON S.StudentID = EN.StudentID
LEFT JOIN Courses AS C
ON EN.CourseID = C.CourseID
WHERE C.CourseName IS NULL

24)

SELECT E.Name AS EMPLOYEES,
       M.Name AS MANAGERS
FROM Employees AS E
 JOIN Employees AS M
ON E.ManagerID = M.EmployeeID
WHERE E.Salary >= M.Salary

25)


SELECT C.CustomerID,
       C.FirstName,
	   C.LastName,
	   C.Phone,
	   O.OrderID,
	   P.PaymentID
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID

LEFT JOIN Payments AS P
ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL
