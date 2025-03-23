SELECT * FROM (SELECT v.maker, v.model, moto.horsepower, moto.engine_capacity, 'Motorcycle' as vehicle_type
FROM Motorcycle moto
join vehicle as v on moto.model = v.model
WHERE moto.horsepower > 150
  AND moto.price < 20000
  AND moto.engine_capacity < 1.5
  and v.type = 'Motorcycle'
UNION ALL
SELECT v.maker, v.model, c.horsepower, c.engine_capacity, 'Car' as vehicle_type
FROM car as c
join vehicle as v on c.model = v.model
WHERE c.horsepower > 150
  AND c.price < 35000
  AND c.engine_capacity < 3.0
  and v.type = 'Car'
UNION ALL
SELECT v.maker, v.model, NULL as horsepower, NULL as engine_capacity, 'Bicycle' as vehicle_type
FROM bicycle as b
join vehicle as v on b.model = v.model
WHERE b.gear_count > 18
  AND b.price < 4000
  and v.type = 'Bicycle')
  ORDER BY horsepower desc NULLS LAST;