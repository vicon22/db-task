WITH hotel_categories AS (
    SELECT
        h.ID_hotel,
        h.name AS hotel_name,
        AVG(r.price) AS avg_price,
        CASE
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
        END AS hotel_category
    FROM Hotel h
    JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
customer_preference AS (
    SELECT
        c.ID_customer,
        c.name AS customer_name,
        MAX(CASE
            WHEN hcat.hotel_category = 'Дорогой' THEN 'Дорогой'
            WHEN hcat.hotel_category = 'Средний' THEN 'Средний'
            ELSE 'Дешевый'
        END) AS preferred_hotel_type,
        STRING_AGG(DISTINCT hcat.hotel_name, ', ') AS visited_hotels
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    JOIN hotel_categories hcat ON h.ID_hotel = hcat.ID_hotel
    GROUP BY c.ID_customer, c.name
)
SELECT
    ID_customer,
    customer_name AS name,
    preferred_hotel_type,
    visited_hotels
FROM customer_preference
ORDER BY
    CASE preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
    END;