SELECT m.sensor_id, AVG(m.temperature) AS avg_temp
FROM measurement m
GROUP BY m.sensor_id;

SELECT p.product_name, p.expiry_date
FROM product p
WHERE p.expiry_date < SYSDATE + 10;
