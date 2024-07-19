# cs336Train

GROUP 7

VIDEO LINKS (3 Parts):

https://www.youtube.com/watch?v=Hh9eoKbnwes  
https://www.youtube.com/watch?v=Wk3Iq2xawQ0&t=147s
<br>
https://youtu.be/TQKU2zWcL9g

----

Before  Running Application:
  -Make sure to change DB password in src/main/java/com/cs336/pkg/ApplicationDB.java

  -Some already inputed user.
  Employee:
    -ADMIN: 
        Username - admin
        Password - admin
    -Customer-Rep:
        Username - cherry
        Password - cherry

  Customer: 
      -Customer1:
          Username - apple
          Password - apple


-----

THESE ARE SOME EXTRA QUERIES OPTIONAL TO INPUT INTO DB

/*Adding some customers*/

INSERT INTO Customer (first_name, last_name, username, password, email) VALUES
('John', 'Doe', 'johndoe', 'password123', 'john.doe@example.com'),
('Jane', 'Smith', 'janesmith', 'securepass', 'jane.smith@example.com'),
('Alice', 'Johnson', 'alicej', 'alicepass', 'alice.johnson@example.com'),
('Bob', 'Brown', 'bobb', 'bobbspass', 'bob.brown@example.com'),
('Charlie', 'Davis', 'charlied', 'charliespass', 'charlie.davis@example.com');

/*Adding some reservations*/

-- Sample reservations
INSERT INTO Reservation (reservation_number, rdate, total_fare, cid) VALUES
(1001, '2024-07-01', 120.50, 1),
(1002, '2024-07-02', 85.00, 2),
(1003, '2024-07-03', 99.99, 3),
(1004, '2024-07-04', 150.75, 4),
(1005, '2024-07-05', 45.20, 5),
(1006, '2024-07-06', 180.00, 1),
(1007, '2024-07-07', 75.50, 2),
(1008, '2024-07-08', 60.00, 3),
(1009, '2024-07-09', 130.30, 4),
(1010, '2024-07-10', 50.00, 5);

-- Sample reservations and train IDs
INSERT INTO isForTrainReservation (reservation_number, train_id) VALUES
(1001, 1),
(1002, 2),
(1003, 1),
(1004, 2),
(1005, 1),
(1006, 2),
(1007, 1),
(1008, 2),
(1009, 1),
(1010, 2);
