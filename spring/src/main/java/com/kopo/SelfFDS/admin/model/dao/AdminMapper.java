package com.kopo.SelfFDS.admin.model.dao;

import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.model.dto.CardStats;
import com.kopo.SelfFDS.admin.model.dto.MemberStats;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface AdminMapper {

    int getAllAmountSumOfDay();

    List<MemberStats> getMemberCntByYear();
    List<CardStats> getCardCntByYear();
    List<CardHistoryStats> getAmountSumByDate();





}
