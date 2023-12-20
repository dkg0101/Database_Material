/* create the database for storing table */
create database amazon_sales;

/* use databas */
use amazon_sales;

/* create table */
create table if not exists  forecasted_sales(
`Month` varchar(30),
Forecast int(10),
Actual int(10)
);

/* view tables in database */
show tables;

/* insert data into table */
INSERT INTO forecasted_sales (`Month`, Forecast, Actual)
VALUES
('April', 2458, NULL),
('August', 2584, NULL),
('December', 8228.50, NULL),
('January', 8948.7, NULL),
('July', 7421, 7514),
('June', 5124, 3652),
('March', 2145, 2247),
('May', 1245, NULL),
('November', 7508.25, 2248),
('October', 7846, 6354),
('September', 5314, 4251);


INSERT INTO forecasted_sales (Forecast, Actual)
VALUES
(2459, NULL),
(NULL, NULL),
(2585, NULL),
(8949.75, NULL),
(7607, 7700),
(2180, 708),
(NULL, NULL),
(1246, NULL),
(-3012.25, -8272.50),
(4862, 3370),
(3188, 2125),
(NULL, NULL),
(2460, NULL),
(2586, NULL),
(8230.50, NULL),
(8950.75, NULL),
(7793, 7886),
(-764, -2236),
(1247, NULL),
(-13532.75, -18793),
(1878, 386),
(1062, -1);


/* see all the values in table */
select * from forecasted_sales;


# To get count of records inside table
select count(*) from forecasted_sales

# To get particular column
select `month`,`actual` from forecasted_sales

# select firt n records
select * from forecasted_sales limit 8

# conditional formatting
select * from forecasted_sales where `month`= 'November'


SELECT *
FROM forecasted_sales
WHERE `Month` = 'January' AND `Forecast` = 8949 AND `Actual` IS NULL;


# fetch unique
select distinct `month` from forecasted_sales

#fetch count of unique
select count(distinct`month`) from forecasted_sales

# arrange by column order
select * from forecasted_sales order by `month` desc

select max(`Forecast`) from forecasted_sales

#having cluase
select * from forecasted_sales having `month` = 'March'
select * from forecasted_sales where `month` = 'March'

select * from forecasted_sales where `Forecast` in (select max(`Forecast`) from forecasted_sales)
select * from forecasted_sales where `Forecast` = (select max(`Forecast`) from forecasted_sales)





