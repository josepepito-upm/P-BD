SELECT planetas.nombre, planetas.sistema
FROM planetas JOIN pasajeros p ON planetas.nombre = p.planeta_natal
GROUP BY planetas.nombre, planetas.sistema
HAVING AVG((SELECT COUNT(planeta_natal)
		FROM pasajeros)) < AVG((SELECT COUNT(planetas.nombre) 
								FROM planetas JOIN pasajeros p2 ON planetas.nombre = p2.planeta_natal));
