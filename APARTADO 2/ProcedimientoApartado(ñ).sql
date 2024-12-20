DROP PROCEDURE IF EXISTS updateVip;

DELIMITER //

CREATE PROCEDURE updateVip()
BEGIN 
	DECLARE done INT DEFAULT FALSE;
	DECLARE gasto DECIMAL(10, 2);
	DECLARE pasa VARCHAR(7); 
    
	DECLARE cur CURSOR FOR 
		SELECT pasajero, SUM(cantidad)
		FROM gastos g JOIN pasajeros p ON p.id = g.pasajero
		WHERE vip = 0
		GROUP BY id; 
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	OPEN cur;
    
	read_loop: LOOP
		FETCH cur INTO pasa, gasto;
        
        IF done THEN
			LEAVE read_loop;
		END IF;
		
		IF (gasto > 5000) THEN
			SET SQL_SAFE_UPDATES = 0;
            
			UPDATE pasajeros
			SET vip = 1
			WHERE id = pasa;
            
            SET SQL_SAFE_UPDATES = 1;
		END IF;
	
	END LOOP;
    CLOSE cur;
END//
DELIMITER ;
