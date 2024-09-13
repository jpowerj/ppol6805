from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
@app.route("/hack")
def hacker_detected():
    return "<p>Hacker detected, pls stop</p>"
