-- sales database contains this tables

select * from customers;
select * from markets;
select * from products;
select * from transactions;

-- Total number of tranasactions
select count(*) from transactions;

-- Getting Names of unique customers
select distinct count(custmer_name) from customers;

-- Getting Top 10 Highest Revenue Generated Market Names 
select m.markets_name ,sum(sales_amount) as Total_Sales
from markets m
join transactions t on t.market_code = m.markets_code
group by m.markets_name
order by Total_Sales desc
limit 10;

-- Getting Top 10 Highest Quantity Sold Through Markets
select m.markets_name ,sum(sales_qty) as Total_Quantity
from markets m
join transactions t on t.market_code = m.markets_code
group by m.markets_name
order by Total_Quantity desc
limit 10;

-- Finding unrelavant Data and Deleting them
select count(*) from transactions
where sales_amount like 0 and -1;

delete from transactions
where sales_amount = 0 and -1;

-- Getting Top 5 Highest Revenue Generated Customers 
select distinct c.custmer_name as customers , sum(sales_amount) as Total_Sales
from customers c
join transactions t on t.customer_code = c.customer_code
group by c.custmer_name
order by Total_Sales desc
limit 5;

-- Getting Top 5 Highest Revenue Generated Products 
select distinct p.product_code as Products , sum(sales_amount) as Total_Sales
from products p
join transactions t on t.product_code = p.product_code
group by p.product_code
order by Total_Sales desc
limit 5;

-- Retriving set of columns at once
select product_code,order_date, sales_qty,sales_amount from transactions;   

-- this query is used to get unique product code
select distinct product_code from sales.transactions where market_code = "mark001"; 

-- total transactions performed in chennai location (i.e mark001)
select * from transactions where market_code = "mark001";
select count(*) from transactions where market_code = "mark001";  

-- Filtering largest sales of sales amount above 10 lakhs in descending order 
select * from transactions
where sales_amount > 1000000
order by sales_amount desc;

-- Distinct products
select distinct(product_code) from transactions;           

-- this query gives us total amount of distinct products
select product_code, sum(sales_amount) from transactions  
group by product_code
order by product_code;

-- this query gives us maximum sales_amount of a product
select product_code, max(sales_amount) as Maximum_amount 
from transactions                                     
group by product_code
order by maximum_amount desc
limit 1;

-- using inner join we are joined date and transactions tables and used filter for year 2020 
SELECT transactions.*, date.* 
FROM transactions 
INNER JOIN date                     
ON transactions.order_date=date.date 
where date.year=2020;

-- total revenue in year 2020
SELECT SUM(transactions.sales_amount) FROM 
transactions INNER JOIN date                      
ON transactions.order_date=date.date 
where date.year=2020 and transactions.currency="INR\r" or transactions.currency="USD\r";

--  total revenue in year 2020, January Month
SELECT SUM(transactions.sales_amount) FROM transactions      
INNER JOIN date ON transactions.order_date=date.date          
where date.year=2020 and date.month_name="January" and (transactions.currency="INR\r" or transactions.currency="USD\r");

-- finding min,max,avg,count of sales_amount using window aggregate functions 
select *,
max(sales_amount) over(partition by product_code) as max_amount,     
min(sales_amount) over(partition by product_code) as min_amount,
avg(sales_amount) over(partition by product_code) as avg_amount,
count(sales_amount) over(partition by product_code) as count_amount
from transactions;

-- window ranking functions
select *,                                                            
rank () over(partition by product_code order by sales_amount desc) as rnk,
dense_rank() over(partition by product_code order by sales_amount desc) as dense_rnk,
row_number() over(partition by product_code order by product_code ) as rn
from transactions;








