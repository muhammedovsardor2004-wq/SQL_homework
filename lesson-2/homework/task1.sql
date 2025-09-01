1)
CREATE TABLE Employees (EmpID INT,Name VARCHAR(50),Salary DECIMAL(10,2))
SELECT *FROM Employees

2)
INSERT INTO Employees VALUES (1,  'SARDOR', 10000), (2, 'DILMUROD',5000), (3,'AZIZ',1000)
SELECT *FROM Employees

3)
UPDATE Employees
SET Salary=7000
WHERE EmpID=1
SELECT *FROM Employees

4)
DELETE FROM Employees
WHERE EmpID=2
SELECT *FROM Employees

5)
DELETE: Removes specific rows from a table based on a WHERE clause. It is DML (Data Manipulation Language), and the action can be rolled back (if inside a transaction).

TRUNCATE: Removes all rows from a table quickly, without logging individual row deletions. It is DDL (Data Definition Language), and cannot be rolled back in most databases.

DROP: Completely removes the table structure from the database (i.e., deletes the table itself). It is also DDL and cannot be rolled back.

6)
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100)
SELECT *FROM Employees

7) 
ALTER TABLE Employees
ADD Department VARCHAR(50)
SELECT *FROM Employees

8)
ALTER TABLE  Employees
ALTER COLUMN Salary FLOAT
SELECT *FROM Employees

9)
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50))
SELECT *FROM  Departments

10)
TRUNCATE TABLE Employees
SELECT *FROM Employees


11)
INSERT INTO Departments
SELECT 1,' HR'
UNION ALL
SELECT 2, 'MENIGMENT'
UNION ALL
SELECT 3, 'MARKETING'
UNION ALL
SELECT 4, 'FINANCE'
UNION ALL
SELECT 5, 'IT'
SELECT * FROM Departments

12)
INSERT INTO Employees VALUES
(1, 'SARDOR', 1000, 'HR'),
(2, 'DILMUROD', 5000, 'MARKETING'),
(3, 'AZIZ', 8000, 'HR'),
(4, 'HUSNIDDIN',4000, 'IT'),
(5, 'MUHAMMADUMAR', 7500, 'FINANCE')
SELECT * FROM Employees

UPDATE  Employees
SET Department = 'Management'
WHERE Salary>7000
SELECT * FROM Employees

13) 
TRUNCATE TABLE Employees
SELECT * FROM Employees

14)
ALTER TABLE Employees
DROP column Department
SELECT * FROM Employees

15)
EXEC sp_rename  'SARRDOR.dbo.Employees','StaffMembers '
SELECT * FROM Employees
SELECT * FROM StaffMembers

16) 
DROP TABLE Departments
SELECT * FROM Departments



17)
CREATE TABLE Products (ProductsID INT Primary Key,ProductName VARCHAR (50),Category VARCHAR(50), Price DECIMAL (10,2), Description TEXT)
SELECT *FROM  Products

18)
ALTER TABLE Products
ADD CONSTRAINT positive CHECK (Price>0)
SELECT *FROM  Products

19)
ALTER TABLE Products
ADD StockQuantity  INT DEFAULT(50)
SELECT *FROM Products

20)
EXEC sp_rename 'Products.Category', 'PraductCategory', 'COLUMN'
SELECT *FROM Products

21) 
INSERT INTO Products VALUES
(1,'APPLE','VEGETABLES',12.1,'RED',10)
SELECT *FROM Products
INSERT INTO Products VALUES
(2,'PHONE','ELECTRONIC', 230.5, 'BLACK', 50)
SELECT *FROM Products
INSERT INTO Products VALUES
(3,'MOUSE', 'ELECTRONIC', 15.0, 'BLACK', 13)
SELECT *FROM Products
INSERT INTO Products VALUES
(4, 'AIRPODS', 'ELECTRONIC', 100, 'WHITE', 28)
SELECT *FROM Products
INSERT INTO Products VALUES
(5,'GLASS', 'ELECTRONIC', 14, 'BLUE', 46)
SELECT *FROM Products

22)
SELECT * INTO Products_Backup FROM Products
SELECT *FROM Products_Backup 
SELECT *FROM Products

23)
EXEC sp_rename '[SARRDOR].[dbo].[Products]', 'Inventory'
SELECT *FROM Products
SELECT *FROM Inventory

24) 
ALTER TABLE Inventory
DROP CONSTRAINT positive

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT


25) 

ALTER TABLE Inventory
ADD ProductCode INT IDENTITY (1000,5)
SELECT *FROM Inventory
