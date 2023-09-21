package com.kopo.SelfFDS.admin.model.dao;

import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.model.dto.CardStats;
import com.kopo.SelfFDS.admin.model.dto.Fds;
import com.kopo.SelfFDS.admin.model.dto.MemberStats;
import com.kopo.SelfFDS.member.model.dto.LostCard;
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

    List<PaymentLog> getAllAnomalyData();

    PaymentLog getAnomalyDataById(int paymentLogId);

    Fds getFdsStatsByCardId(String cardId);

    List<CardHistoryStats> getRegionGroupCntByCardId(String cardId);
    List<CardHistoryStats> getCategoryGroupCntByCardId(String cardId);

    List<LostCard> selectAllLostCard();

    List<String> selectLostReason();


}
