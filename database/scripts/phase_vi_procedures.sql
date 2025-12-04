-- Procedure to add a new sensor
CREATE OR REPLACE PROCEDURE add_sensor (
    p_type IN VARCHAR2,
    p_location IN VARCHAR2,
    p_id OUT NUMBER
) AS
BEGIN
    INSERT INTO sensor(sensor_type, location)
    VALUES (p_type, p_location)
    RETURNING sensor_id INTO p_id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END add_sensor;
/

-- Procedure to update product expiry
CREATE OR REPLACE PROCEDURE update_product_expiry (
    p_product_id IN NUMBER,
    p_new_expiry IN DATE
) AS
BEGIN
    UPDATE product
    SET expiry_date = p_new_expiry
    WHERE product_id = p_product_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Product not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END update_product_expiry;
/
