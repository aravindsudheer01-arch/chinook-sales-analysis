# Chinook Digital Media Store — SQL Sales Analysis

## Project overview

This portfolio project uses **MySQL 8+ and MySQL Workbench** to analyse transactions in the [Chinook sample database](https://github.com/lerocha/chinook-database). It explores sales by country, customer purchasing behaviour, and revenue by media genre. The aim is to translate relational data into clear, business-relevant findings.

**Tools:** MySQL, MySQL Workbench  
**Techniques:** Filtering and sorting, aggregations, `GROUP BY`, `INNER JOIN`, common table expressions (CTEs), subqueries, and window functions (`RANK`, running `SUM`).

## Business questions

1. Which billing countries generate the most revenue?
2. Who are the highest-spending customers?
3. How do order frequency and average order value vary across customers?
4. Which genres generate the most revenue?
5. How concentrated is revenue among the highest-performing genres?

## Dataset and approach

Chinook is a fictional digital-media-store database with related tables for customers, invoices, invoice lines, tracks, and genres. This analysis uses:

- **`Customer` + `Invoice`:** Customer-level spending, number of invoices, and average invoice value.
- **`Invoice`:** Revenue grouped by `BillingCountry`.
- **`Genre` + `Track` + `InvoiceLine`:** Genre-level units sold and revenue (`UnitPrice * Quantity`).

SQL queries are grouped by topic in the `01_data_exploration.sql`, `02_sales_analysis.sql`, and `03_advanced_queries.sql` files. Revenue shares and cumulative revenue percentages are calculated using a CTE and window functions.

## Key findings

### 1. Revenue by billing country

| Rank | Billing country | Total revenue |
| ---: | --- | ---: |
| 1 | USA | $523.06 |
| 2 | Canada | $303.96 |
| 3 | France | $195.10 |
| 4 | Brazil | $190.10 |
| 5 | Germany | $156.48 |

The USA is the leading billing market, followed by Canada. **Together, the USA and Canada generated $827.02 in sales** in this dataset.

### 2. Highest-spending customers

| Rank | Customer | Total spent |
| ---: | --- | ---: |
| 1 | Helena Holý | $49.62 |
| 2 | Richard Cunningham | $47.62 |
| 3 | Luis Rojas | $46.62 |
| 4 | Ladislav Kovács | $45.62 |
| 5 | Hugh O'Reilly | $45.62 |

Helena Holý has the highest total spending of the customers analysed. Among the **15 customers displayed in the order-frequency query**, each made seven purchases, with differences in total spending driven by average invoice value. This observation should not be extrapolated to all customers without checking the remaining rows.

### 3. Revenue concentration by genre

| Genre | Revenue share | Cumulative revenue share |
| --- | ---: | ---: |
| Rock | 35.50% | 35.50% |
| Latin | 16.41% | 51.91% |
| Metal | 11.22% | 63.13% |
| Alternative & Punk | 10.37% | 73.51% |
| TV Shows | 4.02% | 77.52% |
| Jazz | 3.40% | 80.93% |

**Rock contributes the largest share (35.50%).** The top three genres account for **63.13%** of sales revenue, and the top **six of 24 genres reach 80.93%** of cumulative revenue. These results demonstrate a concentration of sales within a subset of the catalogue.

*Note: Reported percentages are rounded individually; cumulative percentages are calculated from unrounded revenue totals.*

## Business interpretation

- **Market concentration:** The USA and Canada are the top two billing markets. Their performance warrants further examination alongside customer counts, order values, and time trends before making marketing-spend decisions.
- **Customer behaviour:** The displayed high-spending customers have equal order counts but different average order values. Value-based segmentation may therefore be more informative than order count alone for this group.
- **Catalogue strategy:** Rock, Latin, and Metal dominate revenue. An initial next step could be to investigate purchasing patterns and catalogue breadth in those genres, while evaluating smaller genres for potential unmet demand.

These are **hypotheses and exploratory recommendations**, not causal conclusions or evidence that a particular marketing intervention will increase revenue.

## Repository structure

```text
chinook-sales-analysis/
├── README.md
├── 01_data_exploration.sql    # Basic filtering, customer counts, country revenue
├── 02_sales_analysis.sql      # Customer spending, order behaviour, genre sales
└── 03_advanced_queries.sql   # Genre share, rankings, cumulative revenue
```

## How to run

1. Install MySQL Server and open MySQL Workbench.
2. Download the MySQL version of the Chinook database from the [Chinook project](https://github.com/lerocha/chinook-database).
3. Review the setup script **before execution**: the standard Chinook script may drop and recreate a database called `Chinook`.
4. Run the setup script, then execute `USE Chinook;`.
5. Open and execute the three analysis scripts in order, or run individual queries.

## Limitations and potential next steps

- Chinook is **synthetic sample data**, not a live commercial dataset. Findings should be treated as a SQL demonstration.
- Country represents **invoice billing country**, not necessarily customers' current residence or the location of product usage.
- The genre list includes **TV Shows** and other non-music media; it should not be interpreted as purely music sales.
- Additional analysis could examine revenue trends over time, monthly changes, customer retention, and revenue per customer by country.
- A further validation step would reconcile invoice totals against the sum of invoice-line amounts.

## What this project demonstrates

I can query multiple relational tables, calculate sales and customer KPIs, use CTEs and window functions for ranked and cumulative analysis, and communicate findings with appropriate analytical caveats.
