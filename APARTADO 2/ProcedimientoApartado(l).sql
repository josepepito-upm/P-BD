ALTER TABLE pasajeros ADD tutor VARCHAR(30);

DELIMITER $$
CREATE PROCEDURE asignar_tutores()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE menor_id VARCHAR(7);
    DECLARE cabina_letra VARCHAR(1);
    DECLARE cabina_numero INT;
    DECLARE cabina_lado VARCHAR(1);
    DECLARE tutor_id VARCHAR(7) DEFAULT NULL; 
    DECLARE cur_menores CURSOR FOR
        SELECT id, cubierta, numero_cabina, lado_cabina
        FROM pasajeros
        WHERE edad < 18 AND criosueño = 0 AND tutor IS NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur_menores;
    read_loop: LOOP
        FETCH cur_menores INTO menor_id, cabina_letra, cabina_numero, cabina_lado;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SET tutor_id = NULL;
        SELECT id INTO tutor_id
        FROM pasajeros
        WHERE cubierta = cabina_letra AND numero_cabina = cabina_numero
                                   AND lado_cabina = cabina_lado
                                   AND edad >= 18
        LIMIT 1;
        IF tutor_id IS NOT NULL THEN
            UPDATE pasajeros
            SET tutor = tutor_id
            WHERE id = menor_id;
        ELSE
            UPDATE pasajeros
            SET criosueño = 1
            WHERE id = menor_id;
        END IF;
    END LOOP;
    CLOSE cur_menores;
END $$
DELIMITER ;