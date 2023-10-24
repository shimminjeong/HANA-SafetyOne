package com.kopo.SelfFDS.payment.controller;

import com.kopo.SelfFDS.member.model.dto.Card;
import com.kopo.SelfFDS.member.model.dto.SafetyCard;
import com.kopo.SelfFDS.member.service.MemberService;
import com.kopo.SelfFDS.member.service.MyPageService;
import com.kopo.SelfFDS.naverSMS.SmsService;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import com.kopo.SelfFDS.payment.model.dto.WordToVec;
import com.kopo.SelfFDS.payment.model.dto.RequestFds;
import com.kopo.SelfFDS.payment.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService paymentService;

    private final MemberService memberService;
    private final MyPageService myPageService;


    @Autowired
    public PaymentController(PaymentService paymentService, MemberService memberService, MyPageService myPageService) {
        this.paymentService = paymentService;
        this.memberService = memberService;
        this.myPageService = myPageService;

    }


    @GetMapping("/paymentPage")
    public ModelAndView paymentPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<Card> cardInfo = memberService.selectCardOfEmail(email);
        ModelAndView mav = new ModelAndView();
        mav.addObject("cards", cardInfo);
        mav.setViewName("payment/paymentPage");
        return mav;
    }


    //    safety rule과 비교
    @PostMapping("/requestPayment")
    public ResponseEntity<String> responsePayment(@RequestBody PaymentLog paymentLog) {
        System.out.println("paymentLog" + paymentLog);
        System.out.println("paymentLogcardiD" + paymentLog.getCardId());
        SafetyCard responseSafetyCard = paymentService.requestPayment(paymentLog, paymentLog.getCardId());
        System.out.println("responseSafetyCard" + responseSafetyCard);
        System.out.println("date"+paymentLog.getPaymentDate());
        System.out.println("date"+paymentLog.getTime());
        if (responseSafetyCard == null) {
            System.out.println("거래승인");
            paymentLog.setPaymentApprovalStatus("Y");
            paymentService.insertApprovalTransaction(paymentLog);
            return ResponseEntity.ok("거래승인");
        } else {
            System.out.println("거래미승인");
            paymentLog.setPaymentApprovalStatus("N");
            paymentService.insertNotApprovalTransaction(paymentLog);
            return ResponseEntity.ok("거래미승인");
        }
    }

    @GetMapping("/paymentApproval")
    public ModelAndView paymentApproval(
            @RequestParam String cardId,
            @RequestParam String store,
            @RequestParam String address,
            @RequestParam String paymentDate,
            @RequestParam String time,
            @RequestParam String categorySmall,
            @RequestParam String storePhoneNumber,
            @RequestParam String road_address_name,
            @RequestParam int amount) {

        System.out.println(cardId);
        System.out.println(address);
        System.out.println(time);
        System.out.println(categorySmall);
        System.out.println(amount);

        int approvalNum=paymentService.selectPaymentLogId(cardId, store);
        ModelAndView mav = new ModelAndView();

        mav.setViewName("payment/receipt");
        Card cardInfo=myPageService.selectCardInfoByCardId(cardId);

        mav.addObject("cardId", cardId);
        mav.addObject("address", address);
        mav.addObject("time", time);
        mav.addObject("categorySmall", categorySmall);
        mav.addObject("amount", amount);
        mav.addObject("store", store);
        mav.addObject("paymentDate", paymentDate);
        mav.addObject("storePhoneNumber", storePhoneNumber);
        mav.addObject("cardInfo", cardInfo);
        mav.addObject("approvalNum", approvalNum);

        return mav;
    }


    @GetMapping("/paymentNotApproval")
    public ModelAndView paymentNotApproval(
            @RequestParam String cardId,
            @RequestParam String store,
            @RequestParam String address,
            @RequestParam String paymentDate,
            @RequestParam String time,
            @RequestParam String categorySmall,
            @RequestParam String storePhoneNumber,
            @RequestParam String road_address_name,
            @RequestParam int amount) {

        System.out.println(cardId);
        System.out.println(address);
        System.out.println(time);
        System.out.println(categorySmall);
        System.out.println(amount);

        ModelAndView mav = new ModelAndView();

        Card cardInfo=myPageService.selectCardInfoByCardId(cardId);

        mav.addObject("cardId", cardId);
        mav.addObject("address", address);
        mav.addObject("time", time);
        mav.addObject("categorySmall", categorySmall);
        mav.addObject("amount", amount);
        mav.addObject("store", store);
        mav.addObject("paymentDate", paymentDate);
        mav.addObject("storePhoneNumber", storePhoneNumber);
        mav.addObject("cardInfo", cardInfo);

        mav.setViewName("payment/receiptNotApproval");
        return mav;
    }


    @PostMapping("/detectFds")
    public ResponseEntity<String> detectFds(@RequestBody PaymentLog paymentLog) {
        System.out.println("paymentLog" + paymentLog);
        String time = paymentLog.getTime();
        String regionName = paymentLog.getAddress();
        String categorySmall = paymentLog.getCategorySmall();
        int amount = paymentLog.getAmount();
        String cardId=paymentLog.getCardId();
        WordToVec wordToVec = paymentService.wordEmbedding(regionName, categorySmall, time, amount);
        System.out.println("wordToVec" + wordToVec);
        // FastAPI로 데이터 전송
        RestTemplate restTemplate = new RestTemplate();
        String fastApiUrl = "http://localhost:8000/anomalyDetection";

        RequestFds fastApiRequest = new RequestFds();
        fastApiRequest.setCardId(cardId);
        fastApiRequest.setWordToVec(wordToVec);

        ResponseEntity<String> response = restTemplate.postForEntity(fastApiUrl, fastApiRequest, String.class);

        String fastApiResponse = response.getBody().replaceAll("\"", "");
        System.out.println("Sending response to client: " + fastApiResponse);
        if (fastApiResponse.equals("Y")){
            paymentService.updateAnomalyDetection(cardId);
        }
        return ResponseEntity.ok(fastApiResponse);
    }


}
