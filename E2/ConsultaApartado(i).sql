SELECT vip, numero_cabina, lado_cabina, pasajeros.cubierta 
FROM pasajeros JOIN cabinas c ON pasajeros.numero_cabina = c.numero 
							AND pasajeros.lado_cabina = c.lado
                            AND pasajeros.cubierta = c.cubierta
GROUP BY id
HAVING COUNT(pasajeros.vip = 0) > 3 AND (SELECT cantidad 
										FROM gastos JOIN pasajeros p ON gastos.pasajero = p.id LIMIT 1) 
										> 2*AVG((SELECT SUM(cantidad) 
												FROM gastos JOIN pasajeros p2 ON gastos.pasajero = p2.id 
															JOIN cabinas ON p2.numero_cabina = cabinas.numero 
																		AND p2.lado_cabina = cabinas.lado
																		AND p2.cubierta = cabinas.cubierta));