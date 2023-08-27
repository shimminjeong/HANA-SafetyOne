package com.kopo.SelfFDS.cardService.model.dao;

import com.kopo.SelfFDS.cardService.model.dto.Card;
import com.kopo.SelfFDS.chart.model.dto.CardHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CardMapper {

    List<Card> getAllCard();
    List<Card> selectCardOfEmail(String email);
    Card paymentCard(HashMap<String, String> paymentCardData);

    Card selectCardOfCardId(String cardId);

    void updateSelfFdsStatus(Card card);

}
