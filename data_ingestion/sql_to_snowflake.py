import os
import pandas as pd
import pyodbc
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas

# 🔐 Optional: Use environment variables if preferred
# os.environ['SNOWFLAKE_PWD'] = 'your_password_here'

# ✅ SQL Server Connection
sql_conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=DESKTOP-V2B514I;'
    'DATABASE=atliq_db;'
    'Trusted_Connection=yes;'
)

# ✅ Snowflake Connection
sf_conn = snowflake.connector.connect(
    user='dbt',
    password=os.getenv('SNOWFLAKE_PWD', 'Kh@n131299!'),  # Use env var if set
    account='ahprnkl-xl12535',  # Remove region suffix unless required
    warehouse='atliq_wh',
    database='atliq_db',
    schema='raw_zone',
    role='transform'
)

# 📦 Transfer Function
def transfer_table(table_name):
    print(f"\n🚚 Transferring: {table_name}")

    try:
        # Step 1: Read from SQL Server
        df = pd.read_sql(f"SELECT * FROM {table_name}", sql_conn)
        print(f"📊 Fetched: {len(df)} rows")

        # Step 2: Upload to Snowflake
        success, nchunks, nrows, _ = write_pandas(sf_conn, df, table_name.upper())
        if success:
            print(f"✅ Inserted: {nrows} rows into {table_name}")
        else:
            print(f"⚠️ Failed to insert into {table_name}")

    except Exception as e:
        print(f"❌ Error with {table_name}: {e}")

# 🔄 List of Tables to Transfer
tables = [
    'dim_hotels',
    'dim_rooms',
    'dim_date',
    'fact_aggregated_bookings',
    'fact_bookings'
]

# 🚀 Transfer All Tables
for tbl in tables:
    transfer_table(tbl)

# 🔒 Close Connections
sql_conn.close()
sf_conn.close()
print("\n🎯 All data successfully loaded into Snowflake Raw Zone.")
