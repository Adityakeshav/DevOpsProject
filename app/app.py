from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, this is my DevOps project where I am allocating and provisioning my resources via Terraform on Azure, and building my Flask application into a Docker image and pushing it to Docker Hub. For CI/CD, I am using GitHub Actions.'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)