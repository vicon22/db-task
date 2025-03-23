WITH AvgPositions AS (
    SELECT
        c.name AS car,
        c.class,
        cl.country,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    JOIN Classes cl ON c.class = cl.class
    GROUP BY c.name, c.class, cl.country
)
SELECT
    car,
    class,
    country,
    ROUND(average_position, 4) as average_position,
    race_count
FROM AvgPositions
ORDER BY average_position ASC, car ASC
LIMIT 1;