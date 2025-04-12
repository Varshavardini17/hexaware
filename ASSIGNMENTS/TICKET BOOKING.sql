 -----------TABLE 1-------------------
 CREATE TABLE Venue (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(100),
    address VARCHAR(200)
);

INSERT INTO Venue VALUES
(1, 'City Arena', '123 Main St'),
(2, 'Metro Stadium', '456 Oak Ave'),
(3, 'Cineplex Hall', '789 Pine Rd'),
(4, 'Sunshine Theater', '321 Lake View'),
(5, 'Grand Grounds', '654 Hilltop'),
(6, 'Sky Dome', '111 Skyway'),
(7, 'Cultural Palace', '222 Heritage Rd'),
(8, 'Riverfront Arena', '333 River Dr'),
(9, 'Downtown Club', '444 Club St'),
(10, 'Royal Pavilion', '555 Crown Blvd');

----------------TABLE2-----------------------------------

CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
    event_time TIME,
    venue_id INT,
    total_seats INT,
    available_seats INT,
    ticket_price DECIMAL(10,2),
    event_type VARCHAR(20),
    booking_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
);

INSERT INTO Event VALUES
(1, 'Football Match', '2025-05-01', '18:00:00', 2, 50000, 20000, 150.00, 'Sports', 1),
(2, 'Rock Concert', '2025-05-03', '20:00:00', 8, 10000, 4500, 250.00, 'Concert', 2),
(3, 'Movie Premiere', '2025-05-05', '19:30:00', 3, 300, 50, 100.00, 'Movie', 3),
(4, 'Stand-up Comedy', '2025-05-07', '21:00:00', 10, 500, 120, 80.00, 'Concert', 4),
(5, 'Basketball Game', '2025-05-09', '17:00:00', 2, 20000, 5000, 130.00, 'Sports', 5),
(6, 'Drama Night', '2025-05-10', '19:00:00', 4, 250, 100, 90.00, 'Movie', 6),
(7, 'Music Festival', '2025-05-11', '16:00:00', 7, 8000, 3000, 200.00, 'Concert', 7),
(8, 'Horror Movie', '2025-05-12', '22:00:00', 3, 200, 30, 75.00, 'Movie', 8),
(9, 'Cricket Match', '2025-05-13', '14:00:00', 5, 60000, 15000, 180.00, 'Sports', 9),
(10, 'Jazz Night', '2025-05-15', '20:00:00', 6, 1000, 400, 220.00, 'Concert', 10);

------------------------TABLE3--------------------------------


CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);


CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost DECIMAL(10,2),
    booking_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

INSERT INTO Customer VALUES
(1, 'Amit Sharma', 'amit@example.com', '9876543210'),
(2, 'Neha Patel', 'neha@example.com', '9123456789'),
(3, 'Raj Verma', 'raj@example.com', '9988776655'),
(4, 'Sneha Joshi', 'sneha@example.com', '9011223344'),
(5, 'Karan Singh', 'karan@example.com', '9871234567'),
(6, 'Meera Iyer', 'meera@example.com', '9765432100'),
(7, 'Yash Desai', 'yash@example.com', '9887766554'),
(8, 'Ritu Nair', 'ritu@example.com', '9933445566'),
(9, 'Arjun Kapoor', 'arjun@example.com', '9988771122'),
(10, 'Tanya Bose', 'tanya@example.com', '9445566778');


INSERT INTO Booking VALUES
(1, 1, 1, 3, 450.00, '2025-04-10'),
(2, 2, 2, 2, 500.00, '2025-04-11'),
(3, 3, 3, 4, 400.00, '2025-04-12'),
(4, 4, 4, 5, 400.00, '2025-04-13'),
(5, 5, 5, 6, 780.00, '2025-04-14'),
(6, 6, 6, 3, 270.00, '2025-04-15'),
(7, 7, 7, 2, 400.00, '2025-04-16'),
(8, 8, 8, 1, 75.00, '2025-04-17'),
(9, 9, 9, 5, 900.00, '2025-04-18'),
(10, 10, 10, 2, 440.00, '2025-04-19');



----------------------------TASK2----------------------------------

------------------------------------------- Q1. Write a SQL query to insert at least 10 sample records into each table.-------------------------
inserted

------------------------------------------  Q2. Write a SQL query to list all Events.--------------------------------------------------------
SELECT * FROM Event;

-------------------------------------------Q3. Write a SQL query to select events with available tickets.---------------------------------------
SELECT * 
FROM Event
WHERE available_seats > 0;
-------------------------------------------Q4. Write a SQL query to select events name partial match with ‘cup’.-------------------------------------
SELECT * 
FROM Event
WHERE event_name LIKE '%cup%';

------------------------------------------Q5. Write a SQL query to select events with ticket price range is between 1000 to 2500.------------------------
SELECT * 
FROM Event
WHERE ticket_price BETWEEN 1000 AND 2500;

--------------------------------------------Q6. Write a SQL query to retrieve events with dates falling within a specific range.------------------------
SELECT * 
FROM Event
WHERE event_date BETWEEN '2025-05-05' AND '2025-05-12';

--------------------------------------------Q7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name--------------------
SELECT * 
FROM Event
WHERE available_seats > 0
AND event_name LIKE '%Concert%';

-----------------------------------------------Q8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user.-----------------------------------
SELECT * 
FROM Customer
ORDER BY customer_id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-----------------------------------------------Q9. Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.-------------------------
SELECT * 
FROM Booking
WHERE num_tickets > 4;

------------------------------------------------Q10. Write a SQL query to retrieve customer information whose phone number end with ‘000’-----------------------------
SELECT * 
FROM Customer
WHERE phone_number LIKE '%000';

------------------------------------------------Q11. Write a SQL query to retrieve the events in order whose seat capacity more than 15000.----------------------------
SELECT * 
FROM Event
WHERE total_seats > 15000
ORDER BY total_seats DESC;

-------------------------------------------------Q12. Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’----------------------------------
SELECT * 
FROM Event
WHERE event_name NOT LIKE 'x%' 
  AND event_name NOT LIKE 'y%' 
  AND event_name NOT LIKE 'z%';

-------------------------------------------------TASK 3--------------------------------------------


--------------------------------------------------Q1. Write a SQL query to List Events and Their Average Ticket Prices.----------------------------------------
SELECT  AVG(ticket_price) AS avg_ticket_price
FROM Event;

---------------------------------------------------Q2. Write a SQL query to Calculate the Total Revenue Generated by Events.--------------------------------------
SELECT event_name, SUM(num_tickets * ticket_price) AS total_revenue
FROM Event
JOIN Booking ON Event.event_id = Booking.event_id
GROUP BY event_name;

---------------------------------------------------Q3. Write a SQL query to find the event with the highest ticket sales.--------------------------------------------
SELECT TOP 1 event_name, SUM(num_tickets * ticket_price) AS total_sales
FROM Event
JOIN Booking ON Event.event_id = Booking.event_id
GROUP BY event_name
ORDER BY total_sales DESC;

-----------------------------------------------------Q4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.---------------------------------
SELECT event_name, SUM(num_tickets) AS total_tickets_sold
FROM Event
JOIN Booking ON Event.event_id = Booking.event_id
GROUP BY event_name;

-------------------------------------------------------Q5. Write a SQL query to Find Events with No Ticket Sales.-----------------------------------------------------
SELECT event_name
FROM Event
LEFT JOIN Booking ON Event.event_id = Booking.event_id
GROUP BY event_name
HAVING  SUM(num_tickets) = 0;

------------------------------------------------------Q6. Write a SQL query to Find the User Who Has Booked the Most Tickets.-------------------------------------------
SELECT TOP 1 
    C.customer_id,
    C.customer_name,
    SUM(B.num_tickets) AS total_tickets_booked
FROM Customer C
JOIN Booking B ON C.customer_id = B.customer_id
GROUP BY C.customer_id, C.customer_name
ORDER BY total_tickets_booked DESC;

---------------------------------------------------Q7. Write a SQL query to List Events and the total number of tickets sold for each month.----------------------------
SELECT 
    MONTH(b.booking_date) AS booking_month,
    e.event_name,
    SUM(b.num_tickets) 
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY MONTH(b.booking_date), e.event_name
ORDER BY booking_month, e.event_name;

----------------------------------------------------Q8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue.----------------------------
SELECT 
    V.venue_name,
    AVG(E.ticket_price) AS average_ticket_price
FROM Venue V
JOIN Event E ON V.venue_id = E.venue_id
GROUP BY V.venue_name;

----------------------------------------------------Q9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type.-----------------------
SELECT 
    E.event_type,
    SUM(B.num_tickets) AS total_tickets_sold
FROM Event E
JOIN Booking B ON E.event_id = B.event_id
GROUP BY E.event_type;

----------------------------------------------------Q10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year.--------------------------
SELECT 
    YEAR(B.booking_date) AS booking_year,----to extract year from date
    SUM(B.total_cost) AS total_revenue
FROM Booking B
GROUP BY YEAR(B.booking_date)
ORDER BY booking_year;

---------------------------------------------------Q11. Write a SQL query to list users who have booked tickets for multiple events.------------------------
SELECT 
    C.customer_id,
    C.customer_name,
    COUNT(DISTINCT B.event_id) AS events_booked
FROM Customer C
JOIN Booking B ON C.customer_id = B.customer_id
GROUP BY C.customer_id, C.customer_name
HAVING COUNT(DISTINCT B.event_id) > 1;

---------------------------------------------------Q12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User.------------------
SELECT 
    C.customer_id,
    C.customer_name,
    SUM(B.total_cost) AS total_revenue
FROM Customer C
JOIN Booking B ON C.customer_id = B.customer_id
GROUP BY C.customer_id, C.customer_name;

----------------------------------------------------Q13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue.-----------------
SELECT 
    E.event_type,
    V.venue_name,
    AVG(E.ticket_price) AS average_ticket_price
FROM Event E
JOIN Venue V ON E.venue_id = V.venue_id
GROUP BY E.event_type, V.venue_name
ORDER BY E.event_type, V.venue_name;

------------------------------------------------------Q14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 days--------------SELECT 
    c.customer_name,
    SUM(b.num_tickets) AS total_tickets_purchased
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id
WHERE b.booking_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY c.customer_name
ORDER BY total_tickets_purchased DESC;
---------------------------------------------------------------TASK 4 ----------------------------------------------------------------------------------------------------------------------------------------------------Q1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.------------------------------
SELECT 
    V.venue_name,
    (SELECT AVG(E.ticket_price) 
     FROM Event E 
     WHERE E.venue_id = V.venue_id) AS average_ticket_price
FROM Venue V;

-------------------------------------------------------Q2. Find Events with More Than 50% of Tickets Sold using subquery.-----------------------------------------
SELECT event_name
FROM Event E1
WHERE (total_seats - available_seats) > 
      (SELECT total_seats * 0.5 FROM Event E2 WHERE E2.event_id = E1.event_id);

------------------------------------------------------Q3. Calculate the Total Number of Tickets Sold for Each Event.----------------------------------------------
SELECT 
    event_name,
    (SELECT SUM(B.num_tickets) FROM Booking B 
	WHERE B.event_id = E.event_id) AS tickets_sold
FROM Event E;

-------------------------------------------------------Q4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.---------------------------------
SELECT *
FROM Customer C
WHERE NOT EXISTS (
    SELECT 1 FROM Booking B WHERE B.customer_id = C.customer_id
);

--------------------------------------------------------Q5. List Events with No Ticket Sales Using a NOT IN Subquery.----------------------------------------
SELECT *
FROM Event
WHERE event_id NOT IN (
    SELECT DISTINCT event_id FROM Booking
);

---------------------------------------------------------Q6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM caluse-----------------
SELECT 
    e.event_type,
    SUM(b.num_tickets) AS total_tickets_sold
FROM (SELECT event_id, event_type FROM Event) AS e
JOIN Booking b ON e.event_id = b.event_id
GROUP BY e.event_type;

-----------------------------------------------------------Q7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the where caluse----------------
SELECT *
FROM Event
WHERE ticket_price > (
    SELECT AVG(ticket_price) FROM Event
);

---------------------------------------------------------q8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.--------------------------
SELECT 
    C.customer_id,
    C.customer_name,
    (SELECT SUM(B.total_cost) 
     FROM Booking B 
     WHERE B.customer_id = C.customer_id) AS total_revenue
FROM Customer C;

---------------------------------------------------------Q9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE----------------
SELECT *
FROM Customer
WHERE customer_id IN (
    SELECT B.customer_id
    FROM Booking B
    JOIN Event E ON B.event_id = E.event_id
    WHERE E.venue_id = 2  
);

----------------------------------------------------------Q10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with groupby-----------------
SELECT 
    event_type,
    SUM(tickets_sold) AS total_tickets
FROM (
    SELECT 
        E.event_type,
        (SELECT SUM(B.num_tickets) 
         FROM Booking B 
         WHERE B.event_id = E.event_id) AS tickets_sold
    FROM Event E
) AS sub
GROUP BY event_type;

----------------------------------------------------------q11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery withdate_format----------------
SELECT DISTINCT C.customer_id, C.customer_name
FROM Customer C
WHERE EXISTS (
    SELECT 1
    FROM Booking B
    WHERE B.customer_id = C.customer_id
      AND FORMAT(B.booking_date, 'yyyy-MM') IS NOT NULL
);

-----------------------------------------------------------q12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery-------------------------------SELECT 
    V.venue_name,
    (SELECT AVG(E.ticket_price) 
     FROM Event E 
     WHERE E.venue_id = V.venue_id) AS avg_ticket_price
FROM Venue V;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
