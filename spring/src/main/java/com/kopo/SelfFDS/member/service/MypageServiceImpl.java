package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dao.MemberMapper;
import com.kopo.SelfFDS.member.model.dao.MyPageMapper;
import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.model.dto.CardHistory;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageServiceImpl implements MyPageService {
    private MyPageMapper mypageMapper;

    @Autowired
    public MypageServiceImpl(MyPageMapper mypageMapper) {
        this.mypageMapper = mypageMapper;
    }


    @Override
    public int selectSumAmountByCardId(String cardId) {
        return mypageMapper.selectSumAmountByCardId(cardId);
    }

    @Override
    public int selectCountByCardId(String carId) {
        return mypageMapper.selectCountByCardId(carId);
    }

    @Override
    public String selectSafetyStatusByCardId(String carId) {
        return mypageMapper.selectSafetyStatusByCardId(carId);
    }

    @Override
    public String selectFdsStatusByCardId(String carId) {
        return mypageMapper.selectFdsStatusByCardId(carId);
    }

    @Override
    public Card selectCardInfoByCardId(String carId) {
        return mypageMapper.selectCardInfoByCardId(carId);
    }

    @Override
    public List<PaymentLog> selectPaymentLogByEmail(String email) {
        return mypageMapper.selectPaymentLogByEmail(email);
    }

    @Override
    public List<CardHistory> select6MonthTotalAmountByEmail(String email) {
        return mypageMapper.select6MonthTotalAmountByEmail(email);
    }

    @Override
    public List<CardHistory> selectTopCategoryTotalAmountByEmail(String email) {
        return mypageMapper.selectTopCategoryTotalAmountByEmail(email);
    }

    @Override
    public List<CardHistory> selectTopCategoryDifferenceByEmail(String email) {
        return mypageMapper.selectTopCategoryDifferenceByEmail(email);
    }

    @Override
    public List<CardHistory> selectTopStoreCountByEmail(String email) {
        return mypageMapper.selectTopStoreCountByEmail(email);
    }

    @Override
    public List<CardHistory> selectTimeTotalAmountByEmail(String email) {
        return mypageMapper.selectTimeTotalAmountByEmail(email);
    }

    @Override
    public List<CardHistory> selectRegionTotalAmountByEmail(String email) {
        return mypageMapper.selectRegionTotalAmountByEmail(email);
    }

    @Override
    public List<String> selectCategory3monthByEmail(String email) {
        return mypageMapper.selectCategory3monthByEmail(email);
    }

    @Override
    public List<String> selectAllSmallCategory() {
        return mypageMapper.selectAllSmallCategory();
    }

    @Override
    public List<CardHistory> selectCardHistoryByEmail(String email) {
        return mypageMapper.selectCardHistoryByEmail(email);
    }

    @Override
    public List<CardHistory> selectTopCategoryByEmail(String email) {
        return mypageMapper.selectTopCategoryByEmail(email);
    }

    @Override
    public List<CardHistory> selectCardHistoryByCardId(String cardId) {
        return mypageMapper.selectCardHistoryByCardId(cardId);
    }

    @Override
    public List<PaymentLog> selectPaymentLogByCardId(String cardId) {
        return mypageMapper.selectPaymentLogByCardId(cardId);
    }




}
