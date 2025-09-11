from flask import Flask, jsonify, request
import psycopg2
import os
import time

app = Flask(__name__)

# Database connection parameters
DB_HOST = os.getenv('DB_HOST', 'db')
DB_PORT = os.getenv('DB_PORT', '5432')
DB_NAME = os.getenv('DB_NAME', 'softy_pinko')
DB_USER = os.getenv('DB_USER', 'postgres')
DB_PASSWORD = os.getenv('DB_PASSWORD', 'password')

def get_db_connection():
    """Get database connection with retry logic"""
    max_retries = 30
    for i in range(max_retries):
        try:
            conn = psycopg2.connect(
                host=DB_HOST,
                port=DB_PORT,
                database=DB_NAME,
                user=DB_USER,
                password=DB_PASSWORD
            )
            return conn
        except psycopg2.OperationalError as e:
            if i < max_retries - 1:
                print(f"Database connection attempt {i+1} failed, retrying in 2 seconds...")
                time.sleep(2)
            else:
                raise e

def init_db():
    """Initialize database with sample data"""
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Create table if it doesn't exist
        cur.execute('''
            CREATE TABLE IF NOT EXISTS messages (
                id SERIAL PRIMARY KEY,
                content TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Insert sample data if table is empty
        cur.execute('SELECT COUNT(*) FROM messages')
        if cur.fetchone()[0] == 0:
            sample_messages = [
                "Hello from the database!",
                "Docker multi-container setup working!",
                "PostgreSQL container connected successfully!"
            ]
            for msg in sample_messages:
                cur.execute('INSERT INTO messages (content) VALUES (%s)', (msg,))
        
        conn.commit()
        cur.close()
        conn.close()
        print("Database initialized successfully!")
    except Exception as e:
        print(f"Database initialization error: {e}")

@app.route('/api/hello')
def hello_world():
    return 'Hello, World!'

@app.route('/api/messages')
def get_messages():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT id, content, created_at FROM messages ORDER BY id')
        messages = cur.fetchall()
        cur.close()
        conn.close()
        
        return jsonify([{
            'id': msg[0],
            'content': msg[1],
            'created_at': msg[2].isoformat() if msg[2] else None
        } for msg in messages])
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/messages', methods=['POST'])
def add_message():
    try:
        data = request.get_json()
        if not data or 'content' not in data:
            return jsonify({'error': 'Content required'}), 400
        
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO messages (content) VALUES (%s) RETURNING id', (data['content'],))
        message_id = cur.fetchone()[0]
        conn.commit()
        cur.close()
        conn.close()
        
        return jsonify({'id': message_id, 'content': data['content']}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    # Initialize database on startup
    init_db()
    app.run(host='0.0.0.0', port=5252)