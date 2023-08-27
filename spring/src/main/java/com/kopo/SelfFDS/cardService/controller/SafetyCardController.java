package com.kopo.SelfFDS.cardService.controller;

import com.kopo.SelfFDS.cardService.model.dto.Card;
import com.kopo.SelfFDS.cardService.model.dto.SafetyRegister;
import com.kopo.SelfFDS.cardService.service.CardService;
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
public class SafetyCardController {

    private final CardService cardService;

    @Autowired
    public SafetyCardController(CardService cardService) {
        this.cardService = cardService;
    }

    @GetMapping("/")
    public String selffdsPage() {
        return "service/safetyCard";
    }


    @RequestMapping("/cardSelect")
    public ModelAndView cardSelectPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = cardService.selectCardOfEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("service/cardSelect");
        return mav;
    }


    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody String cardId, HttpServletRequest request) {
        Card updateCard = cardService.selectCardOfCardId(cardId);
        HttpSession session = request.getSession();

        if (updateCard.getSelffdsSerStatus().equals("N")) {
            updateCard.setSelffdsSerStatus("Y");
            session.setAttribute("cardId", cardId);
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
        if (updateCard.getSelffdsSerStatus().equals("Y")) {
            updateCard.setSelffdsSerStatus("N");
            cardService.updateSelfFdsStatus(updateCard);
            return "selffds 서비스 해제 성공";
        } else {
            return "selffds 서비스 해제 실패";
        }
    }


    @GetMapping("/region")
    public ModelAndView regionPage() {
        List<String> regionList = cardService.selectAllRegionName();
        ModelAndView mav = new ModelAndView();
        mav.addObject("regionList", regionList);
        mav.setViewName("service/region");
        return mav;
    }

    @GetMapping("/category")
    public ModelAndView selfCategoryPage() {
        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();

        List<String> bigCategory = cardService.selectAllBigCategory();

        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = cardService.selectSmallCategoryOfBigCategory(bigcategory);
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

//    @GetMapping("/selffdsTotal")
//    public ModelAndView selffdsTotalPage() {
//
//        ModelAndView mav = new ModelAndView();
//        //region
//        List<String> regionList = safetyRegisterService.selectAllRegionName();
//        mav.addObject("regionList", regionList);
//
//        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();
//
//        List<String> bigCategory = safetyRegisterService.selectAllBigCategory();
//
//        for (String bigcategory : bigCategory) {
//            List<SafetyRegister> smallCategoryList = safetyRegisterService.selectSmallCategoryOfBigCategory(bigcategory);
//            categoryMap.put(bigcategory, smallCategoryList);
//        }
//
//        mav.addObject("categoryMap", categoryMap);
//        mav.setViewName("service/selffdsTotal");
//        return mav;
//    }


}
