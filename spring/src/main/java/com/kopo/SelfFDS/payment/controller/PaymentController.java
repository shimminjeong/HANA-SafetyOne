package com.kopo.SelfFDS.payment.controller;

import com.kopo.SelfFDS.member.model.dto.SafetyCard;
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

@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService paymentService;

    @Autowired
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }


    @GetMapping("/paymentPage")
    public String paymentPage() {
        return "payment/paymentPage";
    }


    //    safety rule과 비교
    @PostMapping("/requestPayment")
    public ResponseEntity<String> responsePayment(@RequestBody PaymentLog paymentLog) {
        System.out.println("paymentLog" + paymentLog);
        SafetyCard responseSafetyCard = paymentService.requestPayment(paymentLog, paymentLog.getCardId());
        System.out.println("responseSafetyCard" + responseSafetyCard);
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
        // 데이터 처리 로직
        // 예를 들어, 데이터를 데이터베이스에 저장하거나, 다른 서비스로 전송 등

        ModelAndView mav = new ModelAndView();
        // 필요한 뷰 이름 설정. 예를 들면:
        mav.setViewName("payment/receipt");  // 뷰 이름을 적절하게 변경해야 합니다.

        // 뷰에 데이터를 전달하려면 아래와 같이 추가:
        mav.addObject("cardId", cardId);
        mav.addObject("address", address);
        mav.addObject("time", time);
        mav.addObject("categorySmall", categorySmall);
        mav.addObject("amount", amount);
        // 다른 데이터도 동일한 방식으로 추가

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
        return ResponseEntity.ok(fastApiResponse);

    }




    @GetMapping("/paymentNotApproval")
    public String paymentNotApprovalPage() {
        System.out.println("거래승인page로 이동");
        return "payment/receipt";
    }

    //정상결제되면 영수증 페이지로 이동
//    @PostMapping("/insertPaymentLog")
//    public ResponseEntity<String> insertPaymentLog(){
//        return null;
//    }


}
