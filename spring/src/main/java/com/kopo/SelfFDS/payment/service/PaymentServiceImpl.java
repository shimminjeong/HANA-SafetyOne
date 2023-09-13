package com.kopo.SelfFDS.payment.service;

import com.kopo.SelfFDS.payment.model.dao.PaymentMapper;
import com.kopo.SelfFDS.member.model.dto.*;
import com.kopo.SelfFDS.payment.model.dao.PaymentMapper;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

        String regionName=null;

        String[] parts = address.split(" ");

        if ("경기".equals(parts[0])) {
            regionName = "경기도";
        }
        if ("서울".equals(parts[0])) {
            regionName = "서울특별시";
        }
        if ("인천".equals(parts[0])) {
            regionName = "인천광역시";
        }
        if ("강원특별자치도".equals(parts[0])) {
            regionName = "강원도";
        }
        if ("대전".equals(parts[0])) {
            regionName = "대전광역시";
        }
        if ("충북".equals(parts[0])) {
            regionName = "충청북도";
        }
        if ("충남".equals(parts[0])) {
            regionName = "충청남도";
        }
        if ("부산".equals(parts[0])) {
            regionName = "부산광역시";
        }
        if ("울산".equals(parts[0])) {
            regionName = "울산광역시";
        }
        if ("대구".equals(parts[0])) {
            regionName = "대구광역시";
        }
        if ("경북".equals(parts[0])) {
            regionName = "경상북도";
        }
        if ("경남".equals(parts[0])) {
            regionName = "경상남도";
        }
        if ("전남".equals(parts[0])) {
            regionName = "전라남도";
        }
        if ("광주".equals(parts[0])) {
            regionName = "광주광역시";
        }
        if ("전북".equals(parts[0])) {
            regionName = "전라북도";
        }
        if ("제주특별자치도".equals(parts[0])) {
            regionName = "제주도";
        }
        String pretime = paymentLog.getTime();
        String[] timeParts = pretime.split(" ");
        String time = timeParts[1].split(":")[0];

        if (timeParts[0].equals("오후")) {
            int pretimeInt = Integer.parseInt(time);
            pretimeInt += 12;

            // 24시인 경우 12로 바꾸기 (오후 12시는 12로 표시됩니다)
            if (pretimeInt == 24) {
                pretimeInt = 12;
            }

            time = Integer.toString(pretimeInt);
        }


        String categorySmall = paymentLog.getCategory();
        System.out.println(cardId+' '+time + ' ' + regionName + ' ' + categorySmall);
        return paymentMapper.checkSafetyRule(cardId, regionName, time, categorySmall);

    }


    //    cardid별로 selfrule가져옴
    @Override
    public List<SafetyCard> selectSafetyRuleByCardId(String cardId) {
        List<SafetyCard> ff=paymentMapper.selectSafetyRuleByCardId(cardId);
        return paymentMapper.selectSafetyRuleByCardId(cardId);
    }

//    selfruel과 결제내역과 비교
//    @Override
//    public String requestPayment(PaymentLog paymentLog, String cardId) {
//        List<SafetyCard> safetyRuleList=selectSafetyRuleByCardId(cardId);
//        for (SafetyCard safetyRule : safetyRuleList){
//            safetyRule.setRegionName();
//
//        }
//        return null;
//    }


}
