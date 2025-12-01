CREATE OR REPLACE PROCEDURE test_customer_manager AS
    BEGIN
    customer_manager.assign_gifts_to_all;
    DBMS_OUTPUT.put_line('[REWARD ITEMS] -- [REWARD ID] -- [EMAIL] -- [GIFT SET ID] -- [REWARD DATE]');
    FOR r in (SELECT cr.reward_id_pk, cr.customer_email, cr.gift_id, cr.reward_date, gc.gifts
    FROM customer_rewards cr 
    JOIN gift_catalog gc ON cr.gift_id = gc.gift_id_pk
    FETCH FIRST 5 ROW ONLY) LOOP
        DBMS_OUTPUT.PUT('[ ');
        FOR i in 1 .. r.gifts.count LOOP
            DBMS_OUTPUT.PUT(r.gifts(i) || ' ');
        END LOOP;
        DBMS_OUTPUT.PUT('] ');

        DBMS_OUTPUT.PUT_LINE(
            TO_CHAR(r.reward_id_pk)|| ' ' ||
            r.customer_email|| ' ' ||
            TO_CHAR(r.gift_id )|| ' ' ||
            TO_CHAR(r.reward_date )|| ' ' 
        );
    END LOOP;
END;


BEGIN
    TEST_CUSTOMER_MANAGER;
END;