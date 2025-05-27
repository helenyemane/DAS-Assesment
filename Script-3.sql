CREATE SCHEMA market;
CREATE TABLE market.employees_table (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    Department VARCHAR(50),
    HireDate DATE,
    Salary FLOAT
);
INSERT INTO market.employees_table (EmployeeID, FirstName, LastName, Gender, Department, HireDate, Salary) VALUES
(1, 'John', 'Doe', 'Male', 'IT', '2018-05-01', 60000.00),
(2, 'Jane', 'Smith', 'Female', 'HR', '2019-06-15', 50000.00),
(3, 'Michael', 'Johnson', 'Male', 'Finance', '2017-03-10', 75000.00),
(4, 'Emily', 'Davis', 'Female', 'IT', '2020-11-20', 70000.00),
(5, 'Sarah', 'Brown', 'Female', 'Marketing', '2016-07-30', 45000.00),
(6, 'David', 'Wilson', 'Male', 'Sales', '2019-01-05', 55000.00),
(7, 'Chris', 'Taylor', 'Male', 'IT', '2022-02-25', 65000.00);
CREATE TABLE market.products_table (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price FLOAT,
    Stock INT
);
INSERT INTO market.products_table (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 30),
(2, 'Desk', 'Furniture', 300.00, 50),
(3, 'Chair', 'Furniture', 150.00, 200),
(4, 'Smartphone', 'Electronics', 800.00, 75),
(5, 'Monitor', 'Electronics', 250.00, 40),
(6, 'Bookshelf', 'Furniture', 100.00, 60),
(7, 'Printer', 'Electronics', 200.00, 25);

CREATE TABLE market.sales_table (
    SaleID INT PRIMARY KEY,
    ProductID INT REFERENCES market.employees_table(EmployeeID),                     
    EmployeeID INT REFERENCES market.employees_table(EmployeeID),
    SaleDate DATE,
    Quantity INT,
    Total FLOAT
);

INSERT INTO market.sales_table  (SaleID, ProductID, EmployeeID, SaleDate, Quantity, Total) VALUES
(1, 1, 1, '2021-01-15', 2, 2400.00),
(2, 2, 2, '2021-03-22', 1, 300.00),
(3, 3, 3, '2021-05-10', 4, 600.00),
(4, 4, 4, '2021-07-18', 3, 2400.00),
(5, 5, 5, '2021-09-25', 2, 500.00),
(6, 6, 6, '2021-11-30', 1, 100.00),
(7, 7, 1, '2022-02-15', 1, 200.00),
(8, 1, 2, '2022-04-10', 1, 1200.00),
(9, 2, 3, '2022-06-20', 2, 600.00),
(10, 3, 4, '2022-08-05', 3, 450.00),
(11, 4, 5, '2022-10-11', 1, 800.00),
(12, 5, 6, '2022-12-29', 4, 1000.00);

-- 1
SELECT * FROM market.employees_table;
-- 2
SELECT FirstName AS FName FROM market.employees_table;
-- 3
SELECT DISTINCT Department AS Distinct FROM market.employees_table;
-- 4
SELECT COUNT(*) As total_employees FROM market.employees_table;
-- 5
SELECT SUM(Salary) AS total_salary FROM market.employees_table;
-- 6
SELECT AVG(Salary) AS average_salary FROM market.employees_table;
-- 7
SELECT MAX(Salary) AS highest_salary FROM market.employees_table;
-- 8
SELECT MIN(Salary) AS lowest_salary FROM market.employees_table;
-- 9
SELECT COUNT(*) AS male_employees FROM market.employees_table;
-- 10
SELECT COUNT(*) AS female_employees FROM market.employees_table;
-- 11
SELECT COUNT(EmployeeId) AS employees_hired_in_2020
FROM market.employees_table
WHERE EXTRACT (YEAR FROM HireDate) = 2020
GROUP BY(HireDate);
-- 12
SELECT AVG(Salary) AS IT_Avg_Salary FROM market.employees_table WHERE Department = 'IT';
-- 13
SELECT Department, COUNT(*) AS EmployeeCount
FROM market.employees_table
Group BY Department;
-- 14
SELECT Department, SUM(Salary) AS TotalDptSalary
FROM market.employees_table
GROUP BY Department

-- 15
SELECT Department, MAX(Salary) AS Max_Salary
FROM market.employees_table
GROUP BY  Department;

-- 16
SELECT Department, MIN(Salary) AS Min_Salary
FROM market.employees_table
GROUP BY Department ;
--17
SELECT Gender, COUNT (*) AS Employee_Count
FROM market.employees_table
GROUP BY Gender

-- 18
SELECT Gender, AVG(Salary) AS avg_salary
FROM market.employees_table
GROUP BY Gender;
-- 19
SELECT * FROM market.employees_table
ORDER BY Salary DESC
LIMIT 5;
-- 20
SELECT COUNT(DISTINCT FirstName) AS unique_fName
FROM market.employees_table;
-- 21
SELECT *
FROM market.employees_table e, market.sales_table s
WHERE e.EmployeeId = s.EmployeeId;
-- 22
SELECT * FROM market.employees_table ORDER BY HireDate ASC LIMIT 10;
-- 23
SELECT * FROM market.employees_table e
WHERE NOT EXISTS (
	SELECT 1 FROM market.sales_table s WHERE s.EmployeeID = e.EmployeeID
);
-- 24
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(s.SaleID) AS TotalSales
FROM market.employees_table e
LEFT JOIN market.sales_table s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;
-- 25
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(s.Total) AS TotalSales
FROM market.employees_table e
JOIN market.sales_table s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC
LIMIT 1;
-- 26
SELECT e.Department, AVG(s.Quantity) AS AvgQuantitySold
FROM market.employees_table e
JOIN market.sales_table s ON e.EmployeeID = s.EmployeeID
GROUP BY e.Department;
-- 27
SELECT employees.EmployeeID, employees.FirstName, employees.LastName, SUM(sales.total) AS total_sales_2021
from market.employees_table employees
JOIN  market.sales_table sales
ON employees.EmployeeID = sales.EmployeeID
WHERE EXTRACT(YEAR FROM sales.SaleDate) = 2021
GROUP BY employees.EmployeeID,employees.FirstName, employees.LastName;
-- 28
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(s.Quantity) AS TotalQuantity
FROM market.employees_table e
JOIN market.sales_table s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalQuantity DESC
LIMIT 3;
-- 29
SELECT e.Department, SUM(s.Quantity) AS TotalQuantity
FROM market.employees_table e
JOIN market.sales_table s ON e.EmployeeID = s.EmployeeID
GROUP BY e.Department;
-- 30
SELECT p.Category, SUM(s.Total) AS TotalRevenue
FROM market.sales_table s
JOIN market.products_table p ON s.ProductID = p.ProductID
GROUP BY p.Category;