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
INSERT INTO Station (station_id, state, city, name) VALUES
(1, 'CA', 'San Francisco', 'San Francisco Station'),
(2, 'CA', 'Los Angeles', 'Los Angeles Station'),
(3, 'CA', 'San Jose', 'San Jose Station'),
(4, 'CA', 'Fresno', 'Fresno Station'),
(5, 'CA', 'Sacramento', 'Sacramento Station');

-- Insert train schedules
INSERT INTO TrainSchedule (transit_name, stops, fare, travel_time, dep_time, arr_time, origin_station_id, destination_station_id) VALUES
('Express Line', 3, 100, 360, '2024-07-15 08:00:00', '2024-07-15 14:00:00', 1, 2),
('Coastal Line', 4, 120, 480, '2024-07-15 09:00:00', '2024-07-15 17:00:00', 1, 3);

-- Insert trains (assuming the Train table has train_id and other columns)
INSERT INTO Train (train_id) VALUES
(1),
(2);

-- Insert train has schedule
INSERT INTO Train_Has_Schedule (train_id, transit_name) VALUES
(1, 'Express Line'),
(2, 'Coastal Line');

-- Insert stops for each train
INSERT INTO Stops (train_id, station_id, arrival, depart) VALUES
(1, 1, '2024-07-15 08:00:00', '2024-07-15 08:10:00'), -- San Francisco
(1, 4, '2024-07-15 10:00:00', '2024-07-15 10:10:00'), -- Fresno
(1, 2, '2024-07-15 14:00:00', '2024-07-15 14:10:00'), -- Los Angeles

(2, 1, '2024-07-15 09:00:00', '2024-07-15 09:10:00'), -- San Francisco
(2, 5, '2024-07-15 11:00:00', '2024-07-15 11:10:00'), -- Sacramento
(2, 4, '2024-07-15 13:00:00', '2024-07-15 13:10:00'), -- Fresno
(2, 3, '2024-07-15 17:00:00', '2024-07-15 17:10:00'); -- San Jose
