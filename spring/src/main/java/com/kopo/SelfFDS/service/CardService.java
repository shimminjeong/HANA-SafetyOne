package com.kopo.SelfFDS.service;

import com.kopo.SelfFDS.model.dto.Card;

import java.util.HashMap;
import java.util.List;

public interface CardService {

    List<Card> getAllCard();
    List<Card> selectCardOfEmail(String email);
    Card paymentCard(HashMap<String, String> paymentCardData);

    Card selectCardOfCardId(String cardId);

    void updateSelfFdsStatus(Card card);

}
