create database building_db;

use building_db;

create table Building(
	id int auto_increment primary key,
    build_name varchar(45) not null,
    address varchar(45) not null,
    city varchar(45) not null,
    cost float not null,
    start_time date not null,
    host_id int not null,
    contractor_id int not null,
    foreign key (host_id) references Hostt(id),
    foreign key (contractor_id) references Contractor(id)
);


create table Hostt (
	id int auto_increment primary key,
    host_name varchar(45) not null,
    address varchar(45) not null
);

create table Contractor (
	id int auto_increment primary key,
    name varchar(255),
    address varchar(255),
    contractorcol varchar(45)
);

create table Worker (
	id int auto_increment primary key,
    worker_name varchar(45),
	dob varchar(45),
    yearr varchar(45),
    skill varchar(45)
);

create table Workk(
	building_id int,
    worker_id int, 
    work_date date,
    total varchar(45),
    primary key (building_id, worker_id),
    foreign key (building_id) references Building(id),
    foreign key (worker_id) references Worker(id)
);

create table Design(
	building_id int,
    architect_id int,
    benefit varchar(45),
    primary key (building_id, architect_id),
    foreign key (building_id) references Building(id),
    foreign key (architect_id) references Architect(id)
);

create table Architect(
	id int primary key, 
	arc_name varchar(255),
    sex tinyint(1),
    birthday date,
    place varchar(255),
    address varchar(255)
);




