package com.kopo.SelfFDS.member.controller;

import com.kopo.SelfFDS.member.model.dto.CardHistory;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.service.MemberService;
import com.kopo.SelfFDS.member.service.MyPageService;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
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
public class MemberController {

    private final MemberService memberService;
    private final MyPageService myPageService;

    @Autowired
    public MemberController(MemberService memberService, MyPageService myPageService) {
        this.memberService = memberService;
        this.myPageService = myPageService;
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
            Member updatemember = memberService.selectNameOfMember(member.getEmail());
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
            session.setAttribute("phone", loginMember.getPhone());
            session.setAttribute("address", loginMember.getAddress());

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


    @PostMapping("/cardHistoryReceipt")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cardHistoryReceipt(@RequestBody PaymentLog paymentLog) {
        Map<String, Object> response = new HashMap<>();
        System.out.println("paymentLog.getPaymentLogId()"+paymentLog.getPaymentLogId());
        System.out.println("paymentLog.getCardId()"+paymentLog.getCardId());
        PaymentLog paymentLog1 = myPageService.selectByPaymentLogId(paymentLog.getPaymentLogId());


        Card cardInfo=myPageService.selectCardInfoByCardId(paymentLog.getCardId());
        response.put("paymentLog1", paymentLog1);
        response.put("cardInfo", cardInfo);

        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @RequestMapping("/mypage")
    public ModelAndView mypage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);
        List<CardHistory> cardHistoryList = myPageService.selectCardHistoryByEmail(email);
        List<CardHistory> categoryTopList = myPageService.selectTopCategoryByEmail(email);
        List<CardHistory> storeCntList = myPageService.selectTopStoreCountByEmail(email);
        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.addObject("cardHistoryList", cardHistoryList);
        mav.addObject("categoryTopList", categoryTopList);
        mav.addObject("storeCntList", storeCntList);


        mav.setViewName("member/mypage");
        return mav;
    }

    @PostMapping("/cardinfo")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> postCardInfo(@RequestBody CardHistory cardHistory) {
        String cardId = cardHistory.getCardId();

        int amountSum = myPageService.selectSumAmountByCardId(cardId);
        int amountCnt = myPageService.selectCountByCardId(cardId);
        String safetyStatus = myPageService.selectSafetyStatusByCardId(cardId);
        String fdsStatus = myPageService.selectFdsStatusByCardId(cardId);
        Card cardInfo = myPageService.selectCardInfoByCardId(cardId);


        Map<String, Object> response = new HashMap<>();

        response.put("amountSum", amountSum);
        response.put("amountCnt", amountCnt);
        response.put("safetyStatus", safetyStatus);
        response.put("fdsStatus", fdsStatus);
        response.put("cardInfo", cardInfo);
        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/mypageCardHistory")
    public ModelAndView mypageCardHistory(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);
        List<CardHistory> cardHistoryList = myPageService.selectCardHistoryByEmail(email);
        List<PaymentLog> paymentLogList = myPageService.selectPaymentLogByEmail(email);
        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.addObject("cardHistoryList", cardHistoryList);
        mav.addObject("paymentLogList", paymentLogList);

        mav.setViewName("member/mypageCardHistory");
        return mav;
    }

    @PostMapping("/cardHistoryDetail")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cardHistoryDetail(@RequestBody CardHistory cardHistory) {
        String cardId = cardHistory.getCardId();
        System.out.println("cardId" + cardId);

        List<CardHistory> cardHistoryList = myPageService.selectCardHistoryByCardId(cardId);
        List<PaymentLog> paymentLogList = myPageService.selectPaymentLogByCardId(cardId);
        System.out.println("paymentLogList" + paymentLogList);
        Card cardInfo = myPageService.selectCardInfoByCardId(cardId);
        Map<String, Object> response = new HashMap<>();
        response.put("cardHistoryList", cardHistoryList);
        response.put("paymentLogList", paymentLogList);
        response.put("cardInfo", cardInfo);

        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/mypageReport")
    public ModelAndView mypageReport(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
//        List<CardHistory> cardHistoryList = myPageService.selectCardHistoryByEmail(email);
        List<CardHistory> monthList = myPageService.select6MonthTotalAmountByEmail(email);
        List<CardHistory> topCategoryList = myPageService.selectTopCategoryTotalAmountByEmail(email);
        List<CardHistory> topCountCategoryList = myPageService.selectTopCategoryCountByEmail(email);
        List<CardHistory> differenceList = myPageService.selectTopCategoryDifferenceByEmail(email);
//        List<CardHistory> categoryCntList = myPageService.selectTopStoreCountByEmail(email);
        List<CardHistory> timeList = myPageService.selectTimeTotalAmountByEmail(email);
        List<String> categoryAllList = myPageService.selectAllSmallCategory();
        System.out.println("categoryAllList" + categoryAllList);
        List<String> categoryList = myPageService.selectCategory3monthByEmail(email);
        System.out.println("categoryList" + categoryList);
        categoryAllList.removeAll(categoryList);
        System.out.println("categoryAllList" + categoryAllList);
        List<CardHistory> regionNameList = myPageService.selectRegionTotalAmountByEmail(email);
        ModelAndView mav = new ModelAndView();


        mav.addObject("monthList", monthList);
        mav.addObject("topCategoryList", topCategoryList);
        mav.addObject("topCountCategoryList", topCountCategoryList);
        mav.addObject("differenceList", differenceList);
        mav.addObject("categoryAllList", categoryAllList);
        mav.addObject("timeList", timeList);
        mav.addObject("regionNameList", regionNameList);

        mav.setViewName("member/mypageReport");
        return mav;
    }


//    mypage copy
//    @PostMapping("/cardinfo")
//    @ResponseBody
//    public ResponseEntity<Map<String, Object>> postCardInfo(@RequestBody CardHistory cardHistory) {
//        String cardId=cardHistory.getCardId();
//
//        int difference=memberService.selectDifferenceMonthByCardId(cardId);
//
//        List<CardHistory> list=memberService.selectDiffCategoryOfMonthByCardId(cardId);
//
//        List<CardHistory> monthData=memberService.selectAmountOfMonthByCardId(cardId);
//        List<CardHistory> weekData=memberService.selectAmountOfWeekByCardId(cardId);
//        List<CardHistory> decreaseData=memberService.selectAmountOfMonthByCardIdCategory(cardId,list.get(0).getCategorySmall());
//        List<CardHistory> increaseData=memberService.selectAmountOfMonthByCardIdCategory(cardId,list.get(1).getCategorySmall());
//
//        List<CardHistory> cardHistoryServiceList = memberService.selectAllCardHistoryOfCardId(cardId);
//        Map<String, Object> response = new HashMap<>();
//        response.put("difference", difference);
//        response.put("monthData", monthData);
//        response.put("weekData", weekData);
//        response.put("decreaseList", list.get(0));
//        response.put("increaseList", list.get(1));
//        response.put("decreaseData", decreaseData);
//        response.put("increaseData", increaseData);
//
//        response.put("cardHistoryList", cardHistoryServiceList);
//        if (!cardHistoryServiceList.isEmpty()) {
//            return ResponseEntity.ok(response);
//        } else {
//            return ResponseEntity.notFound().build();
//        }
//    }


    @PostMapping("/cardDetail")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> CardDetailInfo(@RequestBody CardHistory cardHistory) {
        String cardId = cardHistory.getCardId();
        System.out.println("coin");


        List<CardHistory> monthData = memberService.selectAmountOfMonthByCardId(cardId);
        List<CardHistory> weekData = memberService.selectAmountOfWeekByCardId(cardId);

        List<CardHistory> cardHistoryServiceList = memberService.selectAllCardHistoryOfCardId(cardId);
        Map<String, Object> response = new HashMap<>();
        response.put("monthData", monthData);
        response.put("weekData", weekData);
        System.out.println("weekData" + weekData);

        response.put("cardHistoryList", cardHistoryServiceList);
        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/updateChart")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateChartInfo(@RequestBody CardHistory cardHistory) {
        String cardId = cardHistory.getCardId();
        System.out.println("coin");


        List<CardHistory> dayData = memberService.selectDayByCardIdDate(cardHistory.getCardId(), cardHistory.getCardHisDate());

        Map<String, Object> response = new HashMap<>();
        response.put("dayData", dayData);

        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
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