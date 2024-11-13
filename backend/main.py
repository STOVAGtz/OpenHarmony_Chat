from flask import Flask, request, jsonify

friend_list = ["10000","10001","10002","10003","10004","10005"]

app = Flask(__name__)

# 路由: 处理前端传送的 JSON 数据
@app.route('/login', methods=['POST'])
def login():
    # 从请求中获取 JSON 数据
    data = request.get_json()

    # 从 JSON 中提取 username 和 password
    username = data.get('username')
    password = data.get('password')

    # 验证用户名和密码是否存在
    if not username or not password:
        return jsonify({"message": "用户名和密码不能为空"}), 400

    # 这里可以进行用户名和密码的验证，比如查数据库等
    # 为了简单起见，我们假设用户名和密码是 "11" 和 "22"
    if username == "11" and password == "22":
        return jsonify({"message": "登录成功","friend_list":friend_list}), 200
    else:
        return jsonify({"message": "用户名或密码错误"}), 401


if __name__ == '__main__':
    app.run(host = '127.0.0.1', port = '65000',debug=True)
