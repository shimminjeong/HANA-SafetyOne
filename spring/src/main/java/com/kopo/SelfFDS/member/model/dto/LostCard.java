package com.kopo.SelfFDS.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class LostCard {

    private int lost_id;

    private String cardId;
    private String lostDate;
    private String lostPlace;
    private String lostReason;
    private String reissued;

}
