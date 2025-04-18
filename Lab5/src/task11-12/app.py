from flask import Flask
import socket
import os

app = Flask(__name__)

@app.route('/')
def container_info():
    # Get container IP
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    # Get student name from environment variable
    student_name = os.getenv('STUDENT_NAME', 'Rincewind')
    return f"Container IP: {ip_address} Student: {student_name}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
