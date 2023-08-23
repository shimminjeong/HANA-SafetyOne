package com.kopo.SelfFDS.service;

import com.kopo.SelfFDS.model.dto.CardHistory;

import java.util.List;

public interface CardHistoryService {

    List<CardHistory> selectAllOfCardId(String card_id);

    List<CardHistory> selectCountRegionOfCardId(String card_id);

    List<CardHistory> selectCountCategoryOfCardId(String card_id);

    List<CardHistory> selectCountTimeOfCardId(String card_id);

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<CardHistory> selectSmallCategoryOfBigCategory(String category_big);

    List<CardHistory> selectAllCardHistoryOfCardId(String card_id);

}
