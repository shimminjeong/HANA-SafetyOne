package com.kopo.SelfFDS.cardService.service;

import com.kopo.SelfFDS.cardService.model.dao.CardMapper;
import com.kopo.SelfFDS.cardService.model.dao.SafetyRegisterMapper;
import com.kopo.SelfFDS.cardService.model.dto.Card;
import com.kopo.SelfFDS.cardService.model.dto.SafetyRegister;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class CardServiceImpl implements CardService{

    private CardMapper cardMapper;
    private SafetyRegisterMapper safetyRegisterMapper;

    @Autowired
    public CardServiceImpl(CardMapper cardMapper, SafetyRegisterMapper safetyRegisterMapper) {
        this.cardMapper = cardMapper;
        this.safetyRegisterMapper = safetyRegisterMapper;
    }

    @Override
    public List<Card> getAllCard() {
        return cardMapper.getAllCard();
    }


    public List<Card> selectCardOfEmail(String email) {
        return cardMapper.selectCardOfEmail(email);
    }

    @Override
    public Card paymentCard(HashMap<String, String> paymentCardData) {
        return cardMapper.paymentCard(paymentCardData);
    }

    @Override
    public Card selectCardOfCardId(String cardId) {
        return cardMapper.selectCardOfCardId(cardId);
    }

    @Override
    public void updateSelfFdsStatus(Card card) {
        cardMapper.updateSelfFdsStatus(card);

    }



    @Override
    public List<String> selectAllRegionName() {
        return safetyRegisterMapper.selectAllRegionName();
    }

    @Override
    public List<String> selectAllBigCategory() {
        return safetyRegisterMapper.selectAllBigCategory();
    }

    @Override
    public List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig) {
        return safetyRegisterMapper.selectSmallCategoryOfBigCategory(categoryBig);
    }

}
