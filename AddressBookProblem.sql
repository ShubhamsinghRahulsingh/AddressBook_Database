--UC1-Creating Databse
CREATE DATABASE AddressBook_Service
USE AddressBook_Service;

--UC2-Creating AddressBook Table
CREATE TABLE AddressBook_DB(
PersonID INT PRIMARY KEY IDENTITY(1,1),
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30),
Address VARCHAR(100) NOT NULL,
City VARCHAR(20) NOT NULL,
State VARCHAR(20) NOT NULL,
ZIP INT NOT NULL,
PhoneNumber BIGINT NOT NULL,
Email VARCHAR(50) NOT NULL
);
SELECT * FROM AddressBook_DB

--UC3-Insert New Contacts To AddressBook table
INSERT INTO AddressBook_DB(FirstName,LastName,Address,City,State,ZIP,PhoneNumber,Email)VALUES
('Shubham','Singh','Rampuri Colony','Saharanpur','UP',247001,7837373733,'shubham@gmail.com'),
('Rahul','Singh','Rampuri Colony','Saharanpur','UP',247001,7537737332,'rahul@gmail.com'),
('Dheeraj','Singh','Line Paar','Moradabad','UP',456363,8373737273,'dheeraj@gmail.com'),
('Shanu','Gupta','Hasanpur','Dehradun','UK',345233,7675747374,'shanu@gmail.com'),
('Yogesh','Upadhyay','Manak Mau','Roorkee','UK',373746,848838383,'yogesh@gmail.com')

--UC4-Edit existing contact person using their names
UPDATE AddressBook_DB SET Lastname='Saini' WHERE Firstname='Dheeraj';
UPDATE AddressBook_DB SET Lastname='Sharma' WHERE Firstname='Rahul';
UPDATE AddressBook_DB SET State='MP' WHERE FirstName='Rahul';
UPDATE AddressBook_DB SET City='Nagpur' WHERE FirstName='Rahul';
UPDATE AddressBook_DB SET Address='Royal Garden' WHERE FirstName='Rahul';
SELECT * FROM AddressBook_DB

--UC5-Delete a person using person's name
DELETE FROM AddressBook_DB WHERE FirstName='Yogesh';
SELECT * FROM AddressBook_DB

--UC6-Retrieve Person belonging to a City or State from the Address Book
SELECT * FROM AddressBook_DB WHERE City='Saharanpur';
SELECT * FROM AddressBook_DB WHERE State='UP';
SELECT * FROM AddressBook_DB WHERE City = 'Nagpur' OR State = 'UK';  
SELECT * FROM AddressBook_DB WHERE City = 'Nagpur' AND State = 'UK';

--UC7-Size of Address book by City and State
SELECT COUNT(*) AS CityCount,City FROM AddressBook_DB GROUP BY City;
SELECT COUNT(*) AS StateCount,State FROM AddressBook_DB GROUP BY State;

--Inserting some more values to perform further UC
INSERT INTO AddressBook_DB(FirstName,LastName,Address,City,State,ZIP,PhoneNumber,Email)VALUES
('Rajat','Verma','Sugar Mill','Saharanpur','UP',247001,7574747373,'rajat@gmail.com'),
('Aakash','Tomar','Basant Vihar','Rohtak','HR',247001,8848484848,'aakash@gmail.com');
SELECT * FROM AddressBook_DB

--UC8-Retrieve entries sorted alphabetically by Person’s name for a given city
SELECT * FROM AddressBook_DB WHERE City='Saharanpur' ORDER BY FirstName;

--Retrieve entries sorted alphabetically by City Name
SELECT * FROM AddressBook_DB ORDER BY City DESC;
--Retrieve entries sorted alphabetically by Person's Name
SELECT * FROM AddressBook_DB ORDER BY FirstName;

--UC9-Ability to Identify each contact with name and Type.
ALTER TABLE AddressBook_DB ADD AddressBookType VARCHAR(50);
ALTER TABLE AddressBook_DB ADD AddressBookName VARCHAR(50);
UPDATE AddressBook_DB SET AddressBookType = 'Friends' WHERE City = 'Rohtak';
UPDATE AddressBook_DB SET AddressBookType = 'Family' WHERE NOT City = 'Rohtak';
UPDATE AddressBook_DB SET AddressBookType = 'Profession' WHERE FirstName  = 'Shubham';
UPDATE AddressBook_DB SET AddressBookName = 'Buddies' WHERE FirstName  = 'Rahul';
UPDATE AddressBook_DB SET AddressBookName = 'Buddies' WHERE FirstName  = 'Dheeraj';
UPDATE AddressBook_DB SET AddressBookName = 'Jigri' WHERE FirstName  = 'Shanu';
UPDATE AddressBook_DB SET AddressBookName = 'Jigri' WHERE FirstName  = 'Rajat';
UPDATE AddressBook_DB SET AddressBookName = 'Bros' WHERE FirstName  = 'Shubham';
UPDATE AddressBook_DB SET AddressBookName = 'Bros' WHERE FirstName  = 'Aakash';
SELECT * FROM AddressBook_DB

--UC10-Ability to get number of contact persons i.e. count by type
SELECT AddressBookType,COUNT(AddressBookType) AS NumberOfContactPersons FROM AddressBook_DB GROUP BY AddressBookType;

--UC11-Ability to add person to both Friend and Family
INSERT INTO AddressBook_DB(FirstName,LastName,Address,City,State,ZIP,PhoneNumber,Email,AddressBookType,AddressBookName)VALUES
('Shubham','Singh','Rampuri Colony','Saharanpur','UP',247001,7837373733,'shubham@gmail.com','Family','Buddies'),
('Mahesh','Babu','Aawas Vikas','Saharanpur','UP',247001,7837373733,'mahesh@gmail.com','Friends','Buddies')

--UC12-Implementation of ER Diagram
CREATE TABLE AddressBookType(
Id INT PRIMARY KEY IDENTITY(1,1),
Type VARCHAR(20) NOT NULL
);
SELECT * FROM AddressBookType;
INSERT INTO AddressBookType VALUES(
'Buddies'),('Yaar'),('Bros'),('Jigri');
ALTER TABLE AddressBook_DB DROP COLUMN AddressBookType;
ALTER TABLE AddressBook_DB ADD AddressBookType INT CONSTRAINT fk FOREIGN KEY(AddressBookType) REFERENCES AddressBookType(Id)
SELECT * FROM AddressBook_DB

CREATE TABLE AddressBookName(
TypeNameId INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) NOT NULL
);
SELECT * FROM AddressBookName;
INSERT INTO AddressBookName VALUES('Friend'),('Professional'),('Family'),('College'),('Others')
ALTER TABLE AddressBook_DB DROP COLUMN AddressBookName;
ALTER TABLE AddressBook_DB ADD AddressBookName INT CONSTRAINT fkk FOREIGN KEY(AddressBookName) REFERENCES AddressBookName(TypeNameId)

--Inserting values in First table After Creating new Tables
UPDATE AddressBook_DB SET AddressBookType = 1 WHERE State='UP'
UPDATE AddressBook_DB SET AddressBookType = 2 WHERE State='UK'
UPDATE AddressBook_DB SET AddressBookType = 3 WHERE State='MP'
UPDATE AddressBook_DB SET AddressBookType = 4 WHERE State='HR'
SELECT * FROM AddressBookType
SELECT * FROM AddressBookName
SELECT * FROM AddressBook_DB
UPDATE AddressBook_DB SET AddressBookName = 1 WHERE State='UP'
UPDATE AddressBook_DB SET AddressBookName = 3 WHERE State='UK'
UPDATE AddressBook_DB SET AddressBookName = 2 WHERE State='MP'
UPDATE AddressBook_DB SET AddressBookName = 4 WHERE State='HR'
UPDATE AddressBook_DB SET AddressBookName = 1 WHERE State='UP'

--UC13-Retrieving all values as done in previous UC's
SELECT FirstName,LastName,Address,Email,State,ZIP,City,Type,Name FROM AddressBook_DB 
INNER JOIN AddressBookName ON AddressBookName.TypeNameId=AddressBook_DB.AddressBookType
INNER JOIN AddressBookType on AddressBookType.Id=AddressBook_DB.AddressBookType

SELECT FirstName,LastName,Address,Email,State,ZIP,City,Type,Name FROM AddressBook_DB 
INNER JOIN AddressBookName ON AddressBookName.TypeNameId=AddressBook_DB.AddressBookType And City='Saharanpur'
INNER JOIN AddressBookType on AddressBookType.Id=AddressBook_DB.AddressBookType

SELECT CONCAT(FirstName,' ',LastName) AS FullName,Address,Email,State,ZIP,City,Type,Name FROM AddressBook_DB 
INNER JOIN AddressBookName ON AddressBookName.TypeNameId=AddressBook_DB.AddressBookType
INNER JOIN AddressBookType on AddressBookType.Id=AddressBook_DB.AddressBookType

SELECT Type,COUNT(*) AS NoOFTypes FROM AddressBook_DB 
INNER JOIN AddressBookName ON AddressBookName.TypeNameId=AddressBook_DB.AddressBookType
INNER JOIN AddressBookType on AddressBookType.Id=AddressBook_DB.AddressBookType
 GROUP BY Type

SELECT CONCAT(FirstName,' ',LastName) AS FullName,CONCAT(Address,', ',ZIP,', ',City,',' ,State) AS FullAddress,Type,Name,Email FROM AddressBook_DB 
INNER JOIN AddressBookName ON AddressBookName.TypeNameId=AddressBook_DB.AddressBookType
INNER JOIN AddressBookType on AddressBookType.Id=AddressBook_DB.AddressBookType
ORDER BY FullName

SELECT Name,COUNT(*) AS NoOFContacts FROM AddressBook_DB 
INNER JOIN AddressBookName ON AddressBookName.TypeNameId=AddressBook_DB.AddressBookType
INNER JOIN AddressBookType on AddressBookType.Id=AddressBook_DB.AddressBookType 
GROUP BY Name


