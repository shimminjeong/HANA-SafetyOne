#%
import os
import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import tqdm
import cx_Oracle

def train_cluster():

    connection = cx_Oracle.connect(user='scott', password='tiger', dsn='192.168.119.119:1521/dink11.dbsvr')
    cursor = connection.cursor()
    sql="select categorySmall, convenienceToEmbedding from CATEGORYembedding"
    cursor.execute(sql)
    rows = cursor.fetchall()
    columns = ['categorySmall','convenienceToEmbedding']
    category = pd.DataFrame(rows, columns=columns)

    sql="SELECT c.email as email,ch.categorySmall, ch.amount FROM cardhistory ch JOIN card c ON ch.cardid = c.cardid WHERE ch.cardhisdate >= TO_DATE('2023-07-07', 'YYYY-MM-DD')"
    cursor.execute(sql)
    rows = cursor.fetchall()
    columns = ['email','categorySmall','amount']
    data = pd.DataFrame(rows, columns=columns)
    data['categoryEmbedding'] = data['categorySmall'].replace(category.set_index('categorySmall')['convenienceToEmbedding'])
    userList=data['email'].unique()

    mode_card_df = {'email': [], 'categorySmall' : [], 'embedding_mode' : [],'amount':[]}
    for i, userId in tqdm.tqdm(enumerate(userList)):
        '''
        _df : 카드 거래 내역 중 카드번호 같은 것 끼리 모은 임시 df
        mean_card_df : 카드번호 같은 것들 중, 최빈값 업종을 뽑아서 대표 업종으로 만든 df
        '''
        _df = data[data['email']==userId][['categorySmall', 'categoryEmbedding','amount']]
        # print(_df)
        # print(_df['categorySmall'].mode().iloc[0])
        # print(_df['amount'].mean())

        mode_card_df['email'].append(userId)
        mode_card_df['categorySmall'].append(_df['categorySmall'].mode().iloc[0])
        mode_card_df['embedding_mode'].append(_df['categoryEmbedding'].mode().iloc[0])
        mode_card_df['amount'].append(_df['amount'].mean())
        
    # mode_card_df = pd.DataFrame(mode_card_df)
    # print(mode_card_df)
    print(len(mode_card_df['email']))
    print(len(mode_card_df['categorySmall']))
    print(len(mode_card_df['amount']))
    mode_card_df = pd.DataFrame(mode_card_df)
    mode_card_df['amount'] = mode_card_df['amount'].astype(int)

    from sklearn.cluster import KMeans

    n_clusters = 5
    X = np.array(list(zip(mode_card_df['embedding_mode'].values, mode_card_df['amount'].values)))
    print(X.shape)

    kmeans = KMeans(n_clusters=n_clusters)
    kmeans.fit(X)
    cluster_labels = kmeans.labels_
    print(len(cluster_labels))
    mode_card_df['Cluster'] = cluster_labels
    mode_card_df['Cluster']=mode_card_df['Cluster'].astype(str)


    insertSql="INSERT INTO clusterTable (email,clusterNum) values(:1,:2)"
    for i in range(len(mode_card_df)):
        cursor.execute(insertSql, (mode_card_df.loc[i,'email'],mode_card_df.loc[i,'Cluster']))
    connection.commit()
    cursor.close()
    connection.close()
    
    return "clusterInfo update"