CREATE OR REPLACE PACKAGE customer_manager AS
    FUNCTION get_total_purchase(customer_id_in NUMBER) RETURN NUMBER;
    PROCEDURE assign_gifts_to_all;
END customer_manager;

CREATE OR REPLACE PACKAGE BODY customer_manager AS
    FUNCTION get_total_purchase(customer_id_in NUMBER) RETURN NUMBER IS
        DECLARE
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

    FUNCTION choose_gift_package(total_purchase_in IN NUMBER) RETURN NUMBER IS
        BEGIN
    END choose_gift_package;

END choose_gift_package


SELECT SUM(oi.unit_price * oi.quantity)
  FROM order_items oi
  JOIN orders o 
  ON o.order_id = oi.order_id
  WHERE o.customer_id = 1;