package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping("/fds")
public class FdsServiceController {

    private final MemberService memberService;

    @Autowired
    public FdsServiceController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/")
    public String fdsPage() {
        return "service/fds";
    }

    @RequestMapping("/fdsCardSelect")
    public ModelAndView fdsCardSelectPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("service/fdsCardSelect");
        return mav;
    }

    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody String cardId, HttpServletRequest request) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        memberService.regFdsService(updateCard);
        return "이상 소비 알림 서비스 신청 성공";
//        return "이미 신청이 완료된 카드입니다.";
//
//        return "카드등록 후 6개월 이상의 카드만 서비스 신청이 가능합니다.";

    }

    @GetMapping("/fdsRegisterOk")
    public String fdsRegisterOkPage() {
        return "service/fdsRegisterOk";
    }

    @PostMapping("/cancleCard")
    @ResponseBody
    public String cancleCard(@RequestBody String cardId) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        memberService.unregFdsService(updateCard);
        return "이상 소비 알림 서비스 해제 성공";

    }
}
