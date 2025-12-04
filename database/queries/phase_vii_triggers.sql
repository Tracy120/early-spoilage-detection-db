-- 7. Test queries

-- Attempt an insert (this may fail if today is weekday/holiday)
BEGIN
    INSERT INTO SENSOR(sensor_type, location) VALUES ('Temperature', 'Warehouse');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- Check audit log
SELECT * FROM AUDIT_LOG ORDER BY action_date DESC;

-- Check SENSOR table
SELECT * FROM SENSOR;