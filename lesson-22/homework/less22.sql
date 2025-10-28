
1)

SELECT *,
        SUM (total_amount) OVER (PARTITION BY CUSTOMER_ID ORDER BY TOTAL_AMOUNT) AS R_TOTAL
FROM sales_data


2)
SELECT * ,
		COUNT (sale_id) OVER (PARTITION BY PRODUCT_CATEGORY) AS TOTAL_SOLD
FROM sales_data


3)
SELECT * ,
			MAX(total_amount) OVER (PARTITION BY PRODUCT_CATEGORY) AS MAX_AMOUNT
FROM sales_data


4)
SELECT * ,
			MIN(unit_price) OVER (PARTITION BY PRODUCT_CATEGORY) AS MIN_PRICE
FROM sales_data


5)
SELECT * ,
			AVG (total_amount) OVER (ORDER BY ORDER_DATE
									ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING 
									) AS AVG_3DAYS
FROM sales_data


6)
SELECT * ,
			SUM (total_amount) OVER (PARTITION BY REGION) AS TOTAL_AMOUNGT_BY_REGION
FROM sales_data


7)

;WITH

CTE AS 
(
SELECT * ,
			SUM (total_amount) OVER (PARTITION BY CUSTOMER_ID ) AS TOTAL
FROM sales_data
)

SELECT *,
			DENSE_RANK () OVER (ORDER BY TOTAL DESC) AS DR
FROM CTE


8)

;WITH

CTE AS
(
SELECT * ,
			LAG (total_amount,1) OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE)AS PREVIOUS_AMOUNT
FROM sales_data
)

SELECT *,
			total_amount-PREVIOUS_AMOUNT AS DIFF
FROM CTE


9)

;WITH

CTE AS
(
SELECT * ,
			DENSE_RANK () OVER (PARTITION BY PRODUCT_CATEGORY ORDER BY UNIT_PRICE DESC ) AS MAX_PRICE
FROM sales_data
)

SELECT  DISTINCT product_category,
		product_name
FROM CTE
WHERE MAX_PRICE IN(1,2,3)


10)

SELECT *,
			SUM (total_amount)  OVER (PARTITION BY REGION ORDER BY ORDER_DATE) AS Cumulative
FROM sales_data


11)
SELECT *,
		SUM (total_amount) OVER (PARTITION BY PRODUCT_CATEGORY ORDER BY TOTAL_AMOUNT) AS Cumulative
FROM sales_data



12)

--A)

CREATE TABLE Numbers (
    ID INT
);

INSERT INTO Numbers (ID)
VALUES (1), (2), (3), (4), (5);

SELECT *,
		SUM (ID) OVER (ORDER BY ID
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM Numbers;




--B)

DECLARE @I INT = 5

;WITH
CTE AS
(
		SELECT 
			   1 AS N,
			   1 AS YIGINDI
		
		UNION ALL

		SELECT
		       N+1,
			   YIGINDI + (N+1)
        FROM CTE
		WHERE N+1 <= @I
			   
)

SELECT N AS ID,
       YIGINDI AS SumPreValues
FROM CTE



13)

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

SELECT *,
		SUM (Value) OVER (ORDER BY VALUE
						  ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS Sum_of_Previous
FROM OneColumn



14)


;WITH 
CTE AS 
(
SELECT * ,
        DENSE_RANK () OVER (PARTITION BY CUSTOMER_NAME ORDER BY PRODUCT_CATEGORY) AS DR
FROM sales_data
)
SELECT customer_name FROM CTE
WHERE DR= 2 


15)


;WITH 
REGION_AVG AS (
	SELECT 
		region,
		AVG(total_amount) AS avg_region_amount
	FROM sales_data
	GROUP BY region
),
CUSTOMER_TOTAL AS (
	SELECT 
		customer_name,
		region,
		SUM(total_amount) AS total_spent
	FROM sales_data
	GROUP BY customer_name, region
)
SELECT 
	c.customer_name,
	c.region,
	c.total_spent,
	r.avg_region_amount
FROM CUSTOMER_TOTAL AS c
JOIN REGION_AVG AS r
	ON c.region = r.region
WHERE c.total_spent > r.avg_region_amount;



16)


;WITH TOTAL AS (
    SELECT 
        customer_name,
        region,
        SUM(total_amount) AS total_spend
    FROM sales_data
    GROUP BY customer_name, region
)
SELECT 
    customer_name,
    region,
    total_spend,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY total_spend DESC) AS DR
FROM TOTAL
ORDER BY region, DR;


17)

SELECT *,
         SUM(total_amount) OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS cumulative_sales
FROM sales_data


18)

WITH 
PREVUS AS
(
		SELECT *,
				LAG (total_amount,1) OVER (ORDER BY ORDER_DATE) AS PREVIOUS
		FROM sales_data
)

SELECT *,
		CAST (ROUND (100* (total_amount-PREVIOUS)/PREVIOUS ,2) AS DECIMAL (10,2))AS growth_rate_BY_DAY
FROM PREVUS


19)


;
WITH CTE AS (
		SELECT 
			customer_id,
			order_date,
			total_amount,
			LAG(total_amount ,1) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS last_order_amount
		FROM sales_data
)
SELECT *
FROM CTE
WHERE total_amount > last_order_amount;



20)

;WITH
CTE AS
(
SELECT *,
      AVG (unit_price) OVER () AS AVG_PRICE
FROM sales_data
)

SELECT DISTINCT product_name,
		unit_price,
		AVG_PRICE
FROM CTE
WHERE unit_price>AVG_PRICE



21)

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);



A)
SELECT Id,
		Grp,
		Val1,
		Val2,
		CASE
		    WHEN ROW_NUMBER () OVER (PARTITION BY GRP ORDER BY ID) = 1
			THEN SUM(Val1+Val2) OVER (PARTITION BY GRP)
			ELSE NULL
			END AS Tot

FROM MyData


B)
;WITH 
CTE AS
(
SELECT *,
		SUM (Val1+Val2) OVER (PARTITION BY GRP ) AS TOTAL,
		ROW_NUMBER() OVER (PARTITION BY GRP ORDER BY ID) AS RN
FROM MyData
)

SELECT Id,
		Grp,
		Val1,
		Val2,
		CASE
		    WHEN RN = 1 THEN TOTAL
			ELSE NULL
			END AS Tot
FROM CTE


22)

CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

SELECT *FROM TheSumPuzzle


; WITH 
CTE AS
(
SELECT ID,
		COST,
		SUM (Quantity) TOTAL
FROM TheSumPuzzle
GROUP BY ID,
		 COST
)

SELECT ID,
	   SUM (Cost)  AS Cost,
	   TOTAL AS Quantity
FROM CTE
GROUP BY ID,
          TOTAL
ORDER BY ID


                                     


23)

CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 

SELECT * FROM Seats




DECLARE @MAX INT = (SELECT MAX(SeatNumber) FROM Seats);

;WITH 
CTE AS
(
    SELECT 1 AS N
    UNION ALL
    SELECT N + 1
    FROM CTE
    WHERE N + 1 <= @MAX
),
JOIN_CTE AS
(
    SELECT N,
           S.SeatNumber
    FROM CTE AS T
    LEFT JOIN Seats AS S
    ON T.N = S.SeatNumber
),
GAPS AS
(
    SELECT *,
           CASE
               WHEN SeatNumber IS NULL AND (N = 1 OR LAG(SeatNumber) OVER (ORDER BY N) IS NOT NULL)
               THEN N
           END AS GAP_START,
           CASE
               WHEN SeatNumber IS NULL AND (N = @MAX OR LEAD(SeatNumber) OVER (ORDER BY N) IS NOT NULL)
               THEN N
           END AS GAP_END
    FROM JOIN_CTE
)

SELECT GAP_START, GAP_END
FROM GAPS
WHERE GAP_START IS NOT NULL OR GAP_END IS NOT NULL
ORDER BY GAP_START
