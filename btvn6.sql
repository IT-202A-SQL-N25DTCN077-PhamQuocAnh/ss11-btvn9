CREATE DATABASE RikkeiClinicDB;
USE RikkeiClinicDB;

DElIMITER $$
CREATE PROCEDURE ProcessPrescription(
	IN p_patient_id INT,
    IN p_medicine_id INT,
    IN p_quantity INT,
    IN p_voucher VARCHAR(50),
    OUT p_status_message VARCHAR(100)
)
BEGIN
	DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,0);
    DECLARE v_total_cost DECIMAL(10,0);
	SELECT stock , price INTO v_stock, v_price FROM medicines WHERE p_medicine_id = medicine_id;
	IF p_quantity <= v_stock THEN
		SET v_total_cost = p_quantity * v_price;
		IF p_voucher = 'NV-RIKKEI' THEN 
			SET v_total_cost = v_total_cost * 0.5;
		ELSE 
			SET v_total_cost = v_total_cost;
        END IF;
     
		UPDATE patient_invoices
        SET total_due = total_due + v_total_cost
        WHERE p_patient_id = patient_id;
        
        UPDATE medicines
        SET stock = stock - p_quantity
        WHERE p_medicine_id = medicine_id;
        
        SET p_status_message = 'Thành công: Đã xử lý đơn thuốc';
	ELSE 
		SET p_status_message = 'Thất bại: Kho không đủ thuốc';
     END IF;
END $$
DELIMITER ;

CALL ProcessPrescription(1, 1, 2, NULL, @msg);
SELECT @msg AS status_message;

CALL ProcessPrescription(1,1,2,'NV-RIKKEI',@msg);
SELECT @msg AS status_message;

CALL ProcessPrescription(1,1,1,'ABCXYZ',@msg);
SELECT @msg AS status_message;

CALL ProcessPrescription(1,1,999,NULL,@msg);
SELECT @msg AS status_message;