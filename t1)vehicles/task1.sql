SELECT v.maker, v.model
FROM Motorcycle moto
join vehicle as v on moto.model = v.model
WHERE moto.horsepower > 150
  AND moto.price < 20000
  AND moto.type = 'Sport'
  and v.type = 'Motorcycle'
ORDER BY moto.horsepower DESC;