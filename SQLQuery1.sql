
CREATE DATABASE medical_rentalEQ

ON PRIMARY
(
    NAME = 'medical_rental_Data',
    FILENAME = 'D:\sqlproject\medical_rental.mdf',
    SIZE = 10MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 5MB
),

(
    NAME = 'medical_rental_Secondary',
    FILENAME = 'D:\sqlproject\medical_rental_Secondary.ndf',
    SIZE = 10MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 5MB
)

LOG ON
(
    NAME = 'medical_rental_Log',
    FILENAME = 'D:\sqlproject\medical_rental_Log.ldf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
),

(
    NAME = 'medical_rental_Log2',
    FILENAME = 'D:\sqlproject\medical_rental_Log2.ldf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
);
USE medical_rentalEQ
CREATE TABLE Customers(
customerID INT IDENTITY(1,1),
CONSTRAINT PK_customersid PRIMARY KEY (customerID),
customername VARCHAR (100) NOT NULL,
phone VARCHAR (20),
email VARCHAR(100),
address VARCHAR (100));


CREATE TABLE Equipment_categories (
categoryID INT IDENTITY (1,1),
CONSTRAINT PK_categoryID PRIMARY KEY (categoryID),
categoryname VARCHAR(100) NOT NULL,
CONSTRAINT PK_category UNIQUE (categoryname)
);

create TABLE medical_equipment(
equipmentID INT IDENTITY(1,1),
CONSTRAINT PK_equipment PRIMARY KEY(equipmentID),
categoryID INT NOT NULL,
CONSTRAINT FK_category FOREIGN KEY(categoryID) REFERENCES Equipment_categories(categoryID),
serialnumber VARCHAR(50) NOT NULL ,
CONSTRAINT UQ_serialnumber UNIQUE(serialnumber),
daily_rental DECIMAL(10,2) NOT NULL,
CONSTRAINT CHK_daily_rental CHECK (daily_rental>0),
availabilitystatus VARCHAR(20) DEFAULT'AVAILABLE',
CONSTRAINT CHK_availability CHECK (availabilitystatus IN ('AVAILABLE','RENTED','UNDER MAINTENANCE')),
condition VARCHAR(20) DEFAULT 'GOOD',
CONSTRAINT CHK_condition CHECK(condition IN ('GOOD','POOR"','FAIR')) );
CREATE TABLE Rentals
(
    rentalID INT IDENTITY(1,1),

    customerID INT NOT NULL,

    rentalDate DATE NOT NULL,

    startdate DATE NOT NULL,

    enddate DATE NOT NULL,

    rentalstatus VARCHAR(20) DEFAULT 'PENDING',

    CONSTRAINT PK_rentalsID
    PRIMARY KEY (RentalID),

    CONSTRAINT FK_Rentals_Customers
    FOREIGN KEY (customerID)
    REFERENCES Customers(customerID),

    CONSTRAINT CHK_rentaldate
    CHECK (EndDate >= StartDate),

    CONSTRAINT CHK_rentalstatus
    CHECK (rentalstatus IN ('PENDING', 'ACTIVE', 'COMPLETED', 'CANCELED'))
);
CREATE TABLE Rental_details(
rentalIDdetail INT IDENTITY (1,1)NOT NULL,
CONSTRAINT pk_rentalIDdetail PRIMARY KEY (rentalIDdetail) ,
rentalID INT NOT NULL,
CONSTRAINT FK_rentalID_Rentaldetails_renntalID_rentals FOREIGN KEY(rentalID) REFERENCES Rentals(rentalID),
equipmentID INT NOT NULL,
CONSTRAINT FK_equipmentID_Rentaldetails_equipmentID_Medicalequipment FOREIGN KEY (equipmentID) REFERENCES medical_equipment(equipmentID),
CONSTrAINT UQ_rentalid_equipmentid UNIQUE(rentalID,equipmentID),
quantity INT NOT NULL ,
CONSTRAINT CHK_quantity CHECK (quantity>0) 

);
CREATE TABLE Payments
(
    paymentID INT IDENTITY(1,1),
    CONSTRAINT PK_payments
    PRIMARY KEY (paymentID),
    rentalID INT NOT NULL,
    CONSTRAINT FK_rentalID_Payments_rentalID_Rentals FOREIGN KEY (rentalID) REFERENCES Rentals(rentalID),
    
    paymentdate DATE NOT NULL,

    amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_amount
    CHECK (amount > 0),

    paymentmethod VARCHAR(30) NOT NULL,
    CONSTRAINT CHK_method
    CHECK (paymentmethod IN ('Cash', 'Card', 'Bank Transfer')),

    paymentstatus VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT CHK_status
    CHECK (paymentstatus IN ('Pending', 'Paid', 'Failed'))
);
CREATE TABLE Maintenance
(
    maintenanceID INT IDENTITY(1,1),
    CONSTRAINT PK_Maintenance PRIMARY KEY (maintenanceID),

    equipmentID INT NOT NULL,
    CONSTRAINT FK_equipmentID_Maintainence_equipmentID_Medical_equipment
    FOREIGN KEY (EquipmentID)
    REFERENCES Medical_Equipment(equipmentID),

    maintenanceDate DATE NOT NULL,

    Description VARCHAR(250),

    Cost DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_Maintenance_Cost
    CHECK (Cost >= 0),

    MaintenanceStatus VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT CHK_Maintenance_Status
    CHECK (MaintenanceStatus IN ('Pending', 'In Progress', 'Completed'))
);




























