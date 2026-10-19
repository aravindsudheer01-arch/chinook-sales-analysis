USE Chinook;

-- Exercise E: Top 10 customers by spending
SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       ROUND(SUM(i.Total), 2) AS TotalSpent
FROM Customer AS c
INNER JOIN Invoice AS i
    ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY TotalSpent DESC
LIMIT 10;


-- Exercise F: Customer purchasing behavior
SELECT c.CustomerId,
       c.FirstName,
       COUNT(i.InvoiceId) AS NumberOfOrders,
       ROUND(AVG(i.Total), 2) AS AverageOrderValue,
       ROUND(SUM(i.Total), 2) AS TotalSpent
FROM Customer AS c
INNER JOIN Invoice AS i
    ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName
ORDER BY NumberOfOrders DESC,
         TotalSpent DESC;
         
         
-- Exercise G: Bestselling music genres
SELECT
    g.Name AS Genre,
    SUM(l.Quantity) AS TracksSold,
    ROUND(SUM(l.UnitPrice * l.Quantity), 2) AS TotalRevenue
    
FROM Genre AS g
INNER JOIN Track AS t
    ON g.GenreId = t.GenreId
INNER JOIN InvoiceLine AS l
    ON t.TrackId = l.TrackId
    
GROUP BY g.GenreId, g.Name
ORDER BY TotalRevenue DESC;

