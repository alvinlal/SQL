--QUESTION NO:1--
CREATE DATABASE ONESTUDENT;
USE ONESTUDENT;

CREATE TABLE student(
    Roll_no     NUMERIC(5)  CONSTRAINT pk_student_Roll_no PRIMARY KEY,
    Name        VARCHAR(20) NOT NULL,
    Dept_id     NUMERIC(5)  CONSTRAINT fk_student_Dept_id FOREIGN KEY REFERENCES department(Dept_id),
    Gender      VARCHAR(2),
    Contact_no  NUMERIC(10) 
);

CREATE TABLE department(
    Dept_id     NUMERIC(5)  CONSTRAINT pk_department_Dept_id PRIMARY KEY,
    Dept_name   VARCHAR(10) NOT NULL
);

--1a--
INSERT INTO student VALUES(001,'alvin lal',120,'M',9207248664);
INSERT INTO student VALUES(002,'amal tom',120,'M',9207248665);
INSERT INTO student VALUES(003,'allen joseph',122,'M',9207248666);
INSERT INTO student VALUES(004,'aliya',123,'F',9207248667);
INSERT INTO student VALUES(005,'jasmine',124,'F',9207248668);

INSERT INTO department VALUES(120,'ELECTRICAL');
INSERT INTO department VALUES(121,'MECHANICAL');
INSERT INTO department VALUES(122,'CHEMICAL');
INSERT INTO department VALUES(123,'COMPUTER');
INSERT INTO department VALUES(124,'AUTOMOBILE');

--1b--
UPDATE student SET Contact_no=123456789 WHERE Roll_no=005;

--2a--
SELECT * FROM student WHERE Gender='F' ORDER BY Name ASC;

--2b--
SELECT COUNT(*) FROM student WHERE Dept_id='120' GO;

--3--
CREATE VIEW STUDENTVIEW AS SELECT * FROM student ;
SELECT * FROM STUDENTVIEW GO; --to display the view

--4a--
CREATE PROCEDURE GETNAMECONTACT AS SELECT Name,Contact_no FROM student;
EXEC GETNAMECONTACT GO;        --to execute the procedure

--4b--
CREATE PROCEDURE GETEMPTYDEPS AS SELECT Dept_name FROM department WHERE Dept_id NOT IN (SELECT Dept_id FROM student);
EXEC GETEMPTYDEPS;

--QUESTION NO 2--
CREATE DATABASE TWOSUPERMARKET;
USE TWOSUPERMARKET;

CREATE TABLE customer(
    Cust_id         VARCHAR(10) CONSTRAINT pk_customer_Cust_id PRIMARY KEY,
    Fname           VARCHAR(25) NOT NULL,
    Lname           VARCHAR(25),
    Area            VARCHAR(10) CONSTRAINT check_customer_Area CHECK(Area='kottayam' OR Area='Kollam' OR Area='Kochi'),
    Phone_number    NUMERIC(15)
);

CREATE TABLE invoice(
    Inv_no          VARCHAR(20) CONSTRAINT pk_invoice_Inv_no  PRIMARY KEY,
    Cust_id         VARCHAR(10) CONSTRAINT fk_invoice_Cust_id FOREIGN KEY REFERENCES customer(Cust_id),
    Issue_date      DATE
);

--1a--

INSERT INTO customer VALUES('100','lionel','messi','kochi',9207248664);
INSERT INTO customer VALUES('101','johns','cena','kollam',9207248665);
INSERT INTO customer VALUES('102','philipe','coutinho','kottayam',920724444);
INSERT INTO customer VALUES('103','bale','gareth','kochi',9207248664);
INSERT INTO customer VALUES('104','paulo','dybala','kollam',9207233664);

INSERT INTO invoice VALUES('120','100','13/7/08');  --use SET DATEFORMAT dmy before insertion if any errors occur to explicity change the date format
INSERT INTO invoice VALUES('121','101','14/8/08');
INSERT INTO invoice VALUES('122','102','15/9/08');
INSERT INTO invoice VALUES('123','103','13/2/08');
INSERT INTO invoice VALUES('124','104','13/12/08');

--1b--
UPDATE invoice SET Issue_date='24/7/8' WHERE Cust_id='101';

--2b--
SELECT Fname,Inv_no FROM invoice INNER JOIN customer ON customer.Cust_id=invoice.Cust_id;

--3--
CREATE VIEW CUSTOMERVIEW AS SELECT * FROM customer ;
SELECT * FROM CUSTOMERVIEW GO;

--4a--
CREATE PROCEDURE GETLNAMEPB AS SELECT Lname FROM customer WHERE Fname LIKE 'p%' OR Fname LIKE 'b%' ;
EXEC GETLNAMEPB GO;
--4b--
CREATE PROCEDURE GETCUSTDETAILS AS SELECT * FROM customer ORDER BY Fname ASC;
EXEC GETCUSTDETAILS;


--QUESTION NO 3--
CREATE DATABASE THREESUPERMARKET;
USE THREESUPERMARKET;

CREATE TABLE customer(
    Cno      VARCHAR(6)  CONSTRAINT pk_customer_Cno PRIMARY KEY,
    Cname    VARCHAR(20) NOT NULL,
    Address  VARCHAR(20),
    City     VARCHAR(20)
);

CREATE TABLE sales(
    Orderno   VARCHAR(6) CONSTRAINT pk_sales_Orderno PRIMARY KEY,
    Orderdate DATE,
    Cno       VARCHAR(6) CONSTRAINT fk_sales_Cno     FOREIGN KEY REFERENCES customer(Cno)
);
--1a--
INSERT INTO customer VALUES(100,'john',null,'kochi');
INSERT INTO customer VALUES(101,'alvin','alvin villa','kakkanad');
INSERT INTO customer VALUES(102,'amal','amal villa','kochi');
INSERT INTO customer VALUES(103,'amal','amal villa','south kochi');
INSERT INTO customer VALUES(104,'jay',null,'alapuzha');

INSERT INTO sales VALUES(120,'3/1/2012',100);
INSERT INTO sales VALUES(121,'3/2/2012',101);
INSERT INTO sales VALUES(122,'3/3/2012',102);
INSERT INTO sales VALUES(123,'4/3/2012',103);
INSERT INTO sales VALUES(124,'7/3/2012',104);
DROP TABLE customer;
DROP TABLE sales;
--1b--
UPDATE customer SET Address='john villa' WHERE Cname='john';

--2a--
SELECT COUNT(*)  FROM sales WHERE Orderdate>'3/3/2012';

--2b--
SELECT Orderno FROM sales JOIN customer ON customer.Cno=sales.Cno AND customer.Cname='jay'

--3--
CREATE VIEW CUSTOMERVIEW AS SELECT * FROM customer;
SELECT * FROM CUSTOMERVIEW GO;

--4a--
CREATE PROCEDURE GETDISNAMEA AS SELECT DISTINCT Cname FROM customer WHERE Cname LIKE 'A%';
EXEC GETDISNAMEA GO;

--4b--
CREATE PROCEDURE GETNULLADDRESS AS SELECT * FROM customer WHERE Address IS NULL;
EXEC GETNULLADDRESS;


--QUESTION NO 4--
CREATE DATABASE FOUREMPLOYEE;
USE FOUREMPLOYEE;

CREATE TABLE employee(
    eno          VARCHAR(5)   CONSTRAINT pk_employee_eno  PRIMARY KEY,
    name         VARCHAR(30)  NOT NULL,
    designation  VARCHAR(30)  CONSTRAINT check_employee_designation  CHECK(designation='trainee' OR designation='team member' OR designation='team head' OR designation='manager'),
    salary       NUMERIC(7,2),
);

CREATE TABLE project(
    PID      VARCHAR(5)  CONSTRAINT pk_project_PID PRIMARY KEY,
    ProjName VARCHAR(25),
    eno      VARCHAR(5)  CONSTRAINT fk_project_eno FOREIGN KEY REFERENCES employee(eno)
);

--1a--
INSERT INTO employee VALUES(100,'Albert','trainee',1000);
INSERT INTO employee VALUES(101,'Alvin','team member',4000);
INSERT INTO employee VALUES(102,'Glenn','team head',6000);
INSERT INTO employee VALUES(103,'Rivin','team member',4000);
INSERT INTO employee VALUES(104,'Basil','manager',10000);

INSERT INTO project VALUES(120,'Online Shop',100);
INSERT INTO project VALUES(121,'Social network site',101);
INSERT INTO project VALUES(122,'Chat app',102);
INSERT INTO project VALUES(123,'Recipe app',103);
INSERT INTO project VALUES(124,'Taxi app',104);

--1b--
UPDATE employee SET designation='team member' WHERE name='Albert';

--2a--
SELECT * FROM employee ORDER BY name;

--2b--
SELECT name,ProjName FROM employee JOIN  project ON employee.eno=project.eno;

--3--
CREATE VIEW EMPLOYEEVIEW AS SELECT * FROM employee;
SELECT * FROM EMPLOYEEVIEW; 

--4a--
CREATE PROCEDURE GETSALARY5000 AS SELECT name FROM employee WHERE salary<5000;
EXEC GETSALARY5000 GO;

--4b--
CREATE PROCEDURE GETMINMAXAVG AS SELECT designation,MIN(salary) AS MINIMUMSALARY,MAX(salary) AS MAXIMUMSALARY ,AVG(salary) AS AVGSALARY FROM employee GROUP BY designation;
EXEC GETMINMAXAVG;


