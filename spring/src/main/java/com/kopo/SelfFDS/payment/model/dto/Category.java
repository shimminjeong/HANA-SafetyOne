package com.kopo.SelfFDS.payment.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class Category {
    private String categoryCode;
    private String categoryBig;
    private String categoryMiddle;
    private String categorySmall;

}
