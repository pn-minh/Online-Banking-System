-- DROP DATABASE onlinebank;

CREATE DATABASE onlinebank; 

use onlinebank;

CREATE TABLE account (
	accountNo varchar(100),
    userID varchar(10),
    balance real NOT NULL,
    password_ varchar(100) NOT NULL,
    accountType char(7) NOT NULL,
    primary key(accountNo)
    );

    
CREATE TABLE customer (
	customerID int auto_increment,
    customerName varchar(100) NOT NULL,
    creditScore int NOT NULL,
    street varchar(50) NOT NULL,
    area varchar(50) NOT NULL,
    city varchar(50) NOT NULL,
    pincode char(6) NOT NULL,
    primary key(customerID),
    CHECK (creditScore <= 1000 and creditScore >=0)
    ) auto_increment = 1;
    
create table customerPhone(
	customerID int,
    phoneNumber char(10),
    primary key(customerID, phoneNumber),
    foreign key(customerID) references customer(customerID)
	);
    
CREATE TABLE employee (
	employeeID int auto_increment,
    employeeName varchar(100) NOT NULL,
    salary int NOT NULL,
    -- joiningDate date, 
    street varchar(50),
    area varchar(50),
    city varchar(50),
    pincode char(6),
    primary key(employeeID),
    CHECK (salary > 0)
    ) auto_increment = 1;
    
create table employeePhone(
	employeeID int,
    phoneNumber char(10),
    primary key(employeeID, phoneNumber),
    foreign key(employeeID) references employee(employeeID)
	);
    
CREATE TABLE branch (
	IFSC char(15),
    branchArea varchar(50) NOT NULL,
    branchCity varchar(50) NOT NULL,
    primary key(IFSC)
    );
    
CREATE TABLE loan (
	customerID int,
	loanID int auto_increment,
    interestRate int NOT NULL,
    period int NOT NULL,  -- in months
    amount real NOT NULL,
    collateral varchar(100),
    EMI int,
    primary key(loanID,customerID),
    foreign key (customerID) references customer(customerID),
    CHECK (period > 0 and amount > 0)
    ) auto_increment = 1;


CREATE TABLE fixedDeposit (
	accountNo varchar(100),
	fixedDepositID int auto_increment,
    interest int NOT NULL,
    period int NOT NULL,  -- in months
    amount real NOT NULL,
    primary key(fixedDepositID,accountNo),
    foreign key(accountNo) references account(accountNo),
    CHECK (period > 0 and amount > 0)
    ) auto_increment = 1;

CREATE TABLE card (
	cardNo varchar(100),
	accountNo varchar(100),
    Expiry date NOT NULL,  
    CVV varchar(100) NOT NULL,
    cardtype varchar(6) NOT NULL,
    spendLimit int,
    primary key(cardNo),
    foreign key(accountNo) references account(accountNo)
    ) auto_increment = 1;

CREATE TABLE accountOpening (
	customerID int,
    accountNo varchar(100),
	IFSC char(15),
    dateOfOpening date,
    primary key(customerID, accountNo),
    foreign key(customerID) references customer(customerID),
    foreign key(accountNo) references account(accountNo),
    foreign key(IFSC) references branch(IFSC)
    );
    
CREATE TABLE accountInBranch (
	accountNo varchar(100),
    dateOfInception date,
    IFSC char(15),
    primary key (accountNo, dateOfInception),
    foreign key(IFSC) references branch(IFSC)
    );
    
CREATE TABLE loanInBranch (	
    loanID char(15),
    IFSC char(15),
    primary key (loanID),
    foreign key(IFSC) references branch(IFSC)
    )auto_increment = 1;
    
CREATE TABLE login(
	accountNo varchar(100),
    time_Stamp timestamp,
    customerID int,
	loggedIn boolean not null,
    primary key (accountNo, time_Stamp),
    foreign key(customerID) references customer(customerID),
    foreign key(accountNo) references account(accountNo)
    );
    
CREATE TABLE transaction(
	transactionID int auto_increment,
	accountNo varchar(100) NOT NULL,
    recAccNo varchar(100) NOT NULL,
    mode varchar(100) NOT NULL,
    amount int NOT NULL,
    time_Stamp timestamp,
    primary key (transactionID),
    foreign key(accountNo) references account(accountNo),
    foreign key(recAccNo) references account(accountNo),
    CHECK (amount > 0)
    )auto_increment = 1;

    
CREATE TABLE borrow (
	customerID int,
    loanID int,
	startDate date,
    primary key(loanID),
    foreign key(customerID) references customer(customerID),
    foreign key(loanID) references loan(loanID)
    );
    
CREATE TABLE repayment (
	paymentID int auto_increment,
    customerID int,
    loanID int,
	dateOfPayment date,
    EMI real,
    primary key(paymentID),
    foreign key(customerID) references customer(customerID),
    foreign key(loanID) references loan(loanID)
    )auto_increment = 1;
    
CREATE TABLE employs (
	employeeID int,
	joiningDate date,
    IFSC char(15),
    primary key(employeeID, joiningDate),
    foreign key(employeeID) references employee(employeeID),
    foreign key(IFSC) references branch(IFSC)
    );
    
CREATE TABLE manages (
	employeeID int,
	dateOfAppointment date,
    IFSC char(15),
    primary key(employeeID, dateOfAppointment),
    foreign key(employeeID) references employee(employeeID),
    foreign key(IFSC) references branch(IFSC)
    );
    
    
insert into account values 
("111111111111111","meet",99929922929292929,"meetpopat","savings"),
("211111111111111","meet",99929922929292929,"meetpopat","CURRENT"),
("111111111111112","shourya",-100,"shouryajindal","SAVINGS"),
("211111111111112","shourya",-100,"shouryajindal","current"),
("111111111111113","aditya",10,"adityanangia","savings"),
("211111111111113","aditya",10,"adityanangia","CURRENT"),
("111111111111114","sufyan",999,"sufyanazam","SAVING"),
("211111111111114","sufyan",999,"sufyanazam","current"),
("111111111111115","pavitra",50,"pavitragupta","savings"),
("211111111111115","pavitra",50,"pavitragupta","CURRENT");


insert into branch values 
("PYTM01234567891","ABCH","AKOLA"),
("ICICI8908765432","TRRRR","DELHI"),
("HDFC12345678900","VVVVV","DELHI"),
("IDBI09876543212","ZZZZZ","MUMBAI"),
("AUBL12345678900","XXXX","AKOLA");

insert into accountInBranch values
("111111111111111","2021-07-07","PYTM01234567891"),
("111111111111112","2020-09-08","ICICI8908765432"),
("111111111111113","2019-08-06","HDFC12345678900"),
("111111111111114","2019-07-09","IDBI09876543212"),
("111111111111115","2017-09-09","AUBL12345678900");


insert into customer (customerName, creditScore, street, area, city, pincode) values 
("Meet Popat",999,"566","OKHLA","DELHI","110021"),
("Shourya Jindal",9,"233","NEHRU","DELHI","110022"),
("Aditya Nangia",899,"455","LAJPAT","NOIDA","110023"),
("Sufyan Azam",900,"4578","SAKET","GURUGRAM","110024"),
("Pavitra Gupta",80,"77","NOIDA","NOIDA","110025");

insert into customerPhone values
(1,"8888011288"),
(2,"8888011289"),
(3,"8888011290"),
(4,"8888011291"),
(5,"8888011292");


insert into accountOpening values
(1,"111111111111111","PYTM01234567891","2021-07-07"),
(2,"111111111111112","ICICI8908765432","2020-09-08"),
(3,"111111111111113","HDFC12345678900","2019-08-06"),
(4,"111111111111114","IDBI09876543212","2019-07-09"),
(5,"111111111111115","AUBL12345678900","2017-09-09"),
(1,"211111111111111","PYTM01234567891","2021-07-07"),
(2,"211111111111112","ICICI8908765432","2020-09-08"),
(3,"211111111111113","HDFC12345678900","2019-08-06"),
(4,"211111111111114","IDBI09876543212","2019-07-09"),
(5,"211111111111115","AUBL12345678900","2017-09-09");


insert into card values
("1234567891234567","111111111111111","2026-09-02","198","DEBIT",1000000),
("2234567891234567","211111111111111","2026-09-02","198","CREDIT",1000000),
("1234567891234568","111111111111112","2026-09-03","200","DEBIT",91110),
("2234567891234568","211111111111112","2026-09-03","200","CREDIT",91110),
("1234567891234569","111111111111113","2026-09-04","201","DEBIT",20000),
("2234567891234569","211111111111113","2026-09-04","201","CREDIT",20000),
("1234567891234570","111111111111114","2026-09-05","202","DEBIT",300000),
("2234567891234570","211111111111114","2026-09-05","202","CREDIT",300000),
("1234567891234571","111111111111115","2026-09-06","203","DEBIT",400000),
("2234567891234571","211111111111115","2026-09-06","203","CREDIT",400000);


insert into transaction values
(1234,"111111111111114","111111111111115","UPI",2000,'2020-01-01 00:00:01'),
(2345,"111111111111111","111111111111112","Card",3000,'2022-01-01 00:00:01'),
(3456,"111111111111113","211111111111115","Online",5000,'2021-01-01 00:00:01'),
(4567,"211111111111115","111111111111114","UPI",6000,'2022-01-07 00:00:01'),
(5567,"211111111111112","111111111111111","Card",8000,'2022-06-07 00:00:01');


insert into employee (employeeName,salary,street,area,city,pincode) values
("sibin",30000,"1","ANDHERI","MUMBAI","400001"),
("rahul",40000,"2","MODEL TOWN","DELHII","110021"),
("saksham",50000,"3","KAROL BAGH","DELHII","110020"),
("subham",60000,"4","JUHU","MUMBAI","444001"),
("BANSAL",70000,"5","DADAR","MUMBAI","444441");

insert into employeePhone values
(1,7744063263),
(2,7741063263),
(3,9423088766),
(4,8888011299),
(5,8888011277);

insert into employs values
(1,"2019-01-01","PYTM01234567891"),
(2,"2020-02-02","ICICI8908765432"),
(3,"2018-08-08","HDFC12345678900"),
(4,"2017-07-07","IDBI09876543212"),
(5,"2016-06-06","AUBL12345678900");

insert into fixedDeposit (accountNo,interest,period,amount) values
("111111111111111",7,10,100000),
("111111111111111",7,5,200000),
("111111111111112",8,6,30000),
("111111111111113",8,9,50000),
("211111111111114",6,25,60000);

insert into loan (customerID,interestRate,period,amount,collateral,EMI)values
(1,11,5,1000000,"property",10000),
(2,12,7,2000000,"on loan",20000),
(3,13,3,3000000,"car",30000),
(4,15,12,400000,"land",4000),
(5,10,10,5000000,"gold",50000);

insert into loanInbranch values
(1,"PYTM01234567891"),
(2,"ICICI8908765432"),
(3,"HDFC12345678900"),
(4,"IDBI09876543212"),
(5,"AUBL12345678900");

insert into repayment(CustomerID,loanID,dateOfPayment,EMI) values 
(1,1,'2020-01-01',10000),
(2,2,'2020-01-01',20000),
(3,3,'2020-01-01',30000),
(4,4,'2020-01-01',4000),
(5,5,'2020-01-01',50000);

insert into borrow values
(1,1,'2019-01-01'),
(2,2,'2018-01-01'),
(3,3,'2017-01-01'),
(4,4,'2016-01-01'),
(5,5,'2015-01-01');

insert into login values 
("111111111111111",'2020-01-01 00:00:01',1,true),
("111111111111112",'2020-01-01 00:00:01',2,true),
("111111111111113",'2020-01-01 00:00:01',3,true),
("111111111111114",'2020-01-01 00:00:01',4,true),
("111111111111115",'2020-01-01 00:00:01',5,true);

insert into manages values 
(1,"2019-01-01","PYTM01234567891");


-- TRRIGER 1: to create accounts on customer registration
DELIMITER &&
CREATE TRIGGER accountCreate 
before INSERT
on customer
for each row 
	BEGIN
		DECLARE accVar, pass, CaccVar, Cpass, cardNoVar, cvvar, cardNoVarDe, cvvarDe varchar(100) Default '999999999999999';
		SELECT FLOOR(RAND() * (999999999999999-899999999999999) + 899999999999999)
		INTO accVar;
        SELECT FLOOR(RAND() * (9999999999999999-8999999999999999) + 8999999999999999)
		INTO cardNoVar;
        SELECT FLOOR(RAND() * (9999999999999999-8999999999999999) + 8999999999999999)
		INTO cardNoVarDe;
        SELECT FLOOR(RAND() * (999-899) + 899)
		INTO cvvar;
        SELECT FLOOR(RAND() * (999-899) + 899)
		INTO cvvarDe;
        SELECT concat(New.customerName, New.customerID)
		INTO pass;
        SELECT FLOOR(RAND() * (999999999999999-899999999999999) + 899999999999999)
		INTO CaccVar;
        SELECT concat(New.customerName, New.customerID, "C")
		INTO Cpass;
		
        
		insert into account values(accVar, NEW.customerName, 10000000, pass, 'savings');
        insert into card values (cardNoVarDe, accVar, "2026-09-02", cvvarDe, "DEBIT",1000);
        insert into account values(CaccVar, NEW.customerName, 100000, Cpass, 'current');
        insert into card values (cardNoVar, CaccVar, "2026-09-02", cvvar, "CREDIT",1000);
	END&&

DELIMITER ;

-- Triger 2: to set employee salary on each new employee registration 
create trigger Employee_salary_update 
before insert 
on employee 
for each row 
set new.salary = 100000;


-- Trigger 3: for transaction updates
DELIMITER &&
CREATE TRIGGER transactionUpdates
before INSERT
on transaction
for each row 
	BEGIN
		set New.mode = "Net Banking";
        set New.time_Stamp = current_timestamp;
		update account set balance = balance - New.amount where accountNo = New.accountNo;
        update account set balance = balance + New.amount where accountNo = New.recAccNo;
	END&&
DELIMITER ;

-- Trigger 4: to create accountinBranch
DELIMITER &&
CREATE TRIGGER addBranch
before INSERT
on account
for each row 
	BEGIN
		insert into accountInBranch values(New.accountNo, "2021-07-07", "PYTM01234567891");
	END&&
DELIMITER ;


-- Trigger 5: to create loanInBranch
DELIMITER &&
CREATE TRIGGER loanBranch
before INSERT
on account
for each row 
	BEGIN
		insert into loanInBranch values(New.loanID, "PYTM01234567891");
	END&&
DELIMITER ;

-- VIEW 1 
create view employee_view_cust as
select c.customerName, c.creditScore, a.accountNo, a.balance, a.accountType 
from customer c, account a, accountOpening ao
where ao.customerID = c.customerId and ao.accountNo = a.accountNo ;

-- VIEW 2 
create view manager_view_cust as
select c.customerName, c.creditScore, c.customerID, a.accountNo, a.balance, a.accountType , b.IFSC
from customer c, account a, accountOpening ao, accountInBranch aib, branch b
where ao.customerID = c.customerId and ao.accountNo = a.accountNo and aib.accountNo = a.accountNo and b.IFSC = aib.IFSC;

-- VIEW 3 

create view manager_view_emp as
select e.employeeID, e.employeeName, e.salary
from employee e;

CREATE INDEX idx_transact ON transaction(accountNo);
CREATE INDEX idx_acc ON account(accountNo);
CREATE UNIQUE INDEX idx_card ON card(accountNo);
CREATE INDEX idx_accOpen ON accountopening(customerID);
CREATE INDEX idx_customer ON customer(customerID);
CREATE INDEX idx_loan ON loan(loanID);
CREATE INDEX idx_FD ON fixeddeposit(accountNo);



select A.accountNo, O.IFSC, A.balance 
from account as A, accountOpening as O 
where A.accountType = 'savings' and A.accountNo = O.accountNo and O.customerID = 5;
insert into employee (employeeName, street, area, city, pincode) values('asd', 'scfd', 'asdd', 'sdcd', 123456);
select * from employee;


