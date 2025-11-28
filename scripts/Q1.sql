CREATE TYPE t_gift_items_type IS TABLE OF VARCHAR2(256);

CREATE TABLE gift_catalog (
    gift_id_pk NUMBER PRIMARY KEY,
    min_purchase NUMBER,
    gifts t_gift_items_type
) NESTED TABLE gifts STORE AS gift_items;

INSERT INTO gift_catalog (gift_id_pk, min_purchase, gifts) VALUES
    (1, 100, t_gift_items_type('Stickers','Pen Set'));
INSERT INTO gift_catalog (gift_id_pk, min_purchase, gifts) VALUES
    (2, 1000, t_gift_items_type('Teddy Bear', 'Mug', 'Perfume Sample'));
INSERT INTO gift_catalog (gift_id_pk, min_purchase, gifts) VALUES
    (3, 10000, t_gift_items_type('Backpack', 'Thermos Bottle', 'Chocolate Collection'));