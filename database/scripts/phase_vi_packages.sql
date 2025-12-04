-- Package specification
CREATE OR REPLACE PACKAGE product_pkg AS
    PROCEDURE update_expiry(p_product_id IN NUMBER, p_new_expiry IN DATE);
    FUNCTION check_expiry(p_product_id IN NUMBER) RETURN VARCHAR2;
END product_pkg;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY product_pkg AS
    PROCEDURE update_expiry(p_product_id IN NUMBER, p_new_expiry IN DATE) IS
    BEGIN
        UPDATE product
        SET expiry_date = p_new_expiry
        WHERE product_id = p_product_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Product not found');
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END update_expiry;

    FUNCTION check_expiry(p_product_id IN NUMBER) RETURN VARCHAR2 IS
        v_expiry DATE;
    BEGIN
        SELECT expiry_date INTO v_expiry
        FROM product
        WHERE product_id = p_product_id;
        IF v_expiry < SYSDATE THEN
            RETURN 'EXPIRED';
        ELSE
            RETURN 'VALID';
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN 'PRODUCT NOT FOUND';
        WHEN OTHERS THEN RETURN 'ERROR';
    END check_expiry;
END product_pkg;
/
