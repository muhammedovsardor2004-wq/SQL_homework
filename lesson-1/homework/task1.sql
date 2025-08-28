1) 
1.DATA is facts, taxts and any informations that can be used or analyzed
2.DATABASE is an organized collection of data that can be easily managed, used and accessed
3.RELATIONALA DATABASE that stores data in tables and relotionships between the tables based on common fields
4.TABLE is a structre in relational databasse consisting of rows and columns used to store data 

2)
1.data storage and management
2.security featury 
3.high availability and disaster recovery
4.advanced querying and analystics
5.BI and integration tools

3)
1.Wendows authentication	
2.SQL server authentication 

4)
CREATE DATABASE schoolDB

5)
CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR (50), Age INT)

6)
1. SQL server - software/system (the actuol database engine)
2. SSMS - Tool/interface (the grafical tool to intract with sql server)
3. SQL - language ( the language used to manage and query data

7)
1. DQL - DATA QUERY LANGUAGE  (to query data from database)
*SELECT
2. DDL - DATA DEFINTION LANGUAGE ( to define or change structure of database objects)
*CREATE
*ALTER
*DROP
*TRUNCATE 
3. DML - DATA MANIPULATION LANGUAGE ( to manipulate data in table)
*INSERT
*UPDATE
*DELETE
4. DCL - DATA CONTROL LANGUAGE ( to control access or permisssions on database objects
*GRANT
*REVOKE
5. TCL - TRANSACTION CONTROL LANGUAGE  ( to manage transaction )
*BEGIN
*UPDATE
*COMMIT


8)
INSERT INTO Students (StudentID, Name, Age) VALUES (3, 'SARDOR', 21)
INSERT INTO Students (StudentID, Name, Age) VALUES (2, 'AZIZBEK', 22)
INSERT INTO Students (StudentID, Name, Age) VALUES (4, 'DILMUROD', 22)

SELECT*FROM Students


9)
1. search  adventureworks sample database in google
2. download 2022 version
3. copy file in dowloads
4. past file in backup file
5. in SSMS, database>  estore database>  device>  ...>  add>  choose adventureworks sample database 2022>  ok>  refresh
