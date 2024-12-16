SELECT pl.nombre, pl.sistema
FROM pasajeros pa JOIN planetas pl ON pa.planeta_destino = pl.nombre
WHERE pa.planeta_destino NOT IN ( SELECT pa1.planeta_destino
									FROM pasajeros pa1 
									WHERE pa1.vip = 1)
AND pa.planeta_destino IN ( SELECT pa1.planeta_natal
							FROM pasajeros pa1 
                            WHERE edad >= 70 )
