package com.kopo.SelfFDS.member.model.dao;

import com.kopo.SelfFDS.member.model.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface MemberMapper {

    List<Member> getAllMember();

    Member selectNameOfMember(String email);

    Member loginMember(HashMap<String, String> loginData);

    void insertMember(Member member);

    void updateMember(Member member);

    void deleteMember(String email);


    //    card
    List<Card> getAllCard();

    List<Card> selectCardOfEmail(String email);

    Card paymentCard(HashMap<String, String> paymentCardData);

    Card selectCardOfCardId(String cardId);

    void updateSelfFdsStatus(Card card);

    void updateFdsStatus(Card card);


    //    safetycard
    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig);


    //    cardhistory
    List<CardHistory> selectCountRegionOfCardId(String cardId);

    List<CardHistory> selectCountSmallCategoryOfCardIdCategoryBig(@Param("cardId") String cardId, @Param("categoryBig") String categoryBig);

    List<CardHistory> selectCountTimeOfCardId(String cardId);


//    List<CardHistory> selectManyCategoryLatestMonthOfCardID(String cardId);

    List<CardHistory> selectAllCardHistoryOfCardId(String cardId);

    List<SafetyCard> selectAllSafetyCardOfCardId(String cardId);


    void insertSafetySetting(SafetyCard safetyCard);

    void insertLostCardInfo(LostCard lostCard);

    List<SafetyCard> selectSafetySettingByCardId(@Param("cardId") String cardId, @Param("enrollSeq") int enrollSeq);

    List<SafetyCard> selectSafetySettingByEmail(String email);

    int selectSafetySettingEnrollSeqByCardId(String cardId);

    void updateStopDate(SafetyCard safetyCard);

    int selectDifferenceMonthByCardId(String cardId);

    List<CardHistory> selectDiffCategoryOfMonthByCardId(String cardId);

    List<CardHistory> selectAmountOfMonthByCardIdCategory(@Param("cardId") String cardId, @Param("categorySmall") String categorySmall);


}
