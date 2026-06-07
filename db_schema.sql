-- File: create_db.sql
CREATE TABLE IF NOT EXISTS measurements (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    recorded_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    people          INTEGER NOT NULL CHECK (people BETWEEN 0 AND 9999),
    temperature     REAL NOT NULL CHECK (temperature BETWEEN -50 AND 60),
    
    -- Future extension columns (NULL until used)
    extra1          TEXT,
    extra2          REAL,
    notes           TEXT
);

-- Optional: index for fast graphing by time
CREATE INDEX IF NOT EXISTS idx_recorded_at ON measurements(recorded_at);
