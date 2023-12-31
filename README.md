# SafetyOne-부정사용거래를 줄이기 위한 통합관리 서비스

# 1. 프로젝트 소개

### 1-1. 기획배경
• 신용카드 부정사용 5년간 11.6만건 발생.<br/>
• 부정거래금액에 대한 보상은 곧 카드사의 손실로 이어짐.<br/>
• 부정거래가 일어날 경우의 수를 줄여 카드사의 손실을 줄인다면 장기적으로 이는 카드사의 이익으로 이어질 것으로 기대함.<br/>

<img src="img/outline.png"/> <br/></br>

### 1-2. 목표
#### 부정사용거래를 줄이기 위한 사전, 사후 통합 관리 서비스
• 안심서비스 (사전) : 안심서비스로 본인만의 Rule을 설정하여 Rule에 해당하는 거래는 사전에 차단되어 부정거래 가능성을 사전에 예방. <br/>
• 이상소비알림서비스 (사후) : 이상소비 알림 서비스로 평소의 거래패턴과 다를 경우 고객에게 실시간으로 알림 메시지를 전송하여 부정사용의 연속적인 발생을 방지. <br/>

<img src="img/goal.png"/> <br/></br>



### 1-3. 개발환경

```
OS : Window 10
Framework : Spring Boot, FastAPI
Server : tomcat9
Tool : Intellij, VSCode, Sql Developer, Github
DBMS : Oracle DBMS
```

</br>

### 1-4. 수행기간

개발기간: 2022.09.01 - 2022.10.20 <br/>

<img src="img/chart.png"/> <br/></br>


# 2. 주요기능

### 2-1. 사용자기능

• 안심서비스 (SafetyOne 사전 서비스) :<br/>
  사용자는 개인별로 거래를 허용하거나 차단할 본인만의 Rule을 설정.<br/>
  승인 요청이 들어오는 거래가 설정된 Rule과 일치할 경우 거래는 미승인.<br/>
  서비스 일시정지 : 안심 Rule 차단 항목 중 일정기간동안 거래를 허용하도록 서비스 일시정지 <br/><br/>
  
• 이상소비알림서비스 (SafetyOne 사후 서비스) :<br/>
  사용자가 서비스를 신청하면, 최근 6개월 동안의 카드 거래 내역을 학습하여 가중치를 저장.</br>
  사용자가 카드 결제하여 정상 승인이 난 이후 해당 결제 내역이 평소 거래 패턴과 다를 경우, 실시간 알림 메시지 전송.</br><br/>
  
• 분실/도난 신고 : <br/>
  카드 분실신고 및 재발급 동시에 신청 가능.<br/><br/>
  
• 소비레포트 : <br/>
  사용자의 거래내역을 활용하여 이번달의 소비 변화와 3개월동안 카테고리별 사용금액과 결제빈도, 결제 시간 및 지역별 지출 금액 확인 가능. </br><br/>

#### <strong>결제</strong>
  안심서비스, 이상소비알림서비스 각각 신청에 따라 결제할 때 거래승인 여부와 이상소비 탐지 여부 확인.<br/></br>

<img src="img/user.png"/> <br/>

#### 결제 흐름도
<img style="width:100%;" src="img/payment.png"/> <br/>


### 2-2. 관리자기능

• 군집분석 :<br/>
  하나카드 전체 사용자 소비데이터 확인.<br/>
  군집 별 특징 확인<br/><br/>
  
• 이메일 전송 :<br/>
  군집분석의 결과를 활용하여 군집 변 안심서비스 추천 메일 전송.<br/><br/>

• 이상소비알림서비스 관리 :<br/>
이상소비내역 확률분포 시각화 및 서비스 사용자, 이상소비내역 관리.<br/><br/>

• 안심서비스 관리 :<br/>
안심서비스 사용자 및 미승인 내역 관리.<br/><br/>

• 분실/도난 신고 관리 :<br/>
분실카드 사유별로 확인 가능.<br/><br/>

• 결제로그 관리 :<br/>
일자별 카드별 결제로그 확인 가능.<br/><br/>
  
<img src="img/admin.png"/> <br/><br/>



# 3. 프로젝트 구성도

### 3-1. 시스템 아키텍처

<img src="img/architecture.png"/> <br/></br>


### 3-2. ERD

<img src="img/erd.png"/> <br/></br>




# 4. 적용기술
</br>
• Spring MVC 기반 웹 어플리케이션 제작<br/>
• Python Faker Library 활용한 가상의 대용량 데이터 생성<br/>
• Python Scikit-Learn K-means clustering을 활용한 군집분석<br/>
• Python Scikit-Learn GMM 모델을 활용한 이상탐지 API 개발<br/>
• Simple & Easy Notification Service를 통한 SMS 본인인증, 알림메시지 전송<br/>
• Kakao Map API를 활용하여 오프라인 결제 가맹점명 검색<br/>
• Java Mail Sender를 활용한 안심서비스 추천 메일 전송<br/>
• M-VIEW, INDEX를 활용한 성능개선<br/></br>

### 4-1. 대용량 데이터 생성
<img src="img/generateData.png"/> <br/></br>

### 4-2. 성능개선
<img src="img/performance.png"/> <br/></br>

### 4-3. 적용된 특화 기술
<img src="img/specialTech.png"/> <br/></br>

### 4.4 그 외 적용 기술
<img src="img/tech.png"/> <br/></br>


## 발표 ppt
[발표자료<img src="img/main.png"/>](/SafetyOne_심민정.pdf) <br/><br/>

## 시연 동영상
<a href="https://youtu.be/Zn69_DVyPl4"><img src="img/mainPage.png"></a><br/>
 *사진을 누르시면 영상 유튜브 사이트로 이동합니다
</br></br>

## 본인 소개

| 구분 | 내용 | 비고 |
|---------|-----------------------------------|-------------------------------|
| 이름                          | 심민정                                                                                       | <img src="img/profile.jpg" width="80">        |
| 이메일                         | pooh5045@naver.com                                                                             |      
| 학력사항                        | 광운대학교 정보융합학부 데이터사이언스전공                                                        | 2022.02                               |
| Frontend skill               | HTML, CSS, Javascript                                                                         |                                            |
| Backend skill                | Java,Python, SpringBoot, Oracle                                                                          |              
| 자격증                         | 데이터분석 전문가(ADP) 필기                                                                  | 2022. 02. 26                        |
|                          | 빅데이터분석기사                                                                  | 2021. 12. 31                           |
|                       | 정보처리기사                                                             | 2020. 12. 31                            |
|                         | SQL 개발자(SQLD)                                                             | 2020. 09 .25                           |
|                     | 데이터분석 준전문가(ADsP)                                                                 | 2020. 08. 29                             |
|                    | 리눅스마스터 2급                                                                  | 2019. 10. 11                            |
| 교육활동                       | 하나금융티아이 채용전환형 교육 1200시간</br>(한국폴리텍대학교 광명융합기술교육원 - 데이터분석과) | 2023.03.02 ~ 2023.10.20 (1200시간)         |       
| 경력사항                       |코오롱베니트 (인턴)                                                | 2022.07 ~ 2022.09 (3개월)          |
|                        |슈어소프트테크 (인턴)                                                | 2022.03 ~ 2022.06 (4개월)          |
