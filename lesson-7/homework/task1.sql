1)
SELECT MIN ( PRICE ) AS MIN_PRICE  FROM Products

2)
SELECT MAX ( SALARY) AS MAX_SALARY FROM Employees

3)
SELECT COUNT (*) AS NUMBER_OF_ROWS FROM Customers

4)
SELECT COUNT( DISTINCT CATEGORY ) AS CATEGORY FROM Products

5)

SELECT SUM (SALEAMOUNT) AS TOTAL_AMOUNT FROM SALES
WHERE PRODUCTID = 7 

6)
SELECT AVG ( AGE ) AS AVERAGE_AGE FROM Employees

7)
SELECT DepartmentName ,
                      COUNT ( EMPLOYEEID) AS TOTAL_EMPLOYEES
FROM EMPLOYEES
GROUP BY DepartmentName

8)
SELECT CATEGORY ,
                 MIN ( PRICE) AS MIN_PRICE,
				 MAX ( PRICE) AS MAX_PRICE
FROM Products
GROUP BY CATEGORY

9)
SELECT CUSTOMERID,
                  SUM ( SALEAMOUNT ) AS TOTAL_SALES
FROM Sales
GROUP BY CUSTOMERID

10)
SELECT DepartmentName ,
                     COUNT ( EMPLOYEEID ) AS TOTAL_EMPLOEES
FROM EMPLOYEES
GROUP BY DepartmentName
HAVING   COUNT ( EMPLOYEEID ) > 5





11)
SELECT ProductID,
                 SUM ( SaleAmount) AS TOTAL_AMOUNT,
				 AVG ( SaleAmount ) AS AVERAGE_AMOUNT
FROM Sales
GROUP BY ProductID

12)
SELECT DepartmentName ,
                     COUNT ( EMPLOYEEID ) AS TOTAL_EMPLOYEES
FROM Employees
WHERE DepartmentName = 'HR'
GROUP BY DepartmentName

13)
SELECT DepartmentName,
                      MAX ( SALARY ) AS HIGHEST_SALARY,
					  MIN ( SALARy ) AS LOWEST_SALARY
FROM Employees
GROUP BY DepartmentName


14)
SELECT DepartmentName,
                       AVG ( SALARY ) AS AVERAGE_SALARY
FROM Employees
GROUP BY DepartmentName

15)
SELECT DepartmentName,
                      AVG ( SALARY ) AS AVERAGE_SALARY,
					  COUNT( EMPLOYEEID) AS TOTTAL_EMPLOYEES
FROM Employees
GROUP BY DepartmentName 

16)
SELECT Category ,
                AVG ( PRICE ) AS AVERAGE_PRICE
FROM Products
GROUP BY Category
HAVING AVG ( PRICE ) > 400

17)
SELECT SALEDATE, 
                 SUM ( SALEAMOUNT ) AS TOTAL_SALE
FROM Sales
GROUP BY SaleDate 

18)
SELECT CustomerID, 
                 COUNT ( ORDERID ) AS TOTAL_ORDERS
FROM Orders
GROUP BY CustomerID
HAVING  COUNT ( ORDERID )>= 3

19)
SELECT DepartmentName,
                       AVG ( SALARY ) AS AVERAGE_SALARY
FROM Employees
GROUP BY DepartmentName
HAVING AVG ( SALARY ) > 60000





20)
SELECT Category ,
                AVG ( PRICE) AS AVERAGE_PRICE
FROM Products
GROUP BY Category
HAVING AVG ( PRICE) > 150

21)
SELECT CustomerID ,
                  SUM ( SALEAMOUNT ) AS TOTAL_SALE
FROM Sales
GROUP BY CustomerID
HAVING SUM ( SALEAMOUNT ) >1500

22)
SELECT DepartmentName,
                      SUM ( SALARY ) AS TOTAL_SALARY,
					  AVG ( SALARY ) AS AVERAGE_SALARY
FROM Employees
GROUP BY DepartmentName 
HAVING AVG ( SALARY ) > 65000

23)
SELECT * FROM TSQL2012.SALES.ORDERS
SELECT custid,
              COUNT ( ORDERID) AS TOTAL_ORDER,
			  MIN ( FREIGHT) AS MIN_FREIGHT
FROM TSQL2012.SALES.ORDERS
GROUP BY custid
HAVING SUM (freight) > 50

24)
SELECT
    YEAR(OrderDate) AS OrderYear,           
    MONTH(OrderDate) AS OrderMonth,         
    SUM(TotalAmount) AS TotalSales,          
    COUNT(DISTINCT ProductID) AS UniqueProductsSold  
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2      
ORDER BY OrderYear, OrderMonth;

25)
SELECT
    YEAR(OrderDate) AS OrderYear,     
    MIN(Quantity) AS MinQuantity,      
    MAX(Quantity) AS MaxQuantity      
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
