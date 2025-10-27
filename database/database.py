import psycopg2
from psycopg2 import pool
import os
from dotenv import load_dotenv
import time
import random
import boto3 
from botocore.exceptions import ClientError
import json
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# # Load environment variables from .env file
# load_dotenv()

# # Get database credentials from environment variables
# DB_NAME = os.getenv("DB_NAME")
# DB_USER = os.getenv("DB_USER")
# DB_PASSWORD = os.getenv("DB_PASSWORD")
# DB_HOST = os.getenv("DB_HOST")
# DB_PORT = os.getenv("DB_PORT")

SECRET_NAME = "rmp-db/secrets"
AWS_REGION = "us-west-2"

#create connection pool
connection_pool = None

def get_database_credentials():
    """Retrieve database credentials from AWS Secrets Manager."""
    try:
        # Create a Secrets Manager client
        session = boto3.session.Session()
        client = session.client(service_name="secretsmanager", region_name=AWS_REGION)
        
        # Fetch the secret
        secret_value = client.get_secret_value(SecretId=SECRET_NAME)
        
        # Parse the JSON secret
        secret_dict = json.loads(secret_value["SecretString"])
        logger.info("Database credentials retrieved successfully.")
        return secret_dict  # Returns a dictionary containing DB credentials
    
    except Exception as e:
        logger.error("Error getting secrets: {e}")
        return None
    

def initialize_connection_pool():
    """Initializes the connection pool."""
    global connection_pool
    db_credentials = get_database_credentials()
    
    if not db_credentials:
        logger.info("Failed to get Database credentials. Failed to initialize connection pool")
    
    try:
        connection_pool = psycopg2.pool.ThreadedConnectionPool(
            1, 20,  # min and max connections in the pool
             dbname=db_credentials["dbname"],
            user=db_credentials["username"],
            password=db_credentials["password"],
            host=db_credentials["host"],
            port=db_credentials["port"]
        )
        logging.info("Connection pool created successfully")
    except Exception as e:
        logging.error(f"Error initializing connection pool: {e}")
        

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
    try:
        if connection_pool is None:
            initialize_connection_pool()  # Ensure the pool is initialized
        
        # Get a connection from the pool
        db = connection_pool.getconn()
        cursor = db.cursor()

        # Create tables if they do not exist
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS webpages(
                prof_id INTEGER PRIMARY KEY,
                link TEXT
            )
        ''')

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS prof_info(
                prof_id INTEGER PRIMARY KEY,
                prof_name TEXT,
                department TEXT,
                rating FLOAT,
                number_of_ratings INT,
                difficulty FLOAT,
                would_take_again TEXT,
                top_tags TEXT
            )
        ''')

        db.commit()
        print("Database initialized successfully!")

    except Exception as e:
        print(f"Error initializing database: {e}")
    finally:
        if cursor:
            cursor.close()
        if db:
            # Release the connection back to the pool
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

            # Check if prof_id exists
            cursor.execute("SELECT prof_id FROM webpages WHERE prof_id = %s", (item,))
            existing_prof_id = cursor.fetchone()

            if not existing_prof_id:
                cursor.execute("INSERT INTO webpages(prof_id, link) VALUES (%s, %s)", (item, prof_link))

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

        # Insert data into the prof_info table
        cursor.execute("""
            INSERT INTO prof_info(
                prof_id, prof_name, department, rating, number_of_ratings, 
                top_tags, difficulty, would_take_again
            ) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (prof_id) DO NOTHING
        """, (
            prof_id, prof_name, department, rating, number_of_ratings, 
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

        # Correct SQL query to get all links
        cursor.execute("SELECT link FROM webpages;")
        webpage_links = cursor.fetchall()
        
        db.commit()
        print("Got web links successfully!")

    except Exception as e:
        print(f"Error getting links from database: {e}")
        db.rollback()
    finally:
        if cursor:
            cursor.close()
        if db:
            # Release the connection back to the pool
            release_connection(db)

    return [link[0] for link in webpage_links]

def get_prof_id():
    """Retrieves all prof id's from the database."""
    global connection_pool
    prof_id = []  # Initialize an empty list to store prof id 

    try:
        # Get a connection from the pool
        db = connection_pool.getconn()
        cursor = db.cursor()

        # Correct SQL query to get all links
        cursor.execute("SELECT prof_id FROM webpages;")
        prof_id = cursor.fetchall()
        
        db.commit()
        print("Got prof id's successfully!")

    except Exception as e:
        print(f"Error getting prof id from database: {e}")
        db.rollback()
    finally:
        if cursor:
            cursor.close()
        if db:
            # Release the connection back to the pool
            release_connection(db)

    return [id[0] for id in prof_id]



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
