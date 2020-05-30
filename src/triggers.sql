use meas;

DROP TRIGGER IF EXISTS settingdate;
CREATE TRIGGER settingdate 
BEFORE INSERT ON meas.voucher
    FOR EACH ROW SET NEW.vdate = IFNULL(NEW.vdate, NOW());

DELIMITER $$
DROP TRIGGER IF EXISTS ins_deb_cred $$
CREATE TRIGGER ins_deb_cred
BEFORE INSERT ON meas.voucher
FOR EACH ROW
FOLLOWS settingdate
    BEGIN
        IF(NEW.debit = NEW.credit) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Matching debit and credit accounts';
        END IF;
    END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS up_deb_cred $$
CREATE TRIGGER up_deb_cred
BEFORE UPDATE ON meas.voucher
FOR EACH ROW
    BEGIN
        IF(NEW.debit = NEW.credit) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Matching debit and credit accounts';
        END IF;
    END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS ins_cash_txns $$
CREATE TRIGGER ins_cash_txns
BEFORE INSERT ON meas.voucher
FOR EACH ROW
FOLLOWS ins_deb_cred
    BEGIN
        IF( (NEW.debit = (SELECT acc_code FROM accounts WHERE acc_name = 'Cash Account') OR 
            NEW.credit = (SELECT acc_code FROM accounts WHERE acc_name = 'Cash Account') ) 
            AND NEW.amount >= 50000) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Government restricts Cash Txns above 50000';
        END IF;
    END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS up_cash_txns $$
CREATE TRIGGER up_cash_txns
BEFORE UPDATE ON meas.voucher
FOR EACH ROW
FOLLOWS up_deb_cred
    BEGIN
        IF( (NEW.debit = (SELECT acc_code FROM accounts WHERE acc_name = 'Cash Account') OR 
            NEW.credit = (SELECT acc_code FROM accounts WHERE acc_name = 'Cash Account') ) 
            AND NEW.amount >= 50000) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Government restricts Cash Txns above 50000';
        END IF;
    END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS ins_vouch_txns $$
CREATE TRIGGER ins_vouch_txns
BEFORE INSERT ON meas.voucher
FOR EACH ROW
FOLLOWS ins_cash_txns
    BEGIN
        UPDATE accounts SET acc_bal = acc_bal + NEW.amount WHERE acc_code = NEW.debit;
        UPDATE accounts SET acc_bal = acc_bal - NEW.amount WHERE acc_code = NEW.credit;
    END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS up_vouch_txns $$
CREATE TRIGGER up_vouch_txns
BEFORE UPDATE ON meas.voucher
FOR EACH ROW
FOLLOWS up_cash_txns
    BEGIN
        UPDATE accounts SET acc_bal = acc_bal - OLD.amount + NEW.amount WHERE acc_code = NEW.debit;
        UPDATE accounts SET acc_bal = acc_bal + OLD.amount - NEW.amount WHERE acc_code = NEW.credit;
    END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS del_vouch_txns $$
CREATE TRIGGER del_vouch_txns
AFTER DELETE ON meas.voucher
FOR EACH ROW
    BEGIN
        UPDATE accounts SET acc_bal = acc_bal - OLD.amount WHERE acc_code = OLD.debit;
        UPDATE accounts SET acc_bal = acc_bal + OLD.amount WHERE acc_code = OLD.credit;
    END; $$
DELIMITER ;
