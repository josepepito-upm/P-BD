SELECT p.nombre, e.nombre, g.cantidad
FROM pasajeros p JOIN gastos g ON p.id = g.pasajero
				JOIN entretenimientos e ON g.entretenimiento = e.id
WHERE p.cubierta = 'A' AND g.cantidad > 0 
AND p.id IN (SELECT p.id
			 FROM pasajeros p JOIN gastos g ON p.id = g.pasajero
							  JOIN entretenimientos e ON g.entretenimiento = e.id
			 GROUP BY p.id
			 HAVING COUNT(DISTINCT e.id) = 5)
ORDER BY p.nombre ASC, g.cantidad DESC