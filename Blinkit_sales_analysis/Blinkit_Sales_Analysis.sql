select * from BlinkIt;

update BlinkIt
set Item_Fat_Content=
case 
when Item_Fat_Content='LF' then 'Low Fat'
when Item_Fat_Content='low fat' then 'Low Fat'
when Item_Fat_Content='reg' then 'Regular'
else Item_Fat_Content end;


select distinct(Item_Fat_Content) from BlinkIt;

--total sale
select round(sum(total_sales)/1000000,2) as "total_sales(million)" from BlinkIt;

--avg sales
select cast(avg(total_sales) as int) as Average_sales
from BlinkIt;

select count(*) as total_items
from BlinkIt;

--avg rating
select cast(avg(rating) as decimal(10,1)) as avg_rating
from BlinkIt;

-- Total Sales by Fat Content:
select Item_Fat_Content, cast(sum(total_sales) as decimal(10,2)) as total_sales
from BlinkIt
group by Item_Fat_Content;


--Total Sales by Item Type
select Item_Type, cast(sum(total_sales) as decimal(10,2)) as total_sales
from BlinkIt
group by Item_Type
order by total_sales desc;


--Fat Content by Outlet for Total Sales
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

select Outlet_Location_Type,
cast(sum(case when item_fat_content='Low Fat' then total_sales else 0 end) as decimal(10,2)) as 'Low Fat',
cast(sum(case when item_fat_content='Regular' then total_sales else 0 end) as decimal(10,2)) as 'Regular'
from blinkit
group by outlet_location_type
order by outlet_location_type;


 --Total Sales by Outlet Establishment
select Outlet_Establishment_Year ,cast(sum(total_sales) as decimal(10,2)) as total_sales
from BlinkIt
group by Outlet_Establishment_Year
order by total_sales desc;


--Percentage of Sales by Outlet Size
select Outlet_Size, cast(sum(total_sales) as decimal(10,2)) as total_sales, cast(sum(total_sales)*100/sum(sum(total_sales)) over() as decimal(10,2)) as sale_percent
from BlinkIt
group by Outlet_Size
ORDER BY Total_Sales DESC;

--Sales by Outlet Location
SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC

--total_sales,avg_sales,total_orders,avg_rating,avg_visibility
select Outlet_Type,
                    cast(sum(total_sales) as decimal(10,2)) as Total_sales,
                    cast(avg(total_sales) as decimal(10,2)) as avg_sales,
                    count(*) as total_orders,
                    cast(avg(rating) as decimal(10,2)) as avg_rating,
                    cast(avg(Item_Visibility) as decimal(10,2)) as avg_visibility
from BlinkIt
group by Outlet_Type
ORDER BY Total_Sales DESC;
