# Windowing funciton --> Create  bucket

create database win_fun
use win_fun
create table ineuron_students(
student_id int ,
student_batch varchar(40),
student_name varchar(40),
student_stream varchar(30),
students_marks int ,
student_mail_id varchar(50))

insert into ineuron_students values(119 ,'fsbc' , 'sandeep','ECE',65,'sandeep@gmail.com')

select * from ineuron_students


insert into ineuron_students values(100 ,'fsda' , 'saurabh','cs',80,'saurabh@gmail.com'),
(102 ,'fsda' , 'sanket','cs',81,'sanket@gmail.com'),
(103 ,'fsda' , 'shyam','cs',80,'shyam@gmail.com'),
(104 ,'fsda' , 'sanket','cs',82,'sanket@gmail.com'),
(105 ,'fsda' , 'shyam','ME',67,'shyam@gmail.com'),
(106 ,'fsds' , 'ajay','ME',45,'ajay@gmail.com'),
(106 ,'fsds' , 'ajay','ME',78,'ajay@gmail.com'),
(108 ,'fsds' , 'snehal','CI',89,'snehal@gmail.com'),
(109 ,'fsds' , 'manisha','CI',34,'manisha@gmail.com'),
(110 ,'fsds' , 'rakesh','CI',45,'rakesh@gmail.com'),
(111 ,'fsde' , 'anuj','CI',43,'anuj@gmail.com'),
(112 ,'fsde' , 'mohit','EE',67,'mohit@gmail.com'),
(113 ,'fsde' , 'vivek','EE',23,'vivek@gmail.com'),
(114 ,'fsde' , 'gaurav','EE',45,'gaurav@gmail.com'),
(115 ,'fsde' , 'prateek','EE',89,'prateek@gmail.com'),
(116 ,'fsde' , 'mithun','ECE',23,'mithun@gmail.com'),
(117 ,'fsbc' , 'chaitra','ECE',23,'chaitra@gmail.com'),
(118 ,'fsbc' , 'pranay','ECE',45,'pranay@gmail.com'),
(119 ,'fsbc' , 'sandeep','ECE',65,'sandeep@gmail.com')

select * from ineuron_students

# Aggregation type window functions
select student_batch,avg(students_marks) from ineuron_students group by student_batch
select count(student_batch) from ineuron_students
select count(distinct(student_batch)) from ineuron_students
select student_batch,count(student_batch) from ineuron_students group by student_batch

# Rank based window function
select max(students_marks) from ineuron_students where student_batch='fsda'
select student_name from ineuron_students where students_marks in 
(select max(students_marks) from ineuron_students where student_batch="fsda")

# limit n,m --> top m record from n th index

select  * from ineuron_students 
select  * from ineuron_students limit 2
# 3 rd record from 2 nd index
select  * from ineuron_students limit 2,3

#Creating ranks for each window separately
select student_id,student_batch,student_stream,students_marks, row_number() over(order by students_marks) as 'row_number' from ineuron_students
select student_id,student_batch,student_stream,students_marks, row_number() over(partition by student_batch order by students_marks) as 'batchwise_rank' from ineuron_students

# Select topper from each batch
select * from (select student_id,student_batch,student_stream,students_marks, row_number() over(partition by student_batch order by students_marks desc) as 'row_num' from ineuron_students) as
test where row_num = 1


# Using rank() function 
select student_id,student_batch,student_stream, students_marks ,row_number() over(order by students_marks ) 
as 'row_number', rank()  over(order by students_marks desc) as 'row_rank' from ineuron_students

# Using partition , row_number, rank combinely
select student_id,student_batch,student_stream, students_marks ,
row_number() over(order by students_marks ) as 'row_number',
rank()  over(partition by student_batch order by students_marks desc) as 'row_rank' from ineuron_students


# Get topper using rank in case there are more than one student in a branch
# rank skips row number eg. 1,1,3... here it skipped 2 
select * from (select student_id , student_batch , student_stream,students_marks ,
row_number() over( order by students_marks desc) as 'row_number',
rank() over(partition by student_batch order by students_marks desc ) as 'row_rank' 
from ineuron_students ) as test where row_rank = 1


# top mth record in each batch Using Dense rank, Dens rank do not skip rank number eg. 1,1,2...
select * from (select student_id , student_batch , student_stream,students_marks ,
row_number() over(partition by student_batch order by students_marks desc) as 'row_number',
rank() over(partition by student_batch order by students_marks desc ) as 'row_rank',
dense_rank() over( partition by student_batch order by students_marks desc) as 'dense_rank'
from ineuron_students ) as test where `dense_rank` = 3

# top m records in each batch Using Dense rank, Dens rank do not skip rank number eg. 1,1,2...
select * from (select student_id , student_batch , student_stream,students_marks ,
row_number() over(partition by student_batch order by students_marks desc) as 'row_number',
rank() over(partition by student_batch order by students_marks desc ) as 'row_rank',
dense_rank() over( partition by student_batch order by students_marks desc) as 'dense_rank'
from ineuron_students ) as test where `dense_rank` between 1 and 3

# Using in 
select * from (select student_id , student_batch , student_stream,students_marks ,
row_number() over(partition by student_batch order by students_marks desc) as 'row_number',
rank() over(partition by student_batch order by students_marks desc ) as 'row_rank',
dense_rank() over( partition by student_batch order by students_marks desc) as 'dense_rank'
from ineuron_students ) as test where `dense_rank`  in (1,2,3)
