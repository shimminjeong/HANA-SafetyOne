package com.kopo.SelfFDS.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class CardHistory {

    private String cardId;
    private String regionName;
    private String store;
    private String cardHisDate;
    private String safetyStartDate;
    private String safetyEndDate;
    private String time;
    private int amount;
    private String categoryBig;
    private String categorySmall;

//    private List<CardHistory> cardHistoryList;
//    statistic

    private int regionCnt;
    private int categoryCnt;
    private int timeCnt;
    private int amountSum;
    private int amountMean;
    private int history_cnt;


}
