create database library;

use library;

-- bai1
select * from books;
select title, author from books where price > 50;

-- bai2
create table Book (
	bookID int auto_increment primary key,
    price int,
    foreign key (authorID) references Author(authorID),
    foreign key (publisherID) references Publisher(publisherID)
);

create table Author (
	authorID int auto_increment primary key,
    authorName varchar(200)
);

create table Publisher (
	publisherID int auto_increment primary key,
    publisherName varchar(200)
);

-- bai3
create table Student (
	studentID int auto_increment primary key,
    studentName varchar(200),
    dob date
);

create table Course (
	courseID int auto_increment primary key,
    courseName varchar(200),
    price int
);

create table Enrollment (
	studentID int,
    courseID int,
    registerDay date,
    primary key (studentID, courseID),
	foreign key (studentID) references Student(studentID),
    foreign key (courseID) references Course(courseID)
);

-- bai4
create table Customer(
	customer_id int primary key,
    customer_name varchar(100),
    customer_address varchar(100),
    customer_email varchar(100)
);

create table Product(
	product_id int primary key,
    product_name varchar(100),
    price decimal(10,2)
);

create table Orderr(
	order_id int primary key,
    order_date date,
    total_amount decimal(10,2),
    customer_id int,
    foreign key (customer_id) references Customer(customer_id)
);

create table Order_details(
	order_id int,
    product_id int,
    quantity int,
    primary key (order_id, product_id),
    foreign key (order_id) references Orderr(order_id),
    foreign key (product_id) references Product(product_id)
);