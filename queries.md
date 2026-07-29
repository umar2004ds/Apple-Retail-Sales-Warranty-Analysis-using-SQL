## SQL Queries

### 1. Evaluate global retail presence by counting the number of stores in each country.

**Objective:** Evaluate the company's market presence across different countries to identify expansion opportunities, optimize regional investments, and support long-term business growth.

```sql
SELECT
	country,
	COUNT(*) AS no_of_stores
FROM stores
GROUP BY country
ORDER BY no_of_stores DESC;
```

### 2. Calculate the total number of units sold by each store.

**Objective:** Measure store performance by comparing total sales volume, enabling the business to optimize inventory distribution, allocate resources effectively, and improve overall profitability.

```sql
SELECT
	st.store_id, st.store_name, SUM(sl.quantity) AS total_units_sold
FROM sales sl
	JOIN stores st
		ON sl.store_id = st.store_id
GROUP BY st.store_id, st.store_name
ORDER BY total_units_sold DESC;
```

### 3. Measure sales volume during the December 2023 holiday season.

**Objective:** Analyze sales performance during a key seasonal period to evaluate customer demand, measure holiday sales success, and improve future sales forecasting and promotional planning.

```sql
SELECT COUNT(*) FROM sales
WHERE sale_date >= DATE '2023-12-01'
	AND sale_date < DATE '2024-01-01';
```

### 4. Determine how many stores have never had a warranty claim filed.

**Objective:** Identify stores with consistently low warranty claims to uncover best practices, improve product reliability across locations, and reduce after-sales service costs.

```sql
SELECT
	COUNT(*) AS stores_without_warranty_claims
FROM stores st
WHERE EXISTS(
	SELECT 1
	FROM sales sl
	WHERE st.store_id = sl.store_id
)
AND NOT EXISTS(
	SELECT 1
	FROM sales sl
		JOIN warranty w
			ON sl.sale_id = w.sale_id
	WHERE sl.store_id = st.store_id
)
```

### 5. Measure the warranty claim completion rate to evaluate the efficiency of the company's after-sales service process.

**Objective:** Measure the effectiveness of the warranty service process to identify operational bottlenecks, improve claim resolution efficiency, and enhance customer satisfaction.

```sql
WITH warranty_claims
AS(
	SELECT
		COUNT(*) AS total_warranty_claims,
		COUNT(*) FILTER (WHERE repair_status = 'Completed') AS completed_warranty_claims
	FROM warranty
)
SELECT ROUND(completed_warranty_claims * 100.0 / total_warranty_claims, 2) AS completed_claims_percentage
FROM warranty_claims
```

### 6. Identify which store had the highest total units sold in the last year.

**Objective:** Identify the top-performing store to understand successful sales strategies, recognize high-performing teams, and replicate best practices across other locations.

```sql
WITH stores_units_sold
AS(
	SELECT
		st.store_id, st.store_name, st.city, st.country,
		SUM(sl.quantity) AS total_units_sold,
		RANK() OVER (ORDER BY SUM(sl.quantity) DESC) AS rank_lvl
	FROM sales sl
		JOIN stores st
			ON sl.store_id = st.store_id
	WHERE sale_date >= DATE_TRUNC('YEAR', CURRENT_DATE) - INTERVAL '1 YEAR'
		AND sale_date < DATE_TRUNC('YEAR', CURRENT_DATE)
	GROUP BY st.store_id, st.store_name, st.city, st.country
)
SELECT
	store_id, store_name, city, country, total_units_sold
FROM stores_units_sold
WHERE rank_lvl = 1;
```

### 7. Determine the number of distinct products sold during the previous calendar year to evaluate product portfolio utilization and customer demand.

**Objective:** Evaluate product portfolio diversity to optimize inventory planning, identify product expansion opportunities, and ensure the business offers a balanced range of products that meets customer demand.

```sql
SELECT
	COUNT(DISTINCT product_id) AS total_unique_products_sold
FROM sales
WHERE sale_date >= DATE_TRUNC('YEAR', CURRENT_DATE) - INTERVAL '1 YEAR'
	AND sale_date < DATE_TRUNC('YEAR', CURRENT_DATE);
```

### 8. Analyze the average selling price of products within each category to identify premium and budget product segments.

**Objective:** Compare pricing across product categories to support pricing strategies, maximize profitability, and maintain competitive positioning in the market.

```sql
SELECT
	c.category_id, c.category_name, ROUND(AVG(p.price), 2) AS average_product_price
FROM products p
	JOIN category c
		ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY products_price_average DESC;
```

### 9. Analyze warranty claim volume in 2024 to monitor product reliability and customer support activity.

**Objective:** Monitor warranty claim trends to identify product quality issues early, estimate after-sales service costs, and improve customer satisfaction through proactive quality improvements.

```sql
SELECT
	COUNT(*) AS total_warranty_claims
FROM warranty
WHERE claim_date >= DATE '2024-01-01'
	AND claim_date < DATE '2025-01-01';
```

### 10. For each store, identify the best-selling day based on the highest quantity sold.

**Objective:** Identify peak sales days for each store to optimize staffing, inventory availability, promotional campaigns, and operational planning during high-demand periods.

```sql
WITH day_orders
AS(
	SELECT
		st.store_id, st.store_name,
		EXTRACT(ISODOW FROM sl.sale_date) AS day_of_week,
		TO_CHAR(sale_date, 'DAY') AS day_name,
		SUM(sl.quantity) AS total_quantity_sold,
		RANK() OVER (PARTITION BY st.store_id, st.store_name ORDER BY SUM(sl.quantity) DESC) AS rank_lvl
	FROM sales sl
		JOIN stores st
			ON sl.store_id = st.store_id
	GROUP BY st.store_id, st.store_name, day_of_week, day_name
)
SELECT
	store_id, store_name, day_of_week, day_name, total_quantity_sold
FROM day_orders
WHERE rank_lvl = 1;
```

### 11. Identify the lowest-selling product in each country for every year to uncover underperforming products and support inventory optimization decisions.

**Objective:** Identify consistently underperforming products across different markets to support inventory optimization, pricing adjustments, product improvements, or discontinuation decisions.

```sql
WITH country_year_sales
AS(
	SELECT
		st.country, EXTRACT(YEAR FROM sl.sale_date) AS sales_year, p.product_id, p.product_name,
		SUM(sl.quantity) AS total_quantity_sold,
		RANK() OVER (PARTITION BY st.country, EXTRACT(YEAR FROM sl.sale_date) ORDER BY SUM(sl.quantity) ASC) AS rank_lvl
	FROM sales sl
		JOIN stores st
			ON sl.store_id = st.store_id
		JOIN products p
			ON sl.product_id = p.product_id
	GROUP BY st.country, sales_year, p.product_id, p.product_name
)
SELECT
	country, sales_year, product_id, product_name, total_quantity_sold
FROM country_year_sales
WHERE rank_lvl = 1;
```

### 12. Measure the number of warranty claims submitted within 180 days of purchase to evaluate early product reliability.

**Objective:** Measure early product failure rates to identify quality issues, reduce warranty expenses, and support improvements in product design and manufacturing processes.

```sql
SELECT
	COUNT(*) AS no_of_warranty_claims
FROM warranty w
	JOIN sales s
		ON w.sale_id = s.sale_id
WHERE w.claim_date BETWEEN s.sale_date
				AND s.sale_date + INTERVAL '180 DAYS';
```

### 13. Measure warranty claim volume for products launched in the last two years to assess the reliability of recently introduced products.

**Objective:** Evaluate the reliability of newly launched products to detect quality issues early, improve future product launches, and protect customer trust in new offerings.

```sql
SELECT
	COUNT(*) AS total_claims_filed
FROM warranty w
	JOIN sales s
		ON s.sale_id = w.sale_id
	JOIN products p
		ON s.product_id = p.product_id
WHERE p.launch_date >= CURRENT_DATE - INTERVAL '2 YEARS';
```

### 14. Identify high-performing months in the USA where total sales exceeded 1,000 units during the previous three calendar years.

**Objective:** Identify periods of exceptionally high customer demand to improve demand forecasting, optimize inventory planning, and maximize revenue through better marketing and sales strategies.

```sql
SELECT
	DATE_TRUNC('MONTH', sl.sale_date) sale_year_month,
	SUM(sl.quantity) AS total_units_sold
FROM sales sl
	JOIN stores st
		ON sl.store_id = st.store_id
WHERE st.country = 'USA'
	AND sl.sale_date >= DATE_TRUNC('YEAR', CURRENT_DATE) - INTERVAL '3 YEARS'
		AND sl.sale_date < DATE_TRUNC('YEAR', CURRENT_DATE)
GROUP BY sale_year_month
HAVING SUM(sl.quantity) > 1000
ORDER BY sale_year_month;
```

### 15. Identify the product category with the highest warranty claim volume during the last two years to evaluate product reliability across categories.

**Objective:** Determine which product categories generate the highest warranty costs, enabling the business to prioritize quality improvements and reduce after-sales expenses.

```sql
WITH all_categories_claims
AS(
	SELECT
		c.category_id, c.category_name,
		COUNT(*) AS total_claims_filed,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_lvl
	FROM warranty w
		JOIN sales s
			ON w.sale_id = s.sale_id
		JOIN products p
			ON s.product_id = p.product_id
		JOIN category c
			ON p.category_id = c.category_id
	WHERE w.claim_date >= CURRENT_DATE - INTERVAL '2 YEARS'
	GROUP BY c.category_id, c.category_name
)
SELECT
	category_id, category_name, total_claims_filed
FROM all_categories_claims
WHERE rank_lvl = 1;
```

### 16. Calculate the warranty claim rate for each product in every country to assess product reliability across different markets.

**Objective:** Compare warranty claim rates across countries to evaluate regional product performance, identify market-specific quality issues, and support data-driven business decisions for each region.

```sql
WITH country_sales_and_claims
AS(
	SELECT
		st.country, p.product_id, p.product_name,
		COUNT(DISTINCT sl.sale_id) AS total_no_of_sales,
		COUNT(w.claim_id) AS total_claims_filed
	FROM sales sl
		LEFT JOIN warranty w
			ON w.sale_id = sl.sale_id
		JOIN stores st
			ON sl.store_id = st.store_id
		JOIN products p
			ON sl.product_id = p.product_id
	GROUP BY st.country, p.product_id, p.product_name
)
SELECT
	country, product_id, product_name,
	ROUND(total_claims_filed * 100.0 / NULLIF(total_no_of_sales, 0), 2) AS claim_rate
FROM country_sales_and_claims;
```

### 17. Measure year-over-year revenue growth for each store to evaluate long-term sales performance and business expansion.

**Objective:** Track annual sales growth for each store to identify high-performing and underperforming locations, supporting strategic investment, expansion, and performance improvement initiatives.

```sql
WITH store_sales
AS(
	SELECT
		st.store_id, st.store_name,
		EXTRACT(YEAR FROM sl.sale_date) AS sales_year,
		SUM(sl.quantity * p.price) AS current_year_sales
	FROM sales sl
		JOIN stores st
			ON sl.store_id = st.store_id
		JOIN products p
			ON sl.product_id = p.product_id
	GROUP BY st.store_id, st.store_name, sales_year
),
growth_rate
AS(
	SELECT
		store_id, store_name, sales_year, current_year_sales,
		LAG(current_year_sales) OVER (PARTITION BY store_id ORDER BY sales_year) AS previous_year_sales
	FROM store_sales
)
SELECT
	store_id, store_name, sales_year, current_year_sales, previous_year_sales,
	ROUND((current_year_sales - previous_year_sales) * 100.0 / NULLIF(previous_year_sales, 0), 2) AS growth_rate_percentage
FROM growth_rate;
```

### 18. Analyze the relationship between product price and warranty claims across different price segments to determine whether higher-priced products experience more warranty claims.

**Objective:** Analyze the relationship between product price and warranty claims to assess whether higher-priced products deliver better quality, helping refine pricing strategies and product positioning.

```sql
WITH price_range
AS(
	SELECT
		p.product_id, p.product_name, p.price,
		COUNT(w.claim_id) AS no_of_claims,
		CASE
			WHEN p.price >= 3000 THEN 'High'
			WHEN p.price >= 2500 THEN 'Mid-High'
			WHEN p.price >= 2000 THEN 'Mid'
			WHEN p.price >= 1500 THEN 'Mid-Low'
			WHEN p.price >= 100 THEN 'Low'
		END AS price_segment
	FROM sales sl
		JOIN products p
			ON sl.product_id = p.product_id
		LEFT JOIN warranty w
			ON sl.sale_id = w.sale_id
	WHERE sl.sale_date >= DATE_TRUNC('YEAR', CURRENT_DATE) - INTERVAL '4 YEARS'
		AND sl.sale_date < DATE_TRUNC('YEAR', CURRENT_DATE)
	GROUP BY p.product_id, p.product_name, p.price
)
SELECT
	price_segment,
	ROUND(CORR(price, no_of_claims)::NUMERIC, 3) AS correlation
FROM price_range
GROUP BY price_segment
ORDER BY CASE price_segment
			WHEN 'High' THEN 1
			WHEN 'Mid-High' THEN 2
			WHEN 'Mid' THEN 3
			WHEN 'Mid-Low' THEN 4
			WHEN 'Low' THEN 5
		 END;
```

### 19. Identify the store with the highest percentage of "Approved" claims relative to total claims filed.

**Objective:** Compare warranty claim approval rates across stores to ensure consistent customer service, identify process inefficiencies, and improve the overall warranty experience.

```sql
WITH claims
AS(
	SELECT
		st.store_id, st.store_name,
		COUNT(*) AS total_claims_filed,
		COUNT(*) FILTER (WHERE repair_status = 'Approved') AS approved_claims
	FROM sales sl
		JOIN stores st
			ON sl.store_id = st.store_id
		JOIN warranty w
			ON sl.sale_id = w.sale_id
	GROUP BY st.store_id, st.store_name
),
claims_percentage
AS(
SELECT
	store_id, store_name, total_claims_filed, approved_claims,
	ROUND(approved_claims * 100.0 / NULLIF(total_claims_filed, 0), 2) AS approved_claims_percentage,
	RANK() OVER (ORDER BY approved_claims * 100.0 / NULLIF(total_claims_filed, 0) DESC) AS rank_lvl
FROM claims
)
SELECT
	store_id, store_name, total_claims_filed, approved_claims, approved_claims_percentage
FROM claims_percentage
WHERE rank_lvl = 1;
```

### 20. Analyze monthly revenue trends for each store by calculating cumulative sales and month-over-month growth over the previous four years.

**Objective:** Monitor long-term sales trends for each store to evaluate business growth, support strategic planning, forecast future performance, and guide investment decisions.

```sql
WITH month_sales
AS(
	SELECT
		st.store_id, st.store_name,
		DATE_TRUNC('MONTH', sl.sale_date) AS sales_month,
		SUM(sl.quantity * p.price) AS monthly_sales
	FROM sales sl
		JOIN stores st
			ON sl.store_id = st.store_id
		JOIN products p
			ON sl.product_id = p.product_id
	WHERE sl.sale_date >= DATE_TRUNC('YEAR', CURRENT_DATE) - INTERVAL '4 YEARS'
		AND sl.sale_date < DATE_TRUNC('YEAR', CURRENT_DATE)
	GROUP BY st.store_id, st.store_name, sales_month
),
sales_trends
AS(
	SELECT
		store_id, store_name, sales_month, monthly_sales,
		SUM(monthly_sales) OVER (PARTITION BY store_id ORDER BY sales_month) AS running_total_sales,
		LAG(monthly_sales) OVER (PARTITION BY store_id ORDER BY sales_month) AS previous_month_sales
	FROM month_sales
)
SELECT
	store_id, store_name, sales_month, monthly_sales,
	running_total_sales, previous_month_sales,
	ROUND((monthly_sales - previous_month_sales) * 100.0 / NULLIF(previous_month_sales, 0), 2) AS sales_trends_percentage
FROM sales_trends;
```

### 21. Analyze product lifecycle performance by comparing sales revenue across key periods after product launch (0–6 months, 7–12 months, 13–18 months, and beyond 18 months).

**Objective:** Analyze product performance throughout its lifecycle to optimize inventory management, improve marketing strategies, refine pricing decisions, and make informed product launch or discontinuation decisions.

```sql
WITH all_sales
AS(
	SELECT
		p.product_id, p.product_name, p.launch_date, sl.sale_date,
		(sl.quantity * p.price) AS total_amount,
		CASE
			WHEN sl.sale_date <= p.launch_date + INTERVAL '6 MONTHS' THEN '00 - 06 Months'
			WHEN sl.sale_date <= p.launch_date + INTERVAL '12 MONTHS' THEN '07 - 12 Months'
			WHEN sl.sale_date <= p.launch_date + INTERVAL '18 MONTHS' THEN '13 - 18 Months'
			ELSE 'Beyond 18 Months'
		END AS key_period
	FROM sales sl
		JOIN products p
			ON sl.product_id = p.product_id
),
period_sales
AS(
	SELECT
		product_id, product_name, key_period,
		SUM(total_amount) AS total_sales
	FROM all_sales
	GROUP BY product_id, product_name, key_period
),
sales_trends
AS(
SELECT
	*,
	LAG(total_sales) OVER (PARTITION BY product_id, product_name ORDER BY CASE key_period
																						WHEN '00 - 06 Months' THEN 1
																						WHEN '07 - 12 Months' THEN 2
																						WHEN '13 - 18 Months' THEN 3
																						WHEN 'Beyond 18 Months' THEN 4
																					  END) AS previous_key_period_sale
FROM period_sales
)
SELECT
	product_id, product_name, key_period, total_sales, previous_key_period_sale,
	(total_sales - previous_key_period_sale) * 100.0 / NULLIF(previous_key_period_sale, 0) AS sales_growth_percentage
FROM sales_trends;
```
