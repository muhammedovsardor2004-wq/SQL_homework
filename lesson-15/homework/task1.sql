1)
SELECT * 
FROM employees5
WHERE salary = (SELECT  
                MIN(salary) 
				FROM employees5)

2)

SELECT * FROM products5
WHERE price> (SELECT 
              AVG (price)
			  FROM products5)
3)

SELECT * FROM employees4
WHERE department_id = (SELECT 
                       id
					   FROM departments
					   WHERE department_name = 'Sales')
4)
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT
                          customer_id
						  FROM orders)

5)

SELECT * FROM products AS OUTT
WHERE price = (SELECT
               MAX (price)
			   FROM products AS INS
			   WHERE OUTT.category_id = INS.category_id
               )
6)

SELECT *
FROM employeesA
WHERE department_id = (SELECT 
                        TOP 1 department_id
                        FROM employeesA
                        GROUP BY department_id
                        )

7)

SELECT * FROM employees3 AS OUTT
WHERE salary = (SELECT 
                MAX (salary)
				FROM employees3 AS INS
				WHERE OUTT.department_id = INS.department_id
				)

8)
SELECT S.* ,
        G.course_id,
		G.grade
       
FROM students AS S
JOIN 
(
SELECT * FROM grades AS OUTT
WHERE grade =     (SELECT 
                   MAX(grade)
				   FROM grades INS
				   WHERE OUTT.course_id = INS.course_id
                   )
) AS G
ON S.student_id=G.student_id
ORDER BY S.student_id

9)
SELECT * FROM products3 AS OUTT
WHERE price = ( SELECT 
                price
				FROM products3 AS INS
				WHERE OUTT.category_id = INS.category_id
				ORDER BY price DESC
				OFFSET 2 ROWS
				FETCH NEXT 1 ROWS  ONLY
               )

10)
SELECT * FROM employees0 OUTT
WHERE salary  BETWEEN (SELECT
                       AVG(salary)  
					   FROM employees0
                       )
			 AND     (SELECT 
			          MAX (salary)
					  FROM employees0 AS INS
					  WHERE OUTT.department_id = INS.department_id 
					  )
