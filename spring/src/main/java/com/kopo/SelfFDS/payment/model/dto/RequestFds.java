package com.kopo.SelfFDS.payment.model.dto;

import lombok.Data;

@Data
public class RequestFds {

    private String cardId;
    private WordToVec wordToVec;
}
