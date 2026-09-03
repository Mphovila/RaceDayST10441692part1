CREATE DATABASE RaceDayDB;

USE RaceDayDB;

CREATE TABLE Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    PhoneNumber VARCHAR(20),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);


CREATE TABLE Events
(
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId INT NOT NULL,
    EventName VARCHAR(150) NOT NULL,
    Description VARCHAR(500),
    EventType VARCHAR(50) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location VARCHAR(200) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Events_Users
        FOREIGN KEY (OrganiserId)
        REFERENCES Users(UserId)
);

CREATE TABLE Categories
(
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    Distance DECIMAL(10,2) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL DEFAULT 0,
    MaximumParticipants INT NOT NULL,

    CONSTRAINT FK_Categories_Events
        FOREIGN KEY (EventId)
        REFERENCES Events(EventId)
);

CREATE TABLE Enrolments
(
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL,
    EventId INT NOT NULL,
    CategoryId INT NOT NULL,
    EnrolmentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(50) NOT NULL DEFAULT 'Active',

    CONSTRAINT FK_Enrolments_Users
        FOREIGN KEY (ParticipantId)
        REFERENCES Users(UserId),

    CONSTRAINT FK_Enrolments_Events
        FOREIGN KEY (EventId)
        REFERENCES Events(EventId),

    CONSTRAINT FK_Enrolments_Categories
        FOREIGN KEY (CategoryId)
        REFERENCES Categories(CategoryId)
);


CREATE TABLE Results
(
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL UNIQUE,
    FinishTime VARCHAR(20),
    Position INT,
    ResultStatus VARCHAR(50) NOT NULL,

    CONSTRAINT FK_Results_Enrolments
        FOREIGN KEY (EnrolmentId)
        REFERENCES Enrolments(EnrolmentId)
);


CREATE TABLE Routes
(
    RouteId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    RouteName VARCHAR(150) NOT NULL,
    StartLocation VARCHAR(200) NOT NULL,
    EndLocation VARCHAR(200) NOT NULL,
    Distance DECIMAL(10,2) NOT NULL,
    RouteDescription VARCHAR(500),

    CONSTRAINT FK_Routes_Events
        FOREIGN KEY (EventId)
        REFERENCES Events(EventId)
);



CREATE TABLE WeatherInformation
(
    WeatherId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    Temperature DECIMAL(5,2),
    WeatherDescription VARCHAR(150),
    WindSpeed DECIMAL(5,2),
    LastUpdated DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_WeatherInformation_Events
        FOREIGN KEY (EventId)
        REFERENCES Events(EventId)
);

USE RaceDayDB;


SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


USE RaceDayDB;
GO

INSERT INTO Users
(FirstName, LastName, Email, PasswordHash, Role, PhoneNumber)
VALUES
('Thabo', 'Mokoena', 'thabo@gmail.com', 'thamo484', 'Organiser', '07147482926'),
('Sarah', 'Jacobs', 'sarah@gmail.com', 'sara803', 'Organiser', '0646822222'),
('Kabelo', 'Dlamini', 'kabelo@gmail.com', 'dla7484', 'Participant', '08490590594'),
('Lerato', 'Ndlovu', 'lerato@gmail.com', 'Lera475', 'Participant', '0749707577');


INSERT INTO Events
(OrganiserId, EventName, Description, EventType, EventDate, Location, EntryFee)
VALUES
(1, 'Johannesburg Spring Run',
 'A community road running event for different age groups.',
 'Running',
 '2026-10-10 07:00:00',
 'Johannesburg',
 120.00),

(1, 'Soweto Community Walk',
 'A community walking event suitable for families.',
 'Walking',
 '2026-10-24 08:00:00',
 'Soweto',
 80.00),

(2, 'Gauteng Cycle Challenge',
 'A road cycling event for recreational and experienced cyclists.',
 'Cycling',
 '2026-11-07 06:30:00',
 'Pretoria',
 250.00);

 INSERT INTO Categories
(EventId, CategoryName, Distance, EntryFee, MaximumParticipants)
VALUES
(1, '5 KM Run', 5.00, 80.00, 500),
(1, '10 KM Run', 10.00, 120.00, 700),
(1, '21 KM Run', 21.10, 180.00, 500),

(2, '5 KM Walk', 5.00, 60.00, 500),
(2, '10 KM Walk', 10.00, 80.00, 500),

(3, '30 KM Cycle', 30.00, 150.00, 300),
(3, '60 KM Cycle', 60.00, 200.00, 400),
(3, '100 KM Cycle', 100.00, 250.00, 300);


INSERT INTO Enrolments
(ParticipantId, EventId, CategoryId, Status)
VALUES
(3, 1, 2, 'Active'),
(4, 1, 1, 'Active'),
(3, 2, 4, 'Active'),
(4, 3, 6, 'Active');

INSERT INTO Results
(EnrolmentId, FinishTime, Position, ResultStatus)
VALUES
(1, '00:52:35', 24, 'Finished'),
(2, '00:29:48', 12, 'Finished');

USE RaceDayDB;

SELECT * FROM Users;

SELECT * FROM Events;

SELECT * FROM Categories;

SELECT * FROM Enrolments;

SELECT * FROM Results;

SELECT * FROM Routes;

SELECT * FROM WeatherInformation;




