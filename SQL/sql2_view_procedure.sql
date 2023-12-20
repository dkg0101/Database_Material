use ineuron_fsds;
show tables;
select * from bank_details

#fuction to perform default procedure
DELIMITER &&
create procedure all_data()
begin
select * from bank_details;
end &&

call all_data()

#to fetch max balance
DELIMITER &&
CREATE PROCEDURE MAX_BAL()
BEGIN
SELECT * FROM BANK_DETAILS WHERE BALANCE  IN (SELECT MAX(BALANCE) FROM BANK_DETAILS);
END &&

CALL MAX_BAL()

#Procedure for different arguments accepting input variable
DELIMITER &&
create procedure avg_bal_jobroll(in var varchar(30))
begin 
select avg(balance) from bank_details where job = var;
end &&

call avg_bal_jobroll('retired')
call avg_bal_jobroll('unknown')


# multiple input procedure
DELIMITER &&
create procedure education_jobroll(in var1 varchar(30), in var2 varchar(30))
begin 
select * from bank_details where education=var1 and job = var2;
END &&

call education_jobroll('tertiary','admin.');


call all_data()

# To view data in short form  with selected columns;
create view  bank_selected as select age , job , marital , balance , education from bank_details;
SELECT * FROM ineuron_fsds.bank_view;