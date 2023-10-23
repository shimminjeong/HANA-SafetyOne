import pickle
import numpy as np

def anomalyDetection_gmm(card_id, data_to_check):
    """
    주어진 GMM 모델과 임계치 데이터를 사용하여 data_to_check가 이상치인지 판별합니다.
    
    Parameters:
    - model_path: GMM 모델이 저장된 경로
    - threshold_data: 이상치 판별을 위한 임계치 데이터
    - data_to_check: 판별하려는 데이터
    
    Returns:
    - True or False: 이상치인지 아닌지의 여부
    """
    
    model_path = f'gmm_{card_id}.pkl'
    data_to_check=np.array(data_to_check)
    print("data_to_check",data_to_check)
    
    # 모델 불러오기
    with open(model_path, 'rb') as model_file:
        loaded_gmm = pickle.load(model_file)
        
    X_outlier_threshold = np.array([0.8, 150, 20, 500000])
    X_outlier_th_likeli = loaded_gmm.score_samples(X_outlier_threshold.reshape(1,-1))
    
    print("threshold_likeli",X_outlier_th_likeli)
    # data_to_check의 likelihood 계산 후 임계치와 비교
    data_likeli = loaded_gmm.score_samples(data_to_check.reshape(1,-1))
    print("data_likeli",data_likeli)
    is_anomaly="N";
    if (data_likeli < X_outlier_th_likeli):
        is_anomaly="Y"
    print("result",is_anomaly)
    return is_anomaly

