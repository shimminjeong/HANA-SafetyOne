package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

//    신청한 card의 거래내역을 학습
    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody List<String> cardIds, HttpServletRequest request) {

        RestTemplate restTemplate = new RestTemplate();
        // FastAPI URL
        String fastApiUrl = "http://localhost:8000/train";

        for (String cardId : cardIds) {
            System.out.println("cardId"+cardId);
            Card updateCard = memberService.selectCardOfCardId(cardId);
            memberService.regFdsService(updateCard);
            // Request Body를 위한 Map 생성
            Map<String, String> body = new HashMap<>();
            body.put("cardId", cardId);

            // FastAPI 호출
            ResponseEntity<String> response = restTemplate.postForEntity(fastApiUrl, body, String.class);
            System.out.println("response" + response);


        }
        return "이상 소비 알림 서비스 신청 성공";
//        return "이미 신청이 완료된 카드입니다.";
//
//        return "카드가입일자 기준 6개월 이상의 카드만 서비스 신청이 가능합니다.";

    }

    @GetMapping("/fdsRegisterOk")
    public String fdsRegisterOkPage() {
        return "service/fdsRegisterOk";
    }

    @PostMapping("/cancleCard")
    @ResponseBody
    public String cancleCard(@RequestBody List<String> cardIds) {
        for (String cardId : cardIds) {
            Card updateCard = memberService.selectCardOfCardId(cardId);
            memberService.unregFdsService(updateCard);
        }
        return "이상 소비 알림 서비스 해제 성공";

    }
}
