package com.kopo.SelfFDS.model.dao;

import com.kopo.SelfFDS.model.dto.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface MemberMapper {

    List<Member> getAllMember();
    Member selectNameOfMember(String email);
    Member loginMember(HashMap<String, String> loginData);

    void insertMember(Member member);

    void updateMember(Member member);

    void deleteMember(String email);


}
