package com.kopo.SelfFDS.service;

import com.kopo.SelfFDS.model.dao.CardHistoryMapper;
import com.kopo.SelfFDS.model.dto.CardHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CardHistoryServiceImpl implements CardHistoryService{

    private CardHistoryMapper cardHistoryMapper;

    @Autowired
    public CardHistoryServiceImpl(CardHistoryMapper cardHistoryMapper){
        this.cardHistoryMapper=cardHistoryMapper;
    }
    @Override
    public List<CardHistory> selectAllOfCardId(String card_id) {
        return cardHistoryMapper.selectAllOfCardId(card_id);
    }

    @Override
    public List<CardHistory> selectCountRegionOfCardId(String card_id) {
        return cardHistoryMapper.selectCountRegionOfCardId(card_id);
    }

    @Override
    public List<CardHistory> selectCountCategoryOfCardId(String card_id) {
        return cardHistoryMapper.selectCountCategoryOfCardId(card_id);
    }

    @Override
    public List<CardHistory> selectCountTimeOfCardId(String card_id) {
        return cardHistoryMapper.selectCountTimeOfCardId(card_id);
    }
}
