package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.model.dto.CardHistory;
import com.kopo.SelfFDS.member.model.dto.LostCard;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.service.MemberService;
import com.kopo.SelfFDS.member.service.MyPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/customCenter")
public class CustomCenterController {

    private final MemberService memberService;
    private final MyPageService myPageService;

    @Autowired
    public CustomCenterController(MemberService memberService, MyPageService myPageService) {
        this.memberService = memberService;
        this.myPageService = myPageService;
    }


    @GetMapping("/lostCardInfo")
    public ModelAndView lostCardInfoPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("customCenter/lostCardInfo");
        return mav;
    }

    @GetMapping("/lostCardSelect")
    public ModelAndView lostCardSelectPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("customCenter/lostCardSelect");
        return mav;
    }

    @PostMapping("/confirmCardHistory")
    public ResponseEntity<List<CardHistory>> confirmCardHistory(@RequestBody CardHistory cardHistory) {

        List<CardHistory> cardHistories = myPageService.selectCardHistoryByCardId(cardHistory.getCardId());
        System.out.println("cardHistories"+cardHistories);
        return ResponseEntity.ok(cardHistories);

    }




    @RequestMapping("/lostCardRegister")
    public String lostCardRegisterPage(@RequestParam("cardId") String cardId,@RequestParam("reissued") String reissued, Model model) {
        System.out.println("cardId"+cardId+"reissued"+reissued);
        System.out.println("cardId"+cardId+"reissued"+reissued);
        Card cardInfo = myPageService.selectCardInfoByCardId(cardId);
        model.addAttribute("cardId", cardId);
        model.addAttribute("reissued", reissued);
        model.addAttribute("cardInfo", cardInfo);
        return "customCenter/lostCardRegister";
    }


    @PostMapping("/lostCardRegisterOk")
    public ModelAndView lostCardRegisterOk(String cardId,String lostDate, String lostPlace,String lostReason,String reissued) {

        LostCard lostCard = new LostCard();
        lostCard.setCardId(cardId);
        lostCard.setLostDate(lostDate);
        lostCard.setLostPlace(lostPlace);
        lostCard.setLostReason(lostReason);
        lostCard.setReissued(reissued);
        System.out.println("lostCard"+lostCard);
        memberService.insertLostCardInfo(lostCard);
        Card cardInfo=myPageService.selectCardInfoByCardId(cardId);


        ModelAndView mav = new ModelAndView();
        mav.addObject("lostCard", lostCard);
        mav.addObject("cardInfo", cardInfo);
        mav.addObject("todayDate", LocalDate.now(ZoneId.of("Asia/Seoul")));
        mav.setViewName("customCenter/lostCardInfo");
        return mav;

    }




    @PostMapping("/loginMember")
    public ResponseEntity<String> loginMember(@RequestBody HashMap<String, String> loginData, HttpServletRequest request) {
        Member loginMember = memberService.loginMember(loginData);
        HttpSession session = request.getSession();

        if (loginMember != null) {
            session.setAttribute("name", loginMember.getName());
            session.setAttribute("email", loginMember.getEmail());

            System.out.println("세션에 저장된 name: " + session.getAttribute("name"));
            System.out.println("세션에 저장된 email: " + session.getAttribute("email"));

            return ResponseEntity.ok("로그인 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("로그인 실패");
        }
    }

}
