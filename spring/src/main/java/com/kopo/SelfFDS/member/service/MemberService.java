package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.model.dto.CardHistory;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.model.dto.SafetyRegister;

import java.util.HashMap;
import java.util.List;

public interface MemberService {

    public List<Member> getAllMember();
    Member selectNameOfMember(String email);
    Member loginMember(HashMap<String, String> loginData);

    public void joinMember(Member member);

    public void modifyMember(Member member);

    public void deleteMember(String email);

    List<Card> getAllCard();
    List<Card> selectCardOfEmail(String email);
//    Card paymentCard(HashMap<String, String> paymentCardData);

    Card selectCardOfCardId(String cardId);

    void updateSelfFdsStatus(Card card);

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig);


    List<CardHistory> selectCountRegionOfCardId(String cardId);

    List<CardHistory> selectCountSmallCategoryOfCardIdCategoryBig(String cardId,String categoryBig);

    List<CardHistory> selectCountTimeOfCardId(String cardId);


    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);
}
