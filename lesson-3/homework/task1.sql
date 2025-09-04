
1)
	BULK INSERT in SQL Server → a command used to quickly load large amounts of data from an external file (like CSV or TXT) into a table.

Purpose:

Fast import of big datasets.

More efficient than row-by-row INSERT.

Useful for ETL, migration, and data warehousing.


2)
CSV (Comma Separated Values)

TXT (Plain Text)

DAT (Data file)

XML (Extensible Markup Language)


3)
CREATE TABLE Products
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2)
)


4)
INSERT INTO  Products VALUES
(1,'APPLE',10),
(2,'WATER',11),
(3,'PHONE',12)
SELECT*FROM Products

5)
NULL → represents the absence of a value in a database column. It means “unknown” or “missing,” not the same as 0 or an empty string.

NOT NULL → means the column must always have a value. It cannot be left blank when inserting or updating a record.

EXAMPLE

CREATE TABLE Students
(
StudentID int,
name varchar(90) NOT NULL,
AGE INT NULL
)

6)
ALTER TABLE Products
ADD UNIQUE (ProductName)


7)SQL Comment → a note in SQL code (-- or /*...*/) that explains the query but does not execute.
EXAMPLE 
--SARDOR--
/*SARDOR*/

8)
ALTER TABLE Products
ADD CategoryID INT

9)
CREATE TABLE Categories
(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR (90) UNIQUE
)
SELECT *FROM Categories

10)
IDENTITY column in SQL Server → a column that automatically generates unique numeric values for each new row.

Purpose:

To uniquely identify each record without manually entering values.

Commonly used for primary keys.

You can specify a starting value and an increment.

EXAMPLE
CREATE TABLE ROOM
(
ID INT IDENTITY (100,5) PRIMARY KEY,
NAME VARCHAR (99)
)


11)
BULK INSERT Products
FROM 'C:\Users\user\Documents\SQL Server Management Studio\Новый текстовый документ.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
)

12)

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)


13)
PRIMARY KEY → ensures that each record is unique; NULL values are not allowed.

UNIQUE KEY → ensures that column values are unique; NULL values are allowed.


CREATE TABLE SS 
(
ID INT PRIMARY KEY
)
INSERT INTO SS VALUES ( 1),(2),(3)


CREATE TABLE BB
(
ID INT UNIQUE 
)
INSERT INTO BB VALUES (NULL), (2), (3)



14)
ALTER TABLE Products
ADD CHECK (Price>0)

15)
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0

16)
SELECT 
ProductID  ,
ProductName ,
ISNULL (Price, 0) as Price 
FROM
Products



17)
Purpose of FOREIGN KEY

Enforces Referential Integrity:
Ensures that a value in a child table matches a value in the parent table.

Prevents Orphan Records:
Stops inserting a record in the child table that does not have a corresponding parent record.

Supports Data Consistency:
Helps maintain relationships between tables (e.g., orders must belong to valid customers).

EXAMPLE


CREATE TABLE Categories1
(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR (90) UNIQUE
)

CREATE TABLE Products1
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2),
CategoryID INT
FOREIGN KEY (CategoryID) REFERENCES Categories1(CategoryID)
)

18)
CREATE TABLE Customers (AGE INT)
ALTER TABLE Customers 
ADD CHECK (AGE>=18)

19)
CREATE TABLE A (ID INT IDENTITY (100,10) PRIMARY KEY)

20)
CREATE TABLE OrderDetails
(
ID INT ,
NAME VARCHAR (90) ,
AGE INT,
PRIMARY KEY (ID, AGE)
)


21)
Use ISNULL for a simple two-value replacement.

Use COALESCE for multiple fallback options or for standard SQL portability.


22)
CREATE TABLE Employees 
(
EmpID INT PRIMARY KEY,
Email VARCHAR(90) UNIQUE 
)

23)

CREATE TABLE S
(
NAME_ID INT PRIMARY KEY,
NAME VARCHAR (90)
)

CREATE TABLE D
(
SALARY INT ,
AGE INT,
NAME_ID INT,
FOREIGN KEY (NAME_ID) REFERENCES S(NAME_ID) ON DELETE CASCADE ON UPDATE CASCADE
)
