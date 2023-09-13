package com.kopo.SelfFDS.payment.controller;

import com.kopo.SelfFDS.member.model.dto.SafetyCard;
import com.kopo.SelfFDS.member.service.MemberService;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import com.kopo.SelfFDS.payment.service.PaymentService;
import com.kopo.SelfFDS.payment.service.PaymentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

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
    public ResponseEntity<String> responsePayment(@RequestBody PaymentLog paymentLog){
        System.out.println("paymentLog"+paymentLog);
        SafetyCard responseSafetyCard=paymentService.requestPayment(paymentLog,paymentLog.getCardId());
        System.out.println("responseSafetyCard"+responseSafetyCard);
        if (responseSafetyCard == null) {
            System.out.println("거래승인");
            return ResponseEntity.ok("거래승인");
        } else {
            System.out.println("거래미승인");
            return ResponseEntity.ok("거래미승인");
        }
    }

//    @Transactional
//    @PostMapping("/paymentApproval")
//    public ModelAndView(){
//        return
//    }

    @GetMapping("/paymentApproval")
    public String paymentApprovalPage() {
        System.out.println("거래승인page로 이동");
        return "payment/receipt";
    }

    //정상결제되면 영수증 페이지로 이동
//    @PostMapping("/insertPaymentLog")
//    public ResponseEntity<String> insertPaymentLog(){
//        return null;
//    }




}
