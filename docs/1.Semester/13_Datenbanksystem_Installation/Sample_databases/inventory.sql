
DROP DATABASE IF EXISTS inventory;
CREATE DATABASE inventory;
USE inventory;

DROP TABLE IF EXISTS inventory.salesman;
DROP TABLE IF EXISTS inventory.orders;
DROP TABLE IF EXISTS inventory.customer;

CREATE TABLE inventory.salesman (
  salesman_id decimal(5,0) NOT NULL,
  name varchar(30) NOT NULL,
  city varchar(15) DEFAULT NULL,
  commission decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (salesman_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE inventory.customer (
  customer_id decimal(5,0) NOT NULL,
  cust_name varchar(30) NOT NULL,
  city varchar(15) DEFAULT NULL,
  grade decimal(3,0) DEFAULT '0',
  salesman_id decimal(5,0) NOT NULL,
  PRIMARY KEY (customer_id),
  KEY salesman_id_fk (salesman_id),
  CONSTRAINT salesman_id_fk_customer FOREIGN KEY (salesman_id) REFERENCES inventory.salesman (salesman_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE inventory.orders (
  ord_no decimal(5,0) NOT NULL,
  purch_amt decimal(8,2) DEFAULT '0.00',
  ord_date date DEFAULT NULL,
  customer_id decimal(5,0) NOT NULL,
  salesman_id decimal(5,0) NOT NULL,
  PRIMARY KEY (ord_no),
  KEY customer_id_fk (customer_id),
  KEY salesman_id_fk (salesman_id),
  CONSTRAINT customer_id_fk_orders FOREIGN KEY (customer_id) REFERENCES inventory.customer (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT salesman_id_fk_orders FOREIGN KEY (salesman_id) REFERENCES inventory.salesman (salesman_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO inventory.salesman VALUES (5001,'James Hoog','New York',0.15),(5002,'Nail Knite','Paris',0.13),(5003,'Lauson Hen','San Jose',0.12),(5005,'Pit Alex','London',0.11),(5006,'Mc Lyon','Paris',0.14),(5007,'Paul Adam','Rome',0.13);
INSERT INTO inventory.customer VALUES (3001,'Brad Guzan','London',NULL,5005),(3002,'Nick Rimando','New York',100,5001),(3003,'Jozy Altidor','Moscow',200,5007),(3004,'Fabian Johnson','Paris',300,5006),(3005,'Graham Zusi','California',200,5002),(3007,'Brad Davis','New York',200,5001),(3008,'Julian Green','London',300,5002),(3009,'Geoff Cameron','Berlin',100,5003);
INSERT INTO inventory.orders VALUES (70001,150.50,'2012-10-05',3005,5002),(70002,65.26,'2012-10-05',3002,5001),(70003,2480.40,'2012-10-10',3009,5003),(70004,110.50,'2012-08-17',3009,5003),(70005,2400.60,'2012-07-27',3007,5001),(70007,948.50,'2012-09-10',3005,5002),(70008,5760.00,'2012-09-10',3002,5001),(70009,270.65,'2012-09-10',3001,5005),(70010,1983.43,'2012-10-10',3004,5006),(70011,75.29,'2012-08-17',3003,5007),(70012,250.45,'2012-06-27',3008,5002),(70013,3045.60,'2012-04-25',3002,5001);

