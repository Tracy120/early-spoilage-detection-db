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



# PHASE VI – Database Interaction & Transactions

## Objective
Develop PL/SQL procedures, functions, cursors, window functions, and packages to interact with the database, enforce business rules, and perform data operations.

---

## Overview

This phase focuses on:

- **Procedures** – automate insert, update, and delete operations.
- **Functions** – calculate values, validate data, and retrieve information.
- **Packages** – group related procedures and functions for modularity.
- **Cursors** – process multiple rows efficiently.
- **Window Functions** – analyze trends and ranking within datasets.
- **Testing** – verify outputs, edge cases, and performance.

---

## Scripts Implemented

### Procedures
| Procedure | Purpose | Test Output |
|-----------|---------|-------------|
| `add_sensor` | Adds a new sensor record with specified type and location. | Prints new Sensor ID |
| `update_product_expiry` | Updates expiry date of a product | Confirmation message |
| `delete_measurement` | Deletes a measurement record by ID | Confirms deletion or “not found” |

### Functions
| Function | Purpose | Test Output |
|----------|---------|-------------|
| `calc_spoilage_index` | Calculates spoilage index | Numeric value |
| `is_product_expired` | Checks if a product is expired | `EXPIRED` / `NOT EXPIRED` |
| `lookup_sensor_by_location` | Retrieves sensor ID for a given location | Sensor ID or NULL |

### Package (`product_pkg`)
- **Procedures:** `update_expiry` – updates product expiry date  
- **Functions:** `check_expiry` – returns product expiry status  

### Cursors
- `c_temp_high` – loops through all measurements with temperature > 25  
- Outputs sensor ID and temperature for each row  

### Window Functions
- `ROW_NUMBER()`, `LAG()`, `LEAD()`  
- Partitioned by sensor, ordered by measurement date  
- Analyzes trends and previous/next temperature values  

---

## Testing & Output

- All objects tested using `plsql_test_queries.sql`.  
- **Procedures**: Insert, update, delete operations confirmed via DBMS_OUTPUT.  
- **Functions**: Outputs verified via SELECT statements.  
- **Package**: Procedures and functions called successfully.  
- **Cursor & Window Functions**: Verified multi-row processing and trend analysis.

**Sample Output:**

![Procedures Output](screenshots/test%20procedures.png)

![Functions Output](screenshots/test%20functions.png)

![Packages Output](screenshots/test%20packages.png)

![Validation Output](screenshots/test%20validation.png)

![Testing Output](screenshots/output.png)

# PHASE VII: Advanced Programming & Auditing

## Objective
Implement triggers, business rules, and comprehensive auditing for the Early Spoilage Detection System. Ensure database actions are monitored, restricted based on business rules, and all attempts are logged.

---

## Business Rule Implemented
- Employees **cannot INSERT/UPDATE/DELETE** on:
  - **Weekdays (Monday–Friday)**
  - **Public Holidays** (only upcoming month)
- All attempts, whether allowed or denied, are **recorded in an audit log**.

---

## Components Developed

### 1. Holiday Management
- Table: `HOLIDAYS`
- Stores dates of public holidays for the current month.
- Example insert:


![Error weekends](screenshots/error%20trigger.png)