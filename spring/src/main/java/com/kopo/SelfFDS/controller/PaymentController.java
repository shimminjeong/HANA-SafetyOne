package com.kopo.SelfFDS.controller;

import com.kopo.SelfFDS.model.dto.Card;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/payment")
public class PaymentController {

 /*   private final CardService cardService;

    @Autowired
    public PaymentController(CardService cardService) {
        this.cardService = cardService;
    }*/

    @GetMapping("/paymentPage")
    public String paymentPage() {
        return "payment/paymentPage";
    }

    @GetMapping("/drawChartex")
    public String drawChartexPage() {
        return "chart";
    }




}
