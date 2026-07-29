# Apple Retail Sales & Warranty Analysis using PostgreSQL

<p align="center">
  <img src="images/apple_project_banner.png" alt="Apple Store Banner" width="900">
</p>

## Overview

This project is an end-to-end **SQL Data Analysis** project built using **PostgreSQL**, designed to analyze sales performance, product trends, store operations, and warranty claims for a global Apple retail business.

The project demonstrates how SQL can be used to transform raw transactional data into actionable business insights through aggregations, joins, Common Table Expressions (CTEs), window functions, statistical analysis, and time-series reporting.

The primary objective is to showcase practical SQL skills expected from an **Entry-Level Data Analyst** while solving realistic business problems commonly encountered in retail analytics.

---

# 🎯 Project Objectives

This project aims to answer key business questions such as:

* Evaluate the company's retail presence across different countries.
* Measure store performance using sales volume and revenue.
* Analyze product demand and sales trends over time.
* Monitor warranty claim rates and after-sales service performance.
* Identify high-performing and underperforming products.
* Evaluate product reliability using warranty claim analysis.
* Measure year-over-year and month-over-month business growth.
* Analyze product lifecycle performance after launch.
* Perform statistical analysis to understand the relationship between product pricing and warranty claims.

---

# 🗂 Dataset Description

The project uses five relational tables that simulate Apple's retail operations.

| Table        | Description                                           |
| ------------ | ----------------------------------------------------- |
| **Stores**   | Store information including location and country      |
| **Products** | Product catalog, launch dates, categories, and prices |
| **Category** | Product category master table                         |
| **Sales**    | Transaction-level sales records                       |
| **Warranty** | Warranty claims and repair status for sold products   |

---

# 🗃 Database Schema

The database follows a normalized relational structure.

```
Category
    │
    │
Products
    │
    │
Sales
   ├────────── Stores
   │
Warranty
```

Relationships:

* One Category → Many Products
* One Product → Many Sales
* One Store → Many Sales
* One Sale → Zero or One Warranty Claim

---

# ⚙ Database Features

The database includes:

* Primary Keys
* Foreign Key Constraints
* CHECK Constraints
* Data Import using PostgreSQL `COPY`
* Performance Optimization using Indexes

---

# 📌 SQL Concepts Used

This project demonstrates a wide range of PostgreSQL features including:

### Basic SQL

* SELECT
* WHERE
* GROUP BY
* HAVING
* ORDER BY
* Aggregate Functions

### Joins

* INNER JOIN
* LEFT JOIN

### Filtering Techniques

* EXISTS
* NOT EXISTS
* COUNT(DISTINCT)

### Conditional Logic

* CASE Expressions
* FILTER Clause

### Date Functions

* DATE_TRUNC()
* EXTRACT()
* INTERVAL
* Date Arithmetic

### Window Functions

* RANK()
* LAG()
* Running Totals

### Common Table Expressions (CTEs)

* Single CTE
* Multiple CTEs
* Nested CTEs

### Statistical Analysis

* CORR() (Correlation)

### Performance Optimization

* Index Creation
* Query Optimization
* NULLIF() to prevent division-by-zero errors

---

# 📊 Business Problems Solved

The project answers 21 real-world business questions, including:

1. Analyze global retail store distribution.
2. Measure total units sold by each store.
3. Analyze monthly sales activity.
4. Identify stores with no warranty claims.
5. Calculate warranty claim completion rate.
6. Identify the top-performing store based on annual sales volume.
7. Measure product portfolio utilization.
8. Compare average product prices across categories.
9. Monitor annual warranty claim volume.
10. *(Reserved if applicable in your SQL script.)*
11. Identify the lowest-selling product in each country and year.
12. Measure early warranty claims filed within 180 days of purchase.
13. Analyze warranty claims for recently launched products.
14. Identify high-performing sales months in the USA.
15. Determine the product category with the highest warranty claim volume.
16. Calculate warranty claim rates by product and country.
17. Measure year-over-year revenue growth for each store.
18. Analyze the relationship between product price and warranty claims.
19. Identify the store with the highest approved warranty claim rate.
20. Analyze monthly running sales totals and revenue trends.
21. Evaluate product lifecycle sales performance across different launch periods.

---

# 📈 Key Business Insights

This analysis helps answer important business questions such as:

* Which countries have the largest retail footprint?
* Which stores consistently outperform others?
* Which products generate the highest and lowest demand?
* Which product categories experience the highest warranty claims?
* How effective is the warranty repair process?
* Are premium-priced products more reliable?
* Which stores demonstrate the strongest sales growth?
* How does product performance change after launch?
* Which months generate the strongest sales activity?
* Which markets experience higher warranty claim rates?

These insights can support decision-making related to:

* Inventory Planning
* Sales Strategy
* Product Portfolio Management
* Store Performance Evaluation
* Warranty Service Optimization
* Product Quality Monitoring

---

# 🚀 Performance Optimization

To improve query performance, indexes were created on frequently queried columns, including:

* `sales(product_id)`
* `sales(store_id)`
* `sales(sale_date)`
* Composite indexes can also be added depending on reporting requirements.

---

# 💻 Tools & Technologies

* PostgreSQL
* SQL
* pgAdmin
* Git
* GitHub

---

# 📁 Repository Structure

```
Apple-Retail-Sales-Analysis/
│
├── schema.sql
├── data_import.sql
├── indexes.sql
|
├── queries
│
├── README.md
│
└── screenshots/
```

---

# 📚 What I Learned

Through this project, I strengthened my understanding of:

* Writing business-oriented SQL queries.
* Designing normalized relational databases.
* Working with multi-table joins.
* Building reusable CTEs.
* Using window functions for trend analysis.
* Performing time-series analysis.
* Applying statistical functions in SQL.
* Optimizing queries with indexes.
* Translating business requirements into analytical SQL solutions.

---

# 🎯 Project Outcome

This project demonstrates the ability to use SQL beyond simple data retrieval by solving realistic retail business problems through structured analytical queries.

The analysis combines sales performance, product analytics, store evaluation, warranty monitoring, and trend analysis to produce meaningful insights that support data-driven business decisions.

---

# 👤 Author

**Muhammad Umar**

Aspiring Data Analyst | SQL | PostgreSQL | Power BI | Python

If you found this project useful or have any feedback, feel free to connect or explore the repository.
