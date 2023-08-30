package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dto.CardHistory;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/regionServiceChart")
    public ResponseEntity<List<CardHistory>> regionServiceChart(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String cardId = (String) session.getAttribute("cardId");
        List<CardHistory> resultList = memberService.selectCountRegionOfCardId(cardId);
        System.out.println(resultList.get(0).getRegionName());
        System.out.println(resultList.get(0).getRegionCnt());
        System.out.println(resultList.get(0).getAmountSum());

        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/categoryServiceChart")
    @ResponseBody
    public ResponseEntity<List<CardHistory>> categoryServiceChart(@RequestBody CardHistory cardHistory, HttpServletRequest request) {
        HttpSession session = request.getSession();

        String cardId = (String) session.getAttribute("cardId");
        System.out.println("Cardid" + cardId);
        System.out.println("cardHistory.getCategoryBig()" + cardHistory.getCategoryBig());
        List<CardHistory> resultList = memberService.selectCountSmallCategoryOfCardIdCategoryBig(cardId, cardHistory.getCategoryBig());
        System.out.println("gggg");
        System.out.println(resultList.get(0).getCategoryBig());
        System.out.println(resultList.get(0).getCategorySmall());
        System.out.println(resultList.get(0).getCategoryCnt());
        System.out.println(resultList.get(0).getAmountSum());

        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/timeServiceChart")
    public ResponseEntity<List<CardHistory>> timeServiceChart(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String cardId = (String) session.getAttribute("cardId");
        List<CardHistory> resultList = memberService.selectCountTimeOfCardId(cardId);


        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


}
