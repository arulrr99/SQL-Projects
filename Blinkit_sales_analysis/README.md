# Blinkit Sales Analysis SQL Project

## Project Overview

**Project Title**: Blinkit Sales Analysis  
**Level**: Beginner  

To conduct a comprehensive analysis of Blinkit's sales performance, customer satisfaction, and inventory distribution to identify key insights and opportunities for optimization using various KPIs and visualizations in Power BI.

## Objectives

1. Total Sales: The overall revenue generated from all items sold.
2. Average Sales: The average revenue per sale.
3. Number of Items: The total count of different items sold.
4. Average Rating: The average customer rating for items sold.
5. Total Sales by Fat Content:
	Objective: Analyze the impact of fat content on total sales.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
6. Total Sales by Item Type:
	Objective: Identify the performance of different item types in terms of total sales.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
7. Fat Content by Outlet for Total Sales:
	Objective: Compare total sales across different outlets segmented by fat content.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
8. Total Sales by Outlet Establishment:
	Objective: Evaluate how the age or type of outlet establishment influences total sales.
9. Percentage of Sales by Outlet Size:
	Objective: Analyze the correlation between outlet size and total sales.
10. Sales by Outlet Location:
	Objective: Assess the geographic distribution of sales across different locations.
11. All Metrics by Outlet Type:



```sql
select * from BlinkIt;
```

Data cleaning

```sql
update BlinkIt
set Item_Fat_Content=
case 
when Item_Fat_Content='LF' then 'Low Fat'
when Item_Fat_Content='low fat' then 'Low Fat'
when Item_Fat_Content='reg' then 'Regular'
else Item_Fat_Content end;
```

```sql
select distinct(Item_Fat_Content) from BlinkIt;
```


1. Total sale
```sql
select round(sum(total_sales)/1000000,2) as "total_sales(million)" from BlinkIt;
```

2.Average sales

```sql
select cast(avg(total_sales) as int) as Average_sales
from BlinkIt;
```

3. Number of items
```sql
select count(*) as total_items
from BlinkIt;
```


4.Average rating
```sql
select cast(avg(rating) as decimal(10,1)) as avg_rating
from BlinkIt;
```


5.Total Sales by Fat Content:
```sql
select Item_Fat_Content, cast(sum(total_sales) as decimal(10,2)) as total_sales
from BlinkIt
group by Item_Fat_Content;
```

6.Total Sales by Item Type
```sql
select Item_Type, cast(sum(total_sales) as decimal(10,2)) as total_sales
from BlinkIt
group by Item_Type
order by total_sales desc;
```

7.Fat Content by Outlet for Total Sales
```sql
select Outlet_Location_Type,
cast(sum(case when item_fat_content='Low Fat' then total_sales else 0 end) as decimal(10,2)) as 'Low Fat',
cast(sum(case when item_fat_content='Regular' then total_sales else 0 end) as decimal(10,2)) as 'Regular'
from blinkit
group by outlet_location_type
order by outlet_location_type;
```

 8.Total Sales by Outlet Establishment
 ```sql
select Outlet_Establishment_Year ,cast(sum(total_sales) as decimal(10,2)) as total_sales
from BlinkIt
group by Outlet_Establishment_Year
order by total_sales desc;
```


9.Percentage of Sales by Outlet Size
```sql
select Outlet_Size, cast(sum(total_sales) as decimal(10,2)) as total_sales, cast(sum(total_sales)*100/sum(sum(total_sales)) over() as decimal(10,2)) as sale_percent
from BlinkIt
group by Outlet_Size
ORDER BY Total_Sales DESC;
```

10.Sales by Outlet Location
```sql
SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;
```

11.All metrics by outlet type
```sql
select Outlet_Type,
                    cast(sum(total_sales) as decimal(10,2)) as Total_sales,
                    cast(avg(total_sales) as decimal(10,2)) as avg_sales,
                    count(*) as total_orders,
                    cast(avg(rating) as decimal(10,2)) as avg_rating,
                    cast(avg(Item_Visibility) as decimal(10,2)) as avg_visibility
from BlinkIt
group by Outlet_Type
ORDER BY Total_Sales DESC;
```
