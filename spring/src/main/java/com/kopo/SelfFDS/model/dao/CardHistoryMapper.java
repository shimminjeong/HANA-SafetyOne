package com.kopo.SelfFDS.model.dao;

import com.kopo.SelfFDS.model.dto.CardHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CardHistoryMapper {

    List<CardHistory> selectAllOfCardId(String card_id);

    List<CardHistory> selectCountRegionOfCardId(String card_id);

    List<CardHistory> selectCountCategoryOfCardId(String card_id);

    List<CardHistory> selectCountTimeOfCardId(String card_id);

    List<String> selectAllRegionName();


}
