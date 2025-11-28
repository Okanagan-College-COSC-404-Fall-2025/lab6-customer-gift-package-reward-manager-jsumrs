CREATE OR REPLACE TYPE t_gift_items_type IS TABLE OF VARCHAR2(256);

CREATE TABLE gift_catalog (
    gift_id_pk NUMBER,
    min_purchase NUMBER,
    gifts t_gift_items_type NESTED TABLE gifts AS t_gift_items_type
)