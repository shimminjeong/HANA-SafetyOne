package com.kopo.SelfFDS.admin.model.dto;

import com.kopo.SelfFDS.member.model.dto.Member;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class Fds {

    private String cardId;
    private String serRegDate;
    private String learningDate;
    private String serviceStatus;
    private String weightSavePath;
    private String categorySmallStats;
    private String regionStats;
    private String timeStats;
    private String amountStats;
    private Member member;

    @Override
    public String toString() {
        return "Fds{" +
                "cardId='" + cardId + '\'' +
                ", learningDate=" + learningDate +
                ", serviceStatus='" + serviceStatus + '\'' +
                ", weightSavePath='" + weightSavePath + '\'' +
                ", categorySmallStats='" + categorySmallStats + '\'' +
                ", regionStats='" + regionStats + '\'' +
                ", timeStats='" + timeStats + '\'' +
                ", amountStats='" + amountStats + '\'' +
                ", member=" + member +
                '}';
    }
}
