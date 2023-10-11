package com.kopo.SelfFDS.admin.controller;

import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.model.dto.Cluster;
import com.kopo.SelfFDS.admin.service.AdminService;
import com.kopo.SelfFDS.member.model.dto.LostCard;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.model.dto.SafetyCard;
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

//    @GetMapping("/")
//    public ModelAndView adminMainPage() {
//
//        ModelAndView mav = new ModelAndView();
//        mav.addObject("memberCnt", adminService.getAllMemberCnt());
//        mav.addObject("cardCnt", adminService.getAllCardCnt());
//        mav.addObject("amountSum", adminService.getAllAmountSumOfDay());
//        mav.addObject("memberCntByYearRate", adminService.getMemberCntByYearRate());
//        mav.addObject("cardCntByYearRate", adminService.getCardCntByYearRate());
//        mav.addObject("amountSumByDateRate", adminService.getAmountSumByDateRate());
//        mav.addObject("memberCntByYear", adminService.getMemberCntByYear());
//        mav.addObject("cardCntByYear", adminService.getCardCntByYear());
//        mav.addObject("amountSumByYear", adminService.getAmountSumByDate());
//        mav.setViewName("admin/adminMain");
//
//        return mav;
//    }

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
        mav.addObject("amountSumByWeek", adminService.getAmountSumByDate());
        mav.addObject("safetyDataCount", adminService.selectSafetyDataCount());
        mav.addObject("fdsDataCount", adminService.selectFdsDataCount());
        mav.addObject("clusterCount", adminService.selectClusterCount());

        mav.setViewName("admin/admin");

        return mav;
    }

    @GetMapping("/safety")
    public ModelAndView adminSafetyCardPage() {
        ModelAndView mav = new ModelAndView();
        mav.addObject("safetyMemberList", adminService.selectSafetyAndMember());
        mav.addObject("safetyCardCount", adminService.selectSafetyCardCount());
        mav.addObject("safetyDataCount", adminService.selectSafetyDataCount());
        mav.addObject("safetyUserCount", adminService.selectSafetyUserCount());
        mav.setViewName("admin/adminSafety");
        return mav;
    }

    @PostMapping("/safetyInfo")
    public ResponseEntity<Map<String,Object>> safetyInfo(@RequestParam String cardId) {
        int safetyCount = adminService.selectSafetyCountByCardId(cardId);
        List<SafetyCard> safetyCardList=paymentService.selectSafetyRuleByCardId(cardId);
        Map<String, Object> response = new HashMap<>();
        response.put("safetyCount", safetyCount);
        response.put("safetyCardList", safetyCardList);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/safetyData")
    public ModelAndView adminSafetyDataPage() {
        ModelAndView mav = new ModelAndView();

        mav.addObject("safetyCardCount", adminService.selectSafetyCardCount());
        mav.addObject("notApprovalList", adminService.getNotApprovalData());
        mav.addObject("safetyDataCount", adminService.selectSafetyDataCount());
        mav.addObject("safetyUserCount", adminService.selectSafetyUserCount());
        mav.setViewName("admin/adminSafetyData");
        return mav;
    }

    @GetMapping("/fds")
    public ModelAndView adminFdsPage() {
        ModelAndView mav = new ModelAndView();

        mav.addObject("FdsMemberList", adminService.selectFdsAndMember());
        mav.addObject("fdsCardCount", adminService.selectFdsCardCount());
        mav.addObject("fdsDataCount", adminService.selectFdsDataCount());
        mav.addObject("fdsUserCount", adminService.selectFdsUserCount());
        mav.setViewName("admin/adminFds");
        return mav;
    }

    @GetMapping("/fdsData")
    public ModelAndView adminFdsDataPage() {
        ModelAndView mav = new ModelAndView();
        List<PaymentLog> anomalyList = adminService.getAllAnomalyData();
        mav.addObject("anomalyList", anomalyList);
        mav.addObject("fdsCardCount", adminService.selectFdsCardCount());
        mav.addObject("fdsDataCount", adminService.selectFdsDataCount());
        mav.addObject("fdsUserCount", adminService.selectFdsUserCount());
        mav.setViewName("admin/adminFdsData");
        return mav;
    }

    @PostMapping("/fdsDataCount")
    public ResponseEntity<Map<String,Integer>> fdsDataCount(@RequestParam String cardId) {
        int fdsCount = adminService.selectFdsCountByCardId(cardId);

        Map<String, Integer> response = new HashMap<>();
        response.put("fdsCount", fdsCount);
        return ResponseEntity.ok(response);
    }


    @GetMapping("/paymentLogData")
    public ModelAndView paymentLogDataPage() {
        ModelAndView mav = new ModelAndView();
        List<PaymentLog> paymentLogList = adminService.getAllPaymentData();
        mav.addObject("paymentLogList", paymentLogList);
        mav.setViewName("admin/paymentLogPage");
        return mav;
    }

    @PostMapping("/anomalyChart")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> anomalyChart(@RequestBody PaymentLog paymentLog) {
        PaymentLog paymentPayLoad = adminService.getAnomalyDataById(paymentLog.getPaymentLogId());
        System.out.println("paymentPayLoad"+paymentPayLoad);

        Map<String, Object> calStatsData = adminService.calStats(paymentLog.getCardId());

        PaymentLog paymentLogs = adminService.getAnomalyDataById(paymentLog.getPaymentLogId());
        String hour = paymentLogs.getPaymentDate().split(" ")[1];


        WordToVec embeddingData = paymentService.wordEmbedding(paymentLogs.getAddress(), paymentLogs.getCategorySmall(), hour, paymentLogs.getAmount());

        System.out.println("embeddingData"+embeddingData);

        calStatsData.put("address", paymentLogs.getAddress());
        calStatsData.put("category", paymentLogs.getCategorySmall());

        calStatsData.put("embeddingData", embeddingData);

        List<CardHistoryStats> regionCntList = adminService.getRegionGroupCntByCardId(paymentLog.getCardId());
        List<CardHistoryStats> categoryCntList = adminService.getCategoryGroupCntByCardId(paymentLog.getCardId());

        calStatsData.put("regionCntList", regionCntList);
        calStatsData.put("categoryCntList", categoryCntList);

        return ResponseEntity.ok(calStatsData);
    }


    //    cardid의 거래내역을 가지고 gmm 알고리즘 학습
//    @PostMapping("/learning")
//    public ResponseEntity<String> learningPage(@RequestParam("cardId") String cardId) {
//        // RestTemplate 인스턴스 생성
//        RestTemplate restTemplate = new RestTemplate();
//
//        System.out.println("cardId" + cardId);
//
//
//
//
//        System.out.println("response" + response);
//
//        return ResponseEntity.ok(response.getBody());
//    }


    @GetMapping("/cluster")
    public ModelAndView adminClusterPage() {
        ModelAndView mav = new ModelAndView();
        List<Cluster> clusterInfo = adminService.selectClusterStatic();
        List<Cluster> clusterInfo2 = adminService.selectClusterStatic2();
        mav.addObject("clusterInfo", clusterInfo);
        mav.addObject("clusterInfo2", clusterInfo2);
        mav.setViewName("admin/cluster");
        return mav;
    }

    @PostMapping("/clusterDetail")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clusterDetailChart(@RequestBody Cluster cluster) {
        Map<String, Object> response = new HashMap<>();

        List<Cluster> clusterPeopleInfo = adminService.selectClusterPeopleInfo(cluster.getClusterNum());
        List<Cluster> clusterDetail = adminService.selectClusterDetail(cluster.getClusterNum());
        Cluster cluster1 = adminService.selectClusterStatic2ByCluster(cluster.getClusterNum());

        response.put("clusterPeopleInfo", clusterPeopleInfo);
        response.put("clusterDetail", clusterDetail);
        response.put("cluster1", cluster1);

        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/email")
    public ModelAndView adminEmailPage() {
        ModelAndView mav = new ModelAndView();
        List<String> clusterList = adminService.selectClusterNum();
        List<Member> memberList = adminService.selectClusterMemberInfo();
        mav.addObject("clusterList", clusterList);
        mav.addObject("memberList", memberList);
        mav.setViewName("admin/email");
        return mav;
    }

    @PostMapping("/clusterMemberList")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clusterMemberList(@RequestBody Member member) {
        List<Member> memberInfoList = adminService.selectMemberInfoByClusterNum(member.getClusterNum());

        Map<String, Object> response = new HashMap<>();
        response.put("memberInfoList", memberInfoList);
        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/clusterMailContent")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clusterMailContent(@RequestBody Cluster cluster) {
        List<Cluster> memberInfoList = adminService.selectClusterPeopleInfo(cluster.getClusterNum());
        int totalCount = 0;
        for (Cluster clusterItem : memberInfoList) {
            totalCount += clusterItem.getCount(); // 'getCount()'는 Cluster 클래스 내의 count 변수의 getter 메서드라고 가정합니다.
        }
        List<Cluster> clusterDetail = adminService.selectClusterDetail(cluster.getClusterNum());
        String top3 = "";
        String bottom3 = "";


        top3 = clusterDetail.get(2).getCategorySmall() + ", " +
                clusterDetail.get(1).getCategorySmall() + ", " +
                clusterDetail.get(0).getCategorySmall();

        // 마지막 행에서 마지막에서 2번째 행까지의 categorySmall 값을 가져오기
        bottom3 = clusterDetail.get(clusterDetail.size() - 1).getCategorySmall() + ", " +
                clusterDetail.get(clusterDetail.size() - 2).getCategorySmall() + ", " +
                clusterDetail.get(clusterDetail.size() - 3).getCategorySmall();

        String mailTitle="안녕하세요 하나카드 SafetyONE 입니다.";

        String mailContent = "안녕하세요, 고객님. 하나카드를 이용해 주셔서 진심으로 감사드립니다.\n\n" +
                "최근 3개월 동안 고객님의 소비 분석 결과, " + top3 + " 업종에서 주로 거래가 이루어진 것을 확인하였습니다.\n" +
                "반면에 "+ bottom3 + " 업종에서의 거래는 상대적으로 적게 발생한 것으로 파악되었습니다.\n\n" +
                "SafetyOne의 안심서비스를 통해 평소 거래하지 않는 업종에 대한 나만의 거래 규칙을 설정하시면, 금융사고를 사전에 예방할 수 있습니다.\n\n" +
                "하나카드와 함께하는 모든 순간에 감사드리며, 안전한 거래를 위해 항상 주의하시길 바랍니다.";
        Map<String, Object> response = new HashMap<>();
        response.put("mailTitle", mailTitle);
        response.put("mailContent", mailContent);
        response.put("memberCount", totalCount);
        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/lostCard")
    public ModelAndView adminLostCardPage() {
        List<LostCard> lostCardList = adminService.selectAllLostCard();
        List<String> reasonList = adminService.selectLostReason();
        ModelAndView mav = new ModelAndView();
        mav.addObject("lostCardList", lostCardList);
        mav.addObject("reasonList", reasonList);
        mav.setViewName("admin/adminLostCard");
        return mav;
    }

    @PostMapping("/lostReason")
    public ModelAndView adminLostReason() {
        List<LostCard> lostCardList = adminService.selectAllLostCard();
        List<String> reasonList = adminService.selectLostReason();
        ModelAndView mav = new ModelAndView();
        mav.addObject("lostCardList", lostCardList);
        mav.addObject("reasonList", reasonList);
        mav.setViewName("admin/adminLostCard");
        return mav;
    }




}
