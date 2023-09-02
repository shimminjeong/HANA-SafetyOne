package com.kopo.SelfFDS.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class SafetyRegister {

    private String cardId;


    //    code entitiy
    private String category;
    private String categoryBig;
    private String categoryMiddle;
    private String categorySmall;

    private String regionCode;
    private String regionName;


}
