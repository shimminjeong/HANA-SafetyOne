package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dto.*;
import org.apache.ibatis.annotations.Param;

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
    void updateFdsStatus(Card card);

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig);


    List<CardHistory> selectCountRegionOfCardId(String cardId);

    List<CardHistory> selectCountSmallCategoryOfCardIdCategoryBig(String cardId,String categoryBig);

    List<CardHistory> selectCountTimeOfCardId(String cardId);


    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);

    List<SafetyCard> selectAllSafetyCardOfCardId(String cardId);

    void insertSafetySetting(String cardId,int enrollSeq,List<List<String>> safetyCard,String safetyStringInfo);

    List<SafetyCard> selectSafetySettingByCardId(String cardId, int enrollSeq);
    int selectSafetySettingEnrollSeqByCardId(String cardId);

    void insertLostCardInfo(LostCard lostCard);

    List<SafetyCard> selectSafetySettingByEmail(String email);

    void updateStopDate(SafetyCard safetyCard);

    int selectDifferenceMonthByCardId(String cardId);

    List<CardHistory> selectDiffCategoryOfMonthByCardId(String cardId);

    List<CardHistory> selectAmountOfMonthByCardIdCategory(String cardId,String categorySmall);


}
