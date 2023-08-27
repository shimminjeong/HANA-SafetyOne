package com.kopo.SelfFDS.chart.model.dao;

import com.kopo.SelfFDS.chart.model.dto.CardHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CardHistoryMapper {


    List<CardHistory> selectCountRegionOfCardId(String cardId);

    List<CardHistory> selectCountCategoryOfCardId(String cardId);

    List<CardHistory> selectCountTimeOfCardId(String cardId);



//    List<CardHistory> selectManyCategoryLatestMonthOfCardID(String cardId);

    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);

}
