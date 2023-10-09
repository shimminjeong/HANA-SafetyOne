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

        String email = (String) session.getAttribute("email");
        List<CardHistory> resultList = memberService.selectCountRegionOfEmail(email);

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

        String email = (String) session.getAttribute("email");
        List<CardHistory> resultList = memberService.selectCountSmallCategoryOfEmail(email, cardHistory.getCategoryBig());

//        List<String> categoryAllList = myPageService.selectAllSmallCategory();
//        System.out.println("categoryAllList"+categoryAllList);
//        List<String> categoryList = myPageService.selectCategory3monthByEmail(email);
//        System.out.println("categoryList"+categoryList);
//        categoryAllList.removeAll(categoryList);

        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/timeServiceChart")
    public ResponseEntity<List<CardHistory>> timeServiceChart(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");
        List<CardHistory> resultList = memberService.selectCountTimeOfEmail(email);


        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


}
