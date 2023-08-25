package com.kopo.SelfFDS.model.dao;

import com.kopo.SelfFDS.model.dto.CardHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CardHistoryMapper {

    List<CardHistory> selectAllOfCardId(String cardId);

    List<CardHistory> selectCountRegionOfCardId(String cardId);

    List<CardHistory> selectCountCategoryOfCardId(String cardId);

    List<CardHistory> selectCountTimeOfCardId(String cardId);

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<CardHistory> selectSmallCategoryOfBigCategory(String category_big);

//    List<CardHistory> selectManyCategoryLatestMonthOfCardID(String cardId);

    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);

}
