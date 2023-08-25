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
    public List<CardHistory> selectAllOfCardId(String cardId) {
        return cardHistoryMapper.selectAllOfCardId(cardId);
    }

    @Override
    public List<CardHistory> selectCountRegionOfCardId(String cardId) {
        return cardHistoryMapper.selectCountRegionOfCardId(cardId);
    }

    @Override
    public List<CardHistory> selectCountCategoryOfCardId(String cardId) {
        return cardHistoryMapper.selectCountCategoryOfCardId(cardId);
    }

    @Override
    public List<CardHistory> selectCountTimeOfCardId(String cardId) {
        return cardHistoryMapper.selectCountTimeOfCardId(cardId);
    }

    @Override
    public List<String> selectAllRegionName() {
        return cardHistoryMapper.selectAllRegionName();
    }

    @Override
    public List<String> selectAllBigCategory() {
        return cardHistoryMapper.selectAllBigCategory();
    }

    @Override
    public List<CardHistory> selectSmallCategoryOfBigCategory(String category_big) {
        return cardHistoryMapper.selectSmallCategoryOfBigCategory(category_big);
    }

    @Override
    public List<CardHistory> selectAllCardHistoryOfCardId(String cardId) {
        return cardHistoryMapper.selectAllCardHistoryOfCardId(cardId);
    }
}
