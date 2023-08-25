package com.kopo.SelfFDS.model.dao;

import com.kopo.SelfFDS.model.dto.Card;
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
