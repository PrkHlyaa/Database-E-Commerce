create or replace PROCEDURE update_data_diri(
    p_id_customer IN VARCHAR2,
    p_email IN VARCHAR2,
    p_password IN VARCHAR2,
    p_username IN VARCHAR2
) IS
    l_customer_exists INTEGER;
BEGIN
    -- Check if id_customer exists
    SELECT COUNT(*)
    INTO l_customer_exists
    FROM customer
    WHERE id_customer = p_id_customer;

    IF l_customer_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error: Customer ID does not exist');
    END IF;

    -- Update the customer record
    UPDATE customer
    SET email = p_email,
        password = p_password,
        username = p_username
    WHERE id_customer = p_id_customer;

    DBMS_OUTPUT.PUT_LINE('Customer data updated successfully for ID: ' || p_id_customer);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating customer data: ' || SQLERRM);
END;