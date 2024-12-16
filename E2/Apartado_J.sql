SELECT num_entretenidos.planeta_natal, num_entretenidos.sistema_natal, tot_pasajeros.pasajeros_nacidos, num_entretenidos.pasajeros_entretenidos
FROM (SELECT planeta_natal, sistema_natal, COUNT(*) AS pasajeros_entretenidos
		FROM pasajeros
		WHERE id IN( SELECT pasajero
					FROM gastos
					GROUP BY pasajero
					HAVING COUNT(*) >= 4 )
		GROUP BY planeta_natal, sistema_natal) num_entretenidos
JOIN (SELECT planeta_natal, sistema_natal, COUNT(*) AS pasajeros_nacidos
			FROM pasajeros
			GROUP BY planeta_natal, sistema_natal) tot_pasajeros
ON num_entretenidos.planeta_natal = tot_pasajeros.planeta_natal 
AND num_entretenidos.sistema_natal = tot_pasajeros.sistema_natal
WHERE num_entretenidos.pasajeros_entretenidos > tot_pasajeros.pasajeros_nacidos * 0.25
