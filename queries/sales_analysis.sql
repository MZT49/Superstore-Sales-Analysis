-- Query 1: Profit by Category and Sub-Category --

-- Business Question: Which product categories and sub-categories are driving the most profit? --

SELECT  Category ,
        "Sub-Category" ,
        ROUND (SUM(Sales ), 2) AS Total_Sales,
        ROUND (SUM(Profit ), 2) AS Total_Profit
FROM Superstore_Sales
GROUP BY Category ,
         "Sub-Category" 
ORDER BY Total_Profit ASC  
;
-- Finding: Tables (-$17,725) and Bookcases (-$3,472) are loss-makers despite significant sales volume. --
--         Technology sub-categories dominate profitability led by Copiers ($55,617). --

-- Query 2: Sales vs Profit by Customer Segment --

-- Business Question: Which customer segments generate the best sales-to-profit ratio?--

SELECT Segment,
       Total_Sales ,
       Total_Profit ,
       ROUND(
          (Total_Profit / Total_Sales )* 100, 2) AS Profit_Margin
FROM 
(
SELECT Segment ,
       ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2)AS Total_Profit
FROM Superstore_Sales
GROUP BY Segment 
)
ORDER BY Profit_Margin DESC 
;
-- Finding: Home Office has the highest margin (14.03%) despite lowest revenue. --
--          Consumer generates the most revenue ($1.16M) but has the worst margin (11.55%). --

-- Query 3: Impact of Discount on Profit Margin --

-- Business Question: Does higher discounting actually hurt profit margins? --

SELECT 
    CASE               -- Note: Using CASE statement to bin discount values into bands for clearer pattern analysis. --
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.2 THEN '1%-20%'
        WHEN Discount <= 0.4 THEN '21%-40%'
        ELSE 'Above 40%'
    END AS Discount_Band,
    COUNT(*) AS Order_Count,
    ROUND(AVG(Profit), 2) AS Avg_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Sales
FROM Superstore_Sales
GROUP BY Discount_Band
ORDER BY Avg_Profit DESC
;
-- Finding: Discounting beyond 20% results in negative average profit. --
--          Orders with 40%+ discounts lose an average of $106.71 per order. --
--          933 orders fall in this category, representing significant margin destruction. --

-- Query 4a: Bottom 5 Sub-Categories by Profit (Loss-makers) --

-- Business Question: Which sub-categories are destroying value despite high sales volume? --

SELECT  "Sub-Category" ,
        ROUND (SUM(Sales ), 2) AS Total_Sales,
        ROUND (SUM(Profit ), 2) AS Total_Profit,
        ROUND (SUM(Profit)/SUM(Sales)* 100, 2) AS Profit_Margin
FROM Superstore_Sales
GROUP BY "Sub-Category" 
ORDER BY Total_Profit LIMIT 5
;                           -- Finding: Tables have $206k in sales but -$17,725 profit at -8.56% margin. --

-- Query 4b: Top 5 Sub-Categories by Profit (Stars) --

-- Business Question: Which sub-categories should the business prioritize? --

SELECT  "Sub-Category" ,
        ROUND (SUM(Sales ), 2) AS Total_Sales,
        ROUND (SUM(Profit ), 2) AS Total_Profit,
        ROUND (SUM(Profit)/SUM(Sales)* 100, 2) AS Profit_Margin
FROM Superstore_Sales
GROUP BY "Sub-Category" 
ORDER BY Total_Profit DESC LIMIT 5
;                               -- Finding: Copiers lead at 37.2% margin. Paper has the highest margin at 43.39%. --

-- Query 5: Monthly Sales Trend --

-- Business Question: Is the business growing and are there seasonal patterns? --

SELECT strftime('%Y', "Order Date") AS Year,
       strftime('%m', "Order Date") AS Month,
       COUNT("Order ID") Total_order ,
       SUM(Quantity) Total_Quantity,
       ROUND(SUM(Sales), 2) AS Total_Sales 
FROM Superstore_Sales
GROUP BY "Year" ,
         "Month" 
ORDER BY "Year" ,
         "Month" ASC
;

-- Note: strftime() used for date extraction as SQLite has no native DATEPART() function. --
--       Date column cleaned from mixed formats to ISO (YYYY-MM-DD) before import. --
