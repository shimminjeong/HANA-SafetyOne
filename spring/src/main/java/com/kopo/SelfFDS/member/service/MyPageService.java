package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dto.*;

import java.util.HashMap;
import java.util.List;

public interface MyPageService {

    int selectSumAmountByCardId(String carId);
    int selectCountByCardId(String carId);

    String  selectSafetyStatusByCardId(String carId);
    String selectFdsStatusByCardId(String carId);
    String selectCardNameByCardId(String carId);

    List<CardHistory> selectCardHistoryByEmail(String email);

    List<CardHistory> selectTopCategoryByEmail(String email);
}
