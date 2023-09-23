package com.kopo.SelfFDS.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
@Getter
@Setter
public class SafetyCard {

    private int safetyIdSeq;
    private String cardId;
    private String safetyStartDate;
    private String safetyEndDate;
    private String regionName;
    private String categorySmall;
    private String startTime;
    private String endTime;
    private String status;
    private String time;
    private String stopStartDate;
    private String stopEndDate;
    private String safetyStringInfo;
    private String cardName;

    @Override
    public String toString() {
        return "SafetyCard{" +
                "safetyIdSeq='" + safetyIdSeq + '\'' +
                ", cardId='" + cardId + '\'' +
                ", safetyStartDate='" + safetyStartDate + '\'' +
                ", safetyEndDate='" + safetyEndDate + '\'' +
                ", regionName='" + regionName + '\'' +
                ", categorySmall='" + categorySmall + '\'' +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", status='" + status + '\'' +
                ", time='" + time + '\'' +
                ", StopStartDate='" + stopStartDate + '\'' +
                ", StopEndDate='" + stopEndDate + '\'' +
                ", safetyStringInfo='" + safetyStringInfo + '\'' +
                '}';
    }
}
