package com.kopo.SelfFDS.service;

import com.kopo.SelfFDS.model.dao.CardMapper;
import com.kopo.SelfFDS.model.dto.Card;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class CardServiceImpl implements CardService{

    private CardMapper cardMapper;

    @Autowired
    public CardServiceImpl(CardMapper cardMapper){
        this.cardMapper=cardMapper;
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
}
