package com.kopo.SelfFDS.member.controller;


import com.kopo.SelfFDS.member.model.dto.*;
import com.kopo.SelfFDS.member.service.MemberService;
import com.kopo.SelfFDS.member.service.MyPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/safetyCard")
public class SafetyCardServiceController {

    private final MemberService memberService;
    private final MyPageService myPageService;

    @Autowired
    public SafetyCardServiceController(MemberService memberService, MyPageService myPageService) {
        this.memberService = memberService;
        this.myPageService = myPageService;
    }

    @GetMapping("/")
    public String safetyCardPage() {
        return "service/safetyCard";
    }

    @GetMapping("/safetySettingNew")
    public String safetySettingNewPage() {
        return "service/safetySettingNew";
    }


    //setting값들 다시 settingPage로 넘겨줌
    @GetMapping("/safetySettingValue")
    public String safetySettingValue(@RequestParam(value = "region", required = false) List<String> regions,
                                     @RequestParam(value = "time", required = false) List<String> times,
                                     @RequestParam(value = "categorySmall", required = false) List<String> categorySmalls,
                                     Model model) {
        if (regions != null && !regions.isEmpty()) {
            model.addAttribute("regions", regions);
            System.out.println(regions);
        }

        if (times != null && !times.isEmpty()) {
            model.addAttribute("times", times);
        }

        if (categorySmalls != null && !categorySmalls.isEmpty()) {
            model.addAttribute("categorySmalls", categorySmalls);
        }
        return "service/safetySettingNew";
    }


    @GetMapping("/region")
    public ModelAndView regionPage(HttpServletRequest request) {
        String regionExist = "regionExist";
        ModelAndView mav = new ModelAndView();
        List<String> regionList = memberService.selectAllRegionName();
        mav.addObject("regionList", regionList);
        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();
        mav.addObject("categoryMap", categoryMap);

        mav.addObject("regionExist", regionExist);
        mav.setViewName("service/region");
        return mav;
    }

    @GetMapping("/time")
    public String timePage(@RequestParam(value = "region", required = false) List<String> regions, Model model) {
        String regionExist = "regionExist";
        String timeExist = "timeExist";
        if (regions != null && !regions.isEmpty()) {
            model.addAttribute("regions", regions);
            model.addAttribute("regionExist", regionExist);
        }
        model.addAttribute("timeExist", timeExist);
        return "service/time";
    }


    @GetMapping("/category")
    public ModelAndView CategoryPage(@RequestParam(value = "region", required = false) List<String> regions,
                                     @RequestParam(value = "time", required = false) List<String> times, HttpServletRequest request) {
        String regionExist = "regionExist";
        String timeExist = "timeExist";
        String categoryExist = "categoryExist";

        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();
        List<String> bigCategory = memberService.selectAllBigCategory();
        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");
        List<CardHistory> categoryTopList = memberService.selectSmallCategroyTopOfEmail(email);
        List<String> categoryAllList = myPageService.selectAllSmallCategory();

        List<String> categorySmallList = new ArrayList<>();
        for (CardHistory cardHistory : categoryTopList) {
            categorySmallList.add(cardHistory.getCategorySmall());
        }
        categoryAllList.removeAll(categorySmallList);


        List<String> smallCategoryList = new ArrayList<>();

        for (int i = 0; i < 3 && i < categoryAllList.size(); i++) {
            String categorySmall = categoryAllList.get(i);
            smallCategoryList.add(categorySmall);
        }


        List<String> bigCategoryList = new ArrayList<>();

        for (int i = 0; i < 3 && i < categoryAllList.size(); i++) {
            String categorySmall = categoryAllList.get(i);
            String result = memberService.selectBigCategoryOfSmallCategory(categorySmall);
            System.out.println("result" + result);
            bigCategoryList.add(result);
        }



        ModelAndView mav = new ModelAndView();
        mav.addObject("categoryTopList", categoryTopList);
        mav.addObject("categoryMap", categoryMap);
        mav.addObject("categoryBigList", bigCategory);
        mav.addObject("categoryAllList", categoryAllList);
        mav.addObject("bigCategoryList", bigCategoryList);
        mav.addObject("smallCategoryList", smallCategoryList);
        System.out.println("categoryTopList"+categoryTopList);


        if (regions != null && !regions.isEmpty()) {
            mav.addObject("regions", regions);
            mav.addObject("regionExist", regionExist);
        }

        if (times != null && !times.isEmpty()) {
            mav.addObject("times", times);
            mav.addObject("timeExist", timeExist);
        }
        mav.addObject("categoryExist", categoryExist);
        mav.setViewName("service/category");
        return mav;
    }


    @GetMapping("/safetySettingOk")
    public String safetySettingOkPage(HttpSession session) {
        session.removeAttribute("cardId");
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

//    @RequestMapping("/safetyCardStop")
//    public ModelAndView safetyCardStopPage(HttpServletRequest request) {
//        HttpSession session = request.getSession();
//        String email = (String) session.getAttribute("email");
//        List<SafetyCard> safetyInfoList = memberService.selectSafetySettingByEmail(email);
//
//        ModelAndView mav = new ModelAndView();
//        mav.addObject("safetyInfoList", safetyInfoList);
//        mav.setViewName("service/safetyCardStopCopy");
//        return mav;
//    }


    @PostMapping("/updateStopDate")
    @ResponseBody
    public String registerCard(@RequestBody SafetyCard safetyCard) {

        safetyCard.setStatus("N");
        System.out.println("safetyCard" + safetyCard);
        memberService.updateStopDate(safetyCard);
        return "일시해제업데이트";
    }


    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody List<String> cardIds, HttpServletRequest request) {
        HttpSession session = request.getSession();
        for (String cardId : cardIds) {
            Card updateCard = memberService.selectCardOfCardId(cardId);
            memberService.regSafetyService(updateCard);
            Card cardInfo = myPageService.selectCardInfoByCardId(cardId);
            session.setAttribute("cardId", cardId);
            session.setAttribute("cardName", cardInfo.getCardName());
        }
        return "안심카드 서비스 신청 성공";
    }

    @PostMapping("/cancleCard")
    @ResponseBody
    public String cancleCard(@RequestBody List<String> cardIds, HttpSession session) {
        for (String cardId : cardIds) {
            Card updateCard = memberService.selectCardOfCardId(cardId);
            memberService.unregSafetyService(updateCard);
        }
        return "안심카드 서비스 해제 성공";

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
    public String insertSafetyInfo(@RequestBody Map<String, Object> requestData, HttpSession session) {
        String cardId = (String) session.getAttribute("cardId");

        List<List<String>> settingsList = (List<List<String>>) requestData.get("settingsList");

        memberService.insertSafetySetting(cardId, settingsList);
        session.removeAttribute("cardId");
        session.removeAttribute("cardName");
        System.out.println("gogo");
        return "insert성공";
    }

    @PostMapping("/selectSafetyInfo")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> selectSafetyInfo(@RequestBody SafetyCard safetyCard, HttpSession session) {
        String cardId = safetyCard.getCardId();
        List<SafetyCard> safetyCardList = memberService.selectAllSafetyCardOfCardId(cardId);
        List<String> regionList = memberService.selectAllRegionName();
        System.out.println("safetyCardList" + safetyCardList);

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("safetyCardList", safetyCardList);
        responseMap.put("regionList", regionList);
        return ResponseEntity.ok(responseMap);


    }

    @RequestMapping("/CardStop")
    public ModelAndView safetyCardStopPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> safetyCardList = memberService.selectSafetyCardYByEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("safetyCardList", safetyCardList);
        mav.setViewName("safetyCardStop");
        return mav;
    }

    @RequestMapping("/safetyCardStop")
    public ModelAndView CardStopPage(HttpServletRequest request) {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> safetyCardList = memberService.selectSafetyCardYByEmail(email);
        System.out.println("safetyCardList"+safetyCardList);
        ModelAndView mav = new ModelAndView();
        mav.addObject("safetyCardList", safetyCardList);

        mav.setViewName("service/safetyCardStop");
        return mav;
    }

//    @PostMapping("/stopCardDetail")
//    @ResponseBody
//    public Map<String, Object> stopCardDetail(@RequestBody SafetyCard safetyCard) {
//        List<SafetyCard> safetyRuleList = memberService.selectSafetyCardNotRegionByCarId(safetyCard.getCardId());
//        List<String> safetyRegionList = memberService.selectSafetyCardRegionByCarId(safetyCard.getCardId());
//        List<String> regionAllList = memberService.selectAllRegionName();
//        // Create a Map to hold the results
//        regionAllList.removeAll(safetyRegionList);
//
//        Map<String, Object> response = new HashMap<>();
//        response.put("safetyRuleList", safetyRuleList);
//        response.put("safetyRegionList", safetyRegionList);
//        response.put("regionAllList", regionAllList);
//
//        return response; // Return the map as the respons
//
//    }

    @GetMapping("/stopCardDetail")
    public ModelAndView stopCardDetail(@RequestParam("cardId") String cardId) {
        System.out.println("safetyCard.getCardId()"+cardId);

        Card cardInfo = myPageService.selectCardInfoByCardId(cardId);
        List<SafetyCard> safetyRuleList = memberService.selectSafetyCardNotRegionByCarId(cardId);
        List<SafetyCard> safetyRegionList = memberService.selectSafetyCardRegionByCarId(cardId);
        List<String> regionAllList = memberService.selectAllRegionName();
        // Create a Map to hold the results
        for (SafetyCard safetyCard : safetyRegionList) {
            String regionName = safetyCard.getRegionName();
            regionAllList.remove(regionName);
        }
        System.out.println("safetyRuleList"+safetyRuleList);

        ModelAndView mav=new ModelAndView();
        mav.addObject("cardInfo",cardInfo);
        mav.addObject("safetyRuleList",safetyRuleList);
        mav.addObject("safetyRegionList",safetyRegionList);
        mav.addObject("regionAllList",regionAllList);
        mav.setViewName("service/safetyCardStopDetail");

        return mav;

    }


}