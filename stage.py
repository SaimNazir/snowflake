import snowflake.connector
from config import settings


AZURE_STORAGE_CONNECTION_STRING = settings.azure_storage_connection_string
CONTAINER_NAME = settings.container_name

SNOWFLAKE_CONFIG = {
    "user": settings.snowflake_user,
    "password": settings.snowflake_password,
    "account": settings.snowflake_account,
    "warehouse": settings.snowflake_warehouse,
    "database": settings.snowflake_database,
    "schema": settings.snowflake_schema
}

STORAGE_INTEGRATION = settings.storage_integration
FILE_FORMAT_NAME = settings.file_format_name
STAGE_NAME = settings.stage_name
TARGET_TABLE = settings.target_table



def connect_to_snowflake():
    return snowflake.connector.connect(**SNOWFLAKE_CONFIG)

# Ensure stage and format exist
def ensure_stage_exists(cursor):

    cursor.execute(f"""
    CREATE OR REPLACE FILE FORMAT {FILE_FORMAT_NAME}
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    PARSE_HEADER = TRUE
    COMPRESSION = 'AUTO'
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
    
    """)
    
    # Create the stage pointing to the container (not a specific file)
    cursor.execute(f"""
    CREATE OR REPLACE STAGE {STAGE_NAME}
    URL = 'azure://snowflakesaim.blob.core.windows.net/{CONTAINER_NAME}/'
    STORAGE_INTEGRATION = {STORAGE_INTEGRATION}
    FILE_FORMAT = {FILE_FORMAT_NAME}
    """)
    
    print(f"Permanent stage '{STAGE_NAME}' created/verified")



def ensure_table_exists(cursor):
    cursor.execute(f"""
    CREATE TABLE IF NOT EXISTS {TARGET_TABLE} (
        Rank INTEGER,
        Game_ID VARCHAR(50),
        Name VARCHAR(255),
        Platform VARCHAR(50),
        Year FLOAT,
        Genre VARCHAR(50),
        Publisher VARCHAR(255),
        NA_Sales FLOAT,
        EU_Sales FLOAT,
        JP_Sales FLOAT,
        Other_Sales FLOAT,
        Global_Sales FLOAT,
        Age_Rating VARCHAR(20),
        Critic_Score FLOAT,
        User_Score FLOAT,
        Review_Count FLOAT,
        Developer VARCHAR(255),
        Release_Season VARCHAR(20),
        Multiplayer_Support VARCHAR(5),
        DLC_Available VARCHAR(5),
        Remastered_Version VARCHAR(5),
        loaded_at TIMESTAMP
    )
    """)

    
    print(f"Target table '{TARGET_TABLE}' created/verified")



# Find and process the latest GZIPPED CSV file
def process_latest(cursor):
    cursor.execute(f"LIST @{STAGE_NAME}")
    stage_files = cursor.fetchall()

    gzipped_csv_files = [file[0] for file in stage_files if file[0].endswith('.csv.gz')]

    if not gzipped_csv_files:
        raise Exception("No .csv.gz files found in the stage.")
    
    latest_file = sorted(gzipped_csv_files)[-1].split(f"{CONTAINER_NAME}/")[-1]
    print(f"Latest GZIPPED CSV in stage: {latest_file}")

    cursor.execute(f"""
    COPY INTO {TARGET_TABLE}
    FROM @{STAGE_NAME}/{latest_file}
    FILE_FORMAT = (FORMAT_NAME = {FILE_FORMAT_NAME})
    MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
    PURGE = FALSE
    """)
    
    result = cursor.fetchall()
    print(f"Copy operation result: {result}")

    



def main():
    conn = None
    cursor = None
    try:
        conn = connect_to_snowflake()
        cursor = conn.cursor()
        
        ensure_stage_exists(cursor)
        ensure_table_exists(cursor)
        process_latest(cursor)
        
        conn.commit()
        print("Processing completed successfully")
        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == "__main__":
    main()