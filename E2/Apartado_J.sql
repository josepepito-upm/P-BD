select num_entretenidos.planeta_natal, num_entretenidos.sistema_natal, tot_pasajeros.pasajeros_nacidos,
		num_entretenidos.pasajeros_entretenidos
from (select planeta_natal, sistema_natal, count(*) AS pasajeros_entretenidos
		from pasajeros
		where id IN( select pasajero
					from gastos
					group by pasajero
					having Count(*) >= 4 )
		group by planeta_natal, sistema_natal) num_entretenidos
join (select planeta_natal, sistema_natal, count(*) as pasajeros_nacidos
			from pasajeros
			group by planeta_natal, sistema_natal) tot_pasajeros
ON num_entretenidos.planeta_natal = tot_pasajeros.planeta_natal 
AND num_entretenidos.sistema_natal = tot_pasajeros.sistema_natal
where num_entretenidos.pasajeros_entretenidos > tot_pasajeros.pasajeros_nacidos * 0.25