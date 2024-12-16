SELECT p.numero_cabina, p.lado_cabina, p.cubierta
FROM pasajeros p JOIN gastos g ON p.id = g.pasajero
WHERE p.vip = 0
AND g.cantidad > (SELECT 2 * AVG(gastos.cantidad)
		  FROM gastos JOIN pasajeros ON gastos.pasajero = pasajeros.id
		  WHERE pasajeros.numero_cabina = p.numero_cabina
		  AND pasajeros.lado_cabina = p.lado_cabina
		  AND pasajeros.cubierta = p.cubierta)
GROUP BY p.numero_cabina, p.lado_cabina, p.cubierta
HAVING COUNT(*) > 3
