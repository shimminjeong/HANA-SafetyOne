package com.kopo.SelfFDS.controller;

import com.kopo.SelfFDS.model.dto.Card;
import com.kopo.SelfFDS.model.dto.CardHistory;
import com.kopo.SelfFDS.model.dto.Member;

import com.kopo.SelfFDS.service.CardHistoryService;
import com.kopo.SelfFDS.service.CardService;
import com.kopo.SelfFDS.service.MemberService;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class WebController {

    private final MemberService memberService;
    private final CardService cardService;

    private final CardHistoryService cardHistoryService;

    @Autowired
    public WebController(MemberService memberService, CardService cardService, CardHistoryService cardHistoryService) {
        this.memberService = memberService;
        this.cardService = cardService;
        this.cardHistoryService = cardHistoryService;
    }


    @RequestMapping("/")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index");
        return mav;
    }


    @RequestMapping(value = "/logout")
    public ModelAndView deleteGuest(HttpSession session) {
        String guest_id = (String) session.getAttribute("guest_id");
        System.out.println(guest_id);
        ModelAndView mav = new ModelAndView();
        session.invalidate();
        mav.addObject("msg", "로그아웃 성공");
        mav.addObject("loc", "/");
        mav.setViewName("message");
        return mav;
    }

    @RequestMapping("/login")
    public String loginForm() {
        return "login";
    }


    @GetMapping("/join")
    public String createForm() {
        return "join";
    }



    @RequestMapping("/update")
    public ModelAndView update(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Member memberInfo = memberService.selectNameOfMember(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("member", memberInfo);
        mav.setViewName("update");
        return mav;
    }

    @PostMapping("/updateMember")
    @ResponseBody
    public String modifyMember(@RequestBody Member member) {
        try {
            System.out.println("Received memberId: " + member.getEmail());
            Member updatemember=memberService.selectNameOfMember(member.getEmail());
            updatemember.setName(member.getName());
            updatemember.setPassword(member.getPassword());
            updatemember.setPhone(member.getPhone());

            memberService.modifyMember(updatemember);
            return "회원 수정 성공";
        } catch (Exception e) {
            // 회원가입 처리 중 예외가 발생하면 "회원등록실패"를 반환합니다.
            e.printStackTrace();
            return "회원 수정 실패";
        }
    }

    @PostMapping("/deleteMember")
    @ResponseBody
    public String deleteMember(@RequestBody String email) {
        try {
            memberService.deleteMember(email);
            return "회원 삭제 성공";
        } catch (Exception e) {
            // 회원가입 처리 중 예외가 발생하면 "회원등록실패"를 반환합니다.
            e.printStackTrace();
            return "회원 삭제 성공";
        }
    }


    //    postmapping
//    HTTP POST 요청에 대해 특정 URL을 매핑하는 데 사용됩니다.
//    주로 웹 폼 데이터를 서버로 전송하는 경우 사용합니다.
//    이 어노테이션은 @RequestMapping의 축약형으로, method 속성이 기본적으로 RequestMethod.POST로 설정되어 있습니다.
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

    @PostMapping("/joinMember")
    @ResponseBody
    public String joinMember(@RequestBody Member member) {
        try {
            memberService.joinMember(member);
            return "회원 등록 성공";
        } catch (Exception e) {
            // 회원가입 처리 중 예외가 발생하면 "회원등록실패"를 반환합니다.
            e.printStackTrace();
            return "회원 등록 실패";
        }
    }


    @RequestMapping("/mypage")
    public ModelAndView mypage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        System.out.println("email "+email);
        Member memberInfo = memberService.selectNameOfMember(email);
        List<Card> cardInfo = cardService.selectCardOfEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("member",memberInfo);
        mav.addObject("cards", cardInfo);

        mav.setViewName("member/mypage");
        return mav;
    }

    @PostMapping("/cardinfo")
    @ResponseBody
    public ResponseEntity<List<CardHistory>> postCardInfo(@RequestBody CardHistory cardHistory) {
        System.out.println("Received cardId: " + cardHistory.getCard_id());

        List<CardHistory> cardHistoryServiceList=cardHistoryService.selectAllCardHistoryOfCardId(cardHistory.getCard_id());
        if (!cardHistoryServiceList.isEmpty()) {
            return ResponseEntity.ok(cardHistoryServiceList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/selectAll")
    public ModelAndView selectmember(HttpServletRequest request) {
        List<Member> memberList = memberService.getAllMember();

        ModelAndView mav = new ModelAndView();
        mav.addObject("members", memberList);
        mav.setViewName("selectmember");
        return mav;
    }


}