package com.kopo.SelfFDS.admin.controller;

import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.service.AdminService;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import com.kopo.SelfFDS.payment.model.dto.WordToVec;
import com.kopo.SelfFDS.payment.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final PaymentService paymentService;

    @Autowired
    public AdminController(AdminService adminService, PaymentService paymentService) {
        this.adminService = adminService;
        this.paymentService = paymentService;
    }

    @GetMapping("/")
    public ModelAndView adminMainPage() {

        ModelAndView mav = new ModelAndView();
        mav.addObject("memberCnt", adminService.getAllMemberCnt());
        mav.addObject("cardCnt", adminService.getAllCardCnt());
        mav.addObject("amountSum", adminService.getAllAmountSumOfDay());
        mav.addObject("memberCntByYearRate", adminService.getMemberCntByYearRate());
        mav.addObject("cardCntByYearRate", adminService.getCardCntByYearRate());
        mav.addObject("amountSumByDateRate", adminService.getAmountSumByDateRate());
        mav.addObject("memberCntByYear", adminService.getMemberCntByYear());
        mav.addObject("cardCntByYear", adminService.getCardCntByYear());
        mav.addObject("amountSumByYear", adminService.getAmountSumByDate());
        mav.setViewName("admin/adminMain");

        return mav;
    }

    @GetMapping("/safetyCard")
    public String adminSafetyCardPage() {
        return "admin/safetyCard";
    }

    @GetMapping("/fds")
    public ModelAndView adminFdsPage() {
        ModelAndView mav = new ModelAndView();
        System.out.println(adminService.selectFdsAndMember());

        mav.addObject("FdsMemberList", adminService.selectFdsAndMember());
        mav.setViewName("admin/adminFds");
        return mav;
    }

    @GetMapping("/fdsData")
    public ModelAndView adminFdsDataPage() {
        ModelAndView mav = new ModelAndView();
        List<PaymentLog> anomalyList = adminService.getAllAnomalyData();
        mav.addObject("anomalyList", anomalyList);
        mav.setViewName("admin/adminFdsData");
        return mav;
    }

    @PostMapping("/anomalyChart")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> anomalyChart(@RequestBody PaymentLog paymentLog) {
        PaymentLog paymentPayLoad = adminService.getAnomalyDataById(paymentLog.getPaymentLogId());
        Map<String, Object> calStatsData = adminService.calStats(paymentLog.getCardId());
        PaymentLog paymentLogs = adminService.getAnomalyDataById(paymentLog.getPaymentLogId());
        String hour = paymentLogs.getPaymentDate().split(" ")[1];
        System.out.println(" "+paymentLogs.getAddress() + paymentLogs.getCategorySmall() + hour + paymentLogs.getAmount());

        WordToVec embeddingData = paymentService.wordEmbedding(paymentLogs.getAddress(),paymentLogs.getCategorySmall(),hour,paymentLogs.getAmount());
        System.out.println("embeddingData"+embeddingData);
        calStatsData.put("address", paymentLogs.getAddress());
        calStatsData.put("category", paymentLogs.getCategorySmall());

        calStatsData.put("embeddingData", embeddingData);

        List<CardHistoryStats> regionCntList=adminService.getRegionGroupCntByCardId(paymentLog.getCardId());
        List<CardHistoryStats> categoryCntList=adminService.getCategoryGroupCntByCardId(paymentLog.getCardId());

        calStatsData.put("regionCntList", regionCntList);
        calStatsData.put("categoryCntList", categoryCntList);

        return ResponseEntity.ok(calStatsData);
    }


    @PostMapping("/learning")
    public ResponseEntity<String> learningPage(@RequestParam("cardId") String cardId) {
        // RestTemplate 인스턴스 생성
        RestTemplate restTemplate = new RestTemplate();

        System.out.println("cardId" + cardId);

        // FastAPI URL
        String fastApiUrl = "http://localhost:8000/train";

        // Request Body를 위한 Map 생성
        Map<String, String> body = new HashMap<>();
        body.put("cardId", cardId);

        // FastAPI 호출
        ResponseEntity<String> response = restTemplate.postForEntity(fastApiUrl, body, String.class);
        System.out.println("response" + response);

        return ResponseEntity.ok(response.getBody());
    }


    @GetMapping("/cluster")
    public String adminClusterPage() {
        return "admin/cluster";
    }

    @GetMapping("/email")
    public String adminEmailPage() {
        return "admin/email";
    }


}
