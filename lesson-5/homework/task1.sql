1)

SELECT ProductName AS Name  FROM  Products 

2)
SELECT *FROM  Customers AS Client

3)
SELECT ProductName FROM  Products 
UNION
SELECT ProductName FROM  Products_Discounted 

4)
SELECT * FROM  Products 
INTERSECT
SELECT * FROM  Products_Discounted 

5)
SELECT DISTINCT FirstName, LastName, Country FROM  Customers  

6)
SELECT Price, CASE 
WHEN Price > 1000 THEN 'High'
WHEN Price <= 1000 THEN 'Low'
END AS Price_level
FROM  Products 

7)
SELECT StockQuantity,
IIF (StockQuantity > 100,'YES', 'NO') AS StockQuantity_level
FROM  Products_Discounted 


8)
SELECT ProductName FROM  Products 
UNION
SELECT ProductName FROM  Products_Discounted 

9)
SELECT * FROM  Products 
EXCEPT
SELECT * FROM  Products_Discounted 

10)
SELECT Price,
IIF (Price>1000, 'Expensive', 'Affordable') as Price_level
FROM  Products 

11)
SELECT * FROM Employees
WHERE Age<25 OR Salary>60

12)

 UPDATE  Employees
 SET Salary= Salary*1.10
WHERE DepartmentName='HR' OR EmployeeID = 5

13)
SELECT SaleAmount ,
CASE 
WHEN SaleAmount>500 THEN 'Top_tier'
WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid_Tier'
ELSE 'Low_Tier'
END AS SaleAmount_LEVEL
FROM  Sales 

14)
  
SELECT CustomerID FROM  Orders
EXCEPT
SELECT CustomerID FROM  Sales 


15)
SELECT CustomerID, Quantity,
CASE 
WHEN Quantity=1 THEN 0.03 
WHEN Quantity BETWEEN 1 AND 3 THEN 0.05
ELSE 0.07
END AS Discount_percentage
FROM  Orders
