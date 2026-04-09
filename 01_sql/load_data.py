import pandas as pd
import sqlite3
from pathlib import Path

# Build file paths safely
project_root = Path(__file__).resolve().parent.parent
csv_path = project_root / "Data" / "heart_raw.csv"
db_path = project_root / "01_sql" / "heart_disease.db"

# Read the CSV
df = pd.read_csv(csv_path)

# Connect to SQLite database
conn = sqlite3.connect(db_path)

# Load dataframe into SQL table
df.to_sql("heart_disease_raw", conn, if_exists="replace", index=False)

# Quick validation
row_count = conn.execute("SELECT COUNT(*) FROM heart_disease_raw").fetchone()[0]
print(f"Loaded {row_count} rows into heart_disease_raw")

conn.close()