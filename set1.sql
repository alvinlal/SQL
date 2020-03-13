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
/* 
Roll_no  Name           Dept_id     Gender        Contact_no
1	     alvin lal	    120	        M	           9207248664
2	     amal tom	    120	        M	           9207248665
3	     allen joseph   122	        M	           9207248666
4	     aliya	        123	        F	           9207248667
5	     jasmine	    124	        F	           9207248668
*/

INSERT INTO department VALUES(120,'ELECTRICAL');
INSERT INTO department VALUES(121,'MECHANICAL');
INSERT INTO department VALUES(122,'CHEMICAL');
INSERT INTO department VALUES(123,'COMPUTER');
INSERT INTO department VALUES(124,'AUTOMOBILE');

/*
Dept_id  Name
120	     ELECTRICAL
121	     MECHANICAL
122	     CHEMICAL
123	     COMPUTER
124	     AUTOMOBILE
*/


--1b--
UPDATE student SET Contact_no=123456789 WHERE Roll_no=005;
/*
Roll_no  Name           Dept_id     Gender       Contact_no
5	    jasmine	        124	        F	         123456789
*/

--2a--
SELECT * FROM student WHERE Gender='F' ORDER BY Name ASC;
/*
Roll_no  Name           Dept_id     Gender       Contact_no
4	    aliya	        123	        F	        9207248667
5	    jasmine	        124	        F	        123456789
*/
--2b--
SELECT COUNT(*) FROM student WHERE Dept_id='120' ;
/*
2
*/
--3--
CREATE VIEW STUDENTVIEW AS SELECT * FROM student ;
SELECT * FROM STUDENTVIEW GO; --to display the view
/*
Roll_no  Name           Dept_id     Gender       Contact_no
1	    alvin lal	    120	        M	         9207248664
2	    amal tom	    120	        M	         9207248665
3	    allen joseph	122	        M	         9207248666
4	    aliya	        123	        F	         9207248667
5	    jasmine	        124	        F	         123456789
*/
--4a--
CREATE PROCEDURE GETNAMECONTACT AS SELECT Name,Contact_no FROM student GO;
EXEC GETNAMECONTACT;        --to execute the procedure
/*
Name            Contact_no
alvin lal	    9207248664
amal tom	    9207248665
allen joseph	9207248666
aliya	        9207248667
jasmine	        123456789
*/
--4b--
CREATE PROCEDURE GETEMPTYDEPS AS SELECT Dept_name FROM department WHERE Dept_id NOT IN (SELECT Dept_id FROM student) GO;
EXEC GETEMPTYDEPS;
/*
MECHANICAL
*/

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
/*
Cust_id	Fname	    Lname	    Area	    Phone_number
100	    lionel	    messi	    kochi	    9207248664
101	    johns	    cena	    kollam	    9207248665
102	    philipe	    coutinho	kottayam	920724444
103	    bale	    gareth	    kochi	    9207248664
104	    paulo	    dybala	    kollam	    9207233664
*/
INSERT INTO invoice VALUES('120','100','13/7/08');  --use SET DATEFORMAT dmy before insertion if any errors occur to explicity change the date format
INSERT INTO invoice VALUES('121','101','14/8/08');
INSERT INTO invoice VALUES('122','102','15/9/08');
INSERT INTO invoice VALUES('123','103','13/2/08');
INSERT INTO invoice VALUES('124','104','13/12/08');
/*
Inv_no  Cust_id  Issue_date
120	    100	     2008-07-13
121	    101	     2008-08-14
122	    102	     2008-09-15
123	    103	     2008-02-13
124	    104	     2008-12-13
*/
--1b--
UPDATE invoice SET Issue_date='24/7/8' WHERE Cust_id='101';
/*
Inv_no  Cust_id  Issue_date
121	    101	     2008-07-24
*/
--2a--
SELECT Issue_date FROM invoice JOIN customer ON customer.Cust_id=invoice.Cust_id AND customer.Fname='johns'
/*
Issue_date
2008-07-24
*/
--2b--
SELECT Fname,Inv_no FROM invoice JOIN customer ON customer.Cust_id=invoice.Cust_id;
/*
Fname    Inv_no
lionel	120
johns	121
philipe	122
bale	123
paulo	124
*/
--3--
CREATE VIEW CUSTOMERVIEW AS SELECT * FROM customer GO;
SELECT * FROM CUSTOMERVIEW;
/*
Cust_id	Fname	    Lname	    Area	    Phone_number
100	    lionel	    messi	    kochi	    9207248664
101	    johns	    cena	    kollam	    9207248665
102	    philipe	    coutinho	kottayam	920724444
103	    bale	    gareth	    kochi	    9207248664
104	    paulo	    dybala	    kollam	    9207233664
*/

--4a--
CREATE PROCEDURE GETLNAMEPB AS SELECT Lname FROM customer WHERE Fname LIKE 'p%' OR Fname LIKE 'b%' GO;
EXEC GETLNAMEPB;
/*
Lname
coutinho
gareth
dybala
*/

--4b--
CREATE PROCEDURE GETCUSTDETAILS AS SELECT * FROM customer ORDER BY Fname ASC GO;
EXEC GETCUSTDETAILS;
/*
Cust_id	Fname	    Lname	    Area	    Phone_number
103	    bale	    gareth	    kochi	    9207248664
101	    johns	    cena	    kollam	    9207248665
100	    lionel	    messi	    kochi	    9207248664
104	    paulo	    dybala	    kollam	    9207233664
102	    philipe	    coutinho	kottayam    920724444
*/

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
/*
Cno     Cname   Address         City
100	    john	NULL	        kochi
101	    alvin	alvin villa	    kakkanad
102	    amal	amal villa	    kochi
103	    amal	amal villa	    south kochi
104	    jay	    NULL	        alapuzha
*/
INSERT INTO sales VALUES(120,'3/1/2012',100);
INSERT INTO sales VALUES(121,'3/2/2012',101);
INSERT INTO sales VALUES(122,'3/3/2012',102);
INSERT INTO sales VALUES(123,'4/3/2012',103);
INSERT INTO sales VALUES(124,'7/3/2012',104);
/*
Orderno  Orderdate      Cno
120	    2012-01-03	    100
121	    2012-02-03	    101
122	    2012-03-03	    102
123	    2012-03-04	    103
124	    2012-03-07	    104
*/
--1b--
UPDATE customer SET Address='john villa' WHERE Cname='john';
/*
Cno     Cname   Address         City
100	   john	   john villa	kochi
*/
--2a--
SELECT COUNT(*)  FROM sales WHERE Orderdate>'3/3/2012';
/*
2
*/
--2b--
SELECT Orderno FROM sales JOIN customer ON customer.Cno=sales.Cno AND customer.Cname='jay'
/*
2
*/
--3--
CREATE VIEW CUSTOMERVIEW AS SELECT * FROM customer GO;
SELECT * FROM CUSTOMERVIEW ;
/*
Cno     Cname   Address         City
100	    john	john villa	    kochi
101	    alvin	alvin villa	    kakkanad
102	    amal	amal villa	    kochi
103	    amal	amal villa	    south kochi
104	    jay	    NULL	        alapuzha
*/
--4a--
CREATE PROCEDURE GETDISNAMEA AS SELECT DISTINCT Cname FROM customer WHERE Cname LIKE 'A%' GO;
EXEC GETDISNAMEA GO;
/*
Cname
alvin
amal
*/
--4b--
CREATE PROCEDURE GETNULLADDRESS AS SELECT * FROM customer WHERE Address IS NULL;
EXEC GETNULLADDRESS;
/*
Cno     Cname   Address         City
104	    jay	    NULL	        alapuzha
*/

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
/*
eno	    name	designation	    salary
100	    Albert	trainee  	    1000.00
101	    Alvin	team member	    4000.00
102	    Glenn	team head	    6000.00
103	    Rivin	team member	    4000.00
104	    Basil	manager	        10000.00
*/
INSERT INTO project VALUES(120,'Online Shop',100);
INSERT INTO project VALUES(121,'Social network site',101);
INSERT INTO project VALUES(122,'Chat app',102);
INSERT INTO project VALUES(123,'Recipe app',103);
INSERT INTO project VALUES(124,'Taxi app',104);
/*
PID     ProjName            eno
120	    Online Shop	        100
121	    Social network site	101
122	    Chat app	        102
123	    Recipe app	        103
124	    Taxi app	        104
*/
--1b--
UPDATE employee SET designation='team member' WHERE name='Albert';
/*
eno     name    designation         salary
100	    Albert	team member  	    1000.00
*/
--2a--
SELECT * FROM employee ORDER BY name;
/*
eno	    name	designation	    salary
100	    Albert	team member	    1000.00
101	    Alvin	team member	    4000.00
104	    Basil	manager	        10000.00
102	    Glenn	team head	    6000.00
103	    Rivin	team member	    4000.00
*/

--2b--
SELECT name,ProjName FROM employee JOIN  project ON employee.eno=project.eno;
/*
name	ProjName
Albert	Online Shop
Alvin	Social network site
Glenn	Chat app
Rivin	Recipe app
Basil	Taxi app
*/
--3--
CREATE VIEW EMPLOYEEVIEW AS SELECT * FROM employee;
SELECT * FROM EMPLOYEEVIEW; 
/*
eno	    name	 designation	    salary
100	    Albert	 team member	    1000.00
101	    Alvin	 team member	    4000.00
102	    Glenn	 team head	        6000.00
103	    Rivin	 team member	    4000.00
104	    Basil	 manager	        10000.00
*/
--4a--
CREATE PROCEDURE GETSALARY5000 AS SELECT name FROM employee WHERE salary<5000 GO;
EXEC GETSALARY5000 ;
/*
name
Albert
Alvin
Rivin
*/
--4b--
CREATE PROCEDURE GETMINMAXAVG AS SELECT designation,MIN(salary) AS MINIMUMSALARY,MAX(salary) AS MAXIMUMSALARY ,AVG(salary) AS AVGSALARY FROM employee GROUP BY designation GO;
EXEC GETMINMAXAVG;
/*
designation	    MINIMUMSALARY	MAXIMUMSALARY	AVGSALARY
manager	        10000.00	    10000.00	    10000.000000
team head	    6000.00	        6000.00	        6000.000000
team member	    1000.00	        4000.00	        3000.000000
*/
--QUESTION NO 5--
CREATE DATABASE FIVEEMPLOYEE;
USE FIVEEMPLOYEE;
SELECT * from employee;
select * from branch;
CREATE TABLE employee(
    Ecode   VARCHAR(5)   CONSTRAINT pk_employee_Ecode     PRIMARY KEY,
    Ename   VARCHAR(30)  NOT NULL, 
    Bcode   VARCHAR(10)  CONSTRAINT fk_employee_Bcode     FOREIGN KEY REFERENCES branch(Bcode),
    Grade   VARCHAR(2)   CONSTRAINT check_employee_Grade  CHECK(Grade BETWEEN 1 AND 10),
    Dt_in   Date,
    salary  NUMERIC(7,2) 
);

CREATE TABLE branch(
    Bcode VARCHAR(10) CONSTRAINT pk_branch_Bcode PRIMARY KEY,
    Bname VARCHAR(10) NOT NULL
);
--1a--
INSERT INTO employee VALUES('E201','Alvin lal','B120',1,'1/1/2020',2000);
INSERT INTO employee VALUES('E202','Amal tom','B121',2,'1/2/2020',3000);
INSERT INTO employee VALUES('E203','Glenn antony','B122',2,'1/3/2020',4000);
INSERT INTO employee VALUES('E204','Allen joseph','B123',7,'1/4/2020',5000);
INSERT INTO employee VALUES('E205','Antony benjamin','B124',10,'1/5/2020',6000);
/*
Ecode	Ename	          Bcode	    Grade	Dt_in	    salary
E201	Alvin lal	      B120	    1	    2020-01-01	2000.00
E202	Amal tom	      B121	    2	    2020-01-02	3000.00
E203	Glenn antony	  B122	    2	    2020-01-03	4000.00
E204	Allen joseph	  B123	    7	    2020-01-04	5000.00
E205	Antony benjamin	  B124	    10	    2020-01-05	6000.00
*/
INSERT INTO branch VALUES('B120','puthencruz');
INSERT INTO branch VALUES('B121','nilampur');
INSERT INTO branch VALUES('B122','kochi');
INSERT INTO branch VALUES('B123','vaduthala');
INSERT INTO branch VALUES('B124','vypin');
/*
Bcode	Bname
B120	puthencruz
B121	nilampur
B122	kochi
B123	vaduthala
B124	vypin
*/
--1b--
UPDATE employee SET Grade=5 WHERE Ecode='E201';
/*
Ecode	Ename	          Bcode	    Grade	Dt_in	    salary
E201	Alvin lal	      B120	    5	    2020-01-01	2000.00
*/
--2a--
SELECT Ename FROM employee WHERE salary>(SELECT AVG(salary) FROM employee); 
/*
Ename
Allen joseph
Antony benjamin
*/
--2b--
SELECT Ename,Bname,Grade FROM employee JOIN branch ON employee.Bcode=branch.Bcode;
/*
Ename	           Bname	    Grade
Alvin lal	       puthencruz	5
Amal tom	       nilampur	    2
Glenn antony	   kochi	    2
Allen joseph	   vaduthala	7
Antony benjamin	   vypin	    10
*/
--3--
CREATE VIEW EMPBNAMEGRADEVIEW AS SELECT Ename,Grade FROM employee;
SELECT * FROM EMPBNAMEGRADEVIEW;
/*
Ename	         Grade
Alvin lal	     5
Amal tom	     2
Glenn antony	 2
Allen joseph	 7
Antony benjamin	 10
*/
--3a--
CREATE PROCEDURE GETGRADETWO AS SELECT Ename FROM employee WHERE Grade=2;
EXEC GETGRADETWO;
/*
Ename
Amal tom
Glenn antony
*/
--3b--
CREATE PROCEDURE GETSALARY3K5k AS SELECT Ename FROM employee WHERE salary BETWEEN 3000 AND 5000;
EXEC GETSALARY3K5k;
/*
Ename
Amal tom
Glenn antony
Allen joseph
*/





