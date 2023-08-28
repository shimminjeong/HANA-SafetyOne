package com.kopo.SelfFDS.payment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @GetMapping("/paymentPage")
    public String paymentPage() {
        return "payment/paymentPage";
    }

    @GetMapping("/drawChartex")
    public String drawChartexPage() {
        return "chart";
    }




}
