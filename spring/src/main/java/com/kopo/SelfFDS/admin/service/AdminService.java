package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.model.dto.*;
import com.kopo.SelfFDS.member.model.dto.LostCard;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.model.dto.SafetyCard;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;

import java.util.List;
import java.util.Map;

public interface AdminService {

//    adminmain
    int getAllMemberCnt();
    int getAllCardCnt();
    int getAllAmountSumOfDay();

    List<MemberStats> getMemberCntByYear();
    List<CardStats> getCardCntByYear();
    List<CardHistoryStats> getAmountSumByDate();

    double getMemberCntByYearRate();
    double getCardCntByYearRate();
    double getAmountSumByDateRate();

//    fds
    List<Fds> selectFdsAndMember();

    List<PaymentLog> getAllAnomalyData();

    PaymentLog getAnomalyDataById(int paymentLogId);

    Map<String, Object> calStats(String cardId);

    List<List<Double>> statsToPdf(double mean, double stdDev);

    double[] linspace(double start, double end, int points);

    List<CardHistoryStats> getRegionGroupCntByCardId(String cardId);
    List<CardHistoryStats> getCategoryGroupCntByCardId(String cardId);

    List<LostCard> selectAllLostCard();

    List<String> selectLostReason();

    List<Cluster> selectClusterStatic();

    List<Cluster> selectClusterPeopleInfo(String clusterNum);
    List<Cluster> selectClusterDetail(String clusterNum);

    Cluster selectClusterStatic2ByCluster(String clusterNum);
    List<Cluster> selectClusterStatic2();

    List<Member> selectMemberInfoByClusterNum(String clusterNum);

    List<String> selectClusterNum();

    List<String> selectEmailByCluster(String clusterNum);

    List<Member> selectClusterMemberInfo();
    List<PaymentLog> getAllPaymentData();

    List<PaymentLog> getNotApprovalData();


    int selectFdsCardCount();
    int selectSafetyCardCount();
    int selectFdsDataCount();
    int selectSafetyDataCount();

    int selectFdsUserCount();
    int selectSafetyUserCount();

    List<SafetyCard> selectSafetyAndMember();

    int selectFdsCountByCardId(String cardId);

    int selectSafetyCountByCardId(String cardId);

    int selectClusterCount();

    void clusterUpdate();

}
