from flask import Flask, request
from os import environ

app = Flask(__name__)

@app.post("/login")
def post_login():
    userid = request.json.get("operatorID")
    passwd = request.json.get("password")




if __name__ == "__main__":
    app.run()