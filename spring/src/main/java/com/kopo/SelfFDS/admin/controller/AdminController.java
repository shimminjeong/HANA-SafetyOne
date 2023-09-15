package com.kopo.SelfFDS.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

//    private final PaymentService paymentService;

//    @Autowired
//    public AdminController(PaymentService paymentService) {
//        this.paymentService = paymentService;
//    }


    @GetMapping("/")
    public String adminMainPage() {
        return "admin/adminMain";
    }

    @GetMapping("/safetyCard")
    public String adminSafetyCardPage() {
        return "admin/safetyCard";
    }

    @GetMapping("/fds")
    public String adminFdsPage() {
        return "admin/fds";
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
