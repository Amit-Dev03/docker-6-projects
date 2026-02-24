from flask import Flask, render_template
import redis
import os
import socket

app = Flask(__name__)

# Try to connect to Redis (optional)
try:
    redis_client = redis.Redis(host='redis', port=6379, decode_responses=True)
    redis_client.ping()
    redis_connected = True
except:
    redis_connected = False

@app.route('/')
def hello():
    return render_template('index.html', 
                         hostname=socket.gethostname(),
                         redis_connected=redis_connected)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)