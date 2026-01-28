--SQL retailr Sales Analysis - P1 
CREATE DATABASE sql_project_p2

--Create a Table
DROP TABLE retails_sales IF EXISTS 
CREATE TABLE retails_sales (         
        transaction_id INT PRIMARY KEY,	
        sale_date DATE,	 
        sale_time TIME,	
        customer_id	INT,
        gender	VARCHAR(15),
        age	INT,
        category VARCHAR(50),	
        quantity	INT CHECK (quantity > 0),
        price_per_unit DECIMAL(10,2),	
        cogs	DECIMAL(10,2),
        total_sale DECIMAL(10,2)
); 
SELECT * FROM [dbo].[Retail Sales ] 
SELECT TOP (10)* FROM [dbo].[Retail Sales ] 
SELECT COUNT(*) FROM [dbo].[Retail Sales ]

--Data Cleaning

SELECT * FROM [dbo].[Retail Sales ]
WHERE  
    [transactions_id] IS NULL 
    OR [sale_date] IS NULL 
    OR [sale_time] IS NULL 
    OR [customer_id] IS NULL 
    OR [gender] IS NULL 
    OR [age] IS NULL 
    OR [category] IS NULL 
    OR [quantiy] IS NULL 
    OR [price_per_unit] IS NULL 
    OR [cogs] IS NULL 
    OR [total_sale] IS NULL; 

DELETE FROM [dbo].[Retail Sales ]
WHERE  
    [transactions_id] IS NULL 
    OR [sale_date] IS NULL 
    OR [sale_time] IS NULL 
    OR [customer_id] IS NULL 
    OR [gender] IS NULL 
    OR [age] IS NULL 
    OR [category] IS NULL 
    OR [quantiy] IS NULL 
    OR [price_per_unit] IS NULL 
    OR [cogs] IS NULL 
    OR [total_sale] IS NULL; 

--Data Exploration

--How many sales we have
SELECT COUNT (*) AS [total_sale] FROM [dbo].[Retail Sales ]

--How many unique customers we have?
SELECT COUNT (DISTINCT [customer_id]) AS [total_sale] 
FROM [dbo].[Retail Sales ];

--How many unique categories we have?
SELECT COUNT (DISTINCT [category]) AS [total_sale] 
FROM [dbo].[Retail Sales ];


--Data analysis & business key problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM [dbo].[Retail Sales ]
WHERE [sale_date] = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
    *
FROM [dbo].[Retail Sales ]
WHERE [category] = 'Clothing'
AND YEAR([sale_date]) = '2022'
AND MONTH([sale_date])='11' 
AND [quantiy] >= 4 

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    [category]
    ,SUM([total_sale]) AS net_sale
    ,COUNT(*) AS total_orders
 FROM [dbo].[Retail Sales ]
GROUP BY [category]
ORDER BY net_sale DESC

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    ROUND(AVG(age), 2)  AS avg_age
    ,MIN(age) AS min_age
    ,MAX(age) AS max_age
    ,COUNT(DISTINCT [customer_id]) AS total_customers 
FROM [dbo].[Retail Sales ]
WHERE [category] = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM [dbo].[Retail Sales ] 
WHERE [total_sale]> 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) 
-- made by each gender in each category.

SELECT 
     [category]
     ,[gender]
     ,COUNT (*) AS total_trans
     ,SUM([total_sale]) AS total_revenue
     ,CAST (AVG([total_sale]) AS DECIMAL (10,2)) AS avg_transaction_value
 FROM [dbo].[Retail Sales ]
 GROUP BY [category] ,[gender]
 ORDER BY [category], total_trans DESC; 


 -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * FROM 
    (
        SELECT 
            YEAR([sale_date]) AS year
            ,MONTH([sale_date]) AS month
            ,SUM([total_sale]) AS total_sale
            ,CAST(AVG([total_sale]) AS DECIMAL(10,2)) AS avg_sale
            ,RANK() OVER(PARTITION BY YEAR([sale_date]) ORDER BY AVG([total_sale]) DESC) AS rank 
        FROM [dbo].[Retail Sales ]
    GROUP BY YEAR([sale_date]) ,MONTH([sale_date]) 
    --ORDER BY YEAR, MONTH,  avg_sale DESC
    ) as t1 
WHERE rank= 1 
ORDER BY YEAR;  

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT TOP 5 
[customer_id]
,SUM([total_sale]) AS total_sales
FROM [dbo].[Retail Sales ]
GROUP BY [customer_id]
ORDER BY total_sales


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    [category]
    ,COUNT(DISTINCT [customer_id]) AS cnt_unique_customer
FROM [dbo].[Retail Sales ]
GROUP BY [category]


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 
SELECT
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
    ,COUNT(DISTINCT transactions_id) AS total_orders
FROM dbo.[Retail Sales ]
GROUP BY
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;

--End of Project




