package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.model.dto.Email;

import java.util.List;

public interface EmailService {

    void sendSimpleMessage(String to, String title, String message);

}
