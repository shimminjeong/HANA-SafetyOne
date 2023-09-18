import pickle
import numpy as np

def check_outlier_using_gmm(model_path, threshold_data, data_to_check):
    """
    주어진 GMM 모델과 임계치 데이터를 사용하여 data_to_check가 이상치인지 판별합니다.
    
    Parameters:
    - model_path: GMM 모델이 저장된 경로
    - threshold_data: 이상치 판별을 위한 임계치 데이터
    - data_to_check: 판별하려는 데이터
    
    Returns:
    - True or False: 이상치인지 아닌지의 여부
    """
    
    # 모델 불러오기
    with open(model_path, 'rb') as model_file:
        loaded_gmm = pickle.load(model_file)

    # Threshold likelihood 계산
    threshold_likeli = loaded_gmm.score_samples(threshold_data.reshape(1,-1))
    
    # data_to_check의 likelihood 계산 후 임계치와 비교
    data_likeli = loaded_gmm.score_samples(data_to_check.reshape(1,-1))
    
    return data_likeli < threshold_likeli

# 사용 예시
model_path = 'gmm_model.pkl'
threshold_data = np.array([0.7, 300, 23, 500000])
data_to_check = np.array([0.6, 400, 20, 1000000])

is_anomaly = check_outlier_using_gmm(model_path, threshold_data, data_to_check)
print("Is the data an outlier?", is_anomaly)
