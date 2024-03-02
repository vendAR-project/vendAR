CREATE TABLE IF NOT EXISTS Person (
    user_id uuid NOT NULL,
    user_name char(35) NOT NULL,
    user_surname char(30) NOT NULL,
    user_password char(20) NOT NULL,
    user_email char(60) NOT NULL,
    user_phone char(60) NOT NULL,
    PRIMARY KEY(user_id)
);

CREATE TABLE IF NOT EXISTS Product (
    product_id uuid NOT NULL,
    user_id uuid NOT NULL,
    product_title char(100) NOT NULL,
    product_desc text,
    product_images text[],
    product_features text[],
    PRIMARY KEY(product_id),
    FOREIGN KEY(user_id) REFERENCES Person(user_id)
);

CREATE TABLE IF NOT EXISTS Model (
    model_id uuid NOT NULL,
    product_id uuid NOT NULL,
    model_dimensions float8[] NOT NULL,
    model_src text NOT NULL,
    PRIMARY KEY(model_id),
    FOREIGN KEY(product_id) REFERENCES Product(product_id)
);