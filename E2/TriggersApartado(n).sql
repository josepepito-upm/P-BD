DELIMITER $$

CREATE TRIGGER gasto_negativo_insert 
BEFORE INSERT ON gastos
FOR EACH ROW
BEGIN
    IF NEW.cantidad < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: Bienvenido ciber-delincuente, pero no puedes sacar dinero en un entretenimiento';
    END IF;
END$$


CREATE TRIGGER gasto_negativo_update
BEFORE UPDATE ON gastos
FOR EACH ROW
BEGIN
    IF NEW.cantidad < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: Bienvenido ciber-delincuente, pero no puedes sacar dinero en un entretenimiento';
    END IF;
END$$

DELIMITER ;
