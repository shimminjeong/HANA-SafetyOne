package com.kopo.SelfFDS.member.controller;


import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.model.dto.SafetyRegister;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/safetyCard")
public class CardServiceController {

    private final MemberService memberService;

    @Autowired
    public CardServiceController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/")
    public String selffdsPage() {
        return "service/safetyCard";
    }


    @RequestMapping("/cardSelect")
    public ModelAndView cardSelectPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("service/cardSelect");
        return mav;
    }


    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody String cardId, HttpServletRequest request) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        HttpSession session = request.getSession();
        session.setAttribute("cardId", cardId);
        return "selffds 서비스 신청 성공";
    }


//    @PostMapping("/registerCard")
//    @ResponseBody
//    public String registerCard(@RequestBody String cardId, HttpServletRequest request) {
//        Card updateCard = cardService.selectCardOfCardId(cardId);
//        HttpSession session = request.getSession();
//
//        if (updateCard.getSelffdsSerStatus().equals("N")) {
//            updateCard.setSelffdsSerStatus("Y");
//            session.setAttribute("cardId", cardId);
//            cardService.updateSelfFdsStatus(updateCard);
//            return "selffds 서비스 신청 성공";
//        } else {
//            return "selffds 서비스 신청 실패";
//        }
//    }

    @PostMapping("/cancleCard")
    @ResponseBody
    public String cancleCard(@RequestBody String cardId) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        if (updateCard.getSelffdsSerStatus().equals("Y")) {
            updateCard.setSelffdsSerStatus("N");
            memberService.updateSelfFdsStatus(updateCard);
            return "selffds 서비스 해제 성공";
        } else {
            return "selffds 서비스 해제 실패";
        }
    }


    @GetMapping("/region")
    public ModelAndView regionPage() {
        List<String> regionList = memberService.selectAllRegionName();
        ModelAndView mav = new ModelAndView();
        mav.addObject("regionList", regionList);
        mav.setViewName("service/region");
        return mav;
    }

    @GetMapping("/category")
    public ModelAndView selfCategoryPage() {
        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();

        List<String> bigCategory = memberService.selectAllBigCategory();

        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        ModelAndView mav = new ModelAndView();
        mav.addObject("categoryMap", categoryMap);
        mav.setViewName("service/category");
        return mav;
    }

    @GetMapping("/time")
    public String timePage() {
        return "service/time";
    }

    @GetMapping("/selffdsTotal")
    public ModelAndView selffdsTotalPage(@RequestParam(name = "selectedOptions", required = false) List<String> selectedOptions) {
        ModelAndView mav = new ModelAndView();

        System.out.println("selectedOptions"+selectedOptions);
        //region
        List<String> regionList = memberService.selectAllRegionName();
        mav.addObject("regionList", regionList);

        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();

        List<String> bigCategory = memberService.selectAllBigCategory();

        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        mav.addObject("categoryMap", categoryMap);

        // Process selectedOptions as needed and pass them to the view
        mav.addObject("selectedOptions", selectedOptions);

        mav.setViewName("service/selffdsTotal");
        return mav;
    }


}
