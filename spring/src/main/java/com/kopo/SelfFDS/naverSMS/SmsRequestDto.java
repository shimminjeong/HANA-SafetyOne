package com.kopo.SelfFDS.naverSMS;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class SmsRequestDto {
    private String type;
    private String contentType;
    private String subject;
    private String countryCode;
    private String from;
    private String content;
    private List<MessageDto> messages;
}