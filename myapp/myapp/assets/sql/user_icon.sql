CREATE TABLE user_icon (
    id       INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    icon_id  INTEGER,
    order_no INTEGER NOT NULL
                     DEFAULT (1) 
);
