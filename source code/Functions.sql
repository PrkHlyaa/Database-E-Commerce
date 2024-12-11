-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- DAFTAR FUNCTION
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- 1. CALCULATE_FINAL_AMOUNT  
-- 2. GET_USER_ID  

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
-- CALCULATE_FINAL_AMOUNT  
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace FUNCTION calculate_final_amount(
    p_total_amount IN NUMBER,
    p_discount_percent IN NUMBER
) RETURN NUMBER AS
    v_final_amount NUMBER;
BEGIN
    -- Calculate the discount amount and subtract it from the total amount
    v_final_amount := p_total_amount - (p_total_amount * (p_discount_percent / 100));
    RETURN v_final_amount;
END;

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--GET_USER_ID 
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace FUNCTION get_user_id(
    p_username IN VARCHAR2,
    p_email IN VARCHAR2,
    p_password IN VARCHAR2
) RETURN VARCHAR2 IS
    l_id_customer VARCHAR2(32);
BEGIN
    -- Retrieve the user ID based on username, email, and password
    SELECT id_customer
    INTO l_id_customer
    FROM customer
    WHERE username = p_username
    AND email = p_email
    AND password = p_password;

    RETURN l_id_customer;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;  -- No user found
    WHEN OTHERS THEN
        RETURN NULL;  -- Handle any other errors
END;
