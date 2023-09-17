package com.kopo.SelfFDS.payment.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class Region {
    private String regionCode;
    private String regionName;
    private int seoulToRegionTime;
    private int seoulToRegionDistance;
}
