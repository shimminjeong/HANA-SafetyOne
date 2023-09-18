
from pydantic import BaseModel
from learning import train_gmm_model
import fastapi
from fastapi.middleware.cors import CORSMiddleware

app = fastapi.FastAPI()

origins = [
    "*"
]

app.add_middleware(CORSMiddleware, allow_origins=origins, allow_credentials=True,
                   allow_methods=["*"], allow_headers=["*"])

class Fds(BaseModel):
    cardId: str


@app.post('/train')
def train(request:Fds):
    print(request)
    print(request.cardId)
    result = train_gmm_model(request.cardId)
    return result

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)


# from flask import Flask

# app = Flask(__name__)

# @app.route('/')
# @app.route('/home')
# def home():
#     return 'Hello, World!'

# @app.route('/user')
# def user():
#     return 'Hello, User!'

# if __name__ == '__main__':
#     app.run(debug=True)
