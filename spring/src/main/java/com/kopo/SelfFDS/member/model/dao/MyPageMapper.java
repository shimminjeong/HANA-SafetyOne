package com.kopo.SelfFDS.member.model.dao;

import com.kopo.SelfFDS.member.model.dto.CardHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MyPageMapper {

    int selectSumAmountByCardId(String carId);
    int selectCountByCardId(String carId);
    String  selectSafetyStatusByCardId(String carId);
    String selectFdsStatusByCardId(String carId);
    String selectCardNameByCardId(String carId);

    List<CardHistory> selectCardHistoryByEmail(String email);
    List<CardHistory> selectTopCategoryByEmail(String email);

}