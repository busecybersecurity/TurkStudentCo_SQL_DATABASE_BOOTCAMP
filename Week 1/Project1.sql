```sql
-- Create the database
CREATE DATABASE FirstLessonDB;
GO
USE FirstLessonDB;
GO

-- Create the Departments table
CREATE TABLE Departments(
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,  
    DepartmentName NVARCHAR(50) NOT NULL
);

-- Create the Employees table
CREATE TABLE Employees(
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),  
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Age TINYINT NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2) NOT NULL,  
    JoinDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)  
);

-- Insert data into the Departments table
INSERT INTO Departments(DepartmentName)
VALUES (N'IT'), (N'HR'), (N'Finance');

-- Insert data into the Employees table
INSERT INTO Employees(FirstName, LastName, Age, DepartmentID, Salary, JoinDate) 
VALUES 
    ('John', 'Doe', 30, 1, 55000, '2020-01-15'),
    ('Jane', 'Smith', 45, 2, 65000, '2018-07-20'),
    ('Sam', 'Brown', 28, 1, 52000, '2021-04-25'),
    ('Lisa', 'White', 35, 3, 70000, '2019-03-18'),
    ('Mark', 'Black', 50, 1, 75000, '2015-11-05'),
    ('Lucy', 'Green', 40, 2, 60000, '2017-10-10');

-- List all employees
SELECT * FROM Employees;

-- List all departments
SELECT * FROM Departments;

-- Display only employees' first names, last names, and salaries
SELECT FirstName, LastName, Salary FROM Employees;

-- List employees' department information without duplicates
SELECT DISTINCT FirstName, DepartmentID FROM Employees;

-- List employees in the HR department
SELECT * FROM Employees WHERE DepartmentID = 2;

-- Sort employees by salary in descending order
SELECT * FROM Employees ORDER BY Salary DESC;

-- Combine employees' first and last names to create full names
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;
```