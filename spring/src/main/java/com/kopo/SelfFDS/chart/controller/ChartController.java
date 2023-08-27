package com.kopo.SelfFDS.chart.controller;

import com.kopo.SelfFDS.chart.model.dto.CardHistory;
import com.kopo.SelfFDS.chart.service.CardHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/chart")
public class ChartController {

    private final CardHistoryService cardHistoryService;

    @Autowired
    public ChartController(CardHistoryService cardHistoryService) {
        this.cardHistoryService = cardHistoryService;
    }

    @GetMapping ("/regionServiceChart")
    public ResponseEntity<List<CardHistory>> regionServiceChart(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String cardId = (String) session.getAttribute("cardId");
        List<CardHistory> resultList = cardHistoryService.selectCountRegionOfCardId(cardId);

        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
