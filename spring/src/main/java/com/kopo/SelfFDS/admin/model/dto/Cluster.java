package com.kopo.SelfFDS.admin.model.dto;

import lombok.Data;

@Data
public class Cluster {

    private String clusterNum;
    private String categoryMinName;
    private String categoryMaxName;
    private int clusterPeopleCount;
    private double clusterPeopleRatio;

    private String gender;
    private String ageRange;
    private int count;
    private int totalAmount;

    private String categorySmall;

    @Override
    public String toString() {
        return "Cluster{" +
                "clusterNum='" + clusterNum + '\'' +
                ", categoryMinName='" + categoryMinName + '\'' +
                ", categoryMaxName='" + categoryMaxName + '\'' +
                ", clusterPeopleCount=" + clusterPeopleCount +
                ", clusterPeopleRatio=" + clusterPeopleRatio +
                ", gender='" + gender + '\'' +
                ", ageRange='" + ageRange + '\'' +
                ", count=" + count +
                ", totalAmount=" + totalAmount +
                ", categorySmall='" + categorySmall + '\'' +
                '}';
    }
}
