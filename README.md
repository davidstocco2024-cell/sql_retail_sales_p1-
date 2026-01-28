# Retail Sales Analysis – SQL Portfolio Project

## Overview
This project analyzes retail sales data using SQL Server with a focus on data cleaning, exploratory analysis, and business-oriented insights.  
It is part of my data analyst portfolio and demonstrates practical SQL skills used in real-world analytics scenarios.

## Business Objective
Understand sales performance, customer behavior, and time-based patterns to support commercial decision-making.

Key questions addressed:
- Which categories generate the highest revenue?
- Who are the top customers?
- How do sales vary by time of day and month?
- What customer segments drive sales?

## Dataset
Retail sales transactional data including:
- Transaction date and time
- Customer demographics
- Product categories
- Sales, quantity, and cost metrics

## Tech Stack
- SQL Server
- T-SQL
- Data modeling
- CTEs and window functions
- Aggregations and conditional logic

## Data Preparation
- Schema design with appropriate data types
- Null value validation and filtering
- Consistency checks across key columns

## Key Analyses
- Total sales and order volume by category
- Average customer age by product category
- High-value transactions identification
- Monthly sales performance and peak months
- Top customers by total revenue
- Customer distribution by category
- Order volume by time-of-day shift (Morning / Afternoon / Evening)

## Example Query – Sales by Category
```sql
SELECT 
    category,
    SUM(total_sale) AS net_sales,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
# sql_retail_sales_p1-
