IF DB_ID('PetPals') IS NULL
BEGIN
    CREATE DATABASE PetPals;
END
GO
USE PetPals;
GO

---TABLE 1
CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);


---TABLE 2
CREATE TABLE Pets (
    PetID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    Breed VARCHAR(100),
    Type VARCHAR(50),
    AvailableForAdoption BIT 
);


---TABLE 3
CREATE TABLE Donations (
    DonationID INT PRIMARY KEY IDENTITY(1,1),
    DonorName VARCHAR(100),
    DonationType VARCHAR(50) CHECK (DonationType IN ('Cash', 'Item')),
    DonationAmount DECIMAL(10, 2)NULL,
    DonationItem VARCHAR(100)NULL,
    DonationDate DATE NOT NULL DEFAULT GETDATE(),
   );


-- TABLE 4
CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName VARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(200)
);


--- TABLE 5
CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY IDENTITY(1,1),
    ParticipantName VARCHAR(100) NOT NULL,
    ParticipantType VARCHAR(50) CHECK (ParticipantType IN ('Shelter', 'Adopter')),
    EventID INT ,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);


INSERT INTO Shelters (Name, Location) VALUES
('Happy Paws Shelter', 'pondy'),
('FurEver Home', 'chennai'),
('Safe Haven', 'ooty'),
('Paw Palace', 'coimbatore'),
('Rescue Me Center', 'trichy'),
('Pet Angels', 'theni'),
('The Pet House', 'cuddalore'),
('Animal Aid', 'dindugal'),
('Hope for Paws', 'tirupur'),
('Loving Hearts Shelter', 'namakal');

INSERT INTO Pets (Name, Age, Breed, Type, AvailableForAdoption) VALUES
('chellam', 3, 'Golden Retriever', 'Dog', 1),
('Meenu', 2, 'Persian', 'Cat', 1),
('sweety', 4, 'Beagle', 'Dog', 0),
('Luna', 1, 'Siamese', 'Cat', 1),
('azhagan', 5, 'German Shepherd', 'Dog', 0),
('bloomy', 2, 'Bulldog', 'Dog', 1),
('cutie', 3, 'Maine Coon', 'Cat', 1),
('patu', 4, 'Labrador', 'Dog', 0),
('Simba', 1, 'Tabby', 'Cat', 1),
('tinu', 2, 'Pug', 'Dog', 1);

INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem) VALUES
('varsha', 'Cash', 100.00, NULL),
('kalpana', 'Item', NULL, 'Dog Food'),
('velu', 'Cash', 75.50, NULL),
('balaji', 'Item', NULL, 'Pet Toys'),
('afsara', 'Cash', 200.00, NULL),
('roshan', 'Item', NULL, 'Cat Beds'),
('manibala', 'Cash', 150.00, NULL),
('sahitya', 'Item', NULL, 'Leashes'),
('ranjini', 'Cash', 80.00, NULL),
('lakshaya', 'Item', NULL, 'Kennels');

INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES
('Spring Pet Fair', '2025-04-15', 'Central Park, chennai'),
('Adopt-A-Pet Day', '2025-04-20', 'pondy Pet Center'),
('Paws and Claws Expo', '2025-04-25', 'Downtown ooty'),
('Pet Lovers Meet', '2025-04-30', 'coimbatore Expo Center'),
('Rescue Rally', '2025-05-05', 'trichy Community Hall'),
('Furry Friends Fiesta', '2025-05-10', 'theni Park'),
('Pet Parade', '2025-05-12', 'cuddalore Square'),
('Adoption Awareness Week', '2025-05-15', 'dindugal Zoo Grounds'),
('Heart to Paw Fest', '2025-05-20', 'tripur Pet Plaza'),
('Forever Home Festival', '2025-05-25', 'namakal Fairgrounds');

INSERT INTO Participants (ParticipantName, ParticipantType, EventID) VALUES
('Happy Paws Shelter', 'Shelter', 1),
('FurEver Home', 'Shelter', 2),
('Safe Haven', 'Shelter', 3),
('Loving Hearts Shelter', 'Shelter', 4),
('vardini', 'Adopter', 1),
('Bob', 'Adopter', 2),
('Clara', 'Adopter', 3),
('David', 'Adopter', 4),
('Pet Angels', 'Shelter', 5),
('Eva Brown', 'Adopter', 5);


------------Q1. Provide a SQL script that initializes the database for the Pet Adoption Platform ”PetPals”.
------------Q2. Create tables for pets, shelters, donations, adoption events, and participants.
------------Q3. Define appropriate primary keys, foreign keys, and constraints.
------------Q4. Ensure the script handles potential errors, such as if the database or tables already exist

-----------------------------------------Q5 RETRIVE LIST OF AVAIABLE PETS----------------------------------
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 1;

-----------------------------------------Q6 RETRIEVE THE NAMES OF THE PARTICIPANTS REGISTERED FOR SPECIFIC ADOPTION EVENT(USE PARAMETER AND JOIN TABLE)------------

DECLARE @EventID INT = 1;  

SELECT p.ParticipantName, p.ParticipantType
FROM Participants p
JOIN AdoptionEvents a ON p.EventID=a.EventID
WHERE p.EventID = @EventID;

-----------------------------------------Q7 STORED PROCEDURE THAT ALLOWS A SHELTER TO UPDATE INFORMATION---------------------------
CREATE PROCEDURE UpdateShelter
    @ShelterID INT,
    @NewName VARCHAR(50),
    @NewLocation VARCHAR(50)
AS
BEGIN
        UPDATE Shelters
        SET Name = @NewName,
            Location = @NewLocation
        WHERE ShelterID = @ShelterID;
END;
 EXEC UpdateShelter 
    @ShelterID = 2, 
    @NewName = 'New Hope Shelter', 
    @NewLocation = 'Madurai';

SELECT * FROM Shelters;

-----------------------------------------Q8 CALCULATE AND RETRIEVE THE TOTAL DONATION AMOUNT FOR EACH SHELTER--------------------------
ALTER TABLE Donations
ADD ShelterID INT;
ALTER TABLE Donations
ADD CONSTRAINT FK_Donations_Shelters
FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);

UPDATE Donations SET ShelterID = 1 WHERE DonationID = 1;
UPDATE Donations SET ShelterID = 2 WHERE DonationID = 2;
UPDATE Donations SET ShelterID = 3 WHERE DonationID = 3;
UPDATE Donations SET ShelterID = 4 WHERE DonationID = 4;
UPDATE Donations SET ShelterID = 5 WHERE DonationID = 5;
UPDATE Donations SET ShelterID = 6 WHERE DonationID = 6;
UPDATE Donations SET ShelterID = 7 WHERE DonationID = 7;
UPDATE Donations SET ShelterID = 8 WHERE DonationID = 8;
UPDATE Donations SET ShelterID = 9 WHERE DonationID = 9;
UPDATE Donations SET ShelterID = 10 WHERE DonationID = 10;

SELECT * FROM Donations;

SELECT 
    S.Name AS ShelterName,
    SUM(D.DonationAmount) AS TotalDonations
FROM Shelters S
LEFT JOIN Donations D ON S.ShelterID = D.ShelterID
GROUP BY S.Name;


-----------------------------------------Q9 RETRIEVE THE NAMES OF PETS THAT DO NOT HAVE AN OWNER-------------------------------
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption IS NULL;

-----------------------------------------Q10 RETIEVE TOTAL DONATION AMOUNT FOR EACH MONTH AND YEAR eg.jan2023-----------------------
SELECT 
    YEAR(DonationDate) AS DonationYear,
    MONTH(DonationDate) AS DonationMonth,
    SUM(DonationAmount) AS TotalDonation
FROM Donations
WHERE DonationType = 'Cash'
GROUP BY YEAR(DonationDate), MONTH(DonationDate);

----------------------------------------Q11 RETRIVE LIST OF DISTINCT BREEDS FOR ALL PETS THAT ARE EITHER AGE BETWEEN 1 AND 3-----
SELECT DISTINCT Breed
FROM Pets
WHERE (Age BETWEEN 1 AND 3) OR (Age > 5);

--------------------------------------  Q12 RETRIEVE LIST OF PETS AND THEIR SHELTERS WHERE PETS ARE CURRENTLY AVAILABLE FOR ADOPTION----------
ALTER TABLE Pets
ADD ShelterID INT;


ALTER TABLE Pets
ADD CONSTRAINT FK_Pets_Shelters FOREIGN KEY (ShelterID)
REFERENCES Shelters(ShelterID);

UPDATE Pets SET ShelterID = 1 WHERE Name = 'chellam';
UPDATE Pets SET ShelterID = 2 WHERE Name = 'Meenu';
UPDATE Pets SET ShelterID = 3 WHERE Name = 'sweety';
UPDATE Pets SET ShelterID = 2 WHERE Name = 'Luna';
UPDATE Pets SET ShelterID = 4 WHERE Name = 'azhagan';
UPDATE Pets SET ShelterID = 5 WHERE Name = 'bloomy';
UPDATE Pets SET ShelterID = 6 WHERE Name = 'cutie';
UPDATE Pets SET ShelterID = 7 WHERE Name = 'patu';
UPDATE Pets SET ShelterID = 8 WHERE Name = 'Simba';
UPDATE Pets SET ShelterID = 9 WHERE Name = 'tinu';

SELECT * FROM Pets;


SELECT 
    P.Name AS PetName,
    S.Name AS ShelterName
FROM Pets P
JOIN Shelters S ON P.ShelterID = S.ShelterID
WHERE P.AvailableForAdoption = 1;

------------------------------------------Q13 TOTAL NUMBER OF PARTICIPANTS IN EVENTORGANIZED BY SHELTER LOCATED IN SPECIFIC CITY(CHENNAI)------------
SELECT COUNT(*) AS TotalParticipants
FROM Participants p
JOIN AdoptionEvents a ON p.EventID = a.EventID
WHERE a.Location = 'chennai';

-----------------------------------------Q14 RETRIEVE A LIST OF UNIQUE BREEDS FOR PETS WITH AGE 1 AND 5----------------------
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;

------------------------------------------Q15 PETS THAT HAVE NOT BEEN ADOPTED ---------------------------------
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 0;

-----------------------------------------------Q16 RETRIEVE NAMES OF ALL ADOPTED PETS ALONG WITH ADOPTERS NAME-----------
CREATE TABLE Adoption (
    AdoptionID INT PRIMARY KEY,
    PetID INT FOREIGN KEY REFERENCES Pets(PetID),
    AdopterName VARCHAR(100),
    AdoptionDate DATE
);
INSERT INTO Adoption (AdoptionID, PetID, AdopterName, AdoptionDate) VALUES
(1, 3, 'Sundar Raj', '2025-03-15'),
(2, 5, 'Meena Kumari', '2025-03-20'),
(3, 7, 'Ravi Kumar', '2025-03-25'),
(4, 8, 'Priya Sharma', '2025-03-30'),
(5, 1, 'John Peter', '2025-04-01'),
(6, 2, 'Divya Balan', '2025-04-05'),
(7, 4, 'Karthik S.', '2025-04-07'),
(8, 6, 'Aisha Noor', '2025-04-10'),
(9, 9, 'Ganesh R.', '2025-04-11'),
(10, 10, 'Sneha Reddy', '2025-04-11');

SELECT 
    P.Name,
    A.AdopterName
FROM Adoption A
JOIN Pets P ON A.PetID = P.PetID;

-----------------------------------------------Q17 RETRIVEV LIST ALL SHELTERS ALONG WITH COUNT OF PETS CURRENTLY AVAILABLE FOR ADOPTION----------------
SELECT 
    S.Name AS ShelterName,
    COUNT(P.PetID) AS AvailablePetCount
FROM Shelters S
JOIN Pets P ON S.ShelterID = P.ShelterID 
GROUP BY S.Name;

-------------------------------------------------Q18 FIND ALL PAIRS OF PETS FROM THE SAME SHELTER THAT HAVE SAME BREED -----------------
SELECT 
    Pets1.Name,
    Pets2.Name,
    Pets1.Breed,
    Pets1.ShelterID
FROM 
    Pets AS Pets1, Pets AS Pets2
WHERE Pets1.Breed = Pets2.Breed AND Pets1.ShelterID = Pets2.ShelterID;

--------------------------------------------------Q19 LIST ALL POSSIBLE COMBINATIONS OF SHELETR AND ADOPTION EVENT-------------------
SELECT 
    S.Name,
    E.EventName
FROM Shelters S
CROSS JOIN AdoptionEvents E;

----------------------------------------------------Q20 DETERMINE ALL SHELTER THAT HAS THE HIGHEST NO OF ADOPTED PETS------------------------
SELECT TOP 1
    S.Name,
    COUNT(A.AdoptionID) AS AdoptedPetCount
FROM Adoption A
JOIN Pets P ON A.PetID = P.PetID
JOIN Shelters S ON P.ShelterID = S.ShelterID
GROUP BY S.Name
ORDER BY AdoptedPetCount DESC;
---------------------------------------------------------------------------------------------------------------------------------------------------
