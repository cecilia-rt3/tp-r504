from flask import Flask, render_template
import mysql.connector

app = Flask(__name__)

# MySQL configuration
db_config = {
    'host': 'tp4-mysql',  # nom du conteneur MySQL
    'user': 'root',
    'password': 'foo',
    'database': 'demosql'
}

@app.route('/')
def index():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM myTable")
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('index.html', data=data)

if __name__ == '__main__':
    app.run(debug=True)

