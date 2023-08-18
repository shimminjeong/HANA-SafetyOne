package com.kopo.SelfFDS.controller;

import com.kopo.SelfFDS.model.dto.Card;
import com.kopo.SelfFDS.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

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



}
