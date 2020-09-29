CREATE TABLE icon (
    id    INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    code  INTEGER NOT NULL,
    type  TINYINT NOT NULL
                  DEFAULT (0),
    title VARCHAR
);