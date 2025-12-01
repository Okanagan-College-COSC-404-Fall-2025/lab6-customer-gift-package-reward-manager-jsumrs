CREATE TABLE customer_rewards (
    reward_id_pk NUMBER  GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_email VARCHAR2(255),
    FOREIGN KEY (customer_email) REFERENCES Customers(email_address),
    gift_id NUMBER,
    FOREIGN KEY (gift_id) REFERENCES gift_catalog(gift_id_pk),
    reward_date DATE DEFAULT SYSDATE
)

drop table customer_rewards;