package com.kopo.SelfFDS.admin.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CardHistoryStats {

    private String cardHisDate;
    private int amountSum;
    private String regionName;
    private String categorySmall;
    private int cnt;

}
