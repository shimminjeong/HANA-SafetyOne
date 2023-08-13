package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dto.Member;

import java.util.HashMap;
import java.util.List;

public interface MemberService {

    public List<Member> getAllMember();
    Member selectNameOfMember(String email);
    Member loginMember(HashMap<String, String> loginData);

    public void joinMember(Member member);

    public void modifyMember(Member member);

    public void deleteMember(String email);
}
