package com.kopo.SelfFDS.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
@Getter
@Setter
public class Member {
    private int m_id;
    private String id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String sex;
    private String address;
    private String identityNum;
    private Date registerDate;
    public Member() {
    }

}
