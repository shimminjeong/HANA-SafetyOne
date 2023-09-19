package com.kopo.SelfFDS.payment.model.dto;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class PaymentLog {

    private int paymentLogId;
    private String cardId;
    private String address;
    private String road_address_name;
    private String store;
    private String paymentDate; //결제일시
    private String time;
    private String categorySmall;
    private String storePhoneNumber;
    private String product;
    private int amount;
    private String paymentApprovalStatus;
    private String fdsDetectionStatus;

    @Override
    public String toString() {
        return "PaymentLog{" +
                "paymentLogId=" + paymentLogId +
                ", cardId='" + cardId + '\'' +
                ", address='" + address + '\'' +
                ", road_address_name='" + road_address_name + '\'' +
                ", store='" + store + '\'' +
                ", paymentDate='" + paymentDate + '\'' +
                ", time='" + time + '\'' +
                ", categorySmall='" + categorySmall + '\'' +
                ", storePhoneNumber='" + storePhoneNumber + '\'' +
                ", product='" + product + '\'' +
                ", amount=" + amount +
                ", paymentApprovalStatus='" + paymentApprovalStatus + '\'' +
                ", fdsDetectionStatus='" + fdsDetectionStatus + '\'' +
                '}';
    }
}

