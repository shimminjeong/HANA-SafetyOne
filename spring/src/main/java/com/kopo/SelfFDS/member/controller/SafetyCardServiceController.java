package com.kopo.SelfFDS.member.controller;


import com.kopo.SelfFDS.member.model.dto.*;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.IconUIResource;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/safetyCard")
public class SafetyCardServiceController {

    private final MemberService memberService;

    @Autowired
    public SafetyCardServiceController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/")
    public String safetyCardPage() {
        return "service/safetyCard";
    }


    @GetMapping("/safetySettingCopy")
    public String safetySettginCopyPage() {
        return "service/safetySettingCopy";
    }

    @GetMapping("/safetySettingNew")
    public String safetySettingNewPage() {
        return "service/safetySettingNew";
    }

    @GetMapping("/region")
    public ModelAndView regionPage(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        List<String> regionList = memberService.selectAllRegionName();
        mav.addObject("regionList", regionList);
        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();
        mav.addObject("categoryMap", categoryMap);


        HttpSession session = request.getSession();
        String cardId = (String) session.getAttribute("cardId");
        List<CardHistory> resultList = memberService.selectCountRegionOfCardId(cardId);

        mav.addObject("resultList", resultList);
        mav.setViewName("service/region");
        return mav;
    }

    @GetMapping("/time")
    public ModelAndView timePage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("service/time");
        return mav;
    }


    @GetMapping("/category")
    public ModelAndView CategoryPage() {
        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();
        List<String> bigCategory = memberService.selectAllBigCategory();
        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        ModelAndView mav = new ModelAndView();
        mav.addObject("categoryMap", categoryMap);
        mav.addObject("categoryBigList", bigCategory);
        mav.setViewName("service/category");
        return mav;
    }


    @GetMapping("/safetySettingOk")
    public String safetySettingOkPage() {
        return "service/safetySettingOk";
    }

    @GetMapping("/safetyCardStatus")
    public ModelAndView safetyCardStatusPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("service/safetyCardStatus");
        return mav;
    }


    @RequestMapping("/safetyCardSelect")
    public ModelAndView safetyCardSelectPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("service/safetyCardSelect");
        return mav;
    }


    //    @PostMapping("/registerCard")
//    @ResponseBody
//    public String registerCard(@RequestBody String cardId, HttpServletRequest request) {
//        Card updateCard = memberService.selectCardOfCardId(cardId);
//        HttpSession session = request.getSession();
//        session.setAttribute("cardId", cardId);
//        return "안심카드 서비스 신청 성공";
//    }


    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody String cardId, HttpServletRequest request) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        HttpSession session = request.getSession();
        updateCard.setSelffdsSerStatus("Y");
        session.setAttribute("cardId", cardId);
        memberService.updateSelfFdsStatus(updateCard);
        return "안심카드 서비스 신청 성공";
    }

    @PostMapping("/cancleCard")
    @ResponseBody
    public String cancleCard(@RequestBody String cardId) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        if (updateCard.getSelffdsSerStatus().equals("Y")) {
            updateCard.setSelffdsSerStatus("N");
            memberService.updateSelfFdsStatus(updateCard);
            return "안심카드 서비스 해제 성공";
        } else {
            return "안심카드 서비스 해제 실패";
        }
    }


    @GetMapping("/selffdsTotal")
    public ModelAndView selffdsTotalPage(@RequestParam("selectedButtons") String selectedButtons) {
        ModelAndView mav = new ModelAndView();
        System.out.println("selectedButtons : " + selectedButtons);
        String[] buttonsArray = selectedButtons.split(",");
        mav.addObject("selectArray", buttonsArray);
        for (int i = 0; i < buttonsArray.length; i++) {
            System.out.println(buttonsArray[i]);
        }
        //region
        List<String> regionList = memberService.selectAllRegionName();
        mav.addObject("regionList", regionList);
        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();

        List<String> bigCategory = memberService.selectAllBigCategory();
        System.out.println(bigCategory.get(0));

        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        mav.addObject("categoryBigList", bigCategory);
        mav.addObject("categoryMap", categoryMap);


        mav.setViewName("service/selffdsTotal");
        System.out.println("modelandview로 넘어감");
        return mav;
    }

    @PostMapping("/selectSmallByBigCategory")
    public ResponseEntity<List<SafetyRegister>> insertSafetyInfo(@RequestBody SafetyRegister SafetyRegister) {
        List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(SafetyRegister.getCategoryBig());
        if (!smallCategoryList.isEmpty()) {
            return ResponseEntity.ok(smallCategoryList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/safetySetting")
    public ModelAndView safetySettingPage() {
        ModelAndView mav = new ModelAndView();
//        @RequestParam("selectedButtons") String selectedButtons
//        System.out.println("selectedButtons : "+selectedButtons);
//        String[] buttonsArray = selectedButtons.split(",");
//        mav.addObject("selectArray", buttonsArray);
//        for(int i=0;i<buttonsArray.length;i++){
//            System.out.println(buttonsArray[i]);
//        }
        //region
        List<String> regionList = memberService.selectAllRegionName();
        mav.addObject("regionList", regionList);
        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();

        List<String> bigCategory = memberService.selectAllBigCategory();
        System.out.println(bigCategory.get(0));

        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        mav.addObject("categoryBigList", bigCategory);
        mav.addObject("categoryMap", categoryMap);


        mav.setViewName("service/safetySetting");
        System.out.println("modelandview로 넘어감");
        return mav;
    }


    @PostMapping("/insertSetting")
    @ResponseBody
    public String insertSafetyInfo(@RequestBody List<List<String>> safetyCard, HttpSession session) {
        String cardId = (String) session.getAttribute("cardId");
        int enrollSeq = memberService.selectSafetySettingEnrollSeqByCardId(cardId);
        System.out.println(enrollSeq + cardId);
        memberService.insertSafetySetting(cardId, enrollSeq, safetyCard);
        System.out.println("gogo");
        return "insert성공";
    }


    @PostMapping("/selectSafetyInfo")
    @ResponseBody
    public ResponseEntity<List<SafetyCard>> selectSafetyInfo(@RequestBody SafetyCard safetyCard) {
        String cardId = safetyCard.getCardId();
        List<SafetyCard> safetyCardList = memberService.selectAllSafetyCardOfCardId(cardId);
        System.out.println("safetyCardList" + safetyCardList);
        if (!safetyCardList.isEmpty()) {
            return ResponseEntity.ok(safetyCardList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


}
