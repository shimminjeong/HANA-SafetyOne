package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dao.MemberMapper;
import com.kopo.SelfFDS.member.model.dao.MyPageMapper;
import com.kopo.SelfFDS.member.model.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class MemberServiceImpl implements MemberService {
    private MemberMapper memberMapper;
    private MyPageMapper myPageMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper, MyPageMapper myPageMapper) {
        this.memberMapper = memberMapper;
        this.myPageMapper = myPageMapper;
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
    public void regSafetyService(Card card) {
        card.setSelffdsSerStatus("Y");
        memberMapper.updateSelfFdsStatus(card);
    }


//    Transactional처리 delete safetycard 테이블에서 delete도 하기
    @Transactional
    @Override
    public void unregSafetyService(Card card) {
        card.setSelffdsSerStatus("N");
        memberMapper.updateSelfFdsStatus(card);
        memberMapper.deleteSafetyCard(card.getCardId());
    }

    //    CARDFDS서비스 상태 UPDATE와 동시에 fds서비스 테이블에 insert
    @Transactional
    public void regFdsService(Card card) {
        card.setFdsSerStatus("Y");
        memberMapper.updateFdsStatus(card);
        String serviceStatus="학습대기";
        System.out.println("card.getCardId()"+card.getCardId());
        memberMapper.insertFds(card.getCardId(), serviceStatus);
    }

//    fds 서비스 신청 해제
    @Transactional
    @Override
    public void unregFdsService(Card card) {
        card.setFdsSerStatus("N");
        memberMapper.updateFdsStatus(card);
        memberMapper.deleteFds(card.getCardId());
    }
    @Override
    public void deleteFds(String cardId) {
        memberMapper.deleteFds(cardId);
    }

    @Override
    public List<Card> selectSafetyCardYByEmail(String email) {
        return memberMapper.selectSafetyCardYByEmail(email);
    }

    @Override
    public List<SafetyCard> selectSafetyCardNotRegionByCarId(String cardId) {
        return memberMapper.selectSafetyCardNotRegionByCarId(cardId);
    }

    @Override
    public List<SafetyCard> selectSafetyCardRegionByCarId(String cardId) {
        return memberMapper.selectSafetyCardRegionByCarId(cardId);
    }

    @Override
    public List<CardHistory> selectSmallCategroyTopOfEmail(String email) {
        return memberMapper.selectSmallCategroyTopOfEmail(email);
    }

    @Override
    public List<SafetyCard> selectAllSafetyCard() {
        return memberMapper.selectAllSafetyCard();
    }

    @Override
    public void updateSafetyStatus(int safetyIdSeq, String status) {
        memberMapper.updateSafetyStatus(safetyIdSeq, status);
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
    public List<CardHistory> selectCountRegionOfEmail(String email) {
        return memberMapper.selectCountRegionOfEmail(email);
    }

    @Override
    public List<CardHistory> selectCountSmallCategoryOfEmail(String email, String categoryBig) {
        return memberMapper.selectCountSmallCategoryOfEmail(email, categoryBig);
    }

    @Override
    public List<CardHistory> selectCountTimeOfEmail(String email) {
        return memberMapper.selectCountTimeOfEmail(email);
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
    public void insertSafetySetting(String cardId, List<List<String>> safetyCard) {

        List<String> regionList = safetyCard.get(0);
        List<String> timeList = safetyCard.get(1);
        List<String> categoryList = safetyCard.get(2);
        SafetyCard safety = new SafetyCard();
        safety.setCardId(cardId);
//        safety.setSafetyStringInfo(safetyStringInfo);

        Card cardInfo=myPageMapper.selectCardInfoByCardId(cardId);
        safety.setSafetyEndDate(cardInfo.getValidDate());
        System.out.println("---------"+cardInfo.getValidDate());
        System.out.println("timeList" + timeList);


        if (!regionList.isEmpty()) {
            //전체 regionlist가져오기
            List<String> regionAllList = memberMapper.selectAllRegionName();

            //전체 regionList에서 허용 지역 빼기
            regionAllList.removeAll(regionList);

            for (String blockRegion : regionAllList) {
                safety.setRegionName(blockRegion);
                memberMapper.insertSafetySetting(safety);
            }
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
        System.out.println("ddd"+cardId+"sss"+categorySmall);
        List<CardHistory> aa=memberMapper.selectAmountOfMonthByCardIdCategory(cardId,categorySmall);
        System.out.println("aa"+aa);
        return memberMapper.selectAmountOfMonthByCardIdCategory(cardId,categorySmall);
    }

    @Override
    public List<CardHistory> selectAmountOfMonthByCardId(String cardId) {
        return memberMapper.selectAmountOfMonthByCardId(cardId);
    }

    @Override
    public List<CardHistory> selectAmountOfWeekByCardId(String cardId) {
        return memberMapper.selectAmountOfWeekByCardId(cardId);
    }

    @Override
    public List<CardHistory> selectDayByCardIdDate(String cardId, String cardHisDate) {
        return memberMapper.selectDayByCardIdDate(cardId,cardHisDate);
    }




}
