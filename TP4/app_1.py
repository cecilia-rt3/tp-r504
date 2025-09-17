from flask import Flask, render_template
import mysql.connector

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host="tp4-mysql",   # nom du conteneur MySQL (même réseau Docker)
        port=3306,
        user="root",
        password="foo",
        database="tp4db"
    )

@app.route("/")
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT id, name FROM myTable")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("index.html", persons=rows)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

