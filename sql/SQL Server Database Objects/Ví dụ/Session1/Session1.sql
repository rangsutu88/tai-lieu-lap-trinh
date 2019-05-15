--
create database Mobile
--create primary constraint 

create table productCat(catId char(5) not null, catName varchar(20))
alter table productCat add constraint pk_productCat primary key(catId)
create table product(productId char(5) not null, productName varchar(3))
alter table product add constraint pk_productId primary key(productId)

create table [Order](orderId char(5)primary key, orderDate datetime)
create table orderDetail(productId char(5) , orderId char(5) primary key(productId, orderId), quantity int, price float)

--alter table orderDetail add constraint pk_product_order primary key(productId, orderId)

--foreign key

alter table orderDetail add constraint fk_productId foreign key(productId) references product(productId)

alter table orderDetail add constraint fk_orderId foreign key(orderId) references [order](orderId)

--unique constraint

create table customer(customerId char(5), custName varchar(50), CMND varchar(9) unique)

--check constraint

create table employee (empId char(5), empName varchar(30), address varchar(30) check (address in ('Ha Noi',' Hp','HCM')), age int check(age >=10 and age <=100))

--identity

create table news (newsId int identity, newContent varchar(100) )

--default constraint

create table feedback(id char(5) not null primary key, fb_content varchar(30) default 'alo')


insert into feedback(id) values('1')

insert into feedback values('2','noi dung website')

-----------

