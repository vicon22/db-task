WITH AvgPositions AS (
    SELECT
        c.class,
        r.car,
        AVG(r.position) AS avg_position,
        COUNT(r.race) AS race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    GROUP BY c.class, r.car
),
RankedCars AS (
    SELECT
        ap.*,
        RANK() OVER (PARTITION BY ap.class ORDER BY ap.avg_position) AS rnk
    FROM AvgPositions ap
)
SELECT
	rc.car as car_name,
    rc.class as car_class,
    ROUND(rc.avg_position, 4) as average_position,
    rc.race_count as race_count
FROM RankedCars rc
WHERE rc.rnk = 1
ORDER BY rc.avg_position;