SELECT e.nombre, SUM(g.cantidad), CASE 
								WHEN p.vip = 1 THEN 'VIP'
								ELSE 'NO VIP'
								END AS tipo
FROM entretenimientos e JOIN gastos g ON e.id = g.entretenimiento
						JOIN pasajeros p ON g.pasajero = p.id
GROUP BY e.nombre, p.vip;
