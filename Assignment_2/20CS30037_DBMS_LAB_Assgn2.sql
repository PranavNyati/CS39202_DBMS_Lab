-- DBMS Lab Assignment 2
-- Name: Pranav Nyati
-- Roll No: 20CS30037


-- ##################### CREATION OF TABLES AND INSERTION OF TUPLES #####################

--Table 1
-- Create the Physician table
create table Physician(
    EmployeeID INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Position VARCHAR(255) NOT NULL,
    SSN INT NOT NULL,
    PRIMARY KEY(EmployeeID),
    UNIQUE(SSN)
);

-- insert tuples into Physician table
insert into Physician values
(1001, 'Ashok Garg', 'Attending Surgeon', 846173852),
(1002, 'Vineeta Jain', 'Attending Surgeon', 675382914),
(1003, 'Ritik Singh', 'Attending Physician', 341279658),
(1004, 'Amit Gupta', 'Head of the Department', 921358607),
(1005, 'Prachi Agarwal', 'Attending Physician', 734865920),
(2001, 'Ram Prasad', 'Head of the Department', 462087359),
(3001, 'Rohit Tiwari', 'Head of the Department', 893574126),
(4001, 'Ravi Vyas', 'Head of the Department', 709846253),
(4002, 'Kshitij Pareekh', 'Attending Physician', 654389027),
(5001, 'Alka Mathur', 'Head of the Department', 234798650),
(6001, 'Vijay Nyati', 'Head of the Department', 587362914),
(7001, 'Asha Nyati', 'Head of the Department', 498261753),
(8001, 'Shalini Birla', 'Head of the Department', 394721856),
(9001, 'Nilesh Jain', 'Head of the Department', 879542631),
(10001, 'Rajendra Thakar', 'Head of the Department', 765382940),
(11001, 'Neelprabha Nahar', 'Head of the Department', 638294715),
(12001, 'Manav Singh', 'Emergency Surgeon', 548291736),
(12002, 'Dilip Jain', 'Emergency Surgeon', 437892651),
(12003, 'Neeraj Singhvi', 'Head of the Department', 394827165),
(13001, 'Ruchi Goyal', 'Head of the Department', 298746318);


-- Table 2
-- create Department table
create table Department(
    DepartmentID INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    HeadID INT NOT NULL, 
    PRIMARY KEY (DepartmentID), 
    FOREIGN KEY (HeadID) REFERENCES Physician(EmployeeID) );

-- insert tuples into Department table
insert into Department values
(1000, 'Cardiology', 1004), 
(2000, 'Orthopedics', 2001), 
(3000, 'Trauma and Critical Care', 3001),
(4000, 'Neurosurgery', 4001),
(5000, 'Psychiatry', 5001),
(6000, 'Pediatrics', 6001),
(7000, 'Dermatology', 7001),
(8000, 'Opthalmology', 8001),
(9000, 'Urology', 9001),
(10000, 'Rajendra Thakar', 10001),
(11000, 'Radiology', 11001),
(12000, 'Emergency', 12003),
(13000, ' Anesthesiology',  13001);


-- Table 3
-- create Affiliated_with table
create table Affiliated_with(
    PhysicianID INT NOT NULL,
    DepartmentID INT NOT NULL,
    PrimaryAffiliation BOOLEAN NOT NULL,
    PRIMARY KEY (PhysicianID, DepartmentID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- insert tuples into Affiliated_with table
insert into Affiliated_with values
(1001, 1000, true),
(1001, 3000, false),
(1001, 12000, false),
(1002, 1000, true),
(1003, 1000, true),
(1004, 1000, true),
(1004, 3000, false),
(1004, 12000, false),
(1005, 1000, true),
(2001, 2000, true),
(2001, 3000, false),
(2001, 12000, false),
(3001, 3000, true),
(4001, 3000, false),
(4001, 4000, true),
(4001, 12000, false),
(4002, 4000, true),
(5001, 5000, true),
(6001, 6000, true),
(7001, 7000, true),
(8001, 8000, true),
(9001, 9000, true),
(10001, 10000, true),
(11001, 11000, true),
(12001, 12000, true),
(12002, 12000, true),
(12003, 12000, true),
(13001, 3000, false),
(13001, 12000, false),
(13001, 13000, true);


-- Table 4
-- create Med_Procedure table
create table Med_Procedure(
    ProcedureCode INT NOT NULL,
    ProcedureName VARCHAR(255) NOT NULL,
    Cost INT NOT NULL,
    PRIMARY KEY (ProcedureCode)
);

-- insert tuples into Med_Procedure table
insert into Med_Procedure values
(991001, 'Bypass Surgery', 50000),
(991002, 'Heart transplant', 1500000),
(991003, 'Pacemaker insertion', 80000),
(994001, 'Brain Tumor Surgery', 200000),
(994002, 'Biopsy', 30000),
(997001, 'Chemical Peel', 4000),
(998001, 'Cataract surgery', 10000);


-- Table 5
-- create Trained_in table
create table Trained_In(
    PhysicianID INT NOT NULL, 
    ProcedureCode INT NOT NULL, 
    CertificationDate DATETIME NOT NULL, 
    CertificationExpires DATETIME NOT NULL, 
    PRIMARY KEY (PhysicianID, ProcedureCode), 
    FOREIGN KEY (PhysicianID) REFERENCES Physician(EmployeeID), 
    FOREIGN KEY (ProcedureCode) REFERENCES Med_Procedure(ProcedureCode) );

-- insert tuples into Trained_In table
insert into Trained_In values
(1001, 991001, '2012-01-01 00:00:00', '2025-01-01 23:59:59'),
(1002, 991001, '2008-02-01 00:00:00', '2023-02-01 23:59:59'),
(1003, 991001, '2006-03-01 00:00:00', '2020-03-01 23:59:59'),
(4001, 994001, '2012-12-01 00:00:00', '2020-12-01 23:59:59'),
(12001, 991001, '2013-06-01 00:00:00', '2028-06-01 23:59:59'),
(4001, 991001, '2001-12-01 00:00:00', '2015-12-01 23:59:59');


-- Table 6
-- create Patient table
create table Patient( 
    SSN INT NOT NULL, 
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL, 
    Phone VARCHAR(255) NOT NULL, 
    InsuranceID INT NOT NULL, 
    PCP INT NOT NULL, 
    PRIMARY KEY (SSN), 
    FOREIGN KEY (PCP) REFERENCES Physician(EmployeeID),
    UNIQUE (InsuranceID)
);

-- insert tuples into Patient table
insert into Patient values
(738462950, 'Ajay Jha', 'E-41, RKP, KOTA', '9456712345', 37565, 1003),
(857296431, 'Amrita', 'J-12, DB, KOTA', '9643920451', 18163, 12002),
(963147825, 'Soham', 'A-63, GP, KOTA', '8967509123', 17262, 1003),
(263574819, 'Ankur', '2-G-6, VB, KOTA', '9829162824', 36316, 1005),
(123897654, 'Jai', '2-CH-4, RP, KOTA', '9928358672', 39169, 4002),
(795346120, 'Sharv', '2-KA-4, MN, KOTA', '9649014149', 11231, 1005);


-- Table 7
-- create table Block
create table Block(
    Floor INT NOT NULL,
    Code INT NOT NULL,
    PRIMARY KEY (Floor, Code)
);

-- insert tuples into Block table
insert into Block values
(1, 24),
(1, 31),
(2, 5),
(2, 6);


-- Table 8
-- create table Room
create table Room(
    RoomNo INT NOT NULL,
    Type VARCHAR(255) NOT NULL,
    BlockFloor INT NOT NULL,
    BlockCode INT NOT NULL,
    Unavailable BOOLEAN NOT NULL,
    PRIMARY KEY (RoomNo),
    FOREIGN KEY (BlockFloor, BlockCode) REFERENCES Block(Floor, Code)
);

-- insert tuples into Room table
insert into Room values
(102, 'Deluxe', 2, 5, true),
(105, 'Deluxe', 2, 6, false),
(123, 'ICU', 1, 24, true),
(201, 'ICU', 1, 31, false);


-- Table 9
-- create table Stay
create table Stay(
    StayID INT NOT NULL,
    PatientSSN INT NOT NULL,
    RoomNo INT NOT NULL,
    Start DATETIME NOT NULL,
    End DATETIME NOT NULL,
    PRIMARY KEY (StayID),
    FOREIGN KEY (PatientSSN) REFERENCES Patient(SSN),
    FOREIGN KEY (RoomNo) REFERENCES Room(RoomNo)
);

-- insert tuples into Stay table
insert into Stay values
(7012270, 963147825, 102, '2022-01-07 11:30:00', '2022-01-18 14:00:00'),
(15032105, 738462950, 201, '2021-03-15 09:00:00', '2021-04-07 18:00:00'),
(15072276, 795346120, 201, '2022-07-15 18:20:00', '2022-07-21 10:00:00'),
(15122233, 263574819, 105, '2022-12-15 14:30:00', '2022-12-24 20:00:00'),
(16012202, 123897654, 123, '2022-01-16 08:30:00', '2022-02-08 11:50:00'),
(22042117, 857296431, 123, '2021-04-22 13:00:00', '2021-05-17 16:00:00');


-- Table 10
-- create table Nurse
create table Nurse(
    EmployeeID INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Position VARCHAR(255) NOT NULL,
    Registered BOOLEAN NOT NULL, 
    SSN INT NOT NULL, 
    PRIMARY KEY (EmployeeID),
    UNIQUE (SSN)
);

-- insert tuples into Nurse table
insert into Nurse values 
(890001, 'Ramila Singh', 'Staff Nurse', false, 598237564),
(890002, 'Dinesh Kumar', 'Staff Nurse', true, 741628309),
(890003, 'Pramod Sen', 'OT Nurse', true, 294578361),
(890004, 'Richa Jain', 'OT Nurse', true, 638291745),
(890005, 'Sunita Sahu', 'OT Nurse', true, 879354120);


-- Table 11
-- create table On_Call
create table On_Call(
    NurseID INT NOT NULL,
    BlockFloor INT NOT NULL,
    BlockCode INT NOT NULL,
    Start DATETIME NOT NULL,
    End DATETIME NOT NULL,
    PRIMARY KEY (NurseID, BlockFloor, BlockCode, Start, End),
    FOREIGN KEY (NurseID) REFERENCES Nurse(EmployeeID),
    FOREIGN KEY (BlockFloor, BlockCode) REFERENCES Block(Floor, Code)
);

--insert tuples into On_Call table
insert into On_Call values
(890001, 1, 24, '2021-04-01 09:00:00', '2021-04-30 09:00:00'),
(890003, 1, 24, '2022-01-01 09:00:00', '2022-01-31 09:00:00'),
(890004, 1, 31, '2022-02-01 09:00:00', '2022-02-28 09:00:00'),
(890005, 2, 5, '2022-03-01 09:00:00', '2022-03-31 09:00:00'),
(890002, 2, 6, '2021-03-01 09:00:00', '2021-03-31 09:00:00');


-- Table 12
-- create table Undergoes
create table Undergoes(
    PatientSSN INT NOT NULL,
    ProcedureCode INT NOT NULL,
    StayID INT NOT NULL,
    ProcedureDate DATETIME NOT NULL,
    PhysicianID INT NOT NULL,
    AssistingNurseID INT,
    PRIMARY KEY (PatientSSN, ProcedureCode, StayID, ProcedureDate),
    FOREIGN KEY (PatientSSN) REFERENCES Patient(SSN),
    FOREIGN KEY (ProcedureCode) REFERENCES Med_Procedure(ProcedureCode),
    FOREIGN KEY (StayID) REFERENCES Stay(StayID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(EmployeeID),
    FOREIGN KEY (AssistingNurseID) REFERENCES Nurse(EmployeeID)
);

-- insert tuples into Undergoes table
insert into Undergoes values
(123897654, 994001, 16012202, '2022-01-24 13:30:00', 4001, 890003),
(123897654, 994002, 16012202, '2022-01-20 10:00:00', 4002, 890003),
(263574819, 991001, 15122233, '2022-12-17 11:30:00', 1001, 890004),
(738462950, 991001, 15032105, '2021-03-28 09:30:00', 1001, 890005),
(795346120, 991001, 15072276, '2022-07-16 16:00:00', 1003, 890004),
(963147825, 991001, 7012270, '2022-01-08 09:00:00', 1002, 890003),
(963147825, 991003, 7012270, '2022-01-14 14:00:00', 1001, 890004);


-- Table 13
-- create table Medication
create table Medication(
    Code INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Brand VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    PRIMARY KEY (Code)
);

-- insert tuples into Medication table
insert into Medication values
(126132, 'ofloxacin', 'GSK', 'to cure stomach infections'),
(383112, 'captopril', 'GSK', 'heart-related medicine'),                                                    
(393912, 'remdesivir', 'BharatBiotech', 'A medicine to cure lung infections and related complications during COVID'),
(394036, 'calpol-600', 'GSK', 'contains Paracetamol to bring relief from fever');


-- Table 14
-- create table Appointment
create table Appointment(
    AppointmentID INT NOT NULL,
    PatientSSN INT NOT NULL,
    PrepNurseID INT,
    PhysicianID INT NOT NULL,
    Start DATETIME NOT NULL,
    End DATETIME NOT NULL,
    ExaminationRoom VARCHAR(255) NOT NULL,
    PRIMARY KEY (AppointmentID),
    FOREIGN KEY (PatientSSN) REFERENCES Patient(SSN),
    FOREIGN KEY (PrepNurseID) REFERENCES Nurse(EmployeeID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(EmployeeID)
);

-- insert tuples into Appointment table
insert into Appointment values
(9032147, 738462950, 890001, 1003, '2021-03-09 10:00:00', '2021-03-09 11:00:00', '011'),
(15042111, 857296431, 890002, 12002, '2021-04-15 18:00:00', '2021-04-15 19:00:00', '021'),
(19122147, 963147825, 890001, 1003, '2021-12-19 16:00:00', '2021-12-19 17:00:00', '041'),
(24032123, 738462950, 890002, 1003, '2021-03-24 09:00:00', '2021-03-24 10:00:00', '011'),
(26122109, 963147825, NULL, 1003, '2021-12-26 11:00:00', '2021-12-26 12:30:00', '031');


-- Table 15
-- create table Prescribes
create table Prescribes(
    PhysicianID INT NOT NULL,
    PatientSSN INT NOT NULL,
    Medic_Code INT NOT NULL,
    Date DATETIME NOT NULL,
    AppointmentID INT,
    Dose TINYTEXT NOT NULL,
    PRIMARY KEY (PhysicianID, PatientSSN, Medic_Code, Date),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(EmployeeID),
    FOREIGN KEY (PatientSSN) REFERENCES Patient(SSN),
    FOREIGN KEY (Medic_Code) REFERENCES Medication(Code),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- insert tuples into Prescribes table
insert into Prescribes values
(1003, 738462950, 393912, '2021-03-09 10:45:00', 9032147, 'Thrice a day for 3 weeks'),
(1003, 963147825, 383112, '2021-12-26 11:50:00', 26122109, '1 per day for 6 months'),
(12002, 857296431, 393912, '2021-04-15 18:50:00', 15042111, 'Thrice a day for 2 weeks');


-- ################## QUERIES ####################

-- QUERY 1
SELECT Physician.Name
FROM Physician
INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID  
INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';


-- QUERY 2
SELECT Physician.Name 
FROM Physician 
INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID 
INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery'
INNER JOIN Affiliated_with ON Affiliated_with.PhysicianID = Physician.EmployeeID
INNER JOIN Department ON Affiliated_with.DepartmentID = Department.DepartmentID and Department.Name = 'Cardiology';


-- QUERY 3
SELECT Nurse.Name
FROM Nurse
INNER JOIN On_Call ON Nurse.EmployeeID = On_Call.NurseID
INNER JOIN Room ON Room.BlockFloor = On_Call.BlockFloor and Room.BlockCode = On_Call.BlockCode and Room.RoomNo = 123;


-- QUERY 4
SELECT Patient.Name, Patient.Address 
FROM Patient
INNER JOIN Prescribes ON Patient.SSN = Prescribes.PatientSSN
INNER JOIN Medication ON Medication.Code = Prescribes.Medic_Code and Medication.Name = 'remdesivir';


-- QUERY 5
SELECT Patient.Name, Patient.InsuranceID 
FROM Patient
INNER JOIN Stay ON Stay.PatientSSN = Patient.SSN
INNER JOIN Room ON Stay.RoomNo = Room.RoomNo and Room.Type = 'ICU' and DATEDIFF (Stay.End , Stay.Start ) > 15;


-- QUERY 6
SELECT DISTINCT Nurse.Name
FROM Nurse
INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID
INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';


-- QUERY 7
SELECT DISTINCT Nurse.Name, Nurse.Position, Physician.Name
FROM Nurse
INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID
INNER JOIN Physician ON Undergoes.PhysicianID = Physician.EmployeeID
INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';


-- QUERY 8
SELECT Physician.Name
FROM Physician
INNER JOIN Undergoes ON Undergoes.PhysicianID = Physician.EmployeeID
WHERE (Undergoes.PhysicianID , Undergoes.ProcedureCode ) NOT IN (SELECT PhysicianID, ProcedureCode FROM Trained_In);


-- QUERY 9
SELECT Physician.Name
FROM Physician
INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID
INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;


-- QUERY 10
SELECT Physician.Name, Med_Procedure.ProcedureName, Undergoes.ProcedureDate , Patient.Name
FROM Physician
INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID
INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Undergoes.ProcedureCode
INNER JOIN Patient ON Undergoes.PatientSSN = Patient.SSN
INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;


-- QUERY 11
WITH Patient_Data AS(
    SELECT Patient.SSN, Patient.Name, Patient.PCP, COUNT(Patient.SSN)
    FROM Patient
    INNER JOIN Appointment a1 ON Patient.SSN = a1.PatientSSN
    INNER JOIN Affiliated_with  aw1 ON aw1.PhysicianID = a1.PhysicianID
    INNER JOIN Physician ph1 ON ph1.EmployeeID = a1.PhysicianID
    INNER JOIN Department d1 ON d1.DepartmentID = aw1.DepartmentID and d1.Name = 'Cardiology'
    GROUP BY Patient.SSN
    HAVING COUNT(Patient.SSN) > 1
)
SELECT DISTINCT p1.Name, ph2.Name
FROM Patient_Data
INNER JOIN Patient p1 ON p1.SSN = Patient_Data.SSN
INNER JOIN Appointment a2 ON a2.PatientSSN = p1.SSN
INNER JOIN Affiliated_with aw2 ON aw2.PhysicianID = a2.PhysicianID
INNER JOIN Department d2 ON d2.DepartmentID = aw2.DepartmentID and d2.HeadID != a2.PhysicianID
INNER JOIN Prescribes prs1 ON prs1.PatientSSN = Patient_Data.SSN and prs1.PhysicianID = Patient_Data.PCP
INNER JOIN Undergoes u1 ON u1.PatientSSN = Patient_Data.SSN 
INNER JOIN Med_Procedure mp1 ON mp1.ProcedureCode = u1.ProcedureCode
INNER JOIN Physician ph2 ON p1.PCP = ph2.EmployeeID
WHERE mp1.cost > 5000;


-- QUERY 12
WITH Med_Freq AS (
SELECT Medic_Code, Count(*) as med_count
FROM Prescribes
GROUP BY Medic_Code
)
SELECT Name, Brand
FROM Med_Freq 
INNER JOIN Medication ON Medication.Code = Med_Freq.Medic_Code
WHERE Med_Freq.med_count = (SELECT MAX(med_count) FROM Med_Freq);

-- ############################### END OF QUERIES ###############################