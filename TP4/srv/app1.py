from flask import Flask, render_template
import mysql.connector

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host="tp4-mysql",   # nom du conteneur MySQL (même réseau Docker)
        port=3307,
        user="root",
        password="foo",
        database="tp4db"
    )

@app.route("/")
def index():
    # Sample query
    query = "SELECT * FROM myTable"
    cursor.execute(query)
    data = cursor.fetchall()
    
    # Close the cursor and connection
    cursor.close()
    conn.close()
    
    return render_template('index.html', data=data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)



