1. Compute Running Total Sales per Customer 
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) as running_total
FROM sales_data
ORDER BY customer_id, order_date;
 2. Count the Number of Orders per Product Category 
SELECT 
    product_category,
    COUNT(*) as order_count,
    SUM(quantity_sold) as total_quantity_sold
FROM sales_data
GROUP BY product_category
ORDER BY order_count DESC;
3. Find the Maximum Total Amount per Product Category 
SELECT 
    product_category,
    MAX(total_amount) as max_sale_amount,
    product_name,
    customer_name
FROM sales_data
GROUP BY product_category
ORDER BY max_sale_amount DESC;
4.. Find the Minimum Price of Products per Product Category 
SELECT 
    product_category,
    MIN(unit_price) as min_unit_price,
    product_name
FROM sales_data
GROUP BY product_category
ORDER BY min_unit_price;
5.  Compute the Moving Average of Sales of 3 days 
SELECT 
    order_date,
    SUM(total_amount) as daily_sales,
    ROUND(AVG(SUM(total_amount)) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ), 2) as moving_avg_3days
FROM sales_data
GROUP BY order_date
ORDER BY order_date;
6. Find the Total Sales per Region 
SELECT 
    region,
    SUM(total_amount) as total_sales,
    COUNT(*) as total_orders,
    ROUND(AVG(total_amount), 2) as avg_order_value
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;
7. Compute the Rank of Customers Based on Their Total Purchase Amount 
SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) as total_purchase_amount,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) as customer_rank
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY customer_rank;
8. Calculate the Difference Between Current and Previous Sale Amount per Customer 
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) as previous_sale_amount,
    total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) as amount_difference
FROM sales_data
ORDER BY customer_id, order_date;
9. Find the Top 3 Most Expensive Products in Each Category 
WITH RankedProducts AS (
    SELECT 
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY unit_price DESC) as price_rank
    FROM (
        SELECT DISTINCT 
            product_category,
            product_name,
            unit_price
        FROM sales_data
    ) distinct_products
)
SELECT 
    product_category,
    product_name,
    unit_price,
    price_rank
FROM RankedProducts
WHERE price_rank <= 3
ORDER BY product_category, price_rank;
10. Compute the Cumulative Sum of Sales Per Region by Order Date 
SELECT 
    region,
    order_date,
    SUM(total_amount) as daily_sales,
    SUM(SUM(total_amount)) OVER (PARTITION BY region ORDER BY order_date) as cumulative_sales
FROM sales_data
GROUP BY region, order_date
ORDER BY region, order_date;
11. Compute Cumulative Revenue per Product Category 
SELECT 
    product_category,
    order_date,
    SUM(total_amount) as daily_revenue,
    SUM(SUM(total_amount)) OVER (
        PARTITION BY product_category 
        ORDER BY order_date
    ) as cumulative_revenue
FROM sales_data
GROUP BY product_category, order_date
ORDER BY product_category, order_date;
12. Here you need to find out the sum of previous values. Please go through the sample input and expected output.
SELECT 
    ID,
    SUM(ID) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as SumPreValues
FROM your_table
ORDER BY ID;
13. Sum of Previous Values to Current Value 
SELECT 
    Value,
    COALESCE(SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 0) as "Sum of Previous"
FROM OneColumn
ORDER BY Value;
14. Find customers who have purchased items from more than one product_category 
SELECT 
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) as unique_categories
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1
ORDER BY unique_categories DESC, customer_id;
15. Find Customers with Above-Average Spending in Their Region 
WITH RegionalAverages AS (
    SELECT 
        region,
        AVG(total_amount) as avg_region_spending
    FROM sales_data
    GROUP BY region
)
SELECT 
    s.customer_id,
    s.customer_name,
    s.region,
    SUM(s.total_amount) as total_spent,
    r.avg_region_spending
FROM sales_data s
JOIN RegionalAverages r ON s.region = r.region
GROUP BY s.customer_id, s.customer_name, s.region, r.avg_region_spending
HAVING SUM(s.total_amount) > r.avg_region_spending
ORDER BY s.region, total_spent DESC; 
16. 16. Rank customers based on total spending within each region ✓ 
WITH CustomerSpending AS (
    SELECT 
        customer_id,
        customer_name,
        region,
        SUM(total_amount) as total_spent
    FROM sales_data
    GROUP BY customer_id, customer_name, region
)
SELECT 
    customer_id,
    customer_name,
    region,
    total_spent,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY total_spent DESC) as region_rank
FROM CustomerSpending
ORDER BY region, region_rank;
17. Calculate running total for each customer_id ✓ 
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) as cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;
18. Calculate sales growth rate month-over-month  

WITH MonthlySales AS (
    SELECT 
        YEAR(order_date) as year,
        MONTH(order_date) as month,
        SUM(total_amount) as monthly_sales
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT 
    year,
    month,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY year, month) as prev_month_sales,
    ROUND(
        ((monthly_sales - LAG(monthly_sales) OVER (ORDER BY year, month)) / 
         LAG(monthly_sales) OVER (ORDER BY year, month)) * 100, 
        2
    ) as growth_rate
FROM MonthlySales
ORDER BY year, month; 
19. 19. Identify customers with higher amount than last order ✓ 
WITH CustomerOrders AS (
    SELECT 
        customer_id,
        customer_name,
        order_date,
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) as last_order_amount
    FROM sales_data
)
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    last_order_amount,
    (total_amount - last_order_amount) as increase_amount
FROM CustomerOrders
WHERE total_amount > last_order_amount
ORDER BY customer_id, order_date; 
20. Identify Products that prices are above the average product price 
SELECT 
    product_name,
    product_category,
    unit_price,
    (SELECT ROUND(AVG(unit_price), 2) FROM sales_data) as overall_avg_price,
    ROUND(unit_price - (SELECT AVG(unit_price) FROM sales_data), 2) as price_difference
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data)
GROUP BY product_name, product_category, unit_price
ORDER BY price_difference DESC;
21. In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. For more details please see the sample input and expected output.
SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL 
    END as Tot
FROM MyData
ORDER BY Grp, Id;
22. Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details. 
SELECT 
    ID,
    Cost,
    Quantity,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY ID ORDER BY (SELECT NULL)) = 1 
        THEN SUM(Cost) OVER (PARTITION BY ID) * 
             CASE 
                 WHEN COUNT(DISTINCT Quantity) OVER (PARTITION BY ID) > 1 
                 THEN SUM(Quantity) OVER (PARTITION BY ID)
                 ELSE MAX(Quantity) OVER (PARTITION BY ID)
             END
        ELSE NULL 
    END as TotalValue
FROM TheSumPuzzle
ORDER BY ID;
23. From following set of integers, write an SQL statement to determine the expected outputs 
WITH SeatGaps AS (
    SELECT
        SeatNumber as CurrentSeat,
        LEAD(SeatNumber) OVER (ORDER BY SeatNumber) as NextSeat,
        LEAD(SeatNumber) OVER (ORDER BY SeatNumber) - SeatNumber as GapSize
    FROM Seats
)
SELECT
    CurrentSeat + 1 as "Gap Start",
    NextSeat - 1 as "Gap End",
    NextSeat - CurrentSeat - 1 as GapLength
FROM SeatGaps
WHERE NextSeat - CurrentSeat > 1
ORDER BY "Gap Start";
