/* https://drive.google.com/file/d/1FRnbQqgK6S-mr9StNF5MurSaXhah9uoJ/view?usp=sharing */

create database sales;
use sales;
#following is command to  create table automatically using csvkit it will store file named output_sales.sql containing create table command
#csvsql --dialect mysql --snifflimit 100000 "D:\Downloads\sales_data_final.csv" > output_sales.sql
CREATE TABLE sales(
	order_id VARCHAR(15) NOT NULL, 
	order_date VARCHAR(15) NOT NULL, 
	ship_date VARCHAR(15) NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 8) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	`year` DECIMAL(38, 0) NOT NULL
);

SET SESSION sql_mode = ''

# bulk upload
load data infile
"D:/Downloads/sales_data_final.csv"
into table sales
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from sales

#converts dates(string) into date format
#Note: Carefully look at date format present inside table otherwise it will return null values as output
select str_to_date(order_date,'%m-%d-%Y') from sales

# To get date as per out custom format 
SELECT
    STR_TO_DATE(order_date, '%m/%d/%Y') AS original_date,
    DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%d-%m-%Y') AS custom_formatted_date
FROM sales

#Create column after order_date column
alter table sales
add column  order_date_new date after order_date

#SET SQL_SAFE_UPDATES =0;

#updateTABLE
update sales
set order_date_new = str_to_date(order_date,'%m-%d-%Y')

alter table sales
add column ship_date_new date after ship_date

# Use y (in '%m-%d-%Y' ) in capital format otherwise it'll take current year
update sales
set ship_date_new = str_to_date(ship_date,'%m-%d-%Y')


select * from sales  where ship_date_new > '2011-01-08'
select * from sales  where ship_date_new = '2011-01-08'
select * from sales  where ship_date_new < '2011-01-08'

select * from sales where ship_date_new between '2011-01-05' and '2011-08-30'

#current time in system
select now()
select curdate()
select curtime()

select * from sales where ship_date_new < date_sub(now(),interval 2 week)

#Get substracted date
select date_sub(now(),interval 1 week)
select date_add(now(),interval 70 day)

#date after 1000 days later from now
select date_add(now(), interval 1000 day)

#select date_sub(now(),'2022-11-11')

#get current year date
select year(now())
select month(now())

#get dayname on particular date
select dayname('2022-11-22')

#age differance
SELECT DATE_ADD('1999-12-30', INTERVAL 9 MONTH) + INTERVAL 19 DAY AS target_date;


#insert new column which records current time at time of record insertion
alter table sales
add column flag date after order_id

update sales
set flag = now()

select * from sales
# modify year column data type to decimal-->date
alter table sales
modify column year datetime

#create columns which will split date into 3 columns date ,month,year
alter table sales
add column `day` date after order_date_new

alter table sales
add column `month` date after `day`

alter table sales
add column order_year date after `month`

select month(order_date_new) from sales

# it is necessary to convert column type into int  for storing extracted  values (month,day,year)
alter table sales
modify column `day`int;

alter table sales
modify column `month` int;

alter table sales
modify column order_year int;

select month(order_date_new) from sales;

update  sales set `month` = month(order_date_new);

update  sales set `day` = day(order_date_new);

update  sales set order_year = year(order_date_new);

#avg sales group by
select order_year,sum(sales),avg(sales) from sales group by order_year
select order_year,max(sales) from sales group by order_year
select order_year,min(sales) from sales group by order_year

#To find total cost
alter table sales add column company_cost decimal after shipping_cost;

update sales set company_cost = discount+shipping_cost
select (discount+shipping_cost) as CTC  from sales

#separate orders with and without discount using if 
select order_id,discount, if(discount >0,'yes','no') as discount_flag from sales

alter table sales add column discount_flag varchar(30) after discount
update sales set discount_flag =if(discount >0,'yes','no')


#cont of item with discount
select discount_flag,count(*)  from sales group by discount_flag
select count(*) from  sales1 where discount > 0 
select  count(*) from sales where discount > 0;
