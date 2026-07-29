CREATE TABLE category
(
	category_id VARCHAR(5) PRIMARY KEY,
	category_name VARCHAR(20) NOT NULL
);

CREATE TABLE products
(
	product_id VARCHAR(10) PRIMARY KEY,
	product_name VARCHAR(25) NOT NULL,
	category_id VARCHAR(10) NOT NULL,
	launch_date DATE,
	price NUMERIC(10, 2) CHECK (price > 0),
	CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE stores
(
	store_id VARCHAR(15) PRIMARY KEY,
	store_name VARCHAR(25) NOT NULL,
	city VARCHAR(35),
	country VARCHAR(15) NOT NULL
);

CREATE TABLE sales
(
	sale_id VARCHAR(15) PRIMARY KEY,
	sale_date DATE,
	store_id VARCHAR(15) NOT NULL,
	product_id VARCHAR(15) NOT NULL,
	quantity INT NOT NULL,
	CONSTRAINT fk_stores FOREIGN KEY (store_id) REFERENCES stores(store_id),
	CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE warranty
(
	claim_id VARCHAR(15) PRIMARY KEY,
	claim_date DATE,
	sale_id VARCHAR(15) NOT NULL,
	repair_status VARCHAR(15) NOT NULL,
	CONSTRAINT fk_sales FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);