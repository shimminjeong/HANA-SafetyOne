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

    List<PaymentLog> selectPaymentLogByEmail(String email);

    List<CardHistory> select6MonthTotalAmountByEmail(String email);

    List<CardHistory> selectTopCategoryTotalAmountByEmail(String email);
    List<CardHistory> selectTopCategoryCountByEmail(String email);
    List<CardHistory> selectTopCategoryDifferenceByEmail(String email);

    List<CardHistory> selectTopStoreCountByEmail(String email);
    List<CardHistory> selectTimeTotalAmountByEmail(String email);
    List<CardHistory> selectRegionTotalAmountByEmail(String email);

    List<String> selectCategory3monthByEmail(String email);
    List<String> selectAllSmallCategory();

    PaymentLog selectByPaymentLogId(int paymentLogId);
}
