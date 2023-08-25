package com.kopo.SelfFDS.service;

import com.kopo.SelfFDS.model.dto.CardHistory;

import java.util.List;

public interface CardHistoryService {

    List<CardHistory> selectAllOfCardId(String cardId);

    List<CardHistory> selectCountRegionOfCardId(String cardId);

    List<CardHistory> selectCountCategoryOfCardId(String cardId);

    List<CardHistory> selectCountTimeOfCardId(String cardId);

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<CardHistory> selectSmallCategoryOfBigCategory(String category_big);

    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);

}
