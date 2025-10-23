
1)
SELECT *, ROW_NUMBER () OVER (ORDER BY SALEDATE) AS RowNum
FROM ProductSales

2)
SELECT  ProductName,
        SUM (Quantity) AS TotalSale,
		DENSE_RANK () OVER (ORDER BY SUM (Quantity) DESC) AS SaleRank
FROM ProductSales
GROUP BY ProductName

3)

;WITH

CTE AS
(
SELECT *,
		ROW_NUMBER () OVER (PARTITION BY CUSTOMERID ORDER BY SALEAMOUNT DESC) AS SaleByCust
FROM ProductSales
)
SELECT * FROM CTE
WHERE SaleByCust = 1


4)
SELECT * ,
       LEAD (SaleAmount,1,'0') OVER (ORDER BY SALEDATE ) AS NextValue
FROM ProductSales

5)
SELECT * ,
       LAG (SaleAmount,1,'0') OVER (ORDER BY SALEDATE ) AS PreveusValue
FROM ProductSales

6)

;WITH

CTE AS
(
SELECT * ,
       LAG (SaleAmount,1,'0') OVER (ORDER BY SALEDATE ) AS PreveusValue
FROM ProductSales
)
SELECT * FROM CTE
WHERE SaleAmount>PreveusValue

7)

;WITH

CTE AS
(
SELECT * ,
       LAG (SaleAmount,1,'0') OVER (ORDER BY SALEDATE ) AS PreveusValue
FROM ProductSales
)
SELECT * ,
        SaleAmount - PreveusValue AS Diff
FROM CTE

8)

;WITH

CTE_NEXT AS
(
SELECT * ,
       LEAD (SaleAmount,1) OVER (ORDER BY SALEDATE ) AS NextValue
FROM ProductSales
)

SELECT * ,
			CAST((NextValue-SaleAmount)*100.0/SaleAmount AS DECIMAL (10,2)) AS PercentChange
FROM CTE_NEXT


9)

;WITH 

CTE_PER AS
(
SELECT * ,
		LAG (SaleAmount,1) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) AS PerviusSaleAmount
FROM ProductSales
)

SELECT * ,
		CAST ( SaleAmount/PerviusSaleAmount AS DECIMAL (10,2)) AS RatioOfSale
FROM CTE_PER
WHERE PerviusSaleAmount IS NOT NULL;

10)

SELECT * FROM ProductSales



;WITH

CTE AS
(
		SELECT * ,
				ROW_NUMBER () OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) AS RN_BY_GROUP
		FROM ProductSales
),

SALE AS
(
		SELECT  ProductName,
				SaleAmount
		FROM CTE
		WHERE RN_BY_GROUP = 1
),

GROUP_CTE AS
(
		SELECT C.* ,
			   S.SaleAmount AS PreviousSale
		FROM CTE AS C
		JOIN SALE AS S
		ON C.ProductName=S.ProductName
)


SELECT * ,
		SaleAmount-PreviousSale AS DiffSale
FROM GROUP_CTE


11)


;WITH

CTE AS 
(
SELECT *,
		 LAG (SaleAmount,1) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) AS Previous
FROM ProductSales	
)

SELECT * FROM CTE
WHERE SaleAmount>Previous


12)

SELECT *,
       SUM(SaleAmount) OVER (ORDER BY SaleDate 
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ClosingBalance
FROM ProductSales;

13)
SELECT *,
        AVG(SaleAmount) OVER (
           ORDER BY SaleDate
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
      ) AS MovingAvg3
FROM ProductSales;


14)

SELECT *,
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;

15)

SELECT * ,
		DENSE_RANK() OVER (ORDER BY SALARY DESC)  AS DR
FROM Employees1

16)

;WITH

CTE AS 
(
SELECT * ,
		DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC)  AS DR_PRT
FROM Employees1
)
SELECT * FROM CTE
WHERE DR_PRT IN (1,2)

17)



;WITH

CTE AS 
(
SELECT * ,
		DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY )  AS DR_PRT
FROM Employees1
)
SELECT * FROM CTE AS T
WHERE DR_PRT = 1


18)

SELECT *,
         SUM (Salary) OVER (PARTITION BY DEPARTMENT 
							ORDER BY SALARY
							ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
							) AS RunningTotalSalary
FROM Employees1


19)



SELECT DISTINCT
       Department,
       SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees1;

20)

SELECT  DISTINCT
		Department,
		CAST (AVG (Salary) OVER (PARTITION BY DEPARTMENT)AS DECIMAL(10,2)) AS AVG_SALARY
FROM Employees1


21)


SELECT *,
       CAST(Salary - AVG(Salary) OVER(PARTITION BY Department) AS DECIMAL(10,2)) AS DIFF
FROM Employees1;


22)

SELECT * , CAST(
			AVG (Salary) OVER (ORDER BY EMPLOYEEID 
								ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
		                       ) AS DECIMAL (10,2)) MovingAvgSalary
FROM Employees1


23)

;WITH

CTE AS
(
SELECT *, 
			DENSE_RANK () OVER (ORDER BY HIREDATE DESC) HIRE_DATE
FROM Employees1
),

CTE_GRP AS
(
SELECT * FROM CTE
WHERE HIRE_DATE IN (1,2,3)
)

SELECT SUM (Salary) AS TotalS FROM CTE_GRP
