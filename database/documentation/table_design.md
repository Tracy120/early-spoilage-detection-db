# Table Design – EarlySpoilageDetectionSystem

## sensor
- PK: sensor_id
- Columns: sensor_type, location, installation_date
- Tablespace: data_ts

## product
- PK: product_id
- Columns: product_name, category, manufacture_date, expiry_date
- Tablespace: data_ts
- Index: idx_product_category

## measurement
- PK: measurement_id
- FK: sensor_id → sensor(sensor_id)
- Columns: measure_date, temperature, humidity, spoilage_index
- Tablespace: data_ts
- Index: idx_measurement_sensor
