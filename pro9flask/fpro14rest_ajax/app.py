from flask import Flask, render_template, request, redirect, url_for, jsonify
import pymysql

app = Flask(__name__);

@app.route("/")
def main():
    return render_template("main.html");

@app.get("/legacy")
def legacy_f():
    pass    # 생략

@app.get("/async")
def async_f():
    pass    # 생략

@app.get("/fetch")
def fetch_f():
    return render_template("show3.html")

@app.get("/axios")
def axios_f():
    return render_template("show4.html")

@app.get("/api/sangdata")
def sangdata():
    conn = pymysql.connect(
        host="localhost",
        user="root",
        passwd="123",
        database="test",
        charset="utf8"
    )

    cur = conn.cursor()
    cur.execute("select code, sang, su, dan from sangdata")
    colums = [col[0] for col in cur.description]  # 컬럼명 얻기
    rows = cur.fetchall()
    result = [dict(zip(colums, row)) for row in rows]  # [{'code': 1, 'sang': '장갑', 'su': 3, 'dan': 10000}, {'code': 2, 'sang': '벙어리장갑', 'su': 2, 'dan': 12000}, {'code': 3, 'sang': '가죽장갑', 'su': 10, 'dan': 50000}, {'code': 4, 'sang': '가죽점퍼', 'su': 5, 'dan': 650000}, {'code': 5, 'sang': '물티슈', 'su': 3, 'dan': 1000}]
    print(result)
    cur.close()
    conn.close()

    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000);