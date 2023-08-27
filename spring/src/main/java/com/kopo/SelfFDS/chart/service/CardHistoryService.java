package com.kopo.SelfFDS.chart.service;

import com.kopo.SelfFDS.chart.model.dto.CardHistory;

import java.util.List;

public interface CardHistoryService {


    List<CardHistory> selectCountRegionOfCardId(String cardId);

    List<CardHistory> selectCountCategoryOfCardId(String cardId);

    List<CardHistory> selectCountTimeOfCardId(String cardId);



    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);

}
