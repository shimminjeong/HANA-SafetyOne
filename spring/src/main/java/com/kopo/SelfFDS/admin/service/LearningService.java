package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.model.dto.CardStats;
import com.kopo.SelfFDS.admin.model.dto.Fds;
import com.kopo.SelfFDS.admin.model.dto.MemberStats;

import java.util.List;

public interface AdminService {

//    adminmain
    int getAllMemberCnt();
    int getAllCardCnt();
    int getAllAmountSumOfDay();

    List<MemberStats> getMemberCntByYear();
    List<CardStats> getCardCntByYear();
    List<CardHistoryStats> getAmountSumByDate();

    double getMemberCntByYearRate();
    double getCardCntByYearRate();
    double getAmountSumByDateRate();

//    fds
    List<Fds> selectFdsAndMember();
}
