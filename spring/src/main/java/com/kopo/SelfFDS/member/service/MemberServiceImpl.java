package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dao.MemberMapper;
import com.kopo.SelfFDS.member.model.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {
    private MemberMapper memberMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public List<Member> getAllMember() {
        return memberMapper.getAllMember();
    }
    @Override
    public Member selectNameOfMember(String id) {
        return memberMapper.selectNameOfMember(id);
    }
    @Override
    public Member loginMember(HashMap<String, String> loginData) {
        return memberMapper.loginMember(loginData);
    }

    @Override
    public void joinMember(Member member) {
        memberMapper.insertMember(member);
    }

    @Override
    public void modifyMember(Member member) {
        memberMapper.updateMember(member);
    }

    @Override
    public void deleteMember(String id) {
        memberMapper.deleteMember(id);
    }

}
