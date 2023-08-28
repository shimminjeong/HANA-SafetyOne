package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dto.CardHistory;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/chart")
public class ChartController {

    private final MemberService memberService;

    @Autowired
    public ChartController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping ("/regionServiceChart")
    public ResponseEntity<List<CardHistory>> regionServiceChart(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String cardId = (String) session.getAttribute("cardId");
        List<CardHistory> resultList = memberService.selectCountRegionOfCardId(cardId);

        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
