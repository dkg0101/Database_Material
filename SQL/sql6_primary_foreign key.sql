create database key_prim
use key_prim

#primary key should be unique
create table ineuron(
course_id int NOT NULL,
course_name varchar(60),
course_status varchar(40),
number_of_enro int ,
primary key(course_id));

insert into ineuron values(01 , 'FSDA','active',100),
(02 , 'FSDs','not-actrive',100)
select * from ineuron

#foreign key establishes relationship with primary key of paraent table
create table studets_ineuron(
student_id int ,
course_name varchar(60),
student_mail varchar(60),
student_status varchar(40),
course_id1 int,
foreign key(course_id1) references ineuron(course_id))

# If primary key value is not present in parent table, we can't add value in child table as well
insert into studets_ineuron values(101 , 'fsda','test@gmail.com','active',05);
insert into studets_ineuron values(101 , 'fsda','test@gmail.com','active',01);
insert into studets_ineuron values(101 , 'fsda','test@gmail.com','active',01);
insert into studets_ineuron values(101 , 'fsda','test@gmail.com','active',02);

select * from studets_ineuron

#if primary key of child table reffered as foreign key then it becomes one to one relationship
create table class (
course_id int,
class_name varchar(50),
class_topic varchar(50),
class_duration int,
primary key(course_id),
foreign key(course_id) references ineuron(course_id))

insert into class values(1,'fasd','python',25)

#
create table payment(
course_name varchar(60),
course_id int ,
course_live_status varchar(60),
course_launch_date varchar(60),
foreign key(course_id) references ineuron(course_id))

insert into payment values ('fsda',01,'not-active','7th aug')
insert into payment values ('fsda',01,'not-active','7th aug')
insert into payment values ('fsda',01,'not-active','7th aug')

create table test(
id int not null , 
name varchar(60),
email_id varchar(60),
mobile_no varchar(9),
address varchar(50))

alter table test add constraint primk primary key (id,email_id)


# we can not delete values associated with child table directly without using 'on delete cascade'
create table parent(
id int not null ,
primary key(id))

create table child (
id int ,
parent_id int ,
foreign key (parent_id) references parent(id))

insert into parent values(1)
select * from parent 

insert into child values(1,1)
select * from child

insert into child values(2,2)
delete from parent where id =1
delete from child where id =1

drop table child

# using cascade , if we delete some value from parent then record related with that in child also get deleted
create table child (
id int ,
parent_id int ,
foreign key (parent_id) references parent(id) on delete cascade )

insert into parent values(2)

insert into child values(1,1),(1,2),(3,2),(2,2)

select * from child

select * from parent

delete from parent where id  = 1

# also we can not update value in parent without using 'on update cascade'
update parent set id = 3 where id = 2

drop table child

create table child (
id int ,
parent_id int ,
foreign key(parent_id) references parent(id) on update cascade on delete cascade
)

insert into parent values(1)
insert into child values(1,1),(1,2),(3,2),(2,2)
select * from parent
select * from child

# After updating parent value child value get update
update parent set id =3 where id=2

#check child table it would have chnged foreign key value
select * from child
