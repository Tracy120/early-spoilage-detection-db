# EarlySpoilageDetectionSystem_DB

## Project Overview
# PHASE IV – Database Creation for Early Spoilage Detection System.

## Database Setup
- PDB: A_27105_Tracy_EarlySpoilageDetectionSystem_DB
- Admin User: tracy_admin
- Password: Tracy
- Memory: SGA_TARGET=200M, PGA_AGGREGATE_TARGET=100M
- Tablespaces: data_ts, index_ts, temp_ts
- Archive Logging: Enabled at CDB level

## Scripts
- database/scripts/phase_iv_complete.sql

## Documentation
- In details :
- pdb_setup.md
- tablespace_setup.md

# EarlySpoilageDetectionSystem – PHASE V: Table Implementation & Data Insertion

## Overview
This phase implements the physical database structure for the EarlySpoilageDetectionSystem project. It includes:

- Creation of all tables with primary and foreign keys
- Constraints (NOT NULL, UNIQUE, CHECK, DEFAULT)
- Indexes for performance
- Sample data insertion (100+ rows for main tables)
- Validation queries to ensure data integrity and business rules compliance

---

## Pluggable Database Details
- **Database Name:** A_27105_Tracy_EarlySpoilageDetectionSystem_DB
- **Admin User:** tracy_admin
- **Password:** Tracy
- **Tablespaces Used:**
  - `data_ts` → tables
  - `index_ts` → indexes
  - `temp_ts` → temporary tables

---

## Tables Implemented

### sensor
- **Primary Key:** sensor_id  
- **Columns:** sensor_type, location, installation_date  
- **Constraints:** NOT NULL on sensor_type, default SYSDATE for installation_date  
- **Tablespace:** data_ts  

### product
- **Primary Key:** product_id  
- **Columns:** product_name, category, manufacture_date, expiry_date  
- **Constraints:** NOT NULL on product_name  
- **Indexes:** idx_product_category on category  
- **Tablespace:** data_ts  

### measurement
- **Primary Key:** measurement_id  
- **Foreign Key:** sensor_id → sensor(sensor_id)  
- **Columns:** measure_date, temperature, humidity, spoilage_index  
- **Constraints:** CHECK on temperature (-50 to 100) and humidity (0 to 100), default 0 for spoilage_index  
- **Indexes:** idx_measurement_sensor on sensor_id  
- **Tablespace:** data_ts  


![Created tables](screenshots/tables%20created.png)

---

## Sample Data
- **sensor table:** multiple types of sensors with locations  
- **product table:** realistic product names, categories, manufacture and expiry dates  
- **measurement table:** sensor readings including temperature, humidity, and spoilage index  

> All tables have at least 100 realistic rows to simulate actual use cases.

---

## Validation & Testing
- **Basic retrieval queries:** SELECT * FROM each table  
- **Joins:** measurement joined with sensor  
- **Aggregations:** AVG temperature and humidity per sensor  
- **Subqueries:** products expiring within 10 days  
- **Integrity checks:** foreign key relationships enforced, constraints tested  


![Validated Data](screenshots/validation%20data.png)

**Example Queries Run:**
```sql
SELECT * FROM sensor;
SELECT * FROM product;
SELECT * FROM measurement;

SELECT m.measurement_id, s.sensor_type, m.temperature
FROM measurement m
JOIN sensor s ON m.sensor_id = s.sensor_id;

SELECT sensor_id, AVG(temperature) AS avg_temp, AVG(humidity) AS avg_humidity
FROM measurement
GROUP BY sensor_id;

SELECT product_name, expiry_date
FROM product
WHERE expiry_date < SYSDATE + 10;
