package com.kopo.SelfFDS.controller;

import com.kopo.SelfFDS.model.dto.Card;
import com.kopo.SelfFDS.model.dto.CardHistory;
import com.kopo.SelfFDS.service.CardHistoryService;
import com.kopo.SelfFDS.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/service")
public class ServiceController {

    private final CardService cardService;

    private final CardHistoryService cardHistoryService;

    @Autowired
    public ServiceController(CardService cardService, CardHistoryService cardHistoryService) {
        this.cardService = cardService;
        this.cardHistoryService = cardHistoryService;
    }

    @GetMapping("/serviceInfo")
    public String servicePage() {
        return "service/serviceInfo";
    }

    @GetMapping("/selffds")
    public String selffdsPage() {
        return "service/selffds";
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


    @GetMapping("/selffdsRegion")
    public ModelAndView selffdsRegionPage() {
        List<String> regionList = cardHistoryService.selectAllRegionName();
        ModelAndView mav = new ModelAndView();
        mav.addObject("regionList", regionList);
        mav.setViewName("service/selffdsRegion");
        return mav;
    }

    @GetMapping("/selffdsCategory")
    public ModelAndView selfCategoryPage() {
        Map<String, List<CardHistory>> categoryMap = new HashMap<>();

        List<String> bigCategory = cardHistoryService.selectAllBigCategory();

        for (String bigcategory : bigCategory) {
            List<CardHistory> smallCategoryList = cardHistoryService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        ModelAndView mav = new ModelAndView();
        mav.addObject("categoryMap", categoryMap);
        mav.setViewName("service/selffdsCategory");
        return mav;
    }

    @GetMapping("/selffdsTime")
    public String selffdsTimePage() {
        return "service/selffdsTime";
    }

    @GetMapping("/selffdsTotal")
    public ModelAndView selffdsTotalPage() {

        ModelAndView mav = new ModelAndView();
        //region
        List<String> regionList = cardHistoryService.selectAllRegionName();
        mav.addObject("regionList", regionList);

        //category
        Map<String, List<CardHistory>> categoryMap = new HashMap<>();

        List<String> bigCategory = cardHistoryService.selectAllBigCategory();

        for (String bigcategory : bigCategory) {
            List<CardHistory> smallCategoryList = cardHistoryService.selectSmallCategoryOfBigCategory(bigcategory);
            categoryMap.put(bigcategory, smallCategoryList);
        }

        mav.addObject("categoryMap", categoryMap);
        mav.setViewName("service/selffdsTotal");
        return mav;
    }


    @GetMapping("/fds")
    public String fdsPage() {
        return "service/fds";
    }

    @GetMapping("/lostcard")
    public String lostCardPage() {
        return "service/lostcard";
    }


}
