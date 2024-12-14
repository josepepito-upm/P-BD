DELIMITER //
CREATE TRIGGER gasto_vip BEFORE UPDATE ON gastos
FOR EACH ROW
BEGIN  
DECLARE gasto DECIMAL (10,2) DEFAULT 0.00;
SELECT SUM(cantidad) INTO gasto
FROM gastos
WHERE pasajero = NEW.pasajero;
IF gasto > 5000 THEN 
UPDATE pasajero set vip = 1 WHERE id = NEW.pasajero;
END IF;

END//
DELIMITER ;