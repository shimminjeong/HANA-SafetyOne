package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.service.EmailService;
import com.kopo.SelfFDS.admin.model.dto.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSenderImpl javaMailSender;

    public void sendSimpleMessage(String to, String title, String message){
        SimpleMailMessage emailInfo = new SimpleMailMessage();
        emailInfo.setTo(to);
        emailInfo.setSubject(title);
        emailInfo.setText(message);
        javaMailSender.send(emailInfo);
    }
}
