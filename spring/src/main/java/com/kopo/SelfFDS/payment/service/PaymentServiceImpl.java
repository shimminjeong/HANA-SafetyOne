package com.kopo.SelfFDS.payment.service;

import com.kopo.SelfFDS.payment.model.dao.PaymentMapper;
import com.kopo.SelfFDS.member.model.dto.*;
import com.kopo.SelfFDS.payment.model.dao.PaymentMapper;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
public class PaymentServiceImpl implements PaymentService {

    private PaymentMapper paymentMapper;

    @Autowired
    public PaymentServiceImpl(PaymentMapper paymentMapper) {
        this.paymentMapper = paymentMapper;
    }

    @Override
    public List<PaymentLog> getAllPaymentLog() {
        return paymentMapper.getAllPaymentLog();
    }

    @Override
    public List<PaymentLog> getAllPaymentLogByPaymentapproval(String paymentApprovalStatus) {
        return paymentMapper.getAllPaymentLogByPaymentapproval(paymentApprovalStatus);
    }

    @Override
    public List<PaymentLog> getAllPaymentLogByFdsDetection(String fdsDetectionStatus) {
        return paymentMapper.getAllPaymentLogByFdsDetection(fdsDetectionStatus);
    }

    @Override
    public SafetyCard requestPayment(PaymentLog paymentLog, String cardId) {

        String address = paymentLog.getAddress();
        System.out.println("address"+address);

        String regionName = address.split(" ")[0];


        String pretime = paymentLog.getTime();
        String time = pretime.split(":")[0];
        String paymentDate=paymentLog.getPaymentDate();

        String categorySmall = paymentLog.getCategorySmall();
        System.out.println(cardId+' '+time + ' ' + regionName + ' ' + categorySmall);
        return paymentMapper.checkSafetyRule(cardId, regionName, time, categorySmall);

    }


    //    cardid별로 selfrule가져옴
    @Override
    public List<SafetyCard> selectSafetyRuleByCardId(String cardId) {
        List<SafetyCard> ff=paymentMapper.selectSafetyRuleByCardId(cardId);
        return paymentMapper.selectSafetyRuleByCardId(cardId);
    }

    @Override
    @Transactional
    public void insertApprovalTransaction(PaymentLog paymentLog) {

        //결제로그에 insert
        paymentMapper.insertPaymentLog(paymentLog);

        //거래내역에 insert
        paymentMapper.insertCardHistory(paymentLog);

    }

    @Override
    public void insertNotApprovalTransaction(PaymentLog paymentLog) {
        paymentMapper.insertPaymentLog(paymentLog);
    }


}
