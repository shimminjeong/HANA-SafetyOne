package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dao.MemberMapper;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
public class WebController {

    private final MemberService memberService;

    @Autowired
    public WebController(MemberService memberService) {
        this.memberService = memberService;
    }


//    requestmapping
//    다양한 HTTP 요청 메서드(GET, POST, PUT, DELETE 등)에 대해 URL을 매핑하는 데 사용됩니다.
//    method 속성을 사용하여 특정 HTTP 메서드에 대해서만 매핑할 수 있습니다.
    @RequestMapping("/")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index");
        return mav;
    }

    @RequestMapping("/join")
    public ModelAndView join() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("join");
        return mav;
    }


//    postmapping
//    HTTP POST 요청에 대해 특정 URL을 매핑하는 데 사용됩니다.
//    주로 웹 폼 데이터를 서버로 전송하는 경우 사용합니다.
//    이 어노테이션은 @RequestMapping의 축약형으로, method 속성이 기본적으로 RequestMethod.POST로 설정되어 있습니다.
    @PostMapping("/loginMember")
    public ResponseEntity<String> loginMember(@RequestBody HashMap<String, String> loginData, HttpServletRequest request) {
        Member loginMember = memberService.loginMember(loginData);
        HttpSession session = request.getSession();
        if (loginMember!=null) {
            session.setAttribute("name",loginMember.getName());
            session.setAttribute("id",loginMember.getId());
            return ResponseEntity.ok("로그인 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("로그인 실패");
        }
    }

    @PostMapping("/joinMember")
    @ResponseBody
    public ResponseEntity<String> joinMember(@RequestBody Member member){
            memberService.joinMember(member);
        return null;
    }


    @RequestMapping("/mypage")
    public ModelAndView index(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        Member memberInfo = memberService.selectNameOfMember(id);
        ModelAndView mav = new ModelAndView();

        mav.addObject("member",memberInfo);
        mav.setViewName("mypage");
        return mav;
    }





}