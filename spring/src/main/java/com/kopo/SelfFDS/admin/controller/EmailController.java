package com.kopo.SelfFDS.admin.controller;

import com.kopo.SelfFDS.admin.model.dto.Email;
import com.kopo.SelfFDS.admin.service.AdminService;
import com.kopo.SelfFDS.admin.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class EmailController {

    @Autowired
    private EmailService emailService;


    @PostMapping("/sendEmail")
    @ResponseBody
    public String sendEmail(@RequestBody Email email) {
        System.out.println("sendMail들어옴");
        System.out.println(email);
        String to=email.getTo();
        String subject = email.getTitle();
        String text = email.getMessage();
        emailService.sendSimpleMessage(to, subject, text);

        return "이메일 성공";
    }
}


