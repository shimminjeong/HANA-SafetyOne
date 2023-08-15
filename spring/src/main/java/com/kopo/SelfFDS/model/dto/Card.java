package com.kopo.SelfFDS.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class Card {
    private int c_id;
    private String card_id;
    private String email;
    private String card_cvc;
    private String card_password;
    private Date card_reg_date;
    private String amount_limit;
    private String fds_ser_status;
    private String selffds_ser_status;
    public Card() {
    }

}
