# Sensor Logger

Simple, lightweight logging system for people count and temperature using SQLite3.

Designed for minimal resource usage — ideal for logging a few bytes per hour on low-power devices (Raspberry Pi, small servers, etc.).

## Features

- Extremely simple SQLite3 database
- Logs timestamp, number of people (0–9999), and temperature (-50°C to +60°C)
- Easy to extend with additional sensors
- Shell script for automated data collection
- Ready for simple PHP + JavaScript graphing

## File Structure

```
sensor-logger/
├── sensor_log.db              # SQLite database (created automatically)
├── create_db.sql              # Database schema
├── insert_log.py              # Python insert script
├── log_sensor_data.sh         # Main logging script
├── navstevnici                # Input: number of people
├── teplo.php                  # Input: temperature
├── archive/                   # Backup of raw data files
├── data.php                   # (Optional) PHP API for graphing
└── README.md
```

## Database Schema

```sql
CREATE TABLE IF NOT EXISTS measurements (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    recorded_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    people          INTEGER NOT NULL CHECK (people BETWEEN 0 AND 9999),
    temperature     REAL NOT NULL CHECK (temperature BETWEEN -50 AND 60),
    extra1          TEXT,
    extra2          REAL,
    notes           TEXT
);

CREATE INDEX IF NOT EXISTS idx_recorded_at ON measurements(recorded_at);
```

## Setup

### 1. Create the project directory

```bash
mkdir sensor-logger
cd sensor-logger
```

### 2. Create the database

```bash
sqlite3 sensor_log.db < create_db.sql
```

### 3. Make scripts executable

```bash
chmod +x insert_log.py log_sensor_data.sh
mkdir -p archive
```

## Usage

### Manual logging

```bash
./log_sensor_data.sh
```

### Automated logging (recommended)

Add to crontab (`crontab -e`):

```cron
# Log every hour
0 * * * * /home/user/sensor-logger/log_sensor_data.sh >> /home/user/sensor-logger/log_sensor.log 2>&1
```

## Input Files

- **`navstevnici`** — contains **only** a number (example: `1243`)
- **`teplo.php`** — contains **only** the temperature (example: `23.5` or `-8`)

Both files must contain just the raw value with no extra text or spaces.

## Output Example

```
[2026-06-07 15:30:12] Logged: 1243 people, 23.4°C
```

## Graphing

A simple `data.php` + HTML/Chart.js frontend can be added later for visualization.

## Extending the System

The table includes `extra1`, `extra2`, and `notes` columns for future sensors (humidity, CO₂, etc.).

## Technologies

- SQLite3
- Python 3
- Bash
- (Optional) PHP + Chart.js

## License

Free for personal and commercial use.
