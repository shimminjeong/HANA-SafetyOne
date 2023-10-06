package com.kopo.SelfFDS.admin.model.dao;

import com.kopo.SelfFDS.admin.model.dto.*;
import com.kopo.SelfFDS.member.model.dto.LostCard;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.model.dto.SafetyCard;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface AdminMapper {

    int getAllAmountSumOfDay();

    List<MemberStats> getMemberCntByYear();
    List<CardStats> getCardCntByYear();
    List<CardHistoryStats> getAmountSumByDate();

    List<Fds> selectFdsAndMember();
    List<SafetyCard> selectSafetyAndMember();

    List<PaymentLog> getAllAnomalyData();
    List<PaymentLog> getNotApprovalData();

    PaymentLog getAnomalyDataById(int paymentLogId);

    Fds getFdsStatsByCardId(String cardId);

    List<CardHistoryStats> getRegionGroupCntByCardId(String cardId);
    List<CardHistoryStats> getCategoryGroupCntByCardId(String cardId);

    List<LostCard> selectAllLostCard();

    List<String> selectLostReason();

//    cluster
    List<Cluster> selectClusterStatic();
    List<Cluster> selectClusterPeopleInfo(String clusterNum);
    Cluster selectClusterStatic2ByCluster(String clusterNum);
    List<Cluster> selectClusterStatic2();

    List<Cluster> selectClusterDetail(String clusterNum);

    List<Member> selectMemberInfoByClusterNum(String clusterNum);

    List<Member> selectClusterMemberInfo();
    List<String> selectClusterNum();
    List<String> selectEmailByCluster(String clusterNum);

    List<PaymentLog> getAllPaymentData();


    int selectFdsCardCount();
    int selectSafetyCardCount();
    int selectFdsDataCount();
    int selectSafetyDataCount();
    int selectFdsUserCount();
    int selectSafetyUserCount();

    int selectFdsCountByCardId(String cardId);
    int selectSafetyCountByCardId(String cardId);

    int selectClusterCount();

}
