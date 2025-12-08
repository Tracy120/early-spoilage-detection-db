# PHASE VI – PL/SQL Design Documentation

## Overview
This document describes the PL/SQL procedures, functions, packages, cursors, and window functions implemented for the EarlySpoilageDetectionSystem project. 

---

## Procedures
- **add_sensor**  
  - **Purpose:** Adds a new sensor to the `sensor` table.  
  - **Parameters:**  
    - `p_type` (IN) → sensor type  
    - `p_location` (IN) → sensor location  
    - `p_id` (OUT) → returns the newly created sensor ID  
  - **DML:** INSERT  
  - **Exception Handling:** Catches all errors and outputs via DBMS_OUTPUT  

- **update_product_expiry**  
  - **Purpose:** Updates expiry date of a product in `product` table.  
  - **Parameters:**  
    - `p_product_id` (IN)  
    - `p_new_expiry` (IN)  
  - **DML:** UPDATE  
  - **Exceptions:** NO_DATA_FOUND, OTHERS  

- **delete_measurement**  
  - **Purpose:** Deletes a measurement record by ID  
  - **Parameters:** `p_measurement_id` (IN)  
  - **DML:** DELETE  
  - **Exceptions:** OTHERS  

---

## Functions
- **calc_spoilage_index** → calculates spoilage index from temperature & humidity.  
- **is_product_expired** → returns 'EXPIRED' or 'VALID' based on expiry date.  
- **lookup_sensor_by_location** → returns sensor ID by location.

---

## Packages
- **product_pkg**  
  - Groups procedures/functions for product table.  
  - Exposes `update_expiry` and `check_expiry` as public interfaces.  

---

## Cursors
- **Explicit cursor `c_measurements`** → iterates over all measurements where temperature > 25.  

---

## Window Functions
- `ROW_NUMBER() OVER (PARTITION BY sensor_id ORDER BY measure_date DESC)`  
- `RANK()` and `DENSE_RANK()` for measurement ordering.  
- `LAG()` and `LEAD()` for comparing previous/next measurement values.  

---

## Exception Handling
- Predefined exceptions (NO_DATA_FOUND, OTHERS) handled in every procedure/function.  
- Custom messages printed via `DBMS_OUTPUT.PUT_LINE`.  
- Errors logged manually if needed (can extend to logging table).

---

## Testing Approach
1. Procedures executed with sample input using anonymous blocks.  
2. Functions tested using SELECT statements.  
3. Packages called from anonymous blocks and SELECT queries.  
4. Cursors and window functions tested via SELECT statements and DBMS_OUTPUT.  
5. Screenshots captured for GitHub submission.
