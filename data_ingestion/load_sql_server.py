import pandas as pd
import pyodbc

# Function to load data from CSV into SQL Server table
def load_csv(file_path, table_name, columns, connection):
    print(f"🔄 Loading {table_name} from {file_path}...")
    
    # Read the CSV file into a DataFrame
    try:
        data = pd.read_csv(file_path)
    except FileNotFoundError:
        print(f"❌ File not found: {file_path}")
        return
    
    # Create SQL INSERT statement
    placeholders = ", ".join(["?"] * len(columns))
    insert_query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({placeholders})"
    
    # Insert rows into the table
    cursor = connection.cursor()
    for _, row in data.iterrows():
        try:
            values = [row[col] for col in columns]
            cursor.execute(insert_query, values)
        except KeyError as e:
            print(f"❌ Missing column in CSV: {e}")
            return
    
    connection.commit()
    print(f"✅ Finished loading {table_name}.\n")

# 📡 Connect to SQL Server (Windows Authentication)
conn = pyodbc.connect(
    'DRIVER={SQL Server};SERVER=DESKTOP-V2B514I;DATABASE=atliq_db;Trusted_Connection=yes;'
)

# 📁 Load CSV files (Update column names to match your actual files)
load_csv('data/dim_hotels.csv', 'dim_hotels',
         ['property_id', 'property_name', 'category', 'city'], conn)

load_csv('data/dim_rooms.csv', 'dim_rooms',
         ['room_id', 'room_class'], conn)

load_csv('data/dim_date.csv', 'dim_date',
         ['date', 'month_year', 'week_no', 'day_type'], conn)  # Use updated column names

load_csv('data/fact_aggregated_bookings.csv', 'fact_aggregated_bookings',
         ['property_id', 'check_in_date', 'room_category', 'successful_bookings', 'capacity'], conn)

load_csv('data/fact_bookings.csv', 'fact_bookings',
         ['booking_id', 'property_id', 'booking_date', 'check_in_date', 'check_out_date',
          'no_guests', 'room_category', 'booking_platform', 'ratings_given',
          'booking_status', 'revenue_generated', 'revenue_realized'], conn)

# 🔒 Close connection after loading all tables
conn.close()
print("🎉 All tables loaded and SQL connection closed.")



