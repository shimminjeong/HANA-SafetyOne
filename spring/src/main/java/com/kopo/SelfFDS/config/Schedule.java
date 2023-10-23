package com.kopo.SelfFDS.config;

import com.kopo.SelfFDS.admin.service.AdminService;
import com.kopo.SelfFDS.member.model.dto.SafetyCard;
import com.kopo.SelfFDS.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.swing.plaf.synth.SynthOptionPaneUI;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Component
@EnableScheduling
public class Schedule {

    private final MemberService memberService;
    private final AdminService adminService;

    @Autowired
    public Schedule(MemberService memberService, AdminService adminService) {
        this.memberService = memberService;
        this.adminService = adminService;
    }

    @Scheduled(cron = "0 0 0 * * *")
    public void checkSafetyCardDates() {
        List<SafetyCard> safetyCardList = memberService.selectAllSafetyCard();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        for (SafetyCard card : safetyCardList) {
            memberService.updateSafetyStatus(card.getSafetyIdSeq(),"N");

            if (card.getStopStartDate() != null){

                String cardStopStartDateStr = card.getStopStartDate().substring(0, 10);
                String cardStopEndDateStr = card.getStopEndDate().substring(0, 10);
                LocalDate cardStopStartDate = LocalDate.parse(cardStopStartDateStr, formatter);

                if (cardStopStartDate.equals(LocalDate.now())){
                    memberService.updateSafetyStatus(card.getSafetyIdSeq(),"N");
                }
                if (cardStopEndDateStr.equals(LocalDate.now())){
                    memberService.updateSafetyStatus(card.getSafetyIdSeq(),"Y");
                }
            }

        }
    }

    @Scheduled(cron = "0 0 0 1 3,6,9,12 *")
    public void trainCluster(){
        adminService.clusterUpdate();
    }

}
