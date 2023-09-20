package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dto.*;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;

import java.util.HashMap;
import java.util.List;

public interface MyPageService {

    int selectSumAmountByCardId(String carId);
    int selectCountByCardId(String carId);

    String  selectSafetyStatusByCardId(String carId);
    String selectFdsStatusByCardId(String carId);

    List<CardHistory> selectCardHistoryByEmail(String email);

    List<CardHistory> selectTopCategoryByEmail(String email);

    List<CardHistory> selectCardHistoryByCardId(String cardId);
    List<PaymentLog> selectPaymentLogByCardId(String cardId);

    Card selectCardInfoByCardId(String carId);
}
