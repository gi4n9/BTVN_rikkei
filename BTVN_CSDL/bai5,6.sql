-- bai5

create database car_manager;

use car_manager;

create table Customer (
	customer_id int primary key,
    customer_name varchar(100) not null,
    customer_address varchar(100) not null,
    phone_numb varchar(20)
);

create table Car(
	car_id int primary key, 
    car_name varchar(100),
    car_type varchar(50),
    daily_rate decimal(10,2)
);

create table Rental(
	rental_id int primary key,
    customer_id int,
    car_id int,
    start_date date,
    end_date date,
    total_amount decimal(10,2),
    foreign key (customer_id) references Customer(customer_id),
    foreign key (car_id) references Car(car_id)
);

update Rental 
set total_amount = datediff(end_date, start_date) * (select	daily_rate from car where Car.car_id = Rental.car_id);

-- bai6

create database event_manager;

use event_manage;


create table Eventt(
	event_id int primary key,
    event_name varchar(100),
    event_date date,
    location varchar(200),
    budget decimal(10,2)
);

create table Attendee(
	atten_id int primary key,
    atten_name varchar(100),
    atten_email varchar(100)
);

create table Sponsor(
	spon_id int primary key,
    spon_name varchar(100),
    money decimal(10,2)
);

create table Event_Atten(
	event_id int,
    atten_id int,
    foreign key (event_id) references Eventt(event_id),
    foreign key (atten_id) references Attendee(atten_id)
);

create table Event_Sponsor(
	event_id int,
    spon_id int,
    foreign key (event_id) references Eventt(event_id),
    foreign key (spon_id) references Sponsor(spon_id)
);


