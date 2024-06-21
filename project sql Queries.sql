create database project_sql;

use project_sql;

drop table real_estate;

alter table `sql 2`
add column new_dob date;

set sql_safe_updates= 0;

update `sql 2`
set new_dob= str_to_date(`date`,"%d-%m-%Y");

/* what are the top 10 properties selling suburbs ?*/

select suburb, count(Address) as no_of_properties
from `sql 2`
group by suburb
order by no_of_properties desc
limit 10;


/*What are top 10 suburb with most average price of properties?					
*/

select suburb, round(avg(price),2) as avg_price
from `sql 2` 
group by suburb
order by avg_price desc
limit 10;

/*what are the top 10  property selling suburb and which region? */

select suburb,regionname, Count(Address) as no_of_properties_sold
from `sql 2`
group by Suburb, Regionname
order by  no_of_properties_sold desc
limit 10;
							
/*Which Top 10 region has the highest average land size for properties sold?*/

select Regionname, round(avg(landsize),2) as avg_landsize
from `sql 2`			
group by Regionname
order by avg_landsize desc;	

/*Give Top 15 real estate agent that has most property sold*/

select sellerg, count(SellerG) as properties_sold
from `sql 2`
group by sellerg
order by  properties_sold desc
limit 15;

/*whats the status of the properties method in each region */

select regionname, sum(if(method="s",1,""))as S, sum(if(method="sp",1,"")) as SP, sum(if(method="vb",1,"")) as VB, sum(if(method="pi",1,"")) as PI, sum(if(method="sa",1,"")) as SA
from `sql 2`
group by regionname;

/*show which properties have a "BuildingArea" larger than the "Landsize"?*/

with q as (select suburb, sum(if(buildingarea>landsize,1,0)) as morebuildingarea, 
sum(if(landsize>buildingarea,1,0)) as morelandsize
from `sql 2`
group by suburb)

select suburb, morebuildingarea, morelandsize
from q
where morebuildingarea >  morelandsize;

/*which type of property is sold more in each suburb?									
*/

SELECT Regionname, 
count(IF(type='h', 1, NULL)) AS count_of_h,
count(IF(type='u', 1, NULL)) AS count_of_u,
count(if(type='t', 1, null)) as count_of_t
FROM `sql 2`
where type IN ('h', 'u', 't')
group by Regionname;

/*which year most property is sold?*/

select year(new_dob) as year, count(new_dob) as properties_sold
from `sql 2`
group by year(new_dob);

/*How does the distance from the CBD(central business District) 
affect property prices?*/

select suburb, round(avg(price),2) as property_price, distance
from `sql 2`
group by suburb, distance
order by property_price desc;					

/*rank the regions as per properties sold*/

with q as(select regionname, count(address) as no_of_properties
from `sql 2`
group by Regionname
order by no_of_properties desc)

select regionname, rank() over( order by no_of_properties desc) as ranking
from q;

