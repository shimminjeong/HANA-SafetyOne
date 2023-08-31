<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
</style>

<body>
<div class="expend_wrap bg_gray">
    <div class="form_type w_size01">
        <div class="form_ele">
            <div class="ele_tit">
                <label for="radioInfo2">적용구분</label><button type="button" class="btn_tooltip" title="적용구분 툴팁보기" onclick="openTooltip('#feelTooltip', this)"><span>자세히</span></button><!-- 20.03.28 title 수정 -->
            </div>
            <div class="radio_wrap type_flex type_btn">
                <label for="radioInfo2-1" class="radio_btn"><input type="radio" checked="checked" id="radioInfo2-1" name="listRadio2" value="apply" data-bind-click="selectProcType();" data-bind-value="frm.procType" class="set_AutoComplete" autocomplete="off"><span role="text">맞춤설정</span></label>
                <label for="radioInfo2-2" class="radio_btn"><input type="radio" id="radioInfo2-2" name="listRadio2" value="pause" data-bind-click="selectProcType();" data-bind-value="frm.procType" class="set_AutoComplete" autocomplete="off"><span role="text">해외전체 정지</span></label>
            </div>
        </div>
        <div class="gapt16_27" data-bind-visible="vi.showInputwriteApply" style=""><!-- //추가 20191217 조경식 -->
            <div class="form_ele">
                <div class="ele_tit">
                    <label for="radioInfo1">사용가능기간</label>
                </div>
                <div class="radio_wrap type_flex type_btn">
                    <label for="radioInfo1-1" class="radio_btn"><input type="radio" id="radioInfo1-1" name="C03_listRadio" value="01" checked="checked" data-bind-click="selectValidTermType();" data-bind-value="frm.validTermType" class="set_AutoComplete" autocomplete="off"><span role="text">카드유효기간 까지</span></label>
                    <label for="radioInfo1-2" class="radio_btn"><input type="radio" data-tabbutton=".radioCon2" id="radioInfo1-2" name="C03_listRadio" value="02" data-bind-click="selectValidTermType();" data-bind-value="frm.validTermType" class="set_AutoComplete" autocomplete="off"><span role="text">직접선택</span></label>
                </div>
                <div class="input_wrap date_type gapt10" data-bind-visible="vi.showInputwriteValid" style="display: none;"><!-- 직접선택일 경우에만 노출 -->
                    <span class="input_date"><input type="text" id="selectDate3" title="사용가능기간 시작일" data-bind-value="frm.startTerm" data-bind-focus="startTerm" class="datepicker onlyPC hasDatepicker set_AutoComplete" maxlength="10" autocomplete="off"><button type="button" class="ui-datepicker-trigger" title="달력 열기"><span>기간조회</span></button></span>
                    <span class="input_mark">~</span>
                    <span class="input_date"><input type="text" id="selectDate4" title="사용가능기간 종료일" data-bind-value="frm.endTerm" data-bind-focus="endTerm" class="datepicker onlyPC hasDatepicker set_AutoComplete" maxlength="10" autocomplete="off"><button type="button" class="ui-datepicker-trigger" title="달력 열기"><span>기간조회</span></button></span>
                </div>
            </div>
            <div class="form_ele">
                <div class="ele_tit">
                    <label for="selectCard">사용가능국가</label>
                </div>
                <div class="select_wrap select_default">
                    <span class="ui_select set_select">
                        <button type="button" class="ui_select_btn" aria-expanded="false" aria-haspopup="listbox" title="사용가능국가 선택"><span class="ui_select_value">사용국가 선택</span></button><div class="ui_select_menu" style="display: none;"><div class="ui_select_scr mCustomScrollbar _mCS_2 mCS_no_scrollbar"><div id="mCSB_2" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" tabindex="0" style="max-height: none;"><div id="mCSB_2_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">	<ul class="ui_select_list" role="listbox"><li role="option" class="ui_select_option is_selected" aria-selected="true"><a href="javascript:;" role="button">사용국가 선택</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">전체국가 사용</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">주요국가 검색</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">ㄱ,ㄴ,ㄷ</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">ㄹ,ㅁ</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">ㅂ,ㅅ</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">ㅇ</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">ㅈ,ㅊ,ㅋ</a></li><li role="option" class="ui_select_option" aria-selected="false"><a href="javascript:;" role="button">ㅌ,ㅍ,ㅎ</a></li></ul></div><div id="mCSB_2_scrollbar_vertical" class="mCSB_scrollTools mCSB_2_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_2_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><select id="selectCard" title="사용가능국가 선택" data-bind-change="selectCaracter();" data-bind-value="frm.caracterType" data-bind-focus="selectCaracter" aria-hidden="true" tabindex="-1">
                            <option value="none">사용국가 선택</option>
		                    <option value="group_all">전체국가 사용</option>
		                    <option value="group_top20">주요국가 검색</option>
		                    <option value="group_sort1">ㄱ,ㄴ,ㄷ</option>
		                    <option value="group_sort2">ㄹ,ㅁ</option>
		                    <option value="group_sort3">ㅂ,ㅅ</option>
		                    <option value="group_sort4">ㅇ</option>
		                    <option value="group_sort5">ㅈ,ㅊ,ㅋ</option>
		                    <option value="group_sort6">ㅌ,ㅍ,ㅎ</option>
                        </select>
                    </span>
                </div>
                <div class="select_wrap select_default gapt10" data-bind-visible="vi.showFormSelect" style="display: none;">
                    <span class="ui_select set_select">
                        <button type="button" class="ui_select_btn" aria-expanded="false" aria-haspopup="listbox" title="국가 선택"><span class="ui_select_value"></span></button><div class="ui_select_menu" style="display: none;"><div class="ui_select_scr mCustomScrollbar _mCS_1 mCS_no_scrollbar"><div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_1_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">	<ul class="ui_select_list" role="listbox">	</ul></div><div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><select id="selectCard" title="국가 선택" data-bind-each="vi.countryList" data-bind-value="frm.selectedCountry" data-bind-change="addCountry();" data-placeholder="true" aria-hidden="true" tabindex="-1"></select>
                    </span>
                </div>
                <!--                 <div class="select_mix side_btn gapt10" data-bind-visible="vi.showResult"> -->
                <!--                     <div class="select_wrap select_default"> -->
                <!--                         <span class="ui_select"> -->
                <!--                             <select  data-placeholder="true" data-bind-each="vi.resultCountry" data-bind-value="resultCountry" disabled="disabled"> -->
                <!--                                 <option value="{{=$data.code}}" selected>{{=$data.value}}</option> -->

                <!--                             </select> -->
                <!--                         </span> -->
                <!--                     </div> -->
                <!--                     <button type="button" class="btn line_darkgray" value="{{=$index}}" id="deleteCountry" data-bind-click="deleteCountry('{{=$index}}');" data-bind-value="frm.index"><span>삭제</span></button> -->
                <!--                 </div> -->
                <div data-bind-visible="vi.showResult" data-bind-each="vi.resultCountry" data-bind-value="resultCountry" style="display: none;"></div>
            </div>
            <div class="form_ele">
                <div class="ele_tit">
                    <label for="radioInfo3">사용가능 거래유형</label>
                </div>
                <div class="radio_wrap type_flex type_btn">
                    <label for="radioInfo3-1" class="radio_btn"><input type="radio" value="0" id="radioInfo3-1" name="selectDeal" data-bind-click="selectDealClick()" data-bind-value="frm.bizType" checked="checked" class="set_AutoComplete" autocomplete="off"><span role="text">전체거래</span></label>
                    <label for="radioInfo3-2" class="radio_btn"><input type="radio" value="2" id="radioInfo3-2" name="selectDeal" data-bind-click="selectDealClick()" data-bind-value="frm.bizType" class="set_AutoComplete" autocomplete="off"><span role="text">오프라인</span></label>
                    <label for="radioInfo3-3" class="radio_btn"><input type="radio" value="1" id="radioInfo3-3" name="selectDeal" data-bind-click="selectDealClick()" data-bind-value="frm.bizType" class="set_AutoComplete" autocomplete="off"><span role="text">온라인</span></label>
                </div>
                <!-- 23-03-21 추가// -->
                <div class="check_wrap column gapt10" data-bind-visible="vi.showCheckCash" style="display: none;">
                    <label for="checkCash" class="check_default">
                        <input type="checkbox" id="checkCash" name="checkCash" value="3" data-bind-value="frm.checkCash" data-bind-attr="checkCash" class="set_AutoComplete" autocomplete="off"><span role="text">해외 현금서비스 거래만 사용</span>
                    </label>
                </div>
                <!-- //23-03-21 추가 -->
            </div>
            <div class="form_ele">
                <div class="ele_tit">
                    <label for="inputPrice">1회 결제가능금액</label>
                </div>
                <div class="input_wrap unit_side no_check leng4">
                    <input type="tel" placeholder="만원단위(10억 미만)로 입력" id="inputPrice" maxlength="6" data-bind-watch="inputPrice" data-bind-focus="inputPrice" data-bind-value="frm.payOneLimitAmount" title="만원단위(10억 미만)로 입력" class="set_AutoComplete" autocomplete="off"><span class="unit">만원 이하</span><!-- 20.03.28 title 수정 -->
                    <p class="text_tip error" id="inputPrice" data-bind-lamp="inputPrice" style="display: none;" tabindex="0">금액을 입력해주세요.</p>
                </div>
            </div>
        </div>
    </div> <!-- //추가 20191217 조경식 -->
</div>
</body>
</html>
