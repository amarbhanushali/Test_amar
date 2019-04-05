select * from
(
with goodyearresultset as (
SELECT 
  sum(CASE WHEN m_date.m_date_key  BETWEEN (select to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM') 
  THEN t_purchase_order.quantity 
  END) as  goodyrqty,
  sum(CASE WHEN m_date.m_date_key  BETWEEN (to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM')
  AND diameter1=5 
  THEN t_purchase_order.quantity ELSE 0
  END)  as goodyrseventyqty
FROM 
  psd.m_tyre_category,
  psd.t_purchase_order
  LEFT JOIN psd.m_manufacturer ON t_purchase_order.manufacturer_name = m_manufacturer.m_mfr_key
  LEFT JOIN psd.m_brand ON m_brand.m_brand_key = t_purchase_order.brand
  LEFT JOIN psd.m_geography ON t_purchase_order.country = m_geography.m_geogr_key
  LEFT JOIN psd.m_date ON t_purchase_order.order_date = m_date.m_date_key
  LEFT JOIN psd.m_category ON t_purchase_order.category = m_category.m_category_key
  LEFT JOIN psd.m_target_per_country ON m_target_per_country.m_brand_key = t_purchase_order.brand AND m_target_per_country.country = t_purchase_order.country AND m_target_per_country.isactive = 'TRUE' AND m_target_per_country.year = '2019'
WHERE  
  m_category.m_tyre_category_key = m_tyre_category.m_tyre_category_key
  AND m_tyre_category.code = 'PCR' 
  AND m_brand.m_brand_key = 18
  AND  (CASE
      WHEN 'WORLD' = 'WORLD' THEN  
   			(CASE
         			WHEN 'EUROPE' != 'NA' THEN     
    					(CASE
         					WHEN 'FRANCE' != 'NA' THEN m_geography.country = 'FRANCE'
		     			ELSE m_geography.continent = 'EUROPE'
     	 	 		 END)
     	 	 	 ELSE m_geography.world = 'WORLD'
  			END)   
    END)
group by
  m_manufacturer.manufacturer, 
  m_brand.brand, 
  m_target_per_country.target_pcr,
m_brand.m_brand_key 
ORDER BY
   m_manufacturer.manufacturer != 'POINT S GROUP',   
   m_brand.brand asc
)
select goodyrqty,
goodyrseventyqty,(case when goodyrqty >= 0 then (ROUND((goodyrseventyqty/goodyrqty)*100)) else 0 end) as goodyrseventy
from goodyearresultset
) goodyrqry
CROSS JOIN   
(
with continentalresultset as (
SELECT 
  sum(CASE WHEN m_date.m_date_key  BETWEEN (select to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM')
  THEN t_purchase_order.quantity 
  END) as  continentalqty,
  sum(CASE WHEN m_date.m_date_key  BETWEEN (to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM')
  AND diameter1=5
  THEN t_purchase_order.quantity ELSE 0
  END)  as continentalseventyqty
FROM 
  psd.m_tyre_category,
  psd.t_purchase_order
  LEFT JOIN psd.m_manufacturer ON t_purchase_order.manufacturer_name = m_manufacturer.m_mfr_key
  LEFT JOIN psd.m_brand ON m_brand.m_brand_key = t_purchase_order.brand
  LEFT JOIN psd.m_geography ON t_purchase_order.country = m_geography.m_geogr_key
  LEFT JOIN psd.m_date ON t_purchase_order.order_date = m_date.m_date_key
  LEFT JOIN psd.m_category ON t_purchase_order.category = m_category.m_category_key
  LEFT JOIN psd.m_target_per_country ON m_target_per_country.m_brand_key = t_purchase_order.brand AND m_target_per_country.country = t_purchase_order.country AND m_target_per_country.isactive = 'TRUE' AND m_target_per_country.year = '2019'
WHERE  
  m_category.m_tyre_category_key = m_tyre_category.m_tyre_category_key
  AND m_tyre_category.code = 'PCR'
  AND m_brand.m_brand_key = 6
 AND
  (CASE
      WHEN 'WORLD' = 'WORLD' THEN  
   			(CASE
         			WHEN 'EUROPE' != 'NA' THEN     
    					(CASE
         					WHEN 'FRANCE' != 'NA' THEN m_geography.country = 'FRANCE'
		     			ELSE m_geography.continent = 'EUROPE'
     	 	 		 END)
     	 	 	 ELSE m_geography.world = 'WORLD'
  			END)   
    END)
group by
  m_manufacturer.manufacturer, 
  m_brand.brand, 
  m_target_per_country.target_pcr,
m_brand.m_brand_key 
ORDER BY
   m_manufacturer.manufacturer != 'POINT S GROUP',   
   m_brand.brand asc
)
select continentalqty,
continentalseventyqty,(case when continentalqty >= 0 then (ROUND((continentalseventyqty/continentalqty)*100)) else 0 end) as continentalseventy
from continentalresultset
) continentalqry
CROSS JOIN   
(
with dunlopresultset as (
SELECT 
  sum(CASE WHEN m_date.m_date_key  BETWEEN (select to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM')
  THEN t_purchase_order.quantity 
  END) as  dunlopqty,
  sum(CASE WHEN m_date.m_date_key  BETWEEN (to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM')
  AND diameter1=5
  THEN t_purchase_order.quantity ELSE 0
  END)  as dunlopseventyqty
FROM 
  psd.m_tyre_category,
  psd.t_purchase_order
  LEFT JOIN psd.m_manufacturer ON t_purchase_order.manufacturer_name = m_manufacturer.m_mfr_key
  LEFT JOIN psd.m_brand ON m_brand.m_brand_key = t_purchase_order.brand
  LEFT JOIN psd.m_geography ON t_purchase_order.country = m_geography.m_geogr_key
  LEFT JOIN psd.m_date ON t_purchase_order.order_date = m_date.m_date_key
  LEFT JOIN psd.m_category ON t_purchase_order.category = m_category.m_category_key
  LEFT JOIN psd.m_target_per_country ON m_target_per_country.m_brand_key = t_purchase_order.brand AND m_target_per_country.country = t_purchase_order.country AND m_target_per_country.isactive = 'TRUE' AND m_target_per_country.year = '2019'
WHERE  
  m_category.m_tyre_category_key = m_tyre_category.m_tyre_category_key
  AND m_tyre_category.code = 'PCR'
  AND m_brand.m_brand_key = 12
 AND
 (CASE
      WHEN 'WORLD' = 'WORLD' THEN  
   			(CASE
         			WHEN 'EUROPE' != 'NA' THEN     
    					(CASE
         					WHEN 'FRANCE' != 'NA' THEN m_geography.country = 'FRANCE'
		     			ELSE m_geography.continent = 'EUROPE'
     	 	 		 END)
     	 	 	 ELSE m_geography.world = 'WORLD'
  			END)   
    END)
group by
  m_manufacturer.manufacturer, 
  m_brand.brand, 
  m_target_per_country.target_pcr,
m_brand.m_brand_key 
ORDER BY
   m_manufacturer.manufacturer != 'POINT S GROUP',   
   m_brand.brand asc
)
select dunlopqty,
dunlopseventyqty,(case when dunlopqty >= 0 then (ROUND((dunlopseventyqty/dunlopqty)*100)) else 0 end) as dunlopseventy
from dunlopresultset
) dunlopqry
CROSS JOIN
(
with bristresultset as (
SELECT 
  sum(CASE WHEN m_date.m_date_key  BETWEEN (select to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM')
  THEN t_purchase_order.quantity 
  END) as  bristresultqty,
  sum(CASE WHEN m_date.m_date_key  BETWEEN (to_char(date_trunc('year', to_timestamp((to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date - 1, 'YYYYMM')), 'YYYYMM'))::date, 'YYYYMM')) AND to_char(date_trunc('month', to_timestamp('201902', 'YYYYMM'))::date, 'YYYYMM')
  AND diameter1=5
  THEN t_purchase_order.quantity ELSE 0
  END)  as bristseventyqty
FROM 
  psd.m_tyre_category,
  psd.t_purchase_order
  LEFT JOIN psd.m_manufacturer ON t_purchase_order.manufacturer_name = m_manufacturer.m_mfr_key
  LEFT JOIN psd.m_brand ON m_brand.m_brand_key = t_purchase_order.brand
  LEFT JOIN psd.m_geography ON t_purchase_order.country = m_geography.m_geogr_key
  LEFT JOIN psd.m_date ON t_purchase_order.order_date = m_date.m_date_key
  LEFT JOIN psd.m_category ON t_purchase_order.category = m_category.m_category_key
  LEFT JOIN psd.m_target_per_country ON m_target_per_country.m_brand_key = t_purchase_order.brand AND m_target_per_country.country = t_purchase_order.country AND m_target_per_country.isactive = 'TRUE' AND m_target_per_country.year = '2019'
WHERE  
  m_category.m_tyre_category_key = m_tyre_category.m_tyre_category_key
  AND m_tyre_category.code = 'PCR'
  AND m_brand.m_brand_key = 4
 AND
(CASE
      WHEN 'WORLD' = 'WORLD' THEN  
   			(CASE
         			WHEN 'EUROPE' != 'NA' THEN     
    					(CASE
         					WHEN 'FRANCE' != 'NA' THEN m_geography.country = 'FRANCE'
		     			ELSE m_geography.continent = 'EUROPE'
     	 	 		 END)
     	 	 	 ELSE m_geography.world = 'WORLD'
  			END)   
    END)
group by
  m_manufacturer.manufacturer, 
  m_brand.brand, 
  m_target_per_country.target_pcr,
m_brand.m_brand_key 
ORDER BY
   m_manufacturer.manufacturer != 'POINT S GROUP',   
   m_brand.brand asc
)
select (case when bristresultqty IS NOT NULL then bristresultqty else 0 end) as bristresultqty,
(case when bristseventyqty >= 0 then bristseventyqty else 0 end) as bristseventyqty,
(case when bristresultqty >= 0 then (ROUND((bristseventyqty/bristresultqty)*100)) else 0 end) as bristseventy
from bristresultset
) bristqry