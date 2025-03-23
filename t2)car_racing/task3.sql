WITH ClassAvgPositions AS (
    SELECT
        c.class,
        cl.country,
        AVG(r.position) AS class_avg_position,
        COUNT(r.race) AS class_race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    JOIN Classes cl ON c.class = cl.class
    GROUP BY c.class, cl.country
),
MinClassAvg AS (
    SELECT class_avg_position
    FROM ClassAvgPositions
    ORDER BY class_avg_position ASC
    LIMIT 1
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
    cap.country as car_country,
    cap2.class_race_count as total_races
FROM CarAvgPositions cap
JOIN ClassAvgPositions cap2 ON cap.class = cap2.class
WHERE cap2.class_avg_position = (SELECT class_avg_position FROM MinClassAvg)
ORDER BY cap.avg_position ASC;