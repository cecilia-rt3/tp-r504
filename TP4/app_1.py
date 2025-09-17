from flask import Flask, render_template
import mysql.connector

app = Flask(__name__)

# MySQL configuration
db_config = {
    'host': 'mysql',        # hostname of the MySQL container on the Docker network
    'user': 'root',
    'password': 'foo',
    'database': 'tp4db'
}

@app.route('/')
def index():
    # Open connection per-request (simple and fixes the F5 error)
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM myTable")
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('index.html', data=data)

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
