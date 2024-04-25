CREATE TABLE IF NOT EXISTS Person (
    user_id uuid NOT NULL,
    user_name varchar(35) NOT NULL,
    user_surname varchar(30) NOT NULL,
    user_password varchar(200) NOT NULL,
    user_email varchar(60) NOT NULL,
    user_phone varchar(20) NOT NULL,
    user_role varchar NOT NULL,
    PRIMARY KEY(user_id)
);

CREATE TABLE IF NOT EXISTS Product (
    product_id uuid NOT NULL,
    user_id uuid NOT NULL,
    product_title varchar(100) NOT NULL,
    product_desc text,
    product_price real,
    product_images text[],
    product_features text[],
    product_sales_page_url text,
    PRIMARY KEY(product_id),
    FOREIGN KEY(user_id) REFERENCES Person(user_id)
);

CREATE TABLE IF NOT EXISTS Model (
    model_id uuid NOT NULL,
    product_id uuid NOT NULL,
    model_dimensions real[] NOT NULL,
    model_src text NOT NULL,
    PRIMARY KEY(model_id),
    FOREIGN KEY(product_id) REFERENCES Product(product_id)
);