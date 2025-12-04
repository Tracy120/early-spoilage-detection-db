-- PHASE VI Test Queries

-- Test Procedures
DECLARE
    v_id NUMBER;
BEGIN
    add_sensor('Temperature', 'Warehouse', v_id);
    DBMS_OUTPUT.PUT_LINE('New Sensor ID: ' || v_id);
END;
/

BEGIN
    update_product_expiry(101, SYSDATE + 30);
    DBMS_OUTPUT.PUT_LINE('Product 101 expiry updated');
END;
/

BEGIN
    delete_measurement(201);
    DBMS_OUTPUT.PUT_LINE('Measurement 201 deleted');
END;
/

-- Test Functions
SELECT calc_spoilage_index(30, 60) AS spoilage_index FROM dual;
SELECT is_product_expired(SYSDATE - 1) AS expiry_status FROM dual;
SELECT lookup_sensor_by_location('Warehouse') AS sensor_id FROM dual;

-- Test Package
BEGIN
    product_pkg.update_expiry(101, SYSDATE + 15);
END;
/
SELECT product_pkg.check_expiry(101) AS status FROM dual;

-- Cursor Test
DECLARE
    CURSOR c_temp_high IS SELECT * FROM measurement WHERE temperature > 25;
    v_row c_temp_high%ROWTYPE;
BEGIN
    OPEN c_temp_high;
    LOOP
        FETCH c_temp_high INTO v_row;
        EXIT WHEN c_temp_high%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Sensor ID: ' || v_row.sensor_id || ' Temp: ' || v_row.temperature);
    END LOOP;
    CLOSE c_temp_high;
END;
/

-- Window Function Test
SELECT sensor_id, temperature,
       ROW_NUMBER() OVER(PARTITION BY sensor_id ORDER BY measure_date DESC) AS rn,
       LAG(temperature) OVER(PARTITION BY sensor_id ORDER BY measure_date) AS prev_temp,
       LEAD(temperature) OVER(PARTITION BY sensor_id ORDER BY measure_date) AS next_temp
FROM measurement;
