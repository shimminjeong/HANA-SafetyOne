package com.kopo.SelfFDS.admin.controller;

import com.kopo.SelfFDS.admin.service.AdminService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.swing.plaf.IconUIResource;
import javax.swing.plaf.synth.SynthOptionPaneUI;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    @Autowired
    public AdminController(AdminService adminService) {
        this.adminService = adminService;

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
        System.out.println("response"+response);

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
