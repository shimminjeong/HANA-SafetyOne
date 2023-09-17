package com.kopo.SelfFDS.payment.model.dao;

import com.kopo.SelfFDS.member.model.dto.SafetyCard;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PaymentMapper {

    List<PaymentLog> getAllPaymentLog();
    List<PaymentLog> getAllPaymentLogByPaymentapproval(String paymentApprovalStatus);
    List<PaymentLog> getAllPaymentLogByFdsDetection(String fdsDetectionStatus);
    List<SafetyCard> selectSafetyRuleByCardId(String cardId);


    SafetyCard checkSafetyRule(@Param("cardId") String cardId,@Param("regionName") String regionName,@Param("time") String time,  @Param("categorySmall") String categorySmall);

    void insertCardHistory(PaymentLog paymentLog);

    void insertPaymentLog(PaymentLog paymentLog);

    double selectPreprocessingCategory(String categorySmall);
    int selectPreprocessingRegion(String regionName);

}
