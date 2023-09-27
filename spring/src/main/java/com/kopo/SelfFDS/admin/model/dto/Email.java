package com.kopo.SelfFDS.admin.model.dto;

import lombok.Data;

@Data
public class Email {
    private String to;
    private String title;
    private String message;

    @Override
    public String toString() {
        return "Email{" +
                "to='" + to + '\'' +
                ", title='" + title + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}