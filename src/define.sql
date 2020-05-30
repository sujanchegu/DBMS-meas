SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS meas;
CREATE SCHEMA meas;
USE meas;

DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address(
    pincode VARCHAR(6) PRIMARY KEY CHECK(pincode RLIKE '^[1-9][0-9]{5}$'),
    city VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee(
    empid INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(10) NOT NULL,
    minit VARCHAR(10) NOT NULL,
    lname VARCHAR(10) ,
    age INT NOT NULL CHECK(age < 60 AND age >14),
    phno VARCHAR(10) NOT NULL UNIQUE CHECK(phno RLIKE '^[6-9][0-9]{9}$'),
    pincode VARCHAR(6) NOT NULL,
    CONSTRAINT ref_pin
        FOREIGN KEY (pincode)
        REFERENCES address (pincode)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

DROP TABLE IF EXISTS acc_type;
CREATE TABLE IF NOT EXISTS acc_type(
    acc_cat_id INT PRIMARY KEY AUTO_INCREMENT,
    acc_cat_name VARCHAR(15) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS accounts;
CREATE TABLE IF NOT EXISTS accounts(
    acc_code INT(10) PRIMARY KEY CHECK(acc_code >=0000000001),
    acc_name VARCHAR(15) NOT NULL,
    acc_bal DECIMAL(10,2) NOT NULL DEFAULT 0000000.00,
    is_internal BOOL DEFAULT 0,
    acc_cat_id INT NOT NULL,
    CONSTRAINT ref_acc_cat_id
        FOREIGN KEY (acc_cat_id)
        REFERENCES acc_type (acc_cat_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

DROP TABLE IF EXISTS voucher;
CREATE TABLE IF NOT EXISTS voucher(
    vno INT(6) AUTO_INCREMENT PRIMARY KEY,
    vdate DATE NOT NULL,
    amount INT NOT NULL CHECK(amount > 0),
    debit INT(10) NOT NULL,
    CONSTRAINT ref_debit
        FOREIGN KEY (debit)
        REFERENCES accounts (acc_code)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    credit INT(10) NOT NULL,
    CONSTRAINT ref_credit
        FOREIGN KEY (credit)
        REFERENCES accounts (acc_code)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    auth INT NOT NULL,
    CONSTRAINT ref_auth
        FOREIGN KEY (auth)
        REFERENCES employee (empid)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    prep INT,
    CONSTRAINT ref_prep
        FOREIGN KEY (prep)
        REFERENCES employee (empid)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    narration VARCHAR(25) NOT NULL
);

DROP TABLE IF EXISTS supdoc;
CREATE TABLE IF NOT EXISTS supdoc(
    supdoc_no INT NOT NULL,
    supdoc_desc VARCHAR(25) NOT NULL,
    vno INT(6),
    CONSTRAINT prim_supdoc
        PRIMARY KEY (supdoc_no, supdoc_desc),
    CONSTRAINT ref_supdoc
        FOREIGN KEY (vno)
        REFERENCES voucher (vno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
