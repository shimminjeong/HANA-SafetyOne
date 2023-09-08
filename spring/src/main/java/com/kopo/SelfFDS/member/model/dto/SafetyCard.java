package com.kopo.SelfFDS.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
@Getter
@Setter
public class SafetyCard {

    private String cardId;
    private String safetyStartDate;
    private String safetyEndDate;
    private String regionName;
    private String categorySmall;
    private String startTime;
    private String endTime;
    private String status;
    private String time;
    private int enrollSeq;


}
