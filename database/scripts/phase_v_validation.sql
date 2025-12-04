-- Basic SELECT
SELECT * FROM sensor;
SELECT * FROM product;
SELECT * FROM measurement;

-- Join example
SELECT m.measurement_id, s.sensor_type, m.temperature
FROM measurement m
JOIN sensor s ON m.sensor_id = s.sensor_id;

-- Aggregation example
SELECT sensor_id, AVG(temperature) AS avg_temp, AVG(humidity) AS avg_humidity
FROM measurement
GROUP BY sensor_id;

-- Subquery example
SELECT product_name, expiry_date
FROM product
WHERE expiry_date < SYSDATE + 10;
