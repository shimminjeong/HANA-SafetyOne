package com.kopo.SelfFDS.payment.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class WordToVec {

    double categorySmallNumeric;
    int timeNumeric;
    int regionNameNumeric;
    int amountNumeric;

    @Override
    public String toString() {
        return "WordToVec{" +
                "categorySmallNumeric=" + categorySmallNumeric +
                ", timeNumeric=" + timeNumeric +
                ", regionNameNumeric=" + regionNameNumeric +
                ", amountNumeric=" + amountNumeric +
                '}';
    }
}
