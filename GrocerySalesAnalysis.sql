
-- Grocery Data Analysis by Christian Kho Aler

-- Most popular branch with percentage rate

SELECT 
	branch, 
    COUNT(*) as sales_per_branch,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),2) as percent_branch
    FROM transactions
    GROUP BY branch
    ORDER BY sales_per_branch DESC;

-- Customer's city with percentage rate

SELECT 
	customer_city, 
    COUNT(*) as total_city,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),2) as percent_city
    FROM transactions
    GROUP BY customer_city
    ORDER BY total_city DESC;
    
-- Profitable to least products

SELECT 
	p.product_id,
    p.product_name,
    SUM(total_amount) as total_profit
    
    FROM products p JOIN transactions t
    ON p.product_id = t.product_id
    GROUP BY product_id, p.product_name
    ORDER BY total_profit DESC;

-- Most profitable product

SELECT 
	p.product_id,
    p.product_name,
    SUM(total_amount) as total_profit
    FROM products p JOIN transactions t
    ON p.product_id = t.product_id
    GROUP BY product_id, p.product_name
    ORDER BY total_profit DESC LIMIT 1;
    
-- Least profitable product
    
SELECT 
	p.product_id,
    p.product_name,
    SUM(total_amount) as total_profit
    FROM products p JOIN transactions t
    ON p.product_id = t.product_id
    GROUP BY product_id, p.product_name
    ORDER BY total_profit ASC LIMIT 1;
    
-- Most Used payment_method with percentage rate

SELECT 
	Payment_method,
    COUNT(*) as total_payment_method,
	ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),2) AS percent_payment
    FROM transactions 
    GROUP BY payment_method
    ORDER BY total_payment_method DESC;

-- Customer's who buy multiple times

SELECT 
	customer_name,
    count(*) as number_purchase
    FROM transactions
    GROUP BY customer_name
    HAVING number_purchase > 1
    ORDER BY number_purchase DESC;
    
-- Gender breakdown with percentage rate

SELECT 
	gender,
    COUNT(*) total_gender,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),2) as percent_gender
    FROM transactions 
    GROUP BY gender
    ORDER BY total_gender DESC;
    
-- Total Sold per quantity

SELECT 
	p.product_id,
    p.product_name,
    SUM(t.quantity) as total_quantity
    FROM products p JOIN transactions t ON p.product_id = t.product_id 
    GROUP BY 	p.product_id,
    p.product_name
    ORDER BY total_quantity DESC;
    
-- Monthly Running total (2023-2024)

SELECT 
	YEAR(transaction_date) as year_trans,
	MONTH(transaction_date) as month_trans,
    SUM(SUM(total_amount)) OVER(PARTITION BY YEAR(transaction_date) ORDER BY MONTH(transaction_date) ASC)  running_total
    FROM transactions 
    GROUP BY year_trans, month_trans
    ORDER BY year_trans, month_trans;
    
-- Total profit per year

SELECT
	YEAR(transaction_date) as total_profit_year,
    SUM(total_amount) as total_profit
    FROM transactions 
    GROUP BY total_profit_year 
    ORDER BY total_profit_year;
    
-- Overall profit including all years

SELECT 
	SUM(total_amount) as overall_profit
	FROM transactions;
    
-- Profit per stores (Most-Least)

SELECT 
	Branch,
    SUM(total_amount) as branch_profit
    FROM transactions
    GROUP BY branch
    ORDER BY branch_profit DESC;

-- Most profitable product per branch

WITH rank_combo AS (

	SELECT
		t.branch,
        p.product_name,
        SUM(total_amount) as total_profit,
        RANK() OVER(PARTITION BY t.branch ORDER BY SUM(total_amount) DESC ) as rnk 
        FROM products p JOIN transactions t ON p.product_id = t.product_id
        GROUP BY t.branch, p.product_name
)
SELECT 
	branch,
    product_name,
    total_profit
    FROM rank_combo
    WHERE rnk = 1
    ORDER BY total_profit DESC;
    
-- Most sells product per branch

WITH rank_combo AS (

	SELECT
		t.branch,
        p.product_name,
        SUM(quantity) as total_sales,
        RANK() OVER(PARTITION BY t.branch ORDER BY SUM(quantity) DESC ) as rnk 
        FROM products p JOIN transactions t ON p.product_id = t.product_id
        GROUP BY t.branch, p.product_name
)
SELECT 
	branch,
    product_name,
    total_sales
    FROM rank_combo
    WHERE rnk = 1
    ORDER BY total_sales DESC;


    