package com.kopo.SelfFDS.payment.model.dto;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class PaymentCardInfo {
    private String cardId;
    private String email;
}

