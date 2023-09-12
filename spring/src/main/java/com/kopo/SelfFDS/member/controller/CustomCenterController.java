package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.model.dto.LostCard;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/customCenter")
public class CustomCenterController {

    private final MemberService memberService;

    @Autowired
    public CustomCenterController(MemberService memberService) {
        this.memberService = memberService;
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


    @RequestMapping("/lostCardRegister")
    public String lostCardRegisterPage(@RequestParam("cardId") String cardId,@RequestParam("reissued") String reissued, Model model) {
        System.out.println("cardId"+cardId+"reissued"+reissued);
        model.addAttribute("cardId", cardId);
        model.addAttribute("reissued", reissued);
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

        ModelAndView mav = new ModelAndView();
        mav.addObject("lostCard", lostCard);
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
