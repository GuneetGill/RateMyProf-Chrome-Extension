import psycopg2
from psycopg2 import pool
import os
from dotenv import load_dotenv
import time
import random
import boto3
import json
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load environment variables from .env file (useful for local dev)
if os.getenv("AWS_EXECUTION_ENV") is None:
    load_dotenv()

SECRET_NAME = os.environ["SECRET_NAME"]
AWS_REGION = os.getenv("AWS_REGION") 
DEFAULT_APP_DB_NAME = "postgres"

#create connection pool
connection_pool = None


def get_database_credentials():
    """
    Prefer explicit DB_* env vars (local dev). Otherwise fetch credentials from
    AWS Secrets Manager using SECRET_NAME.
    """
    env_dbname = os.getenv("DB_NAME")
    env_user = os.getenv("DB_USER")
    env_password = os.getenv("DB_PASSWORD")
    env_host = os.getenv("DB_HOST")
    env_port = os.getenv("DB_PORT")
    if all([env_dbname, env_user, env_password, env_host, env_port]):
        return {
            "dbname": env_dbname,
            "username": env_user,
            "password": env_password,
            "host": env_host,
            "port": env_port,
        }

    session = boto3.session.Session()
    if AWS_REGION:
        client = session.client("secretsmanager", region_name=AWS_REGION)
    else:
        client = session.client("secretsmanager")
    secret_value = client.get_secret_value(SecretId=SECRET_NAME)
    # Standard RDS-managed secret: username, password, host, port, dbname, engine, ...
    db_credentials = json.loads(secret_value["SecretString"])
    logger.info("Database credentials retrieved successfully.")
    return db_credentials


def initialize_connection_pool():
    """Initializes the connection pool."""
    global connection_pool
    db_credentials = get_database_credentials()
    if not db_credentials:
        raise RuntimeError("Database credentials not available.")
    # RDS secret usually includes dbname; allow env + default if missing.
    dbname = (
        db_credentials.get("dbname")
        or os.getenv("DB_NAME")
        or DEFAULT_APP_DB_NAME
    )
    # RDS uses "username"; psycopg2 uses user=
    connection_pool = psycopg2.pool.ThreadedConnectionPool(
        1,
        20,
        dbname=dbname,
        user=db_credentials["username"],
        password=db_credentials["password"],
        host=db_credentials["host"],
        port=db_credentials["port"],
        sslmode="require",
    )
    logger.info("Connection pool created successfully")

def get_connection():
    """Returns a connection from the pool."""
    if connection_pool:
        return connection_pool.getconn()
    else:
        print("Connection pool not initialized")
        return None

def release_connection(conn):
    """Releases the connection back to the pool."""
    if connection_pool:
        connection_pool.putconn(conn)

def initialize_database():
    """Ensures the required tables exist before inserting data."""
    global connection_pool
    db = None
    cursor = None
    try:
        if connection_pool is None:
            initialize_connection_pool()
        if connection_pool is None:
            raise RuntimeError("Connection pool not initialized after initialize_connection_pool()")

        db = connection_pool.getconn()
        cursor = db.cursor()

        cursor.execute(
            """
            CREATE TABLE IF NOT EXISTS prof_info(
                prof_id INTEGER PRIMARY KEY,
                link TEXT,
                prof_name TEXT,
                department TEXT,
                rating FLOAT,
                number_of_ratings INT,
                difficulty FLOAT,
                would_take_again TEXT,
                top_tags TEXT
            )
            """
        )

        db.commit()
        logger.info("Database initialized successfully!")
    
    except Exception:
        logger.exception("Error initializing database")
        raise
    finally:
        if cursor is not None:
            cursor.close()
        if db is not None:
            release_connection(db)

def insert_prof_links(prof_id_list):
    """Inserts professor IDs and links into the database."""
    global connection_pool
    try:
        # Get a connection from the pool
        db = connection_pool.getconn()
        cursor = db.cursor()

        for item in prof_id_list:
            time.sleep(random.uniform(0.5, 1.5))  # Random delay to avoid detection
            prof_link = f"https://www.ratemyprofessors.com/professor/{item}"

            cursor.execute("""
                INSERT INTO prof_info (prof_id, link)
                VALUES (%s, %s)
                ON CONFLICT (prof_id) DO NOTHING
            """, (item, prof_link))

        db.commit()
        print("Professor links inserted successfully!")

    except psycopg2.Error as e:
        print(f"Error while inserting data: {e}")
        db.rollback()
    finally:
        if cursor:
            cursor.close()
        if db:
            # Release the connection back to the pool
            release_connection(db)

def save_data_prof_info_table(prof_info):
    """Saves professor info to the database."""
    global connection_pool
    try:
        # Get a connection from the pool
        db = connection_pool.getconn()
        cursor = db.cursor()

        # Extract data from the prof_info dictionary
        prof_id = prof_info.get('prof_id')
        prof_name = prof_info.get('prof_name')
        department = prof_info.get('department')
        rating = prof_info.get('rating')
        number_of_ratings = prof_info.get('number_of_ratings')
        top_tags = prof_info.get('top_tags')
        difficulty = prof_info.get('difficulty')
        would_take_again = prof_info.get('would_take_again')
        link = prof_info.get('link')

        # Insert data into the prof_info table
        cursor.execute("""
            INSERT INTO prof_info(
                prof_id, link, prof_name, department, rating, number_of_ratings, 
                top_tags, difficulty, would_take_again
            ) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (prof_id) DO UPDATE SET
                link = COALESCE(EXCLUDED.link, prof_info.link),
                prof_name = EXCLUDED.prof_name,
                department = EXCLUDED.department,
                rating = EXCLUDED.rating,
                number_of_ratings = EXCLUDED.number_of_ratings,
                top_tags = EXCLUDED.top_tags,
                difficulty = EXCLUDED.difficulty,
                would_take_again = EXCLUDED.would_take_again
        """, (
            prof_id, link, prof_name, department, rating, number_of_ratings, 
            top_tags, difficulty, would_take_again
        ))

        db.commit()  # Don't forget to commit the changes
        print("Data inserted successfully!")

    except Exception as e:
        print(f"Error saving to database: {e}")
        db.rollback()
    finally:
        if cursor:
            cursor.close()
        if db:
            # Release the connection back to the pool
            release_connection(db)

def get_links():
    """Retrieves all links from the database."""
    global connection_pool
    webpage_links = []  # Initialize an empty list to store links

    try:
        # Get a connection from the pool
        db = connection_pool.getconn()
        cursor = db.cursor()

        # Get links from prof_info (webpages table removed)
        cursor.execute("SELECT link FROM prof_info WHERE link IS NOT NULL;")
        webpage_links = cursor.fetchall()
        
        db.commit()
        print("Got web links successfully!")
        
        return [link[0] for link in webpage_links]

    except Exception as e:
        print(f"Error getting links from database: {e}")
        db.rollback()
    finally:
        if cursor:
            cursor.close()
        if db:
            # Release the connection back to the pool
            release_connection(db)

   

def get_prof_id():
    """Retrieves all prof id's from the database."""
    global connection_pool
    prof_id = []  # Initialize an empty list to store prof id 

    try:
        # Get a connection from the pool
        db = connection_pool.getconn()
        cursor = db.cursor()

        # Correct SQL query to get all links
        cursor.execute("SELECT prof_id FROM prof_info;")
        prof_id = cursor.fetchall()
        
        db.commit()
        print("Got prof id's successfully!")
        return [id[0] for id in prof_id]

    except Exception as e:
        print(f"Error getting prof id from database: {e}")
        db.rollback()
    finally:
        if cursor:
            cursor.close()
        if db:
            # Release the connection back to the pool
            release_connection(db)


def close_pool():
    """Close all connections in the pool."""
    global connection_pool
    if connection_pool:
        connection_pool.closeall()
        print("Connection pool closed successfully!")


# Initialize the database when the script is first run
if __name__ == "__main__":
    initialize_connection_pool()  # Make sure the pool is initialized
    initialize_database()  # Ensure the database tables are created
