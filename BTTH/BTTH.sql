create database ECommerceDB;

use ECommerceDB;

create table Users(
	ID int auto_increment primary key,
    username varchar(50) unique not null,
    passwordHash varchar(255) not null,
    email varchar(100) unique not null
);

create table Products(
	ID int auto_increment primary key,
    productName varchar(100) not null,
    description_prod text,
    price decimal(10,2) not null,
    stock int not null
);

create table Cart(
	ID int auto_increment primary key,
    userID int ,
    total int not null,
    foreign key (userID) references Users(ID)
);

create table CartItems(
	ID int auto_increment primary key,
    cartID int,
    productID int,
    foreign key (cartID) references Products(ID),
    foreign key (productID) references Products(ID),
    quantity int not null
);