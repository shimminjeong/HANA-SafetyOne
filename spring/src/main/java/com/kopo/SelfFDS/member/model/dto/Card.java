package com.kopo.SelfFDS.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class Card {
    private int c_id;
    private String cardId;
    private String email;
    private String cardCvc;
    private String cardPassword;
    private Date cardRegDate;
    private Date validDate;
    private String amountLimit;
    private String fdsSerStatus;
    private String selffdsSerStatus;
    public Card() {
    }

}
