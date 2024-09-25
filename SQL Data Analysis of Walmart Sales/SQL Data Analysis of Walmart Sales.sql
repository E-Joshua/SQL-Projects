use greens;

#-----------------------------------------------------------> Generic Question <-----------------------------------------------------------------------------------------------

select * from walmart;

alter table walmart
change column `Product line` Product_line text;

alter table walmart
change column `Invoice ID` Invoice_ID text;

alter table walmart
change column Unit_price Unit_price Double;

alter table walmart
change column `Tax 5%` Tax_5_percent double;

alter table walmart
change column `gross margin percentage` gross_margin_percentage double;

alter table walmart
change column `gross income` gross_income double;

alter table walmart
change column `Customer type` Customer_type text;

select * from walmart;

describe walmart;

# 1. How many unique cities does the data have?
select distinct city from walmart;

# 2. In which city is each branch?
select branch, city from walmart group by branch, city;

#------------------------------------------------------------------------> Product <-------------------------------------------------------------------------------------------

# 1. How many unique product lines does the data have?
select distinct Product_line from walmart;

# 2. What is the most common payment method?
select Payment, count(*) as count_of_payments from walmart group by Payment order by count_of_payments desc  limit 1;

# 3. What is the most selling product line?
select Product_line, count(*) as total_sales from walmart group by Product_line order by total_sales desc  limit 1;

select Date from walmart;
update walmart set `Date` = str_to_date(`Date`, '%d-%m-%Y');

desc walmart;

alter table walmart
modify column `Date` DATE;

# 4. What is the total revenue by month?
select date_format(`Date`,'%Y-%M') as Month, sum(Total) as Total_revenue from walmart group by Month;

# 5. What month had the largest COGS?
select date_format(`Date`,'%Y-%M') as Month, max(cogs) as COGS from walmart group by Month;

# 6. What product line had the largest revenue?
select product_line, sum(Total) as Total_revenue from walmart group by product_line order by Total_revenue desc limit 1;

# 5. What is the city with the largest revenue?
select City, sum(Total) as City_total_revenue from walmart group by City order by City_total_revenue desc limit 1;

# 6. What product line had the largest VAT?
select product_line, sum(Tax_5_percent) as VAT from walmart group by product_line order by VAT desc limit 1;

# 7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select product_line, count(*) as total_sales,
case
when count(*) > (select avg(product_count) from
(select count(*) as product_count from walmart
group by product_line) as avg_sales)
then 'Good'
else 'Bad'
End as sales_status
from walmart
group by product_line; -- > from internet

# 8. Which branch sold more products than average product sold?
select Branch, count(*) as total_prod_sold from walmart
group by Branch
having total_prod_sold > (select avg(product_count) from (select count(*) as product_count
from walmart
group by Branch) as avg_products);

# 9. What is the most common product line by gender?
select product_line, Gender, count(*) as Most_common from walmart group by product_line, gender  order by Most_common desc;

# 12. What is the average rating of each product line?
select product_line, round(avg(Rating),2) as Ratings from walmart group by product_line order by Ratings desc;

#--------------------------------------------------------------------------> Sales <-------------------------------------------------------------------------------------------

# 1. Number of sales made in each time of the day per weekday
select dayname(date) as day_of_week, time_format(time, '%H:00:00') as time_of_day, count(*) as Total_sales from walmart group by day_of_week, time_of_day order by day_of_week, day_of_week;

# 2. Which of the customer types brings the most revenue?
select Customer_type, sum(total) as Total_revenue from walmart group by Customer_type order by Total_revenue desc limit 1;

# 3. Which city has the largest tax percent/ VAT
select city, max(Tax_5_percent) as Largest_tax_percent from walmart group by city order by Largest_tax_percent desc limit 1;

# 4. Which customer type pays the most in VAT?
select Customer_type, sum(Tax_5_percent) as total_tax from walmart group by Customer_type order by total_tax desc limit 1;

#------------------------------------------------------------------------> CUSTOMERS <--------------------------------------------------------------------------------------------

# 1. How many unique customer types does the data have?
select distinct Customer_type from walmart;

# 2. How many unique payment methods does the data have?
select distinct Payment from walmart;

# 3. What is the most common customer type?
select Customer_type, count(*) as total_customers from walmart group by Customer_type order by total_customers desc limit 1;

# 4. Which customer type buys the most?
select Customer_type, sum(Total) as Total_revenue from walmart group by Customer_type order by Total_revenue desc limit 1;

# 5. What is the gender of most of the customers?
select gender, count(*) as count_of_gender from walmart group by gender order by count_of_gender desc limit 1;

# 6. What is the gender distribution per branch?
select branch, gender, count(*) as total_distribution from walmart group by branch, gender order by gender, total_distribution desc;

select time from walmart;

alter table walmart 
modify column `Time` TIME;

# 7. Which time of the day do customers give most ratings?
select time_format(Time, '%H:%m:%s') as Time_of_day, count(*) as Total_ratings from walmart group by Time_of_day order by Total_ratings desc limit 1;

# 8. Which time of the day do customers give most ratings per branch?
select branch, time_format(Time, '%H:%m:%s') as Time_of_day, count(*) as Total_ratings from walmart group by branch, Time_of_day order by branch, Total_ratings desc;

# 9. Which day of the week has the best avg ratings?
select dayname(Date) as Day_name, avg(Rating) as AVG_RATINGS from walmart group by Day_name order by AVG_RATINGS desc;

# 10. Which day of the week has the best average ratings per branch?
select branch, dayname(Date) as Day_of_week, avg(Rating) as AVG_RATINGS from walmart group by branch, Day_of_week order by branch, AVG_RATINGS desc;



