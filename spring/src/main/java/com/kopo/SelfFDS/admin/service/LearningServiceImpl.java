package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.model.dao.AdminMapper;
import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.model.dto.CardStats;
import com.kopo.SelfFDS.admin.model.dto.Fds;
import com.kopo.SelfFDS.admin.model.dto.MemberStats;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LearningServiceImpl implements LearningService {

    private AdminMapper adminMapper;

    @Autowired
    public LearningServiceImpl(AdminMapper adminMapper){
        this.adminMapper=adminMapper;
    }





}
