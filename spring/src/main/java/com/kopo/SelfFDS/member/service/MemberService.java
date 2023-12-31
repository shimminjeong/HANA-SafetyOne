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

    Card selectCardOfCardId(String cardId);

    void regSafetyService(Card card);

    void unregSafetyService(Card card);
    void regFdsService(Card card);

    void unregFdsService(Card card);

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig);


    List<CardHistory> selectCountRegionOfEmail(String email);

    List<CardHistory> selectCountSmallCategoryOfEmail(String email,String categoryBig);

    List<CardHistory> selectCountTimeOfEmail(String email);


    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);

    List<SafetyCard> selectAllSafetyCardOfCardId(String cardId);

    void insertSafetySetting(String cardId,List<List<String>> safetyCard);


    void insertLostCardInfo(LostCard lostCard);

    List<SafetyCard> selectSafetySettingByEmail(String email);

    void updateStopDate(SafetyCard safetyCard);

    int selectDifferenceMonthByCardId(String cardId);

    List<CardHistory> selectDiffCategoryOfMonthByCardId(String cardId);

    List<CardHistory> selectAmountOfMonthByCardIdCategory(String cardId,String categorySmall);
    List<CardHistory> selectAmountOfMonthByCardId(String cardId);
    List<CardHistory> selectAmountOfWeekByCardId(String cardId);
    List<CardHistory> selectDayByCardIdDate(String cardId, String cardHisDate);

    void deleteFds(String cardId);

    List<Card> selectSafetyCardYByEmail(String email);

    List<SafetyCard> selectSafetyCardNotRegionByCarId(String cardId);
    List<SafetyCard> selectSafetyCardRegionByCarId(String cardId);

    List<CardHistory> selectSmallCategroyTopOfEmail(String email);

    List<SafetyCard> selectAllSafetyCard();

    void updateSafetyStatus(int safetyIdSeq,String status);

    String selectBigCategoryOfSmallCategory(String categorySmall);

}
