-- Check foreign key violations
SELECT *
FROM measurement
WHERE sensor_id NOT IN (SELECT sensor_id FROM sensor);

-- Check NOT NULL constraint on sensor_type
SELECT *
FROM sensor
WHERE sensor_type IS NULL;
