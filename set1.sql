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
SELECT * FROM STUDENTVIEW ; --to display the view
/*
Roll_no  Name           Dept_id     Gender       Contact_no
1	    alvin lal	    120	        M	         9207248664
2	    amal tom	    120	        M	         9207248665
3	    allen joseph	122	        M	         9207248666
4	    aliya	        123	        F	         9207248667
5	    jasmine	        124	        F	         123456789
*/
--4a--
CREATE PROCEDURE GETNAMECONTACT AS SELECT Name,Contact_no FROM student ;
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
CREATE PROCEDURE GETEMPTYDEPS AS SELECT Dept_name FROM department WHERE Dept_id NOT IN (SELECT Dept_id FROM student) ;
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
CREATE VIEW CUSTOMERVIEW AS SELECT * FROM customer ;
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
CREATE PROCEDURE GETLNAMEPB AS SELECT Lname FROM customer WHERE Fname LIKE 'p%' OR Fname LIKE 'b%' ;
EXEC GETLNAMEPB;
/*
Lname
coutinho
gareth
dybala
*/

--4b--
CREATE PROCEDURE GETCUSTDETAILS AS SELECT * FROM customer ORDER BY Fname ASC ;
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
CREATE VIEW CUSTOMERVIEW AS SELECT * FROM customer ;
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
CREATE PROCEDURE GETDISNAMEA AS SELECT DISTINCT Cname FROM customer WHERE Cname LIKE 'A%' ;
EXEC GETDISNAMEA ;
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
CREATE PROCEDURE GETSALARY5000 AS SELECT name FROM employee WHERE salary<5000 ;
EXEC GETSALARY5000 ;
/*
name
Albert
Alvin
Rivin
*/
--4b--
CREATE PROCEDURE GETMINMAXAVG AS SELECT designation,MIN(salary) AS MINIMUMSALARY,MAX(salary) AS MAXIMUMSALARY ,AVG(salary) AS AVGSALARY FROM employee GROUP BY designation ;
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
CREATE PROCEDURE GETSALARY3K5k AS SELECT Ename FROM employee WHERE salary BETWEEN 3000 AND 5000 ;
EXEC GETSALARY3K5k;
/*
Ename
Amal tom
Glenn antony
Allen joseph
*/
--QUESTION NO 6--
CREATE DATABASE SIXMOVIE;
USE SIXMOVIE;

CREATE TABLE movie(
    Mvno   NUMERIC(2)  CONSTRAINT pk_movie_Mvno PRIMARY KEY,
    Title  VARCHAR(25) CONSTRAINT unique_movie_Title UNIQUE NOT NULL,
    Type   VARCHAR(10) CONSTRAINT check_movie_Type CHECK(Type='comedy' OR Type='action' OR Type='horror'),
    Star   VARCHAR(25),
    Price  NUMERIC(10,2)
)

CREATE TABLE invoice(
    Invno       NUMERIC(2)  CONSTRAINT pk_invoice_Invno PRIMARY KEY,
    Mvno        NUMERIC(2)  CONSTRAINT fk_invoice_Mvno  FOREIGN KEY REFERENCES movie(Mvno),
    Issue_date  Date,
)
--1a--
INSERT INTO movie VALUES(20,'Ford vs ferrari','action','Christian bale',130);
INSERT INTO movie VALUES(21,'Dhrishyam','horror','Mohanlal',150);
INSERT INTO movie VALUES(22,'Joker','horror','Joaquin phoenix',150);
INSERT INTO movie VALUES(23,'CID moosa','comedy','Dileep',160);
INSERT INTO movie VALUES(24,'Avengers endgame','action','Robert downey jr',130);
/*
Mvno	Title	            Type	    Star	             Price
20	    Ford vsferrari	    action	    Christian bale	    130.00
21	    Dhrishyam	        horror	    Mohanlal        	150.00
22	    Joker	            horror	    Joaquin phoenix	    150.00
23	    CID moosa	        comedy	    Dileep	            160.00
24  	Avengers endgame	action	    Robert downey jr	130.00

*/
INSERT INTO invoice VALUES(12,20,'15/3/2020');
INSERT INTO invoice VALUES(13,21,'15/4/2020');
INSERT INTO invoice VALUES(14,22,'15/5/2020');
INSERT INTO invoice VALUES(15,23,'15/6/2020');
INSERT INTO invoice VALUES(16,24,'15/7/2020');
/*
Invno	Mvno	Issue_date
12	    20	    2020-03-15
13	    21	    2020-04-15
14	    22	    2020-05-15
15	    23	    2020-06-15
16	    24	    2020-07-15
*/

--1b--
UPDATE movie SET Price=Price+10;
/*
Mvno	Title	            Type	    Star	             Price
20	    Ford vs ferrari	    action	    Christian bale	    140.00
21	    Dhrishyam	        horror	    Mohanlal	        160.00
22	    Joker	            horror	    Joaquin phoenix	    160.00
23	    CID moosa	        comedy	    Dileep	            170.00
24	    Avengers endgame	action	    Robert downey jr    140.00
*/

--2a--
SELECT Title FROM movie ORDER BY Title;
/*
Title
Avengers endgame
CID moosa
Dhrishyam
Ford vs ferrari
Joker
*/
--2b--
SELECT Title,Issue_date FROM movie JOIN invoice ON movie.Mvno=invoice.Mvno;
/*
Title	            Issue_date
Ford vs ferrari	    2020-03-15
Dhrishyam	        2020-04-15
Joker	            2020-05-15
CID moosa	        2020-06-15
Avengers endgame	2020-07-15
*/
--3--
CREATE VIEW MOVIESTARVIEW AS SELECT star FROM movie ;
SELECT * FROM MOVIESTARVIEW
/*
star
Christian bale
Mohanlal
Joaquin phoenix
Dileep
Robert downey jr
*/
--4a--
CREATE PROCEDURE GETMTT AS SELECT Mvno,Title,Type FROM movie WHERE Star LIKE 'M%' ;
EXEC GETMTT;
/*
Mvno	Title	    Type
21	    Dhrishyam	horror
*/
--4b--
CREATE PROCEDURE GETAVGPRICE AS SELECT Type,AVG(Price) AS AVGPRICE FROM movie GROUP BY Type ;
EXEC GETAVGPRICE;
/*
Type	AVGPRICE
action	140.000000
comedy	170.000000
horror	160.000000
*/


--QUESTION NO 5--
CREATE DATABASE SEVENSUPERMARKET;
USE SEVENSUPERMARKET;

CREATE TABLE persons(
      PID       NUMERIC(5)   CONSTRAINT pk_persons_PID PRIMARY KEY,
      Fname     VARCHAR(15)  NOT NULL,
      Lname     VARCHAR(15),
      Address   VARCHAR(20),
      City      VARCHAR(10)  
);

CREATE TABLE orders(
      OID       NUMERIC(5) CONSTRAINT pk_order_OID PRIMARY KEY,
      ORDERQTY  NUMERIC(5) NOT NULL,
      ORDERDATE Date,
      PID       NUMERIC(5) CONSTRAINT fk_order_PID FOREIGN KEY REFERENCES persons(PID)
);
--1a--
INSERT INTO persons VALUES(100,'alvin','lal','alvin villa','kochi');
INSERT INTO persons VALUES(101,'amal','tom','amal villa','malapuram');
INSERT INTO persons VALUES(102,'glenn','antony','glenn villa','kollam');
INSERT INTO persons VALUES(103,'johnson','joy','johnson villa','kottayam');
INSERT INTO persons VALUES(104,'sachin','kumar','sachin villa','kollam');
/*
PID	        Fname	    Lname	    Address	        City
100	        alvin	    lal	        alvin villa	    kochi
101	        amal	    tom	        amal villa	    malapuram
102	        glenn	    antony	    glenn villa	    kollam
103	        johnson	    joy	        johnson villa	kottayam
104	        sachin	    kumar	    sachin villa	kollam
*/

INSERT INTO orders VALUES(578,3,'15/4/2019',100);
INSERT INTO orders VALUES(579,4,'15/5/2019',101);
INSERT INTO orders VALUES(580,2,'15/6/2019',102);
INSERT INTO orders VALUES(581,5,'9/6/2019',103);
INSERT INTO orders VALUES(582,8,'15/6/2019',104);
/*
OID	    ORDERQTY	ORDERDATE	    PID
578	    3	        2019-04-15	    100
579	    4	        2019-05-15	    101
580	    2	        2019-06-15	    102
581	    5	        2019-06-09	    103
582	    8	        2019-06-15	    104

*/
--1b--
UPDATE orders SET ORDERQTY=10 WHERE OID=578;
/*
OID	    ORDERQTY	ORDERDATE	PID
578	    10	        2019-04-15	100
*/

--2a--
SELECT * FROM orders WHERE ORDERDATE<'9/6/2019';
/*
OID	    ORDERQTY	ORDERDATE	    PID
578	    10	        2019-04-15	    100
579	    4	        2019-05-15	    101
*/
--2b--
SELECT * FROM orders  WHERE PID IN(SELECT PID FROM persons WHERE Fname='johnson'); --This is another method without using join
/*
OID	    ORDERQTY	ORDERDATE	PID
581	    5	        2019-06-09	103
*/
--3--
CREATE VIEW ORDERDATEVIEW AS SELECT ORDERDATE FROM orders;
SELECT * FROM ORDERDATEVIEW
/*
ORDERDATE
2019-04-15
2019-05-15
2019-06-15
2019-06-09
2019-06-15
*/

--4a--
CREATE PROCEDURE GETNAMEADDCITY AS SELECT Fname,Address,City FROM persons WHERE City='kollam' ;
EXEC GETNAMEADDCITY;
/*
Fname	Address	        City
glenn	glenn villa	    kollam
sachin	sachin villa	kollam
*/
--4b--
CREATE PROCEDURE GETPERSONSALPHA AS SELECT * FROM persons ORDER BY Fname ;
EXEC GETPERSONSALPHA;
/*
PID	    Fname	    Lname	    Address	        City
100	    alvin	    lal	        alvin villa	    kochi
101	    amal	    tom	        amal villa	    malapuram
102	    glenn	    antony	    glenn villa	    kollam
103	    johnson	    joy	        johnson villa	kottayam
104	    sachin	    kumar	    sachin villa	kollam
*/

--QUESTION NO 8--
CREATE DATABASE EIGHTCUSTOMER;
USE EIGHTCUSTOMER;

CREATE TABLE customer(
    Cust_id     VARCHAR(10) CONSTRAINT pk_customer_Cust_id PRIMARY KEY,
    Cust_name   VARCHAR(25) NOT NULL,
    Acc_no      NUMERIC(10) CONSTRAINT fk_customer_Acc_no FOREIGN KEY REFERENCES account(Acc_no),
    Address     VARCHAR(25),
    Phone_No    NUMERIC(10)
)

CREATE TABLE account(
    Acc_No      NUMERIC(10)   CONSTRAINT pk_account_Acc_no PRIMARY KEY,
    Amount      NUMERIC(10,2) 
)

--1a--
INSERT INTO customer VALUES('C345','glenn',1234,'antony villa',null);
INSERT INTO customer VALUES('C346','amal',1235,'amal villa',123456789);
INSERT INTO customer VALUES('C347','alvin',1236,'alvin villa',987456123);
INSERT INTO customer VALUES('C348','allen',1237,'allen villa',9207248664);
INSERT INTO customer VALUES('C349','roshan',1238,'roshan villa',456789123);
/*
Cust_id 	Cust_name	    Acc_no	    Address	        Phone_No
C345	    glenn	        1234	    antony villa	NULL
C346	    amal	        1235	    amal villa	    123456789
C347	    alvin	        1236	    alvin villa	    987456123
C348	    allen	        1237	    allen villa	    9207248664
C349	    roshan	        1238	    roshan villa	456789123

*/

INSERT INTO account VALUES(1234,1000.25);
INSERT INTO account VALUES(1235,3000.50);
INSERT INTO account VALUES(1236,6000.20);
INSERT INTO account VALUES(1237,8000.50);
INSERT INTO account VALUES(1238,11000.23);
/*
Acc_No	Amount
1234	1000.25
1235	3000.50
1236	6000.20
1237	8000.50
1238	11000.23
*/
--1b--
UPDATE customer SET Address='glenn villa' WHERE Cust_id='C345';
/*
Cust_id	    Cust_name	Acc_no	Address	        Phone_No
C345	    glenn	    1234	glenn villa	    NULL
*/

--2a--

SELECT * FROM customer WHERE Acc_no=(SELECT Acc_no FROM account WHERE Amount=(SELECT MAX(Amount) FROM account))
/*
Cust_id	    Cust_name	Acc_no	Address	        Phone_No
C349	    roshan	    1238	roshan  villa	456789123
*/
--2b--
SELECT * FROM customer ORDER BY Acc_no;
/*
Cust_id	Cust_name	Acc_no	    Address	        Phone_No
C345	glenn	    1234	    glenn villa	    NULL
C346	amal	    1235	    amal villa  	123456789
C347	alvin	    1236	    alvin villa	    987456123
C348	allen	    1237	    allen villa	    9207248664
C349	roshan	    1238	    roshan villa	456789123
*/
--3--
CREATE VIEW GETACCNO AS SELECT Acc_no FROM customer;
SELECT * FROM GETACCNO;
/*
Acc_no
1234
1235
1236
1237
1238
*/

--4a--
CREATE PROCEDURE GETNULLPHONE AS SELECT Cust_name FROM customer WHERE Phone_no IS NULL ;
EXEC GETNULLPHONE;
/*
Cust_name
glenn
*/
--4b--
CREATE PROCEDURE GETTOTALAMT AS SELECT SUM(Amount) FROM account ;
EXEC GETTOTALAMT;
/*
29001.68
*/

--QUESTION NO 9--
CREATE DATABASE NINEBOOKS;
USE NINEBOOKS;

CREATE TABLE books(
    book_id     NUMERIC(10) CONSTRAINT pk_books_book_id PRIMARY KEY,
    Title       VARCHAR(20) NOT NULL,
    Author      VARCHAR(20) NOT NULL,
    Type        VARCHAR(20) CONSTRAINT check_books_book_tyep CHECK(Type='novel' OR Type='mystery' OR Type='fantasy' OR Type='biography' OR Type='travelogue'),
    Language    VARCHAR(20),
    Price       NUMERIC(5)
)

CREATE TABLE customers(
    Cust_id    VARCHAR(10) CONSTRAINT pk_customers_Cust_id PRIMARY KEY,
    Cust_name  VARCHAR(20) NOT NULL,
    book_id    NUMERIC(10) CONSTRAINT fk_customers_book_id FOREIGN KEY REFERENCES books(book_id),
    Dues       NUMERIC(10)
)
DROP TABLE customers;
--1--
INSERT INTO books VALUES(101,'Aadujeevitham','Benyamin','novel','malayalam',200);
INSERT INTO books VALUES(102,'Adams life','Adams john','novel','english',250);
INSERT INTO books VALUES(103,'Wings of fire','APJ Abdul kalam','biography','english',200);
INSERT INTO books VALUES(104,'Sherlock holmes','Arthur conan doyle','mystery','english',240);
INSERT INTO books VALUES(105,'The Alchemist','Paulo coelho','fantasy','portugese',200);
/*
book_id	    Title	            Author	            Type	    Language	Price
101	        Aadujeevitham	    Benyamin	        novel	    malayalam	200
102	        Adams life	        Adams john	        novel	    english	    250
103 	    Wings of fire	    APJ Abdul kalam	    biography	english	    200
104	        Sherlock holmes	    Arthur conan doyle	mystery 	english	    240
105	        The Alchemist	    Paulo coelho	    fantasy	    portugese	200

*/
INSERT INTO customers VALUES(120,'alvin',101,100);
INSERT INTO customers VALUES(121,'amal',102,150);
INSERT INTO customers VALUES(122,'glenn',103,160);
INSERT INTO customers VALUES(123,'sachin',104,200);
INSERT INTO customers VALUES(124,'allen',105,110);
/*
Cust_id	    Cust_name	book_id	    Dues
120	        alvin	    101	        100
121	        amal	    102	        150
122	        glenn	    103	        160
123	        sachin	    104	        200
124	        allen	    105	        110
*/
--2--
SELECT DISTINCT title,Language FROM books WHERE Type='novel';
/*
title	        Language
Aadujeevitham	malayalam
Adams life	    english
*/
--3--
SELECT * FROM books WHERE Author LIKE 'Adams%';
/*
book_id	    Title	        Author	    Type	Language	Price
102	        Adams life	    Adam john	novel	english	    250

*/
SELECT Cust_name FROM customers ORDER BY Dues;
/*
Cust_name
alvin
allen
amal
glenn
sachin
*/
--QUESTION 10--
CREATE DATABASE TENSUPERMARKET;
USE TENSUPERMARKET;
--1--
CREATE TABLE items(
    item_id NUMERIC(5)  CONSTRAINT pk_items_item_id PRIMARY KEY,
    category   VARCHAR(20) NOT NULL,
    brand   VARCHAR(20),
    Price   NUMERIC(10) NOT NULL,
    Weight  NUMERIC(10),
)

CREATE TABLE sales(
    sales_id NUMERIC(5)  CONSTRAINT pk_sales_sales_id PRIMARY KEY,
    item_id  NUMERIC(5)  CONSTRAINT fk_sales_item_id  FOREIGN KEY REFERENCES items(item_id),
    date     date,
    quantity NUMERIC(10) NOT NULL,
    Amount   NUMERIC(10) NOT NULL,
)

INSERT INTO items VALUES(100,'soap','dettol',30,100)
INSERT INTO items VALUES(101,'floor cleaner','lizol',100,300)
INSERT INTO items VALUES(102,'body wash','lux',120,200)
INSERT INTO items VALUES(103,'soap','lifeboy',35,100)
INSERT INTO items VALUES(104,'floor cleaner','dettol',30,100)
/*
item_id	      category	        brand	    Price	Weight
100	          soap	            dettol	    30  	100
101	          floor cleaner	    lizol	    100	    300
102	          body wash	        lux	        120	    200
103	          soap	            lifeboy	    35	    100
104	          floor cleaner	    dettol	    30	    100
*/
INSERT INTO sales VALUES(120,100,'15/3/2020',10,300);
INSERT INTO sales VALUES(121,101,'15/3/2020',10,1000);
INSERT INTO sales VALUES(122,102,'16/3/2020',4,500);
INSERT INTO sales VALUES(123,103,'18/3/2020',17,600);
INSERT INTO sales VALUES(124,104,'18/3/2020',3,100);
/*
sales_id	item_id        	date	        quantity	Amount
120	        100	            2020-03-15	    10	        300
121	        101	            2020-03-15	    10	        1000
122	        102	            2020-03-16	    4	        500
123	        103	            2020-03-18	    17	        600
124	        104	            2020-03-18	    3	        100

*/
--2--
SELECT category FROM items;
/*
category
soap
floor cleaner
body wash
soap
floor cleaner
*/
--3--
SELECT date,quantity*Amount AS sales FROM sales;
/*
date	    sales
2020-03-15	3000
2020-03-15	10000
2020-03-16	2000
2020-03-18	10200
2020-03-18	300
*/
--4--
SELECT date,MAX(quantity*amount) AS MAXSALES FROM sales GROUP BY date;
/*
date	    MAXSALES
2020-03-15	10000
2020-03-16	2000
2020-03-18	10200
*/


