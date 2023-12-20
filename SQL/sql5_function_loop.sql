#Allowed file size in Mysql is bydefault 1 mb , we can change it by
#set global max_allowed_packet = 1048576*n_mb
use sales
select * from sales

DELIMITER &&
create function add_to_col(a INT)
returns int
deterministic
begin
	DECLARE b int;
    set b = a+10 ;
    return b ;
end &&

 select add_to_col(10)
 
select  quantity, add_to_col(quantity) from sales


DELIMITER &&
CREATE FUNCTION final_profit(profit int ,discount int)
returns int
Deterministic
Begin
	Declare final_profit int;
	set final_profit = profit-discount;
	return final_profit;
end &&


select profit,discount, final_profit(profit,discount) from sales


#function for calculating real discount
DELIMITER &&
create function final_profit_discount(profit decimal(20.6) ,discount decimal(20.6) , sales decimal(20.6))
returns  int
deterministic
begin
declare final_profit int;
set final_profit = profit - sales*discount;
return final_profit;
end &&

select profit,discount,sales ,final_profit_discount(profit,discount,sales) from sales;

# Function that converts int to str
DELIMITER &&
create function int_to_str(a int)
returns int
deterministic
begin
declare b varchar(20);
set b = a;
return b; 
end &&

select quantity ,int_to_str(quantity) from sales;

###### If else statement
select max(sales),min(sales) from sales;


DELIMITER &&
create function sales_cat(sales int)
returns varchar(23)
deterministic
begin
declare flag_sales varchar(20);
if sales <= 100 then 
	set flag_sales = 'Super_affordable';
elseif  sales > 100 and sales <= 300 then
	set flag_sales = 'affordable' ;
elseif sales > 300 and sales < 600 then 
	set flag_sales  = 'moderate_price' ;
else 
	set flag_sales = 'expensive' ;
end if;
return flag_sales;
end &&

select sales_cat(101);
select sales ,sales_cat(sales) from sales;

#add new column and set the value by using function
alter table sales add column sale_cat varchar(30) after sales
 update sales set sale_cat = sales_cat(sales);
select sales,sale_cat from sales

#For loop
create table loop_table(val int)
select * from loop_table

DELIMITER &&
create procedure insert_data()
begin
set @var =10 ;
generate_data : loop
insert into loop_table values(@var);
set @var = @var + 1 ;
if @var = 100 then
	leave generate_data;
end if ;
end loop generate_data;
End &&

call insert_data()

select * from loop_table


#SELECT VERSION();


#Procedure that inserts data if it is divisible by 3
DELIMITER &&
create procedure insert_data_table()
begin 
set @var = 10;
generate_data : loop
if @var %3 = 0 then
set @var = @var;
insert into loop_table values (@var);
set @var = @var + 1;
if @var = 100 then
	leave generate_data;
end if;
end if;
end loop generate_data;
END &&
    
Delimiter $$
create procedure insert_data2()
Begin
set @var  = 10 ;
generate_data : loop
insert into loop_table values (@var);
set @var = @var + 1  ;
if @var  = 100 then 
	leave generate_data;
end if ;
end loop generate_data;
End $$



call insert_data2()

