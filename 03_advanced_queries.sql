USE Chinook;

-- Exercise H: Revenue contribution by genre
/* Practice CTE */

WITH GenreRevenue AS (
    SELECT
        g.Name AS Genre,
        SUM(l.UnitPrice * l.Quantity) AS TotalRevenue
    FROM Genre AS g
    INNER JOIN Track AS t
        ON g.GenreId = t.GenreId
    INNER JOIN InvoiceLine AS l
        ON t.TrackId = l.TrackId
    GROUP BY g.GenreId, g.Name
)

SELECT
    Genre,
    ROUND(TotalRevenue, 2) AS TotalRevenue,
    ROUND(
        TotalRevenue /
        (SELECT SUM(TotalRevenue) FROM GenreRevenue) * 100,
        2
    ) AS RevenuePercentage
FROM GenreRevenue

ORDER BY TotalRevenue DESC;


-- Exercise I: Ranking music genres
WITH GenreRevenue AS (
    SELECT
        g.Name AS Genre,
        SUM(l.UnitPrice * l.Quantity) AS TotalRevenue
    FROM Genre AS g
    INNER JOIN Track AS t
        ON g.GenreId = t.GenreId
    INNER JOIN InvoiceLine AS l
        ON t.TrackId = l.TrackId
    GROUP BY g.GenreId, g.Name
)

SELECT
    Genre,
    RANK() OVER (ORDER BY TotalRevenue DESC) AS RevenueRank,
    ROUND(TotalRevenue, 2) AS TotalRevenue,
    ROUND(
        TotalRevenue /
        (SELECT SUM(TotalRevenue) FROM GenreRevenue) * 100,
        2
    ) AS RevenuePercentage
FROM GenreRevenue

ORDER BY RevenueRank;

-- Exercise J: Cumulative revenue percentage

WITH GenreRevenue AS (
    SELECT
        g.Name AS Genre,
        SUM(l.UnitPrice * l.Quantity) AS TotalRevenue
    FROM Genre AS g
    INNER JOIN Track AS t
        ON g.GenreId = t.GenreId
    INNER JOIN InvoiceLine AS l
        ON t.TrackId = l.TrackId
    GROUP BY g.GenreId, g.Name
)

SELECT
    Genre,

    ROUND(
        TotalRevenue /
        SUM(TotalRevenue) OVER () * 100,
        2
    ) AS RevenuePercentage,

    ROUND(
        SUM(TotalRevenue) OVER (
            ORDER BY TotalRevenue DESC, Genre
            ROWS BETWEEN UNBOUNDED PRECEDING
                     AND CURRENT ROW
        ) /
        SUM(TotalRevenue) OVER () * 100,
        2
    ) AS CumulativeRevenuePercentage

FROM GenreRevenue
ORDER BY TotalRevenue DESC, Genre;
