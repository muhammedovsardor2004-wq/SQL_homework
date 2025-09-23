1)
SELECT O.* ,
       C.FirstName,
	   C.LastName
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID = C.CustomerID
WHERE O.OrderDate > '2022-12-31'

2)
SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'SALES' OR D.DepartmentName = 'MARKETING'
ORDER BY D.DepartmentName


3)
SELECT D.DepartmentName,
       MAX ( SALARY ) AS MAXSALARY
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName


4)
SELECT C.FirstName,
       C.LastName,
	   O.OrderID,
	   O.OrderDate
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID
WHERE C.Country = 'USA' AND O.OrderDate BETWEEN '2023-01-01' AND '2023-12-31'


5)
SELECT C.FirstName,
       C.LastName,
	   COUNT ( O.OrderID ) AS TOTAL_ORDERS
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID =C.CustomerID
GROUP BY C.FirstName , C.LastName


6)
SELECT P.ProductName,
       S.SupplierName
FROM Products AS P
JOIN Suppliers AS S
ON P.SupplierID = S.SupplierID
WHERE S.SupplierName = 'Gadget Supplies' OR S.SupplierName = 'Clothing Mart'
ORDER BY S.SupplierName


7)
SELECT C.FirstName,
       C.LastName,
	   MAX ( O.OrderDate ) AS MostRecentOrderDate
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID 
GROUP BY C.FirstName , C.LastName


8)
SELECT C.FirstName,
       C.LastName,
	   SUM ( O.TotalAmount) AS ORDER_TOTAL
FROM Orders AS O
JOIN Customers AS C
ON O.CustomerID = C.CustomerID 
GROUP BY C.FirstName,  C.LastName
HAVING  SUM ( O.TotalAmount) > 500

9)
SELECT P.ProductName,
       S.SaleDate,
	   S.SaleAmount
FROM Products AS P
JOIN Sales AS S
ON P.ProductID = S.ProductID
WHERE S.SaleDate BETWEEN '2022-01-01'AND '2022-12-31' OR S.SaleAmount > 400


10)
SELECT P.ProductName,
       SUM (S.SaleAmount) AS TotalSalesAmount
FROM Sales AS S
JOIN Products AS P
ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSalesAmount DESC


11)
SELECT E.Name,
       D.DepartmentName ,
	   E.Salary
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID 
WHERE D.DepartmentName = 'HR' AND E.Salary > 60000


12)
SELECT P.ProductName,
       S.SaleDate ,
	   P.StockQuantity
FROM Products AS P
JOIN Sales AS S
ON P.ProductID = S.ProductID
WHERE S.SaleDate BETWEEN '2023-01-01' AND '2023-12-31' AND P.StockQuantity > 100


13)
SELECT E.Name,
       D.DepartmentName,
	   E.HireDate
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'SALES' OR E.HireDate > '2023-12-31'


14)
SELECT  C.FirstName,
        C.LastName,
		O.OrderID,
		O.OrderDate,
		C.Address,
		O.OrderDate
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID 
WHERE C.Country = 'USA' AND C.Address LIKE  '[0-9][0-9][0-9][0-9]%'

15)
SELECT * FROM Categories

SELECT P.ProductName,
       P.Category,
	   S.SaleAmount
FROM Products AS P
JOIN Sales AS S
ON P.ProductID = S.ProductID
WHERE P.Category = 1 OR S.SaleAmount > 350


16)
SELECT C.CategoryName,
       COUNT ( P.ProductID) AS ProductCount
FROM Products AS P
JOIN Categories AS C
ON P.Category = C.CategoryID
GROUP BY C.CategoryName


17)
SELECT C.FirstName,
       C.LastName,
	   C.City,
	   O.OrderID,
	   O.TotalAmount
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O. CustomerID
WHERE C.City = 'LOS ANGELES' AND O.TotalAmount > 300

18)
SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ( 'Human Resources', 'FINANCE' ) 
OR D.DepartmentName LIKE '%[AEIOU]%[AEIOU]%[AEIOU]%[AEIOU]%'


19)
SELECT E.Name,
       D.DepartmentName,
	   E.Salary
FROM Employees AS E
JOIN Departments AS D
ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 60000 AND D.DepartmentName IN ( 'SALES', 'MARKETING' ) 
