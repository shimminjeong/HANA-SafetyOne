#%
import os
import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import tqdm
import fasttext
import fasttext.util
#%
file_path = './category.csv'
df = pd.read_csv(file_path, encoding='UTF8')
print(df)
print(df['SMALL'])
df = df.set_index(keys='CODE')

#%
from gensim import models

ko_model = models.fasttext.load_facebook_model('cc.ko.300.bin')
#%
for w, sim in ko_model.wv.similar_by_word('파이썬', 10):
    print(f'{w}: {sim}')
    
#%
ko_model.wv.vectors.shape


#%
# 한글 폰트 사용을 위해서 세팅
from matplotlib import font_manager, rc
font_path = "C:/Windows/Fonts/NGULIM.TTF"
font = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font)

#%
#임베딩 한 300차원의 벡터를 PCA 사용해서 2차원 벡터로 축소
from sklearn.decomposition import PCA

words = df['MIDDLE'].tolist()[:]
print(words)
pca = PCA(n_components=2)

xys = pca.fit_transform([ko_model.wv.word_vec(w) for w in words])
xs = xys[:,0]
ys = xys[:,1]

plt.figure(figsize=(15, 15))
plt.scatter(xs, ys, marker='o',s=0.2)
for i, v in enumerate(words):
    plt.annotate(v, xy=(xs[i], ys[i]),fontsize=5)
    
df['embedding_x'] = xs
df['embedding_y'] = ys
print(df)

#%
#카드끼리 묶음.

file_path = './minjeong.csv'
card_df = pd.read_csv(file_path, encoding='UTF8')
print(card_df.head())
print(len(card_df))


#%
print(card_df['카드번호'].unique())
print(len(card_df['카드번호'].unique()))

card_IDs = card_df['카드번호'].unique()
#%
mean_card_df = {'카드번호': [], 'embedding_x_mean' : [], 'embedding_y_mean' : [], '거래금액': []}

for i, card_ID in tqdm.tqdm(enumerate(card_IDs)):
    _df = card_df[card_df['카드번호']==card_ID][['category_id', '거래금액']]
    # print(_df['category_id'].tolist())
    # print(df.head())
    # print(df.loc[['hb011','hb012']])
    # print(df.loc[_df['category_id']]['embedding_x'].mean())
    mean_card_df['카드번호'].append(card_ID)
    mean_card_df['embedding_x_mean'].append(df.loc[_df['category_id']]['embedding_x'].mean())
    mean_card_df['embedding_y_mean'].append(df.loc[_df['category_id']]['embedding_y'].mean())
    mean_card_df['거래금액'].append(_df['거래금액'].mean())
    # print(mean_card_df)

mean_card_df = pd.DataFrame(mean_card_df)
print(mean_card_df)
    # print(len(df))

# #%
# j = 0
# for i, card_ID in enumerate(card_df['카드번호']):
#     if card_df
# #%

#%
# 임베딩 벡터와 카드 번호 별로 저장
mean_card_df.to_csv('./SMALL_embedding_mean.csv') 


#%
# k-means
from sklearn.cluster import KMeans

n_clusters = 3
X = mean_card_df[['embedding_x_mean', 'embedding_y_mean', '거래금액']].values
kmeans = KMeans(n_clusters=n_clusters)
kmeans.fit(X)
cluster_labels = kmeans.labels_
mean_card_df['Cluster'] = cluster_labels
print(mean_card_df)

#%
#GMM
#여기서는 클러스터에 해당하는 각 카드의 결제내역을 모두 넣고 진행. 시간, 지역, 거래금액, 업종까지. 업종도 해시테이블 해야함(나중에 플랏 필요)
from sklearn.mixture import GaussianMixture

n_components = 3
GMM_columns = ['embedding_x_mean', 'embedding_y_mean', '거래금액']
gmm = GaussianMixture(n_components=n_components)

for i in range(n_clusters):
    X = mean_card_df[mean_card_df['Cluster'] == i][GMM_columns].values 
    gmm.fit(X)
    likelihoods = gmm.score_samples(X)
    plt.plot(likelihoods)
    plt.show()

    
#%
