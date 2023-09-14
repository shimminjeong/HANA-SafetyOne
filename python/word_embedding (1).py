#%
import os
import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import tqdm
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
# 단어들 간에 유사도 확인
words = df['SMALL'].tolist()[:]
word_embedding = []
for w in words:
    print('편의점-',str(w),': ',ko_model.wv.similarity('편의점', w))
    word_embedding.append(ko_model.wv.similarity('편의점', w))
df['embedding'] = word_embedding
df.head()

#%
#%
#임베딩 한 300차원의 벡터를 PCA 사용해서 2차원 벡터로 축소
# from sklearn.decomposition import PCA

# words = df['MIDDLE'].tolist()[:]
# print(words)
# pca = PCA(n_components=2)

# xys = pca.fit_transform([ko_model.wv.word_vec(w) for w in words])
# xs = xys[:,0]
# ys = xys[:,1]

# plt.figure(figsize=(15, 15))
# plt.scatter(xs, ys, marker='o',s=0.2)
# for i, v in enumerate(words):
#     plt.annotate(v, xy=(xs[i], ys[i]),fontsize=5)
    
# df['embedding_x'] = xs
# df['embedding_y'] = ys
# print(df)

#%
#카드끼리 묶음.

file_path = './minjeong.csv'
card_df = pd.read_csv(file_path, encoding='UTF8')
print(card_df.head())
print(len(card_df))


print(card_df['카드번호'].unique())
print(len(card_df['카드번호'].unique()))

card_IDs = card_df['카드번호'].unique()

# mean_card_df = {'카드번호': [], 'embedding_mod' : [], '거래금액': []}
mode_card_df = {'카드번호': [], '업종' : [], 'embedding_mode' : []}
# add_columns_to_card_df = {'업종_mode' : [], '업종' : [], 'cluster' : []}

for i, card_ID in tqdm.tqdm(enumerate(card_IDs)):
    '''
    _df : 카드 거래 내역 중 카드번호 같은 것 끼리 모은 임시 df
    mean_card_df : 카드번호 같은 것들 중, 최빈값 업종을 뽑아서 대표 업종으로 만든 df
    '''
    _df = card_df[card_df['카드번호']==card_ID][['category_id', '거래금액']]
    
    # print(_df['category_id'].tolist())
    # print(df.head())
    # print(df.loc[['hb011','hb012']])
    # print(df.loc[_df['category_id']]['embedding_x'].mean())
    mode_card_df['카드번호'].append(card_ID)
    mode_card_df['업종'].append(df.loc[_df['category_id']]['SMALL'].mode().iloc[0])
    mode_card_df['embedding_mode'].append(df.loc[_df['category_id']]['embedding'].mode().iloc[0])
    
    # print(df.loc[_df['category_id']]['embedding'].mode().iloc[0])
    # mean_card_df['embedding_y_mean'].append(df.loc[_df['category_id']]['embedding_y'].mean())
    # mean_card_df['거래금액'].append(_df['거래금액'].mean())
    # print(mean_card_df)

mode_card_df = pd.DataFrame(mode_card_df)
print(mode_card_df)
#%
# card_IDs['대표업종'] = card_IDs[card_IDs['카드번호']==mode_card_df['카드번호']]

#%
    # print(len(df))

# #%
# j = 0
# for i, card_ID in enumerate(card_df['카드번호']):
#     if card_df
# #%
#%
print(mode_card_df.head())


#%
# 임베딩 벡터와 카드 번호 별로 저장
mode_card_df.to_csv('./SMALL_embedding_mode.csv') 
#%
df.head()

#%
# k-means 클러스터링, df로 함. category.csv 데이터
from sklearn.cluster import KMeans

n_clusters = 5
# X = mode_card_df[['embedding_x_mean', 'embedding_y_mean', '거래금액']].values
# X = mode_card_df[['embedding_mode']].values
X = df['embedding'].values.reshape(-1,1)


kmeans = KMeans(n_clusters=n_clusters)
kmeans.fit(X)
cluster_labels = kmeans.labels_
# mode_card_df['Cluster'] = cluster_labels
df['Cluster'] = cluster_labels

print(mode_card_df)

#%

#%
# 클러스터 안에 업종들 확인 / 군집 분석
# s = 0
# for i in range(len(mode_card_df['Cluster'].unique())):
#     print(mode_card_df[mode_card_df['Cluster']==i]['업종'].unique())
#     s = s + len(mode_card_df[mode_card_df['Cluster']==i]['업종'].unique())

s = 0
cluster_elements = []
for i in range(n_clusters):
    print(df[df['Cluster']==i]['SMALL'].unique())
    cluster_elements.append(df[df['Cluster']==i]['SMALL'].unique().tolist())
    s = s + len(df[df['Cluster']==i]['SMALL'].unique())

print(s)
print(len(df))
print(cluster_elements)
#%
mode_card_df_per_clusters = []
s = 0
for i in range(n_clusters):
    # print(mode_card_df[mode_card_df['업종'].isin(cluster_elements[i])])
    print(len(mode_card_df[mode_card_df['업종'].isin(cluster_elements[i])]))
    mode_card_df_per_clusters.append(mode_card_df[mode_card_df['업종'].isin(cluster_elements[i])])
    s = s + len(mode_card_df[mode_card_df['업종'].isin(cluster_elements[i])])
print(s)


#%
print(card_df.head())
print(mode_card_df.head())
print(df.head())

#%

add_columns_to_card_df = df.loc[card_df['category_id'], ['SMALL', 'embedding', 'Cluster'] ]
print(add_columns_to_card_df)
print(card_df)
#%
add_columns_to_card_df = add_columns_to_card_df.reset_index(drop=True)
#%
# minjung.csv 에 업종, 업종임베딩, 클러스터 컬럼 추가
card_df['업종'] = add_columns_to_card_df['SMALL']
card_df['embedding'] = add_columns_to_card_df['embedding']
card_df['Cluster'] = add_columns_to_card_df['Cluster']

print(card_df)

#%
# 날짜 컬럼 숫자로 인코딩

print(card_df)

characters_to_remove = '-'
# card_df['거래날짜'] = card_df['거래날짜'].astype(str)
card_df['거래날짜'] = card_df['거래날짜'].str.replace(characters_to_remove, '')
characters_to_remove = ':'
card_df['거래시간'] = card_df['거래시간'].str.replace(characters_to_remove, '')
card_df['시간_numerical'] = card_df['거래날짜'] + card_df['거래시간']
print(card_df)

#%
#%
#GMM
#여기서는 클러스터에 해당하는 각 카드의 결제내역을 모두 넣고 진행. 시간, 지역, 거래금액, 업종까지. 업종도 해시테이블 해야함(나중에 플랏 필요)

#card_df에 컬럼으로 모두 넣어서 합쳐버리는 것은? 업종_mode, 업종, cluster 까지 넣어서

# feature 별로 스케일링 해야할 듯


#최적의 components 수 구하는 코드도 있으면 좋을 것 같긴 함. 밑의 코드
# n_components = np.arange(1, 21)
# models = [GMM(n, covariance_type='full', random_state=0).fit(Xmoon)
#           for n in n_components]

# plt.plot(n_components, [m.bic(Xmoon) for m in models], label='BIC')
# plt.plot(n_components, [m.aic(Xmoon) for m in models], label='AIC')
# plt.legend(loc='best')
# plt.xlabel('n_components')
#

from sklearn.mixture import GaussianMixture

n_components = 5
GMM_columns = ['embedding', '시간_numerical', '거래금액']
# GMM_columns = ['embedding', '거래지역', '거래시간', '거래금액']

gmm = GaussianMixture(n_components=n_components)

for i in range(n_clusters):
    X = card_df[card_df['Cluster'] == i][GMM_columns].values 
    gmm.fit(X)
    likelihoods = gmm.score_samples(X)

#%
print(card_df)

#%
# GMM feature 별로 모수 분포 plot


# Assuming df is your DataFrame and features is a list of feature column names
for i in range(n_clusters):
# for i in range(1):
    for feature in GMM_columns:
        data = card_df[card_df['Cluster'] == i][feature].values.reshape(-1, 1).astype(np.float64)
        # Reshape the data to 2D array
        gmm = GaussianMixture(n_components=n_components)  # You can adjust the number of components as needed
        gmm.fit(data)
        predicted_labels = gmm.predict(data)
        # print(predicted_labels)
        print(data)
        print(len(np.unique(data)))
        print(len(data))
        print(data.min())
        print(data.max())
        
        # Create a range of values for plotting the PDFs
        x = np.linspace(data.min(), data.max(), 1000)

        # Compute the PDF (Probability Density Function) using the GMM
        pdf = np.exp(gmm.score_samples(x.reshape(-1, 1)))
        # Plot the data and the estimated GMM
        plt.figure()
        plt.hist(data, bins=100, density=True, alpha=0.5, color='blue', label='Data Histogram')
        plt.plot(x, pdf, '-r', label='GMM PDF')
        plt.title(f'GMM for {feature}')
        plt.xlabel(feature)
        plt.ylabel('Probability Density')
        plt.legend()
        plt.show()
    
#%
