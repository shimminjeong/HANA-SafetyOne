package com.kopo.SelfFDS.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class Member {
    private int m_id;
    private String email;
    private String name;
    private String password;
    private String phone;
    private String gender;
    private String address;
    private String identityNum;
    private int age;
    private Date regDate;
    private String authority;
    public Member() {
    }

}
