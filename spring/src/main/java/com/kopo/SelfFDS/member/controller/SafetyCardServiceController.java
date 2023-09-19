package com.kopo.SelfFDS.member.controller;


import com.kopo.SelfFDS.member.model.dto.*;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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


        HttpSession session = request.getSession();
        String cardId = (String) session.getAttribute("cardId");
        List<CardHistory> resultList = memberService.selectCountRegionOfCardId(cardId);

        mav.addObject("resultList", resultList);
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
                                     @RequestParam(value = "time", required = false) List<String> times) {
        String regionExist = "regionExist";
        String timeExist = "timeExist";
        String categoryExist = "categoryExist";

        Map<String, List<SafetyRegister>> categoryMap = new HashMap<>();
        List<String> bigCategory = memberService.selectAllBigCategory();
        for (String bigcategory : bigCategory) {
            List<SafetyRegister> smallCategoryList = memberService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        ModelAndView mav = new ModelAndView();
        mav.addObject("categoryMap", categoryMap);
        mav.addObject("categoryBigList", bigCategory);

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

    @RequestMapping("/safetyCardStop")
    public ModelAndView safetyCardStopPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<SafetyCard> safetyInfoList = memberService.selectSafetySettingByEmail(email);

        ModelAndView mav = new ModelAndView();
        mav.addObject("safetyInfoList", safetyInfoList);
        mav.setViewName("service/safetyCardStop");
        return mav;
    }

    @PostMapping("/updateStopDate")
    @ResponseBody
    public String registerCard(@RequestBody SafetyCard safetyCard) {

        safetyCard.setStatus("N");
        System.out.println("safetyCard" + safetyCard);
        memberService.updateStopDate(safetyCard);
        return "일시정지업데이트";
    }


    @PostMapping("/registerCard")
    @ResponseBody
    public String registerCard(@RequestBody String cardId, HttpServletRequest request) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        memberService.regSafetyService(updateCard);
        HttpSession session = request.getSession();
        session.setAttribute("cardId", cardId);
        return "안심카드 서비스 신청 성공";
    }

    @PostMapping("/cancleCard")
    @ResponseBody
    public String cancleCard(@RequestBody String cardId, HttpSession session) {
        Card updateCard = memberService.selectCardOfCardId(cardId);
        memberService.unregSafetyService(updateCard);
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
        String safetyStringInfo = (String) requestData.get("safetyStringInfo");

        memberService.insertSafetySetting(cardId, settingsList, safetyStringInfo);

        System.out.println("gogo");
        return "insert성공";
    }


    @PostMapping("/selectSafetyInfo")
    @ResponseBody
    public ResponseEntity<List<SafetyCard>> selectSafetyInfo(@RequestBody SafetyCard safetyCard, HttpSession session) {
        String cardId = safetyCard.getCardId();
        List<SafetyCard> safetyCardList = memberService.selectAllSafetyCardOfCardId(cardId);
        System.out.println("safetyCardList" + safetyCardList);
        if (!safetyCardList.isEmpty()) {
            return ResponseEntity.ok(safetyCardList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @RequestMapping("/stopCardPage")
    public String handleRequest(@RequestParam("cardId") String cardId, Model model) {
        // Now you have the cardId. You can process it as needed.
        List<SafetyCard> safetyInfo = memberService.selectAllSafetyCardOfCardId(cardId);
        model.addAttribute("safetyInfo", safetyInfo);
        System.out.println("safetyInfo" + safetyInfo);
        // Redirect or forward to another view if needed
        return "service/stopCardPage";
    }


}
