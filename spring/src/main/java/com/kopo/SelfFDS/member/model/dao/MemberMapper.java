package com.kopo.SelfFDS.member.model.dao;

import com.kopo.SelfFDS.member.model.dto.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface MemberMapper {

    List<Member> getAllMember();
    Member selectNameOfMember(String id);
    Member loginMember(HashMap<String, String> loginData);

    void insertMember(Member member);



}
