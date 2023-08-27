package com.kopo.SelfFDS.cardService.service;

import com.kopo.SelfFDS.cardService.model.dto.Card;
import com.kopo.SelfFDS.cardService.model.dto.SafetyRegister;

import java.util.HashMap;
import java.util.List;

public interface CardService {

    List<Card> getAllCard();
    List<Card> selectCardOfEmail(String email);
    Card paymentCard(HashMap<String, String> paymentCardData);

    Card selectCardOfCardId(String cardId);

    void updateSelfFdsStatus(Card card);

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig);
}


