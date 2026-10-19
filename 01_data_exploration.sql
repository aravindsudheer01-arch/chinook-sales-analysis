
USE Chinook;

-- =====================================
-- PHASE 2: DATA EXPLORATION
-- =====================================

-- Exercise A: First 10 customers
SELECT FirstName, LastName, Company
FROM Customer
ORDER BY CustomerId
LIMIT 10;

-- Exercise B: Customers from Brazil
SELECT * FROM Customer
WHERE Country = 'Brazil';

-- Exercise C: Customers by country
SELECT Country,
	   COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY Country
ORDER BY TotalCustomers DESC;

-- Exercise D: Revenue by country
SELECT BillingCountry,
	   ROUND(SUM(Total), 2) AS TotalRevenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalRevenue DESC;
