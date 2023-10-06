package com.kopo.SelfFDS.naverSMS;


import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class SmsController {

    private final SmsService smsService;

    @PostMapping("/sms/sendUser")
    public ResponseEntity<SmsResponseDto> test(@RequestBody Request request,HttpServletRequest sessionRequest) throws NoSuchAlgorithmException, URISyntaxException, UnsupportedEncodingException, InvalidKeyException, JsonProcessingException {
        System.out.println("sms 컨틀롤러 들어옴");

        SmsResponseDto data = smsService.sendSms(request.getRecipientPhoneNumber(), request.getContent());
        System.out.println("data"+request.getOuathNum());
        HttpSession session = sessionRequest.getSession();
        session.setAttribute("ouathNum",request.getOuathNum());
        return ResponseEntity.ok().body(data);
    }


    @PostMapping("/sms/verify")
    public String smsVerify(@RequestBody SmsResponseDto smsResponseDto,HttpServletRequest sessionRequest) {
        HttpSession session = sessionRequest.getSession();
        String ouathNum=(String)session.getAttribute("ouathNum");
        String userResponseOuathNum=smsResponseDto.getSmsConfirmNum();
        if (smsService.verifyOuath(ouathNum,userResponseOuathNum)){
            return "본인인증성공";
        }
        else{
            return "본인인증실패";
        }
    }

    @PostMapping("/sms/notApproval")
    public ResponseEntity<SmsResponseDto> notApprovalMessage(@RequestBody MessageDto MessageDto,HttpServletRequest sessionRequest) throws NoSuchAlgorithmException, URISyntaxException, UnsupportedEncodingException, InvalidKeyException, JsonProcessingException {
        System.out.println("차단문자발송");
        SmsResponseDto data = smsService.sendMessage(MessageDto.getTo(), MessageDto.getContent());
        HttpSession session = sessionRequest.getSession();
        return ResponseEntity.ok().body(data);
    }

    @PostMapping("/sms/fdsAlarm")
    public ResponseEntity<SmsResponseDto> fdsAlarmMessage(@RequestBody MessageDto MessageDto,HttpServletRequest sessionRequest) throws NoSuchAlgorithmException, URISyntaxException, UnsupportedEncodingException, InvalidKeyException, JsonProcessingException {

        System.out.println("이상거래문자발송");
        SmsResponseDto data = smsService.sendMessage(MessageDto.getTo(), MessageDto.getContent());
        HttpSession session = sessionRequest.getSession();
        return ResponseEntity.ok().body(data);
    }
}