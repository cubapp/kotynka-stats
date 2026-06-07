#!/usr/bin/env python3
import sqlite3
import sys
from datetime import datetime

def insert_measurement(people: int, temperature: float):
    conn = sqlite3.connect('sensor_log.db')
    cur = conn.cursor()
    
    cur.execute("""
        INSERT INTO measurements (people, temperature)
        VALUES (?, ?)
    """, (people, temperature))
    
    conn.commit()
    print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Logged: {people} people, {temperature}°C")
    conn.close()

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 insert_log.py <people> <temperature>")
        sys.exit(1)
    
    try:
        people = int(sys.argv[1])
        temp = float(sys.argv[2])
        insert_measurement(people, temp)
    except ValueError:
        print("Error: people must be integer, temperature must be number")
        sys.exit(1)
