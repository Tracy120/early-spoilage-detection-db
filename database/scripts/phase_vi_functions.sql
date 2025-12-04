-- Function to calculate spoilage risk
CREATE OR REPLACE FUNCTION calc_spoilage_index (
    p_temperature IN NUMBER,
    p_humidity IN NUMBER
) RETURN NUMBER IS
    v_index NUMBER;
BEGIN
    v_index := (p_temperature * 0.6) + (p_humidity * 0.4);
    RETURN v_index;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END calc_spoilage_index;
/

-- Function to check if product is expired
CREATE OR REPLACE FUNCTION is_product_expired (
    p_expiry_date DATE
) RETURN VARCHAR2 IS
BEGIN
    IF p_expiry_date < SYSDATE THEN
        RETURN 'EXPIRED';
    ELSE
        RETURN 'VALID';
    END IF;
END is_product_expired;
/
