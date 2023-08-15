<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>

<body>
<div class="ly_inner">
  <div class="contents_heading h_wrap">
    <h3 class="h_title38">카드분실신고</h3><div class="tab_type01 swiper_tab depth4-tab" id="tabSwiper0"><div class="tab_pull"><button type="button" class="swiper-button-prev swiper-button-disabled" tabindex="0" role="button" title="이전 슬라이드 보기" aria-disabled="true"><span class="blind">이전</span></button><button type="button" class="swiper-button-next swiper-button-disabled" tabindex="0" role="button" title="다음 슬라이드 보기" aria-disabled="true"><span class="blind">다음</span></button><div class="swiper-container swiper-container-initialized swiper-container-horizontal"><ul class="tab_list swiper-wrapper" role="tablist" style="transform: translate3d(0px, 0px, 0px);"><li class="swiper-slide current swiper-slide-active" role="none"><a href="/mob/MOBFM155N/MOBFM155R01.shc" data-link="true" role="tab" aria-selected="true" class="role_link">카드분실신고</a></li><li class="swiper-slide swiper-slide-next" role="none"><a href="/mob/MOBFM157N/MOBFM157C01.shc" data-link="true" role="tab" aria-selected="false" class="role_link">카드분실신고 해제</a></li><li class="swiper-slide" role="none"><a href="/mob/MOBFM201N/MOBFM201C01.shc" data-link="true" role="tab" aria-selected="false" class="role_link">타사카드 일괄분실신고</a></li><li class="swiper-slide" role="none"><a href="/mob/MOBFM156N/MOBFM156R01.shc" data-link="true" role="tab" aria-selected="false" class="role_link">카드분실신고 내역</a></li></ul><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div></div></div>
  </div>
  <!-- contents -->
  <div data-bind-view="MOBFM155R01" style="">
    <section class="contents m_fixed_bottom" data-bind-visible="isLoading" style="">
      <p class="font_lg08 color_darkgray wgt_md gap20_10">카드를 선택해주세요.</p>
      <div class="tab_type02">
        <ul class="tab_list" role="tablist">
          <li id="tab01" class="current" role="none"><a href="#section01" role="tab" aria-controls="section01" aria-selected="true" class="role_link">신용카드/체크카드</a></li>
          <li id="tab02" role="none"><a href="#section02" role="tab" aria-controls="section02" aria-selected="false" class="role_link">선불형카드</a>
          </li><li id="tab03" role="none"><a href="#section03" role="tab" aria-controls="section03" aria-selected="false" class="role_link">앱카드(휴대폰분실)</a>
        </li>

        </ul>
        <div class="tab_wrap">
          <div class="tab_wrap">
            <div class="tab_cont current" role="tabpanel" aria-labelledby="tab01" id="section01">
              <!-- 내역없음 -->
              <div class="complete_body type01 gap100_0" data-bind-visible="R0101.mLstCrdList.length < 1" style="">
                <p class="title">분실신고 가능한 신용/체크카드가 없습니다.</p><!-- 20.02.19 윤문검수 -->
                <p class="sub_title">고객 가입 후 이용해주세요.</p><!-- 20.02.19 윤문검수 -->
              </div>
              <!--// 내역없음 -->
              <div data-bind-visible="R0101.mLstCrdList.length > 0" style="display: none;">
                <div class="gapt30 gap20">
                  <div class="check_wrap">
                    <label for="check_1" class="check_default" data-bind-click="allCheck('check1');">
                      <input type="checkbox" id="check_1" class="set_AutoComplete" autocomplete="off">
                      <span role="text">전체선택</span>
                    </label>
                  </div>
                </div>
                <div class="con accordion_wrap type02 card_inquiry_list btn_gap" data-bind-each="tempList1"></div>
              </div>
              <!-- 200130 수정 -->
              <div class="btn_wrap btn_cont align_c gap60_40 gapt40_30">
                <button type="button" class="btn default line_gray" data-bind-click="more('1');" id="btnMore1" title="카드이용내역 6페이지 중 2페이지 더보기" style="display: none;">
                  <span>더보기</span>
                </button>
              </div>

              <div class="btn_wrap align_c m_fixed gap100_0" id="r0101Next" style="display: none;">
                <button type="button" class="btn default blue next" data-bind-click="nextStep()"><span>다음</span></button>
              </div>
              <!-- //200130 수정 -->
            </div>
            <div class="tab_cont" role="tabpanel" aria-labelledby="tab02" id="section02">
              <!-- 내역없음 -->
              <div class="complete_body type01 gap100_0" data-bind-visible="R0102.mLstCrdList.length < 1" style="display: none;">
                <p class="title">분실신고 가능한 선불카드가 없습니다.</p><!-- 20.02.19 윤문검수 -->
                <p class="sub_title">고객님께서는 고객센터 상담실(<a href="tel:1544-7000" role="button" class="">1544-7000</a>)을 통해서 <i class="tbx"></i>분실신고 접수가 가능합니다.</p> <!-- 200130 수정 -->
              </div>
              <!--// 내역없음 -->
              <div data-bind-visible="R0102.mLstCrdList.length > 0" style="">
                <div class="gapt30 gap20">
                  <div class="check_wrap">
                    <label for="check_2" class="check_default" data-bind-click="allCheck('check2');">
                      <input type="checkbox" id="check_2" class="set_AutoComplete" autocomplete="off">
                      <span role="text">전체선택</span>
                    </label>
                  </div>
                </div>
                <div class="con accordion_wrap type02 card_inquiry_list gap60_40" data-bind-each="tempList2">
                  <dl class="item">
                    <dt class="accordion_header" data-wrapper="1" data-idx="0">
                      <div class="cell1">
                        <div class="check_wrap card_head">
                          <label for="check2_0" class="check_default" data-bind-click="chk('check2');" data-bind-item="tempList2,0">
                            <input type="checkbox" id="check2_0" class="checkN2 set_AutoComplete" name="checkN2" value="BCF42BDFC67F7B082C7F6A9E752292270099DA36CE01AAE3F72C87CAD5BA21E2" data-bind-value="crdChk2" autocomplete="off">
                            <span class="head_tit" role="text">
                                                                  <em class="txt01">9458-23**-****-7498</em>
                                                                  <em class="txt02"><span class="user_name">심*정</span><span class="card_name">신한Pay머니 모바일</span></em>

                                                              </span>
                          </label>
                        </div>
                      </div>
                      <button type="button" class="cell acc_btn toggle_btn medium" aria-controls="acc0" aria-expanded="false">
                        <span class="blind">자세히보기</span>

                      </button>
                    </dt>

                    <dd class="accordion_body private" id="acc2_0" data-wrapper="1" data-idx="0">
                      <div class="area state_area">
                        <div class="inner">
                          <dl class="state_list">
                            <dt>현재잔액</dt>
                            <dd>
                              <p><span>0</span>원</p>
                            </dd>
                          </dl>
                          <dl class="state_list">
                            <dt>최종 사용내역</dt>
                            <dd>
                              <p><span>0</span>원</p>

                            </dd>
                          </dl>
                        </div>
                      </div>
                    </dd>
                    <dd class="reissue2" data-bind-visible="R0102.mLstCrdList.length<11">
                      <div class="inner_form">
                        <div class="form_ele">
                          <div class="ele_tit">
                            <label for="reissue">재발급 신청 여부</label>
                          </div>

                          <div>
                            <p class="color_red gapt10 gap10">불가</p>
                          </div>

                        </div>
                      </div>
                    </dd>
                  </dl>
                </div>
              </div>

              <div class="btn_wrap btn_cont align_c gap60_40 gapt40_30">
                <button type="button" class="btn default line_gray" data-bind-click="more('2');" id="btnMore2" title="카드이용내역 6페이지 중 2페이지 더보기" style="display: none;">
                  <span>더보기</span>
                </button>
              </div>

              <div class="btn_wrap align_c m_fixed gap100_0" id="r0102Next">
                <button type="button" class="btn default blue next" data-bind-click="nextStep()"><span>다음</span></button>
              </div>
            </div>
            <div class="tab_cont" role="tabpanel" aria-labelledby="tab03" id="section03">
              <div class="pdt60_30 pdb40_30">
                <div class="con accordion_wrap btm_line">
                  <dl>
                    <dt class="accordion_header" data-wrapper="2" data-idx="0">
                      <button type="button" class="toggle_btn acc_btn medium" aria-controls="acc0" aria-expanded="false">신한카드 휴대폰분실 분실신고란?</button>
                    </dt>
                    <dd class="accordion_body mgb15" id="acc0" data-wrapper="2" data-idx="0" style="display: none;">
                      <div class="area medium">
                        <p>
                          신한카드 휴대폰분실신고는 휴대폰에 설치된 <b>신한플레이 앱 이용만을 불가하게</b> 하는 서비스입니다.
                        </p>
                      </div>
                    </dd>
                  </dl>
                  <dl>
                    <dt class="accordion_header" data-wrapper="2" data-idx="1">
                      <button type="button" class="toggle_btn acc_btn medium" aria-controls="acc1" aria-expanded="false">신한카드에 휴대폰분실 신고하면 어떻게 되나요?</button>
                    </dt>
                    <dd class="accordion_body mgb15" id="acc1" data-wrapper="2" data-idx="1" style="display: none;">
                      <div class="area medium">
                        <p>
                          휴대폰분실신고 시 <b>신한플레이에 가입한 고객님 명의의 모든 휴대폰에서 신한플레이 접속이 차단</b>됩니다.
                        </p>
                      </div>
                    </dd>
                  </dl>
                  <dl>
                    <dt class="accordion_header" data-wrapper="2" data-idx="2">
                      <button type="button" class="toggle_btn acc_btn medium" aria-controls="acc2" aria-expanded="false">분실한 휴대폰을 회수하거나 나의 명의로 가입한 다른 휴대폰에 설치된 신한플레이 접속차단은 어떻게 해제해요?</button>
                    </dt>
                    <dd class="accordion_body mgb15" id="acc2" data-wrapper="2" data-idx="2" style="display: none;">
                      <div class="area medium">
                        <p>
                          휴대폰을 회수 하시면 <b>신한플레이 재설치 및 재가입을 통해서 다시 이용</b>하실 수 있습니다.<br>
                          <b>분실하시지 않은 휴대폰도 신한플레이 재설치 및 재가입을 통해서 다시 신한플레이를 이용</b>하실 수 있습니다.
                        </p>
                      </div>
                    </dd>
                  </dl>
                  <dl>
                    <dt class="accordion_header" data-wrapper="2" data-idx="3">
                      <button type="button" class="toggle_btn acc_btn medium" aria-controls="acc3" aria-expanded="false">현재 사용하고 있는 플라스틱 카드도 사용 못하나요?</button>
                    </dt>
                    <dd class="accordion_body mgb15" id="acc3" data-wrapper="2" data-idx="3" style="display: none;">
                      <div class="area medium">
                        <p>
                          <b>소지하신 플라스틱 카드는 계속 사용 가능</b>합니다.
                        </p>
                      </div>
                    </dd>
                  </dl>
                  <dl>
                    <dt class="accordion_header" data-wrapper="2" data-idx="4">
                      <button type="button" class="toggle_btn acc_btn medium" aria-controls="acc4" aria-expanded="false">신한카드에 휴대폰분실 신고하면 통신사에도 분실신고가 자동으로 되나요?</button>
                    </dt>
                    <dd class="accordion_body mgb15" id="acc4" data-wrapper="2" data-idx="4" style="display: none;">
                      <div class="area medium">
                        <p>
                          아닙니다. <b>휴대폰 통신을 정지하시려면 반드시 통신사에 휴대폰 분실 신고</b>를 하셔야 합니다.
                        </p>
                      </div>
                    </dd>
                  </dl>
                </div>
              </div>
              <div class="btn_wrap align_c m_fixed gap100_0">
                <button type="button" class="btn default blue next" data-bind-click="reportLost()"><span>앱카드(휴대폰분실) 분실등록</span></button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div data-bind-cms="/pconts/html/helpdesk/emergency/MOBFM155/MOBFM155R0101.html"><div class="con accordion_wrap btm_line">
        <dl>
          <dt class="accordion_header on" data-wrapper="3" data-idx="0">
            <button type="button" class="acc_btn toggle_btn on" aria-controls="acc1" aria-expanded="true">
              꼭! 알아두세요
              <span class="blind">자세히보기</span>
            </button>
          </dt>
          <dd class="accordion_body" id="acc1" data-wrapper="3" data-idx="0">
            <div class="area bd_bottom">
              <div class="inner">
                <ul class="marker_dot">
                  <li>분실신고 해제 대상카드
                    <ul class="marker_hyphen">
                      <li>개인신용카드(가족카드도 가능)/신한은행 체크카드/기명식 선불카드&nbsp;
                        <p class="marker_refer">법인, 타행체크, 선불카드, 신한BC카드는 해제 불가</p>
                      </li>
                    </ul>
                  </li>
                  <li>분실신고를 하기 전 먼저 카드 승인내역을 확인해주세요.</li>
                  <li>법인카드 분실, 해외분실의 경우 신한카드 고객센터 <a href="tel:1544-7200" class="tel_link" role="button">1544-7200</a>번으로 즉시 신고하여 주시기 바랍니다.</li>
                  <li>BC카드를 분실한 경우 (<a href="tel:1588-4515" class="tel_link" role="button">1588-4515</a>)로 신고해 주시기바랍니다.</li>
                  <li>고객님이 사용하지 않은 승인내역이 있거나 재발급불가 카드에 대한 상세 내용을 확인하려는 경우 신한카드 고객센터로 문의해주세요.
                    <ul class="marker_hyphen">
                      <li>문의: <a href="tel:1544-7000" class="tel_link" role="button">1544-7000</a>(평일 09:00 ~ 18:00)</li>
                      <li>문의: <a href="tel:1544-7200" class="tel_link" role="button">1544-7200</a>(매일 오후 18:00~다음날 오전 9시)</li>
                    </ul>
                  </li><li>재발급 신청 후에는 분실신고한 카드의 신고해제를 할 수 없다는 점, 유의해주세요.</li>
                  <li>분실신고 접수번호가 부여되지 않으면 분실신고가 이루어진 것이 아니므로 꼭 확인해주세요.</li>
                  <li>월 납부요금[통신비, 관리비, 보험료, 전기요금 등]을 자동납부 중인 카드가 교체 발급되면 새로운 카드로 자동납부가 승계되지 않을 수 있습니다. 각 요금의 해당 업체로 카드번호 변경을 신청해주세요. </li>
                  <li>체크/현금겸용 카드의 경우 예금인출 여부를 따로 확인해야 합니다.</li>
                  <li>체크카드 분실 시 현금겸용 기능 정지는 해당 은행으로 따로 요청해주세요.(신한, 우체국, 수협 제외)</li>
                  <li>
                    재발급불가 표시안내
                    <ul class="marker_hyphen">
                      <li>해당 기관(직업훈련학교, 보훈청 및 읍, 면, 동사무소)에서 발급된 체크카드 중 ‘발급 불가’ 로 표시된 체크카드를 원하는 경우는 해당 기관(직업훈련학교, 보훈청 및 읍, 면, 동사무소)으로 재발급을 신청해주세요.</li>
                      <li>본인 기존 소지한 후불교통체크카드에 계좌연결이 되어 있지 않을 경우 후불교통기능은 계좌가 있는 체크카드에만 추가하실 수 있으므로, 상담실(<a href="tel:1544-7474" class="tel_link" role="button">1544-7474</a>)로 계좌등록 후 재발급 신청 바랍니다.</li>
                      <li>본인 기존 소지한 당사카드에 후불교통 사용제한 코드가 등재되어 있는 경우 후불교통 사용제한 코드가 등재되어 있어 후불교통기능을 추가하실 수 없으므로, 상담실(<a href="tel:1544-7474" class="tel_link" role="button">1544-7474</a>)로 후불교통기능 없는 체크카드로 재발급 신청 바랍니다.</li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
          </dd>
        </dl>
      </div></div>
      <!-- //ly_inner -->
    </section>
  </div>
  <!-- //contents -->
  <div data-bind-view="MOBFM155R02" style="display: none;"></div>
  <div data-bind-view="MOBFM155R03" style="display: none;"></div>
  <div data-bind-view="MOBFM155C03" style="display: none;"></div>
  <div data-bind-view="MOBFM155R04" style="display: none;"></div>
  <div data-bind-view="MOBFM155R05" style="display: none;"></div>
  <div data-bind-view="MOBFM155C06" style="display: none;"></div>
  <div data-bind-view="MOBFM155R07" style="display: none;"></div>
</div>

</body>
</html>
