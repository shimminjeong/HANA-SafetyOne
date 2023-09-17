package com.kopo.SelfFDS.admin.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class fds {

    private String cardId;
    private Date learningDate;
    private String serviceStatus;
    private String weightSavePath;
    private String categorySmallStats;
    private String regionStats;
    private String timeStats;
    private String amountStats;

}
