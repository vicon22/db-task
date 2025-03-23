WITH ClassAvgPositions AS (
    SELECT
        c.class,
        AVG(r.position) AS class_avg_position,
        COUNT(DISTINCT c.name) AS car_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    GROUP BY c.class
    HAVING COUNT(DISTINCT c.name) >= 2
),
CarAvgPositions AS (
    SELECT
        c.name AS car,
        c.class,
        cl.country,
        AVG(r.position) AS avg_position,
        COUNT(r.race) AS race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    JOIN Classes cl ON c.class = cl.class
    GROUP BY c.name, c.class, cl.country
)
SELECT
    cap.car as car_name,
    cap.class as car_class,
    ROUND(cap.avg_position, 4) as average_position,
    cap.race_count,
    cap.country as car_country
FROM CarAvgPositions cap
JOIN ClassAvgPositions cap2 ON cap.class = cap2.class
WHERE cap.avg_position < cap2.class_avg_position
ORDER BY cap.class ASC, cap.avg_position ASC;