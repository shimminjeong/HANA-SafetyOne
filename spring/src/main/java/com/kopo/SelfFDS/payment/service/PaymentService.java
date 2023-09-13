package com.kopo.SelfFDS.payment.service;

import com.kopo.SelfFDS.member.model.dto.*;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;

import java.util.HashMap;
import java.util.List;

public interface PaymentService {

    List<PaymentLog> getAllPaymentLog();

    List<PaymentLog> getAllPaymentLogByPaymentapproval(String paymentApprovalStatus);

    List<PaymentLog> getAllPaymentLogByFdsDetection(String fdsDetectionStatus);

    SafetyCard requestPayment(PaymentLog paymentLog, String cardId);

    List<SafetyCard> selectSafetyRuleByCardId(String CardId);
}
