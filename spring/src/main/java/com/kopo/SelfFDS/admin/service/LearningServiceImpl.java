package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.model.dao.AdminMapper;
import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.model.dto.CardStats;
import com.kopo.SelfFDS.admin.model.dto.Fds;
import com.kopo.SelfFDS.admin.model.dto.MemberStats;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    private AdminMapper adminMapper;

    @Autowired
    public AdminServiceImpl(AdminMapper adminMapper){
        this.adminMapper=adminMapper;
    }


    @Override
    public int getAllMemberCnt() {
        int totalMemberCnt=0;
        List<MemberStats> list=adminMapper.getMemberCntByYear();
        for (MemberStats stats : list) {
            totalMemberCnt += stats.getMemberCnt();
        }
        return totalMemberCnt;
    }

    @Override
    public int getAllCardCnt() {
        int totalCardCnt=0;
        List<CardStats> list=adminMapper.getCardCntByYear();
        for (CardStats stats : list) {
            totalCardCnt += stats.getCardCnt();
        }
        return totalCardCnt;
    }

    @Override
    public int getAllAmountSumOfDay() {
        return adminMapper.getAllAmountSumOfDay();
    }

    @Override
    public List<MemberStats> getMemberCntByYear() {
        return adminMapper.getMemberCntByYear();
    }

    @Override
    public List<CardStats> getCardCntByYear() {
        return adminMapper.getCardCntByYear();
    }

    @Override
    public List<CardHistoryStats> getAmountSumByDate() {
        return adminMapper.getAmountSumByDate();
    }

    @Override
    public double getMemberCntByYearRate() {

        List<MemberStats> list =adminMapper.getMemberCntByYear();

        return ((list.get(1).getMemberCnt()-list.get(0).getMemberCnt())/list.get(1).getMemberCnt())*100;
    }

    @Override
    public double getCardCntByYearRate() {

        List<CardStats> list =adminMapper.getCardCntByYear();

        return ((list.get(1).getCardCnt()-list.get(0).getCardCnt())/list.get(1).getCardCnt())*100;
    }

    @Override
    public double getAmountSumByDateRate() {

        List<CardHistoryStats> list =adminMapper.getAmountSumByDate();
        System.out.println("list.get(1).getAmountSum()"+list.get(1).getAmountSum());
        System.out.println("list.get(0).getAmountSum()"+list.get(0).getAmountSum());

        return ((list.get(1).getAmountSum()-list.get(0).getAmountSum())/list.get(1).getAmountSum())*100;
    }

    @Override
    public List<Fds> selectFdsAndMember() {
        System.out.println("adminMapper.selectFdsAndMember()"+adminMapper.selectFdsAndMember());
        return adminMapper.selectFdsAndMember();
    }


}
