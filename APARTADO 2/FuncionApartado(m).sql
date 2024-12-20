DELIMITER $$
CREATE FUNCTION porcentaje_pasajeros(
    destino_planeta VARCHAR(255), 
    destino_sistema VARCHAR(255),
    cubierta CHAR(1)
) 
RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
    DECLARE total_pasajeros INT;
    DECLARE pasajeros_destino INT;
    DECLARE porcentaje DECIMAL(10,2);

    SELECT COUNT(*) INTO total_pasajeros
    FROM pasajeros p JOIN cabinas c ON p.numero_cabina = c.numero
    WHERE c.cubierta = cubierta;

    SELECT COUNT(*) INTO pasajeros_destino
    FROM pasajeros p JOIN cabinas c ON p.numero_cabina = c.numero
    WHERE c.cubierta = cubierta AND p.planeta_destino = destino_planeta
								AND p.sistema_destino = destino_sistema;

	IF total_pasajeros IS NULL OR total_pasajeros = 0 THEN
        SET porcentaje = 0; 
    ELSE
        SET porcentaje = (pasajeros_destino / total_pasajeros) * 100;
    END IF;

    RETURN porcentaje;
END$$
DELIMITER ;

SELECT letra, porcentaje_pasajeros('55 Cancri e', 'Copernico', letra)
FROM cubiertas
ORDER BY letra
