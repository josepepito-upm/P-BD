DROP TRIGGER IF EXISTS gasto_vip;

DELIMITER //
CREATE TRIGGER gasto_vip AFTER INSERT ON gastos
FOR EACH ROW
BEGIN  
	DECLARE gasto DECIMAL (10,2) DEFAULT 0.00;
    
	SELECT SUM(cantidad) INTO gasto
	FROM gastos
	WHERE pasajero = NEW.pasajero;

	IF gasto > 5000 THEN 
		SET SQL_SAFE_UPDATES = 0;
    
		UPDATE pasajeros
        SET vip = 1 
        WHERE id = NEW.pasajero;
        
        SET SQL_SAFE_UPDATES = 1;

	END IF;

END//
DELIMITER ;
