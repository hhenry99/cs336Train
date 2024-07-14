DROP DATABASE IF EXISTS trainDB;
CREATE DATABASE trainDB;

use trainDB;

create table Customer (
	cid INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    username VARCHAR(200) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL
);


create table Reservation (
	reservation_number INT PRIMARY KEY,
    rdate DATE NOT NULL,
    total_fare FLOAT NOT NULL,
    cid INT NOT NULL,
    FOREIGN KEY (cid) REFERENCES Customer(cid)
);
    
CREATE TABLE Train (
	train_id INT PRIMARY KEY
    );


CREATE TABLE isForTrainReservation (
    reservation_number INT NOT NULL,
    train_id INT NOT NULL,
    PRIMARY KEY (reservation_number, train_id),
    FOREIGN KEY (reservation_number) REFERENCES Reservation(reservation_number),
    FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Station (
    station_id INT PRIMARY KEY,
    state CHAR(2) NOT NULL,
    city VARCHAR(200) NOT NULL,
    name VARCHAR(200) NOT NULL
);

CREATE TABLE Stops (
    train_id INT NOT NULL,
    station_id INT NOT NULL,
    arrival DATETIME NOT NULL,
    depart DATETIME NOT NULL,
    PRIMARY KEY (train_id, station_id),
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

CREATE TABLE TrainSchedule (
    transit_name VARCHAR(200) PRIMARY KEY,
    stops INT NOT NULL,
    fare INT NOT NULL,
    travel_time INT NOT NULL,
    dep_time DATETIME NOT NULL,
    arr_time DATETIME NOT NULL,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    FOREIGN KEY (origin_station_id) REFERENCES Station(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES Station(station_id)
);

CREATE TABLE Train_Has_Schedule(
	train_id INT,
    transit_name VARCHAR(200),
    PRIMARY KEY (train_id, transit_name),
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (transit_name) REFERENCES TrainSchedule(transit_name)
);


CREATE TABLE Employee (
    ssn INT PRIMARY KEY,
    first_name VARCHAR(200) NOT NULL,
    last_name VARCHAR(200) NOT NULL,
    username VARCHAR(200) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    isAdmin BOOLEAN NOT NULL
);

CREATE TABLE Administers (
    admin_id INT NOT NULL,
    customer_rep_id INT NOT NULL,
    PRIMARY KEY (admin_id, customer_rep_id),
    FOREIGN KEY (admin_id) REFERENCES Employee(ssn),
    FOREIGN KEY (customer_rep_id) REFERENCES Employee(ssn)
);

CREATE TABLE Manages (
    ssn INT NOT NULL,
    reservation INT NOT NULL,
    transit_name VARCHAR(200) NOT NULL,
    PRIMARY KEY (ssn, reservation, transit_name),
    FOREIGN KEY (ssn) REFERENCES Employee(ssn),
    FOREIGN KEY (reservation) REFERENCES Reservation(reservation_number),
    FOREIGN KEY (transit_name) REFERENCES TrainSchedule(transit_name)
);



/*Populating some users into the DB/*/

insert into Customer (first_name, last_name, username, password, email) VALUES ("Henry", "Nguyen", "apple", "apple", "henrygl450@yahoo.com");
insert into Employee VALUES (123456789, "Robin", "Gold", "cherry", "cherry", false);
