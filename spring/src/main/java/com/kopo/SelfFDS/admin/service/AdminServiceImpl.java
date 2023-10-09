package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.model.dao.AdminMapper;
import com.kopo.SelfFDS.admin.model.dto.*;
import com.kopo.SelfFDS.member.model.dao.MemberMapper;
import com.kopo.SelfFDS.member.model.dto.CardHistory;
import com.kopo.SelfFDS.member.model.dto.LostCard;
import com.kopo.SelfFDS.member.model.dto.Member;
import com.kopo.SelfFDS.member.model.dto.SafetyCard;
import com.kopo.SelfFDS.payment.model.dao.PaymentMapper;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.apache.commons.math3.distribution.NormalDistribution;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class AdminServiceImpl implements AdminService {

    private AdminMapper adminMapper;
    private MemberMapper memberMapper;
    private PaymentMapper paymentMapper;

    @Autowired
    public AdminServiceImpl(AdminMapper adminMapper, MemberMapper memberMapper, PaymentMapper paymentMapper){
        this.adminMapper=adminMapper;
        this.memberMapper = memberMapper;
        this.paymentMapper = paymentMapper;
    }


    @Override
    public int getAllMemberCnt() {
        int totalMemberCnt=0;
        List<MemberStats> list=adminMapper.getMemberCntByYear();
        for (MemberStats stats : list) {
            totalMemberCnt += stats.getMemberCnt();
        }
        return totalMemberCnt;
    }

    @Override
    public int getAllCardCnt() {
        int totalCardCnt=0;
        List<CardStats> list=adminMapper.getCardCntByYear();
        for (CardStats stats : list) {
            totalCardCnt += stats.getCardCnt();
        }
        return totalCardCnt;
    }

    @Override
    public int getAllAmountSumOfDay() {
        return adminMapper.getAllAmountSumOfDay();
    }

    @Override
    public List<MemberStats> getMemberCntByYear() {
        return adminMapper.getMemberCntByYear();
    }

    @Override
    public List<CardStats> getCardCntByYear() {
        return adminMapper.getCardCntByYear();
    }

    @Override
    public List<CardHistoryStats> getAmountSumByDate() {
        return adminMapper.getAmountSumByDate();
    }

    @Override
    public double getMemberCntByYearRate() {

        List<MemberStats> list =adminMapper.getMemberCntByYear();

        return ((list.get(1).getMemberCnt()-list.get(0).getMemberCnt())/list.get(1).getMemberCnt())*100;
    }

    @Override
    public double getCardCntByYearRate() {

        List<CardStats> list =adminMapper.getCardCntByYear();

        return ((list.get(1).getCardCnt()-list.get(0).getCardCnt())/list.get(1).getCardCnt())*100;
    }

    @Override
    public double getAmountSumByDateRate() {

        List<CardHistoryStats> list =adminMapper.getAmountSumByDate();


        return ((list.get(1).getAmountSum()-list.get(0).getAmountSum())/list.get(1).getAmountSum())*100;
    }

    @Override
    public List<Fds> selectFdsAndMember() {
        return adminMapper.selectFdsAndMember();
    }

    @Override
    public List<PaymentLog> getAllAnomalyData() {
        return adminMapper.getAllAnomalyData();
    }

    @Override
    public PaymentLog getAnomalyDataById(int paymentLogId) {
        return adminMapper.getAnomalyDataById(paymentLogId);
    }

    @Override
    public Map<String, Object> calStats(String cardId) {
        Fds fds=adminMapper.getFdsStatsByCardId(cardId);
        double regionMean=Double.parseDouble(fds.getRegionStats().split(",")[0]);
        double regionVar=Double.parseDouble(fds.getRegionStats().split(",")[1]);
        statsToPdf(regionMean,regionVar);
        double timeMean=Double.parseDouble(fds.getTimeStats().split(",")[0]);
        double timeVar=Double.parseDouble(fds.getTimeStats().split(",")[1]);
        statsToPdf(timeMean,timeVar);
        double categorySmallMean=Double.parseDouble(fds.getCategorySmallStats().split(",")[0]);
        double categorySmallVar=Double.parseDouble(fds.getCategorySmallStats().split(",")[1]);
        statsToPdf(categorySmallMean,categorySmallVar);
        double amountMean=Double.parseDouble(fds.getAmountStats().split(",")[0]);
        double amountVar=Double.parseDouble(fds.getAmountStats().split(",")[1]);
        statsToPdf(amountMean,amountVar);

        Map<String, Object> result = new HashMap<>();
        result.put("categorySmallPdf", statsToPdf(categorySmallMean,categorySmallVar));
        result.put("regionPdf", statsToPdf(regionMean, regionVar));
        result.put("timePdf", statsToPdf(timeMean, timeVar));
        result.put("amountPdf", statsToPdf(amountMean,amountVar));

//
////        X_features
        List<Integer> regionFeature=new ArrayList<>();
        List<Double> categoryFeature=new ArrayList<>();
        List<Integer> timeFeature=new ArrayList<>();
        List<Integer> amountFeature=new ArrayList<>();

        List<CardHistory> cardHistoryList=memberMapper.selectAllCardHistoryOfCardId(cardId);
        for (CardHistory cardHistory : cardHistoryList) {
            String regionName=null;
            if (cardHistory.getRegionName().split(" ").length > 1) {
                regionName = cardHistory.getRegionName().split(" ")[0];
            } else{
                regionName=cardHistory.getRegionName();
            }
//            System.out.println("cardHistory.getRegionName()"+cardHistory.getRegionName());
            int RegionNumeric = paymentMapper.selectPreprocessingRegion(regionName);
            Double categoryDouble = paymentMapper.selectPreprocessingCategory(cardHistory.getCategorySmall());
            int timeNumeric=Integer.parseInt(cardHistory.getCardHisTime().split(":")[0]);

            // 반환된 결과를 regionFeature 리스트에 추가

            regionFeature.add(RegionNumeric);
            categoryFeature.add(categoryDouble);
            timeFeature.add(timeNumeric);
            amountFeature.add(cardHistory.getAmount());
        }

        result.put("regionFeature", regionFeature);
        result.put("categoryFeature", categoryFeature);
        result.put("timeFeature", timeFeature);
        result.put("amountFeature", amountFeature);

        return result;
    }


    public List<List<Double>> statsToPdf(double mean, double variance) {
        double[] pdf_x = linspace(mean - 3 * Math.sqrt(variance), mean + 3 * Math.sqrt(variance), 1000);
        double[] pdf = new double[pdf_x.length];

        NormalDistribution distribution = new NormalDistribution(mean, Math.sqrt(variance));

        for (int i = 0; i < pdf_x.length; i++) {
            pdf[i] = distribution.density(pdf_x[i]);
        }

        // Convert double[] to List<Double>
        List<Double> x_pdfValues = Arrays.stream(pdf_x).boxed().collect(Collectors.toList());
        List<Double> pdfValues = Arrays.stream(pdf).boxed().collect(Collectors.toList());

        List<List<Double>> result = new ArrayList<>();
        result.add(x_pdfValues);
        result.add(pdfValues);

        return result;
    }


    public double[] linspace(double start, double end, int points){
        double[] linspace = new double[points];
        double step = (end - start) / (points - 1);

        for (int i = 0; i < points; i++) {
            linspace[i] = start + i * step;
        }

        return linspace;
    }

    @Override
    public List<CardHistoryStats> getRegionGroupCntByCardId(String cardId) {
        return adminMapper.getRegionGroupCntByCardId(cardId);
    }

    @Override
    public List<CardHistoryStats> getCategoryGroupCntByCardId(String cardId) {
        return adminMapper.getCategoryGroupCntByCardId(cardId);
    }

    @Override
    public List<LostCard> selectAllLostCard() {
        return adminMapper.selectAllLostCard();
    }

    @Override
    public List<String> selectLostReason() {
        return adminMapper.selectLostReason();
    }

    @Override
    public List<Cluster> selectClusterStatic() {
        return adminMapper.selectClusterStatic();
    }

    @Override
    public List<Cluster> selectClusterPeopleInfo(String clusterNum) {
        return adminMapper.selectClusterPeopleInfo(clusterNum);
    }

    @Override
    public List<Cluster> selectClusterDetail(String clusterNum) {
        return adminMapper.selectClusterDetail(clusterNum);
    }

    @Override
    public Cluster selectClusterStatic2ByCluster(String clusterNum) {
        return adminMapper.selectClusterStatic2ByCluster(clusterNum);
    }


    @Override
    public List<Cluster> selectClusterStatic2() {
        return adminMapper.selectClusterStatic2();
    }

    @Override
    public List<Member> selectMemberInfoByClusterNum(String clusterNum) {
        return adminMapper.selectMemberInfoByClusterNum(clusterNum);
    }

    @Override
    public List<String> selectClusterNum() {
        return adminMapper.selectClusterNum();
    }

    @Override
    public List<String> selectEmailByCluster(String clusterNum) {
        return adminMapper.selectEmailByCluster(clusterNum);
    }

    @Override
    public List<Member> selectClusterMemberInfo() {
        return adminMapper.selectClusterMemberInfo();
    }

    @Override
    public List<PaymentLog> getAllPaymentData() {
        return adminMapper.getAllPaymentData();
    }

    @Override
    public List<PaymentLog> getNotApprovalData() {
        return adminMapper.getNotApprovalData();
    }

    @Override
    public int selectFdsCardCount() {
        return adminMapper.selectFdsCardCount();
    }

    @Override
    public int selectSafetyCardCount() {
        return adminMapper.selectSafetyCardCount();
    }

    @Override
    public int selectFdsDataCount() {
        return adminMapper.selectFdsDataCount();
    }

    @Override
    public int selectSafetyDataCount() {
        return adminMapper.selectSafetyDataCount();
    }

    @Override
    public int selectFdsUserCount() {
        return adminMapper.selectFdsUserCount();
    }

    @Override
    public int selectSafetyUserCount() {
        return adminMapper.selectSafetyUserCount();
    }

    @Override
    public List<SafetyCard> selectSafetyAndMember() {
        return adminMapper.selectSafetyAndMember();
    }

    @Override
    public int selectFdsCountByCardId(String cardId) {
        return adminMapper.selectFdsCountByCardId(cardId);
    }

    @Override
    public int selectSafetyCountByCardId(String cardId) {
        return adminMapper.selectSafetyCountByCardId(cardId);
    }

    @Override
    public int selectClusterCount() {
        return adminMapper.selectClusterCount();
    }


}
