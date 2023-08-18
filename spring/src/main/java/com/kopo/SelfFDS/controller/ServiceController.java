package com.kopo.SelfFDS.controller;

import com.kopo.SelfFDS.model.dto.Card;
import com.kopo.SelfFDS.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/service")
public class ServiceController {

    private final CardService cardService;

    @Autowired
    public ServiceController(CardService cardService) {
        this.cardService = cardService;
    }

    @GetMapping("/serviceInfo")
    public String servicePage() {
        return "service/serviceInfo";
    }

    @GetMapping("/selffds")
    public String selffdsPage() {
        return "service/selffds";
    }

    @GetMapping("/selffdsRegion")
    public String selffdsRegionPage() {
        return "service/selffdsRegion";
    }

    @GetMapping("/fds")
    public String fdsPage() {
        return "service/fds";
    }

    @GetMapping("/lostcard")
    public String lostCardPage() {
        return "service/lostcard";
    }

    @RequestMapping("/cardSelect")
    public ModelAndView cardSelectPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = cardService.selectCardOfEmail(email);

        for (Card card : cardInfo) {
            System.out.println("Card ID: " + card.getCard_id());
            System.out.println("CVC: " + card.getCard_cvc());
            // 나머지 카드 정보도 출력하거나 원하는 대로 수정하세요
        }

        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("service/cardSelect");
        return mav;
    }


    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody String cardId) {
        Card updateCard = cardService.selectCardOfCardId(cardId);
        if (updateCard.getSelffds_ser_status().equals("N")) {
            updateCard.setSelffds_ser_status("Y");
            cardService.updateSelfFdsStatus(updateCard);
            return "selffds 서비스 신청 성공";
        } else {
            return "selffds 서비스 신청 실패";
        }
    }

    @PostMapping("/cancleCard")
    @ResponseBody
    public String cancleCard(@RequestBody String cardId) {
        Card updateCard = cardService.selectCardOfCardId(cardId);
        if (updateCard.getSelffds_ser_status().equals("Y"))  {
            updateCard.setSelffds_ser_status("N");
            cardService.updateSelfFdsStatus(updateCard);
            return "selffds 서비스 해제 성공";
        } else {
            return "selffds 서비스 해제 실패";
        }

    }


}
