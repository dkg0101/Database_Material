create database dress_data;
use dress_data;

#data link :https://drive.google.com/drive/folders/1IJegqCDv7TOd8ULgfq7DRzOeC-za1-H0?usp=sharing

create table if not exists dress(
`Dress_ID` varchar(30),	
`Style`	varchar(30),	
`Price`	varchar(30),	
`Rating`	varchar(30),	
`Size`	varchar(30),	
`Season`	varchar(30),	
`NeckLine`	varchar(30),	
`SleeveLength` varchar(30),		
`waiseline`	varchar(30),	
`Material`	varchar(30),	
`FabricType`	varchar(30),	
`Decoration`	varchar(30),	
`Pattern Type` varchar(30),		
`Recommendation` varchar(30))

select  * from dress;

# To describe table
describe test4
#or
show columns from test4

# Get info about create table statement
SHOW CREATE TABLE test4;


#Bulk upload
LOAD DATA INFILE
 "D:/Downloads/AttributeDataSet.csv"
into table dress
fields terminated by ','
enclosed  by '"'
lines terminated by '\n'
ignore 1 rows ;

/* To avoid 'Error:The MySQL server is running with the --secure-file-priv option so it cannot execute this statement' in bulk upload--->
 go to "C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" 
 and set value as secure-file-priv=""
*/


create table if not exists Grade(
`Last name` varchar(20),
`First name` varchar(20),
SSN varchar(40),
Test1 Int(20),
Test2 Int(20),
Test3 Int(20),
Test4 Int(20),
Final Int(20)
);

drop table Grade;


LOAD DATA INFILE 
"D:/Downloads/grades.csv"
into table Grade
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows

select * from Grade

# Autoincreament data inside table can use only once per table 
#by default it'll start from --> 1
create table if not exists test2 ( 
test_id int auto_increment,
test_name varchar(30) , 
test_mailid varchar(30),
teast_adress varchar(30),
primary key (test_id))


select * from test

insert into test2 values (1,'sudhanshu','sudhanshu@ineuron.ai','benglaore'),
(2,'krish','krish@gmail.com', 'bengalore'),
(3,'hitesh' ,'hitesh@ineuron.ai','bengalore'),
(4,'shubahm' , 'shudham@gmail.com', 'jaipur')


#Insertion using mapping
insert into test2 (test_name,test_mailid,teast_adress) values ('sudhanshu','sudhanshu@ineuron.ai','benglaore'),
('krish','krish@gmail.com', 'bengalore'),
('hitesh' ,'hitesh@ineuron.ai','bengalore'),
('shubahm' , 'shudham@gmail.com', 'jaipur')


select * from test2

use dress_data;
DELIMITER &&
create procedure all_table_data()
begin
select * from  test ;
end &&

call all_table_data()

select * from test2

show tables;

DELIMITER &&
CREATE PROCEDURE get_all_data (
    IN table_name VARCHAR(255)
)
BEGIN
    SELECT * FROM table_name;
END &&

#show grants
use dress_data;
CALL get_all_data('dress');

# NOte: Above procedure doesn't work properly


# The check constraint
create table if not exists test3 ( 
test_id int,
test_name varchar(30) , 
test_mailid varchar(30),
test_adress varchar(30),
test_sal int check (test_sal>7000))

select * from test3
insert into test3 values(1,'dhananjay','kdg0101@gmail.com','shigaon',50000),
(2,'ravi','rk19@gmail.com','nevari',20000),
(3,'shivraj','smd52@gmail.com','kokrud',85000),
(4,'ganesh','dukandar@gmail.com','vihe',61999)

select * from test3

# contraist on test_adress
create table if not exists test4(
test_id int,
test_name varchar(30) , 
test_mailid varchar(30),
test_adress varchar(30) check (test_adress ='bengalore'),
test_sal int check (test_sal>7000))


#Add a CHECK constraint to the existing test_name column
ALTER TABLE test4
ADD CONSTRAINT check_test_name CHECK (test_name = 'krish');

#To drop constraints to existing table
alter table test4
DROP CHECK check_test_name;

# It will throw chk1(i.e. adress) violated error
insert into test4 (test_id,test_name,test_mailid,test_adress,test_sal) values 
(4,'sudhanshu','sudhanshu@ineuron.ai','bengalaore',50236),
(1,'krish','krish@gmail.com', 'bengalore',203698),
(3,'hitesh' ,'hitesh@ineuron.ai','bengalore',1325698),
(2,'shubahm' , 'shudham@gmail.com', 'jaipur',78945)

#it will executed successfully
insert into test4 (test_id,test_name,test_mailid,test_adress,test_sal) values 
(4,'sudhanshu','sudhanshu@ineuron.ai','bengalore',50236),
(1,'krish','krish@gmail.com', 'bengalore',203698),
(3,'hitesh' ,'hitesh@ineuron.ai','bengalore',1325698),
(2,'shubahm' , 'shudham@gmail.com', 'bengalore',78945)

select * from test4

#It will show chk2 (i.e. salary ) violated error
insert into test4 (test_name,test_mailid,test_adress,test_sal) values 
('sudhanshu','sudhanshu@ineuron.ai','bengalore',236),
('krish','krish@gmail.com', 'bengalore',203698),
('hitesh' ,'hitesh@ineuron.ai','bengalore',1325698),
('shubahm' , 'shudham@gmail.com','bengalore',945)


#add constraint on existing table later stage
alter table test4 add constraint check(test_id>0)

#It will show chk3 violated error
insert into test4 values
(-2,'shubahm' , 'shudham@gmail.com', 'bengalore',78945)

# not null constraint
create table if not exists test5(
test_id int NOT NULL ,
test_name varchar(30) , 
test_mailid varchar(30),
test_adress varchar(30) check (test_adress ='bengalore'),
test_sal int check (test_sal>7000))


insert into test5 (test_name,test_mailid,test_adress,test_sal) values 
('sudhanshu','sudhanshu@ineuron.ai','bengalore',236)


#default value
create table if not exists test6(
test_id int NOT NULL default 0 ,
test_name varchar(30) , 
test_mailid varchar(30),
test_adress varchar(30) check (test_adress ='bengalore'),
test_sal int check (test_sal>7000))

#here it'll consider defualt value of test_id =0
insert into test6 (test_name,test_mailid,test_adress,test_sal) values 
('sudhanshu','sudhanshu@ineuron.ai','bengalore',23986)

insert into test6 (test_id,test_name,test_mailid,test_adress,test_sal) values 
(3,'hitesh' ,'hitesh@ineuron.ai','bengalore',1325698)

select * from test6

# Unique,used in case of restrict duplicate entries
create table if not exists test7( 
test_id int NOT NULL default 0 ,
test_name varchar(30)  , 
test_mailid varchar(30) unique ,
test_adress varchar(30) check (test_adress= 'bengalore'),
test_salary int check(test_salary > 10000))
	
insert into test7 ( test_name , test_mailid , test_adress,test_salary) values 
('sudhanshu','sudhanshu@ineuron.ai','bengalore' , 50000)

select * from test7


#Table with all constraints discussed above
create table test8(
test_id int not null auto_increment,
test_name varchar(30) not null default 'Unknown',
test_mailid varchar(30) unique not null,
test_adress varchar(30) check(test_adress = 'bengalore') not null ,
test_salary int check (test_salary > 10000) NOT NULL  ,
primary key (test_id))


select * from test8


insert into test8 ( test_id , test_name , test_mailid , test_adress,test_salary) values 
(302 , 'sudhanshu','sudhanshu503@ineuron.ai','bengalore' , 50000)

#it also counts test_id for error statement and hence next time it skips that id for auto_increment so we have to insert that missed id by manually adding record with that id
insert into test8 ( test_name , test_mailid , test_adress,test_salary) values ('sudhanshu','sudhansshu19@ineuron.ai','bengalore' , 50000)
select * from test8




