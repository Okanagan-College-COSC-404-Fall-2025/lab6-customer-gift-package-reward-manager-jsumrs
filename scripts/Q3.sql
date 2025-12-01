CREATE OR REPLACE PACKAGE customer_manager AS
    FUNCTION get_total_purchase(customer_id_in NUMBER) RETURN NUMBER;
    PROCEDURE assign_gifts_to_all;
END customer_manager;

CREATE OR REPLACE PACKAGE BODY customer_manager AS
    FUNCTION get_total_purchase(customer_id_in NUMBER) RETURN NUMBER IS
        v_total NUMBER;
        BEGIN
            -- Find all orders which match the customer id
            -- -- Sum the items within each order and add that to a running total
            select SUM(oi.unit_price * oi.quantity)
            into v_total
            from order_items oi
            join orders o on o.order_id = oi.order_id
            where o.customer_id = customer_id_in;

            RETURN v_total;
    END get_total_purchase;

    FUNCTION choose_gift_package(total_purchase_in IN NUMBER DEFAULT -1) RETURN NUMBER IS
        l_gift_id NUMBER;
        l_max_gift NUMBER;
        l_flag BOOLEAN := FALSE;
        l_count NUMBER;
        BEGIN
            l_flag := CASE (total_purchase_in <= 0)
                        WHEN TRUE THEN TRUE
                        ELSE FALSE
                      END; 
            
            SELECT COUNT(*) INTO l_count 
            FROM gift_catalog gc
            WHERE gc.MIN_PURCHASE <= total_purchase_in; 

            IF l_flag = TRUE OR l_count = 0 THEN 
                RETURN NULL;
            END IF;

            SELECT g.gift_id_pk INTO l_gift_id
            FROM gift_catalog g
            WHERE g.MIN_PURCHASE <= total_purchase_in
            ORDER BY g.min_purchase DESC FETCH FIRST 1 ROW ONLY;

            RETURN l_gift_id;
    END choose_gift_package;

    PROCEDURE assign_gifts_to_all IS
        l_gift_id gift_catalog.gift_id_pk%type;
        l_customer_email CUSTOMERS.email_address%type;
        BEGIN
            FOR cust IN (SELECT customer_id, email_address FROM CUSTOMERS) LOOP
                l_gift_id := choose_gift_package( get_total_purchase( cust.customer_id ));
                IF l_gift_id IS NOT NULL THEN
                    INSERT INTO CUSTOMER_REWARDS (customer_email, gift_id, reward_date) VALUES (cust.email_address, l_gift_id, SYSDATE);
                END IF;
            END LOOP;
    END assign_gifts_to_all;

END customer_manager;

