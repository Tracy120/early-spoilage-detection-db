DECLARE
    CURSOR c_measurements IS
        SELECT * FROM measurement WHERE temperature > 25;
    v_measurement c_measurements%ROWTYPE;
BEGIN
    OPEN c_measurements;
    LOOP
        FETCH c_measurements INTO v_measurement;
        EXIT WHEN c_measurements%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Sensor ID: ' || v_measurement.sensor_id || ' Temp: ' || v_measurement.temperature);
    END LOOP;
    CLOSE c_measurements;
END;
/
