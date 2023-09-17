package com.kopo.SelfFDS.payment.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class WordToVec {

    double categorySmallNumeric;
    int timeNumeric;
    int regionNameNumeric;
    int amountNumeric;
}
