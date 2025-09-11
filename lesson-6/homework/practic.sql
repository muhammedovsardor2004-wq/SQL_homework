1)
SELECT DISTINCT  * FROM InputTbl
WHERE col1  IN ('a','c','m') or col2 IN ('b','d','n')

SELECT DISTINCT  * FROM InputTbl
WHERE col1 LIKE '[a,c,m]' or col2 LIKE '[b,d,n]'

2)
SELECT *FROM TestMultipleZero
WHERE NOT (A=0 AND B=0 AND C=0 AND D=0)

3)
SELECT *FROM section1
WHERE ID%2=1

4)
SELECT * FROM section1
WHERE id= (SELECT MIN(id) FROM section1)

5)
SELECT * FROM section1
WHERE id= (SELECT MAX(id) FROM section1)

6)
SELECT * FROM section1
WHERE name LIKE 'B%'

7)
SELECT *FROM ProductCodes
WHERE Code LIKE '%[_]%'
