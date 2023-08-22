package com.kopo.SelfFDS.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class CardHistory {

    private String card_id;
    private String category;
    private String region_name;
    private String store;
    private Date card_his_date;
    private String card_his_time;
    private int amount;

//    statistic
    private int region_cnt;
    private int category_cnt;
    private int time_cnt;
    private int amount_sum;
    private int amount_mean;
    private int history_cnt;

//    code entitiy
    private String category_big;
    private String category_middle;
    private String category_small;
}
