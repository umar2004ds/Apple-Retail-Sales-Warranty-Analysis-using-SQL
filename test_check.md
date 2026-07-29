# 📸 Screenshots

This document contains the visual assets included in this project to illustrate the database structure and demonstrate SQL query performance optimization.

---

# 1. Entity Relationship Diagram (ERD)

The Entity Relationship Diagram (ERD) provides a visual representation of the database schema and the relationships between tables.

It helps explain how transactional data flows through the database and how tables are connected using primary and foreign keys.

**ER Diagram**

<p align="center">
  <img src="images/apple_sales ER_Diagram.png" alt="Before store_id INDEX image" width="900">
</p>

---

# 2. Query Performance Optimization

To improve query execution performance, indexes were created on frequently queried columns in the `sales` table.

Performance was evaluated using PostgreSQL's `EXPLAIN ANALYZE` before and after index creation.

---

## Index on `store_id`

### Before Index Creation

The execution plan indicates that PostgreSQL scans a larger portion of the table when filtering or joining by `store_id`.

<p align="center">
  <img src="images/Before store_id INDEX.png" alt="Before store_id INDEX image" width="900">
</p>

### After Index Creation

The index on `store_id` enables more efficient lookups during joins and filtering operations.

<p align="center">
  <img src="images/After store_id INDEX.png" alt="After store_id INDEX image" width="900">
</p>

---

## Index on `product_id`

### Before Index Creation

Before indexing, product-based queries require scanning additional rows to locate matching records.

<p align="center">
  <img src="images/Before product_id INDEX.png" alt="Before product_id INDEX image" width="900">
</p>

### After Index Creation

After creating the index, PostgreSQL can locate matching rows more efficiently, resulting in improved query execution.

<p align="center">
  <img src="images/After product_id INDEX.png" alt="After product_id INDEX image" width="900">
</p>

---

# Summary

This project demonstrates not only SQL querying skills but also an understanding of database performance optimization.

By implementing indexes on frequently accessed columns and comparing execution plans using `EXPLAIN ANALYZE`, the project highlights practical techniques for improving query efficiency in PostgreSQL.

**Indexes Created**

* `sales(product_id)`
* `sales(store_id)`
* `sales(sale_date)`

These indexes improve the performance of analytical queries involving joins, filtering, and date-based reporting.

---

# Note

Actual execution time and execution plans may vary depending on:

* PostgreSQL version
* Dataset size
* System hardware
* Available memory
* Query cache

The purpose of these screenshots is to demonstrate SQL performance optimization techniques rather than compare absolute execution times.