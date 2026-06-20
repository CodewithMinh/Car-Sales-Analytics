-- 1. Giá bán trung bình và tổng giá trị xe bán ra thay đổi thế nào theo năm?
select car_sales.year
	, round(avg(sellingprice),2) as avg_selling_price
	, sum(sellingprice) as total_selling_price
from car_sales
group by 1
order by 1 desc;


-- 2. Top 10 hãng xe có tổng giá trị xe bán ra cao nhất là những hãng nào?
select make
	, sum(sellingprice) as total_price
from car_sales
group by 1
order by total_price desc
limit 10;


-- 3. Top 10 hãng xe có số lượng xe bán ra nhiều nhất là những hãng nào?
select make
	, count(*) as total_vehicles_sold
from car_sales
group by 1
order by total_vehicles_sold desc
limit 10;


-- 4. Trong mỗi năm, hãng xe nào có giá bán trung bình cao nhất?
with avg_cte as
(
	select year
		, make
		, round(avg(sellingprice),2) as avg_sellingprice
	from car_sales
	group by 1,2
	order by year desc
), rank_cte as
(
select
    year,
    make,
    avg_sellingprice,
    rank() over (
        partition by year
        order by avg_sellingprice desc
    ) as rnk
from avg_cte
)
select *
from rank_cte
where rnk = 1
order by year desc;


-- 5. Condition ảnh hưởng thế nào đến giá bán xe?
select condition 
	, round(avg(sellingprice),2) as avg_price
	, count(*) as count_vehicles
from car_sales
group by 1;


-- 6. Mileage ảnh hưởng đến giá bán khác nhau như thế nào giữa các hãng xe?
with first_cte as
(
select make
	, case
		when odometer <50000 then 'low'
		when odometer >= 50000 and odometer < 150000 then 'medium'
		when odometer >= 150000 then 'high'
	end as mileage_group
	, round(avg(sellingprice),2) as avg_price
	, count(*) as count_vehicles
from car_sales
group by 1,2
), second_cte as
(
select make 
	, mileage_group
	, avg_price
	, count_vehicles
	, row_number() over(partition by make order by avg_price desc) as row_num
from first_cte
)
select *
from second_cte;


-- 7. Model bán chạy nhất trong từng hãng xe là model nào?
WITH sales_cte AS (
    SELECT
        make,
        model,
        COUNT(*) AS total_vehicles_sold
    FROM car_sales
    GROUP BY make, model
),
rank_cte AS (
    SELECT
        make,
        model,
        total_vehicles_sold,
        RANK() OVER (
            PARTITION BY make
            ORDER BY total_vehicles_sold DESC
        ) AS rnk
    FROM sales_cte
)
SELECT
    make,
    model,
    total_vehicles_sold,
	rnk
FROM rank_cte
WHERE rnk = 1
ORDER BY total_vehicles_sold desc;


-- 8. Trong các hãng có ít nhất 500 xe bán ra, hãng nào có giá bán trung bình cao nhất?
SELECT
    make,
    COUNT(*) AS total_vehicles_sold,
    ROUND(AVG(sellingprice), 2) AS avg_selling_price
FROM car_sales
WHERE make IS NOT NULL
GROUP BY make
HAVING COUNT(*) >= 500
ORDER BY avg_selling_price DESC
LIMIT 10;











