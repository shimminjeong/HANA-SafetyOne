from typing import List
from pydantic import BaseModel
from learning import train_gmm_model
from load_gmm import anomalyDetection_gmm
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
    
class WordToVec(BaseModel):
    categorySmallNumeric : float
    timeNumeric : int
    regionNameNumeric : int
    amountNumeric : int
    
class PaymentLog(BaseModel):
    cardId: str
    wordToVec: WordToVec
    

@app.post('/train')
def train(request:Fds):
    print(request)
    print(request.cardId)
    result = train_gmm_model(request.cardId)
    return result

@app.post('/anomalyDetection')
def train(request:PaymentLog):
    word_to_vec_list = [
        request.wordToVec.categorySmallNumeric,
        request.wordToVec.timeNumeric,
        request.wordToVec.regionNameNumeric,
        request.wordToVec.amountNumeric
    ]
    print("request",request)
    print("request.cardId",request.cardId)
    print("request.wordToVec",request.wordToVec)
    print("word_to_vec_list",word_to_vec_list)
    result = anomalyDetection_gmm(request.cardId,word_to_vec_list)
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
