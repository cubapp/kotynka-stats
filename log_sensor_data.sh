#!/bin/bash
# =============================================
# Sensor Data Logger
# =============================================

PWD="/home/pi/src"
DB="sensor_log.db"
INSERT_SCRIPT="insert_log.py"

# Check files exist
if [ ! -f "navstevnici" ] || [ ! -f "teplo.php" ]; then
    echo "Error: navstevnici or teplo.php not found!"
    exit 1
fi

# Read the values (trim whitespace)
PEOPLE=$(cat navstevnici | tr -d ' \t\r\n')
TEMP=$(cat teplo.php | tr -d ' \t\r\n')

# Basic validation
if ! [[ "$PEOPLE" =~ ^[0-9]+$ ]] || [ "$PEOPLE" -gt 9999 ]; then
    echo "Error: Invalid people count in navstevnici"
    exit 1
fi

if ! [[ "$TEMP" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: Invalid temperature in teplo.php"
    exit 1
fi

# Insert into database
python3 "$INSERT_SCRIPT" "$PEOPLE" "$TEMP"

# Optional: keep history of raw files
TIMESTAMP=$(date +"%Y%m%d_%H%M")
cp navstevnici "archive/navstevnici_${TIMESTAMP}"
cp teplo.php "archive/teplo_${TIMESTAMP}.php" 2>/dev/null || true
