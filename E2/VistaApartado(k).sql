CREATE VIEW entretenimiento_pasajeros AS 
SELECT p.id, p.nombre, p.edad, p.transportado,
		p.planeta_destino, p.sistema_destino,
        p.numero_cabina, p.lado_cabina, p.cubierta, cu.clase, 
        e.nombre AS servicio, g.cantidad AS gastoTotal
FROM pasajeros p JOIN cubiertas cu ON p.cubierta = cu.letra
                JOIN gastos g ON p.id = g.pasajero
                JOIN entretenimientos e ON g.entretenimiento = e.id
WHERE g.cantidad IN (SELECT MAX(cantidad)
					FROM gastos JOIN pasajeros ON gastos.pasajero = pasajeros.id
                    GROUP BY pasajeros.id);
        
CREATE USER 'analista_datos' IDENTIFIED BY 'dataAnalyst123';

GRANT SELECT ON titanic_spaceship.entretenimiento_pasajeros TO 'analista_datos';
