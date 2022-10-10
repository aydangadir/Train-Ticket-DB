CREATE TABLE Train (
	id tinyint primary key auto_increment,
    trainName char(6) unique,
    numOfWagon tinyint NOT NULL,
    numOfSeats mediumint NOT NULL,
    fuelCapacity int not null,
    modelInfo text NOT NULL,
    trouble text not null,
    train_ready boolean default false,
    addedToRailway date NOT NULL,
    modifiedAt date default Null,
    removedAt date default null
);
CREATE TABLE TrainSchedule (
	id tinyint primary key auto_increment,
    scheduleName char(50) unique,
    trainID tinyint NOT NULL,
    woorksOnNonWorkingDays boolean default false,
    addedAt date not null,
    modifiedAt date default null,
    removedAt date default null,
    foreign key (TrainID) references Train(id)
);
CREATE TABLE Locations(
	id tinyint primary key auto_increment,
    locationName char(55) not null,
    latitude Decimal(8,6) not null,
    longitudes Decimal(9,6) not null
);
CREATE TABLE TrainScheduleLocations(
	id mediumint primary key auto_increment,
    trainScheduleID tinyint not null,
    departureTime time not null,
    departureLocationID tinyint not null,
    duration int not null,
    arrivalLocationID tinyint not null,
    distance float not null,
    nextLocation char(55),
    foreign key(TrainScheduleID) references TrainSchedule(id),
    foreign key(departureLocationID) references Locations(id),
    foreign key(arrivalLocationID) references Locations(id)
);
CREATE TABLE TrainSeatTypes (
	id tinyint primary key auto_increment,
    seatTypeName char(7) not null -- business or econom
);
CREATE TABLE TrainSeatReservation (
	id mediumint primary key auto_increment,
    trainScheduleID tinyint not null,
    seatTypeID tinyint not null,
    WagonNumber tinyint not null,
    rowNumber tinyint not null,
    seatNumber char(1) not null,
    price float not null,
    addedAt date not null,
    modifiedAt date default null,
    removedAt date default null,
    foreign key (trainScheduleID) references TrainSchedule(id),
    foreign key (seatTypeID) references TrainSeatTypes(id)
);
CREATE TABLE Staff (
	id int primary key auto_increment,
    firstName char(15) not null,
    lastName char(25) not null,
    dateOfBirth date not null,
    email char(55) unique not null,
    contactNum int unique not null,
	`position` char(30) not null,
    salary float not null,
    hired date not null,
    stillWorking boolean default true
);
CREATE TABLE TrainScheduleWagonStaff (
	id int primary key auto_increment,
    trainScheduleID tinyint not null,
    wagonNum tinyint NOT NULL,
    staffID int not null, 
    foreign key (trainScheduleID) references TrainSchedule(id),
    foreign key (staffID) references Staff(id)
);
CREATE TABLE railwayCards (
	id int primary key auto_increment,
    railwayCardNumber int unique not null,
    amount float not null default 0,
    addedAt date not null,
    validUntil date not null,
    modifiedAt date default null,
    removedAt date default null
);
CREATE TABLE Customers (
	id int primary key auto_increment,
    firstName char(15) not null,
    lastName char(25) not null,
    dateOfBirth date not null,
    email char(55) unique not null,
    railwayCardNumberID int unique default null,
	foreign key (railwayCardNumberID) references railwayCards(id)
);
CREATE TABLE PaymentMethod (
	id tinyint primary key auto_increment,
    method char(4) not null, -- card or cash
    priceChange float not null default 0
);
CREATE TABLE Transactions (
	id bigint primary key auto_increment,
    customerID int not null,
    paymentMethodID tinyint not null,
    registrationTime timestamp not null,
    seatID mediumint not null,
    cashierID int default null,
    addedAt date not null,
    deletedAt date default null,
    foreign key (customerID) references Customers(id),
	foreign key (paymentMethodID) references PaymentMethod(id),
    foreign key (seatID) references TrainSeatReservation(id),
    foreign key (cashierID) references Staff(id)
);