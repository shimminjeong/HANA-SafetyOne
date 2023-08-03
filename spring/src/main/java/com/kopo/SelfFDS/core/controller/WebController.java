package com.kopo.SelfFDS.core.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    @GetMapping("/")
    public String index() {
        System.out.println("test");
        return "index";
    }
}
