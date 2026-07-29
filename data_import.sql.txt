COPY category
FROM 'D:\SQL\DataSets\Zero Analyst\project 7 apple_large_dataset\category.csv'
DELIMITER ','
CSV HEADER;

COPY products
FROM 'D:\SQL\DataSets\Zero Analyst\project 7 apple_large_dataset\products.csv'
DELIMITER ','
CSV HEADER;

COPY stores
FROM 'D:\SQL\DataSets\Zero Analyst\project 7 apple_large_dataset\stores.csv'
DELIMITER ','
CSV HEADER;

COPY sales
FROM 'D:\SQL\DataSets\Zero Analyst\project 7 apple_large_dataset\sales.csv'
DELIMITER ','
CSV HEADER;

COPY warranty
FROM 'D:\SQL\DataSets\Zero Analyst\project 7 apple_large_dataset\warranty.csv'
DELIMITER ','
CSV HEADER;