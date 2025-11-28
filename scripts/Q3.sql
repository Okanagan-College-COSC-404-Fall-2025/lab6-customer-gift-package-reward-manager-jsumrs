CREATE OR REPLACE PACKAGE customer_manager AS
    FUNCTION get_total_purchase(customer_id NUMBER) RETURN NUMBER;
    PROCEDURE assign_gifts_to_all;
END customer_manager;

CREATE OR REPLACE PACKAGE BODY customer_manager AS
    FUNCTION choose_gift_package(total_purchase_in IN NUMBER) RETURN NUMBER IS
    BEGIN

    END choose_gift_package