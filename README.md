# 🛒 Grocery Sales SQL Analysis
**by Christian Kho Aler**

A SQL analysis project using a Philippine-based supermarket/grocery sales dataset. This project demonstrates real-world sales analysis techniques using MySQL including Window Functions, CTEs, Aggregations, Subqueries, and Percentage Calculations.

---

## 📁 Dataset

Two tables were used in this analysis:

### `products` (25 rows)
Contains product information including real Philippine grocery brands.

| Column | Type | Description |
|--------|------|-------------|
| product_id | INT | Primary key |
| product_name | VARCHAR | Full product name (e.g. Lucky Me Pancit Canton) |
| category | VARCHAR | Product category (e.g. Canned Goods, Beverages) |
| brand | VARCHAR | Brand name (e.g. Nestle, San Miguel, UFC) |
| price | DECIMAL | Unit price in PHP |
| unit | VARCHAR | Unit of measure |

### `transactions` (200 rows)
Contains sales transaction records from multiple branches across the Philippines.

| Column | Type | Description |
|--------|------|-------------|
| transaction_id | INT | Primary key |
| product_id | INT | Foreign key → products |
| customer_name | VARCHAR | Full name of customer |
| gender | VARCHAR | Male / Female |
| customer_city | VARCHAR | Customer's city |
| quantity | INT | Number of units purchased |
| unit_price | DECIMAL | Price per unit in PHP |
| total_amount | DECIMAL | Total transaction amount in PHP |
| payment_method | VARCHAR | Cash / GCash / Maya / Credit Card / Debit Card |
| branch | VARCHAR | Store branch (SM, Robinsons, Puregold, SaveMore) |
| transaction_date | DATE | Date of transaction |

---

## 🔍 Analysis Queries

### 🏪 Branch Performance
- **Most Popular Branch with Percentage Rate** — Ranks branches by number of transactions with share percentage using `SUM(COUNT(*)) OVER()`
- **Profit per Branch (Most to Least)** — Ranks branches by total revenue generated
- **Most Profitable Product per Branch** — Uses CTE + `RANK() OVER(PARTITION BY branch)` to find the top earning product in each branch
- **Most Sold Product per Branch** — Uses CTE + `RANK() OVER(PARTITION BY branch)` to find the highest volume product per branch

### 💰 Product Performance
- **Profitable to Least Products** — Full ranking of all products by total revenue
- **Most Profitable Product** — Single top revenue-generating product
- **Least Profitable Product** — Single lowest revenue-generating product
- **Total Sold per Quantity** — Ranks products by total units sold across all branches

### 👥 Customer Insights
- **Customers Who Buy Multiple Times** — Identifies repeat customers using `HAVING`
- **Customer City with Percentage Rate** — Shows which cities contribute most to transactions
- **Gender Breakdown with Percentage Rate** — Male vs Female transaction share

### 💳 Payment Behavior
- **Most Used Payment Method with Percentage Rate** — Breakdown of Cash, GCash, Maya, Credit Card, Debit Card usage

### 📅 Time-Based Analysis
- **Monthly Running Total (2023–2024)** — Cumulative revenue per month that resets every year using `SUM(SUM()) OVER(PARTITION BY YEAR)`
- **Total Profit per Year** — Annual revenue summary
- **Overall Profit (All Years)** — Single total revenue across the entire dataset

---

## 🛠️ SQL Concepts Used

| Concept | Usage |
|--------|-------|
| `CTE` | Organizing branch + product ranking queries |
| `RANK()` | Ranking top product per branch |
| `PARTITION BY` | Separating rankings per branch |
| `SUM(COUNT(*)) OVER()` | Calculating percentage share without subquery |
| `SUM(SUM()) OVER()` | Monthly running total on grouped data |
| `GROUP BY` + `HAVING` | Filtering repeat customers |
| `JOIN` | Combining products and transactions tables |
| `YEAR()` / `MONTH()` | Extracting date parts for time-based analysis |
| `ROUND()` | Formatting percentage and decimal outputs |
| `LIMIT` | Pulling single top/bottom records |

---

## 💡 Key Design Decisions

- **`SUM(COUNT(*)) OVER()`** used for percentage calculations instead of a correlated subquery — more efficient and cleaner syntax
- **`RANK()` over `DENSE_RANK()`** used in branch-product combos — in case of ties, only the strict top 1 per branch is shown
- **Profit and quantity analyzed separately** — revenue and volume don't always tell the same story; a cheap product sold in high volume may rank differently than an expensive product sold less

---

## 🚀 How to Use

1. Import `products.csv` first
2. Import `transactions.csv` second (requires `product_id` foreign key from products)
3. Run `grocery_analysis.sql` in MySQL Workbench or any MySQL client

```sql
-- Quick setup
CREATE DATABASE grocery_sales;
USE grocery_sales;
-- Then import both CSV files and run the analysis
```

---

## 📌 Tools Used
- **MySQL** — Query language
- **MySQL Workbench** — SQL editor and database management

---

## 👤 Author
**Christian Kho Aler**
Aspiring Data Analyst
