package com.kopo.SelfFDS.cardService.model.dao;

import com.kopo.SelfFDS.cardService.model.dto.Card;
import com.kopo.SelfFDS.cardService.model.dto.SafetyRegister;
import com.kopo.SelfFDS.chart.model.dto.CardHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface SafetyRegisterMapper {

    List<String> selectAllRegionName();

    List<String> selectAllBigCategory();

    List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig);


}
