package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dao.MemberMapper;
import com.kopo.SelfFDS.member.model.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

import static org.apache.logging.log4j.ThreadContext.removeAll;

@Service
public class MemberServiceImpl implements MemberService {
    private MemberMapper memberMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public List<Member> getAllMember() {
        return memberMapper.getAllMember();
    }

    @Override
    public Member selectNameOfMember(String email) {
        return memberMapper.selectNameOfMember(email);
    }

    @Override
    public Member loginMember(HashMap<String, String> loginData) {
        return memberMapper.loginMember(loginData);
    }

    @Override
    public void joinMember(Member member) {
        memberMapper.insertMember(member);
    }

    @Override
    public void modifyMember(Member member) {
        memberMapper.updateMember(member);
    }

    @Override
    public void deleteMember(String email) {
        memberMapper.deleteMember(email);
    }

    @Override
    public List<Card> getAllCard() {
        return memberMapper.getAllCard();
    }


    public List<Card> selectCardOfEmail(String email) {
        return memberMapper.selectCardOfEmail(email);
    }


    @Override
    public Card selectCardOfCardId(String cardId) {
        return memberMapper.selectCardOfCardId(cardId);
    }

    @Override
    public void updateSelfFdsStatus(Card card) {
        memberMapper.updateSelfFdsStatus(card);

    }

    @Override
    public void updateFdsStatus(Card card) {
        memberMapper.updateFdsStatus(card);
    }


    @Override
    public List<String> selectAllRegionName() {
        return memberMapper.selectAllRegionName();
    }

    @Override
    public List<String> selectAllBigCategory() {
        return memberMapper.selectAllBigCategory();
    }

    @Override
    public List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig) {
        return memberMapper.selectSmallCategoryOfBigCategory(categoryBig);
    }


    @Override
    public List<CardHistory> selectCountRegionOfCardId(String cardId) {
        return memberMapper.selectCountRegionOfCardId(cardId);
    }

    @Override
    public List<CardHistory> selectCountSmallCategoryOfCardIdCategoryBig(String cardId, String categoryBig) {
        return memberMapper.selectCountSmallCategoryOfCardIdCategoryBig(cardId, categoryBig);
    }

    @Override
    public List<CardHistory> selectCountTimeOfCardId(String cardId) {
        return memberMapper.selectCountTimeOfCardId(cardId);
    }


    @Override
    public List<CardHistory> selectAllCardHistoryOfCardId(String cardId) {
        return memberMapper.selectAllCardHistoryOfCardId(cardId);
    }

    @Override
    public List<SafetyCard> selectAllSafetyCardOfCardId(String cardId) {
        return memberMapper.selectAllSafetyCardOfCardId(cardId);
    }


    @Override
    public void insertSafetySetting(String cardId, int enrollSeq, List<List<String>> safetyCard, String safetyStringInfo) {

        List<String> regionList = safetyCard.get(0);
        List<String> timeList = safetyCard.get(1);
        List<String> categoryList = safetyCard.get(2);
        SafetyCard safety = new SafetyCard();
        safety.setCardId(cardId);
        safety.setEnrollSeq(enrollSeq + 1);
        safety.setSafetyStringInfo(safetyStringInfo);

        System.out.println("timeList" + timeList);

        //전체 regionlist가져오기
        List<String> regionAllList = memberMapper.selectAllRegionName();

        //전체 regionList에서 허용 지역 빼기
        regionAllList.removeAll(regionList);

        for (String blockRegion : regionAllList) {
            safety.setRegionName(blockRegion);
            memberMapper.insertSafetySetting(safety);
        }


        if (!regionList.isEmpty()) {
            for (String regionName : regionList) {
                if (!timeList.isEmpty()) {
                    for (String time : timeList) {
                        if (!categoryList.isEmpty()) {
                            for (String categorySmall : categoryList) {
                                safety.setRegionName(regionName);

                                safety.setTime(time);
                                safety.setCategorySmall(categorySmall);
                                memberMapper.insertSafetySetting(safety);
                            }
                        } else {
                            safety.setRegionName(regionName);
                            safety.setTime(time);
                            memberMapper.insertSafetySetting(safety);
                        }
                    }
                } else if (!categoryList.isEmpty()) {
                    for (String categorySmall : categoryList) {
                        safety.setRegionName(regionName);
                        safety.setCategorySmall(categorySmall);
                        memberMapper.insertSafetySetting(safety);
                    }
                } else {
                    safety.setRegionName(regionName);
                    memberMapper.insertSafetySetting(safety);
                }
            }
        } else if (!timeList.isEmpty()) {
            for (String time : timeList) {

                if (!categoryList.isEmpty()) {
                    for (String categorySmall : categoryList) {
                        safety.setTime(time);
                        safety.setCategorySmall(categorySmall);
                        memberMapper.insertSafetySetting(safety);
                    }
                } else {
                    safety.setTime(time);
                    memberMapper.insertSafetySetting(safety);
                }
            }
        } else if (!categoryList.isEmpty()) {
            for (String categorySmall : categoryList) {
                safety.setCategorySmall(categorySmall);
                memberMapper.insertSafetySetting(safety);
            }
        }
    }

    @Override
    public List<SafetyCard> selectSafetySettingByCardId(String cardId, int enrollSeq) {
        return memberMapper.selectSafetySettingByCardId(cardId, enrollSeq);
    }

    @Override
    public int selectSafetySettingEnrollSeqByCardId(String cardId) {
        return memberMapper.selectSafetySettingEnrollSeqByCardId(cardId);
    }

    @Override
    public void insertLostCardInfo(LostCard lostCard) {
        memberMapper.insertLostCardInfo(lostCard);
    }

    @Override
    public List<SafetyCard> selectSafetySettingByEmail(String email) {
        return memberMapper.selectSafetySettingByEmail(email);
    }

    @Override
    public void updateStopDate(SafetyCard safetyCard) {
        memberMapper.updateStopDate(safetyCard);
    }

    @Override
    public int selectDifferenceMonthByCardId(String cardId) {
        return memberMapper.selectDifferenceMonthByCardId(cardId);
    }

    @Override
    public List<CardHistory> selectDiffCategoryOfMonthByCardId(String cardId) {
        List<CardHistory> list = memberMapper.selectDiffCategoryOfMonthByCardId(cardId);
        Collections.sort(list, Comparator.comparingInt(CardHistory::getDiffAmount));

//        지날달대비 이번달 지출이 가장 많은 업종과 가장 작은 없종
        CardHistory smallest = list.get(0);
        CardHistory largest = list.get(list.size() - 1);

        List<CardHistory> result = new ArrayList<>();
        result.add(smallest);
        result.add(largest);
        return result;
    }

    @Override
    public List<CardHistory> selectAmountOfMonthByCardIdCategory(String cardId, String categorySmall) {
        List<CardHistory> aa=memberMapper.selectAmountOfMonthByCardIdCategory(cardId,categorySmall);
        System.out.println("aa"+aa);
        return memberMapper.selectAmountOfMonthByCardIdCategory(cardId,categorySmall);
    }


}
