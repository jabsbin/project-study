from flask import Flask, render_template, request

app = Flask(__name__);

@app.route("/")# 브라우저에서 메인 주소('/')로 들어오는 요청을 받음
def index():
    return render_template("index.html"); # 서버에서 HTML을 완성한 후 클라이언트에 전송
    # (모든 변수와 조건문·반복문 계산이 끝나 최종 완성된 HTML 텍스트를 웹 브라우저로 전송)

@app.route("/get_form")
def get_form():
    return render_template("get_form.html");

@app.route("/get_result")
def get_result():
    name = request.args.get("username")  # get방식 요청 자료 받기
    age = request.args.get("age")   # '23' 문자 타입으로만 받기
    age = age + "살";
    return render_template("get_result.html", name=name, age=age)
    # get 방식인 경우 args 사용

@app.route("/post_form")
def post_form():
    return render_template("post_form.html");

@app.route("/post_result", methods=['POST'])
def post_result():
    name = request.form.get("username")
    email = request.form.get("email")
    return render_template("post_result.html", name=name, email=email)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000);

# 쿠키는 클라이언트에 저장된 것, 만료일이 있어 일정 기간이나 시간이 지나면 자동삭제, 사용자가 직접보고 조작 가능해서 보안 취약
# 세션은 서버에 저장된 것, 중요 정보는 서버에 두고 세션 ID만 클라이언트에 보내 안전.