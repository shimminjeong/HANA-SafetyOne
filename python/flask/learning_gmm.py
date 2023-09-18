import cx_Oracle
import pandas as pd
import os
import numpy as np
from sklearn.mixture import GaussianMixture
import pickle



def train_gmm_model(card_id):
    connection = cx_Oracle.connect(user='scott', password='tiger', dsn='192.168.119.119:1521/dink11.dbsvr')
    
    cursor = connection.cursor()
    sql=f"select * from cardhistory where cardId='{card_id}'"
    cursor.execute(sql)
    rows = cursor.fetchall()

    columns = ['cardHisId','cardId', 'categoryBig', 'categorySmall','regionName', 'store', 'cardHisDate', 'cardHisTime', 'amount']
    data = pd.DataFrame(rows, columns=columns)
    

    sql="select regionName, SEOULTTOREGIONDISTANCE from region"
    cursor.execute(sql)
    rows = cursor.fetchall()
    columns = ['regionName','seoulTorReionDistance']
    region = pd.DataFrame(rows, columns=columns)


    sql="select categorySmall, barToEmbedding from category"
    cursor.execute(sql)
    rows = cursor.fetchall()
    columns = ['categorySmall','barToEmbedding']
    category = pd.DataFrame(rows, columns=columns)

    data['categorySmall'] = data['categorySmall'].replace(category.set_index('categorySmall')['barToEmbedding'])
    data['regionName'] = data['regionName'].replace(region.set_index('regionName')['seoulTorReionDistance'])
    data['cardHisTime'] = data['cardHisTime'].str.split(':').str[0].astype(int)
    
    n_components = 1
    GMM_columns = ['categorySmall', 'regionName', 'cardHisTime', 'amount']
    gmm = GaussianMixture(n_components=n_components)
    X = data[GMM_columns].values 
    gmm.fit(X)
    
    means=gmm.means_
    covariances=gmm.covariances_
    
    categorySmall=str(means[0,0])+','+str(covariances[0,0,0])
    regionName=str(means[0,1])+','+str(covariances[0,1,1])
    cardHisTime=str(means[0,2])+','+str(covariances[0,2,2])
    amount=str(means[0,3])+','+str(covariances[0,3,3])
    print(categorySmall)
    print(regionName)
    print(cardHisTime)
    print(amount)
    
    sql="update fds set CATEGORYSMALLSTATS=:1 where cardid=:2";
    cursor.execute(sql,(categorySmall,card_id));
    sql="update fds set REGIONSTATS=:1 where cardid=:2";
    cursor.execute(sql,(regionName,card_id));
    sql="update fds set TIMESTATS=:1 where cardid=:2";
    cursor.execute(sql,(cardHisTime,card_id));
    sql="update fds set AMOUNTSTATS=:1 where cardid=:2";
    cursor.execute(sql,(amount,card_id));
    
    model_file_path = f'gmm_{card_id}.pkl'
    sql="update fds set WEIGHTSAVEPATH=:1 where cardid=:2";
    cursor.execute(sql,(model_file_path,card_id));
    

    connection.commit()
    cursor.close()
    connection.close()  

    

    

    with open(model_file_path, 'wb') as model_file:
        pickle.dump(gmm, model_file)

    print(f"GMM 모델이 {model_file_path}에 저장되었습니다.")
    
    return "GMM 모델이 {model_file_path}에 저장되었습니다."

card_id = '9440-9469-2724-7629'
train_gmm_model(card_id)