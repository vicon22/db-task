WITH client_booking_summary AS (
    SELECT
        c.ID_customer,
        c.name,
        COUNT(b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        SUM(r.price) AS total_spent
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name
    HAVING
        COUNT(b.ID_booking) > 2  -- Более двух бронирований
        AND COUNT(DISTINCT h.ID_hotel) > 1  -- Забронировано в более чем одном отеле
),
clients_spent_more_than_500 AS (
    SELECT
        c.ID_customer,
        c.name AS customer_name,
        SUM(r.price) AS total_spent,
        COUNT(b.ID_booking) AS total_bookings
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    GROUP BY
        c.ID_customer, c.name
    HAVING
        SUM(r.price) > 500  -- Потратили более 500 долларов
)
SELECT
    a.ID_customer,
    a.name,
    a.total_bookings,
    a.total_spent,
    a.unique_hotels
FROM client_booking_summary a
JOIN clients_spent_more_than_500 b ON a.ID_customer = b.ID_customer
ORDER BY
    a.total_spent ASC;