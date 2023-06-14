<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.goog-te-gadget .goog-te-combo{
	background-color: #25476a;
	color : white;
	border: none;
	border-radius: 3px;
}
#google_translate_element{
	margin-top: 3px;
}
</style>
<security:authentication property="principal.realUser" var="authMember"/>
<div class="header__inner">

    <!-- Brand -->
    <div class="header__brand">
        <div class="brand-wrap">

            <!-- Brand logo -->
            <a href="${cPath}/index.do" class="brand-img stretched-link">
                <img src="${cPath}/resources/assets/img/keyUniv_realLogo.png" alt="Nifty Logo" class="Nifty logo" width="80" height="40">
            </a>

            <!-- Brand title -->
            <div class="brand-title">학사정보시스템</div>

            <!-- You can also use IMG or SVG instead of a text element. -->

        </div>
    </div>
    <!-- End - Brand -->

    <div class="header__content">

        <!-- Content Header - Left Side: -->
        <div class="header__content-start">

            <!-- Navigation Toggler -->
            <button type="button" class="nav-toggler header__btn btn btn-icon btn-sm" aria-label="Nav Toggler">
                <i class="psi-list-view"></i>
            </button>

			<!-- connect IP -->
<!-- 			<div CLASS="HEADER-SEARCHBOX">  -->
<%-- 				<C:SET VAR="IPADDRESS"VALUE="${NOT EMPTY PAGECONTEXT.REQUEST.GETHEADER('X-FORWARDED-FOR') ? PAGECONTEXT.REQUEST.GETHEADER('X-FORWARDED-FOR') : PAGECONTEXT.REQUEST.REMOTEADDR}" />  --%>
<%--  				접속한 클라이언트의 IP 주소는 ${IPADDRESS} 입니다. --%>
<!-- 			</DIV>  -->

        </div>
        <!-- End - Content Header - Left Side -->
        <!-- Content Header - Right Side: -->
        <div class="header__content-end">

            <!-- Notification Dropdown -->
            <span id="headerMenuGroup">
            </span>
<!-- 언어 선택 구현 구간 -->
			<div id="google_translate_element" class="hd_lang"></div>
			<script>
				function googleTranslateElementInit() {
					new google.translate.TranslateElement({
						pageLanguage : 'ko',
						includedLanguages : 'ko,en',//layout: 	google.translate.TranslateElement.InlineLayout.SIMPLE,
						autoDisplay : false,
					}, 'google_translate_element');
				}
			</script>
			<script
				src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

<!-- End - 언어 선택 구현 구간 -->
&nbsp&nbsp&nbsp
<!-- 세션 연장 구현 구간 -->
  <script type="text/javascript">
    // 세션 타이머를 1초마다 감소시키는 함수
    function decrementTimer() {
      // 세션 타이머 태그 가져오기
      var timerSpan = document.getElementById('sessionTimer');

      // 세션 타이머 감소
      var timerValue = parseInt(timerSpan.getAttribute('data-timer'));
      if (timerValue > 0) {
        timerValue--;
        // 세션 타이머 분, 초 계산
        var minutes = Math.floor(timerValue / 60);
        var seconds = timerValue % 60;
        minutes = ("0" + minutes).slice(-2);
        seconds = ("0" + seconds).slice(-2);
        // 세션 타이머 표시
        timerSpan.setAttribute('data-timer', timerValue);
        timerSpan.innerHTML = minutes + ": " + seconds;
        // 1초 후에 다시 실행
        setTimeout(decrementTimer, 1000);
      } else {
        // 세션 종료
        window.location.href = "<c:url value='/logout.jsp' />";
      }
    }

    // 페이지 로드 완료 시 세션 타이머 시작
    window.onload = function() {
      var timerSpan = document.getElementById('sessionTimer');
      var initialTimerValue = timerSpan.getAttribute('data-timer');
      var minutes = Math.floor(initialTimerValue / 60);
      var seconds = initialTimerValue % 60;
      timerSpan.innerHTML = minutes + ":" + seconds;
      setTimeout(decrementTimer, 1000);
      // 세션 타이머 초기화 버튼 클릭 시
      document.getElementById('resetTimerButton').addEventListener('click', function() {
          // 세션 타이머 초기화
          var timerValue = parseInt("${pageContext.session.maxInactiveInterval}");
          var minutes = Math.floor(timerValue / 60);
          var seconds = timerValue % 60;
          var timerSpan = document.getElementById('sessionTimer');
          timerSpan.setAttribute('data-timer', timerValue);
          timerSpan.innerHTML = minutes + ":" + seconds;
        });
      };
  </script>
</head>
<body>
  <!-- 세션 타이머 표시 -->
  <span id="sessionTimer" data-timer="${pageContext.session.maxInactiveInterval}"></span>
  <!-- 세션 타이머 초기화 버튼 -->
  <button id="resetTimerButton" class="btn btn-xs btn-light">세션 연장</button>
</body>
<!-- End - 세션 연장 구현 구간 -->
&nbsp&nbsp&nbsp
            <div class="dropdown">

                <!-- Toggler -->
                <button class="header__btn btn btn-icon btn-sm" type="button" data-bs-toggle="dropdown" aria-label="Notification dropdown" aria-expanded="false">
                    <span class="d-block position-relative">
                        <i class="psi-bell"></i>
                        <span class="badge badge-super rounded bg-danger p-1">

                            <span class="visually-hidden">unread messages</span>
                        </span>
                    </span>
                </button>

                <!-- Notification dropdown menu -->
                <div class="dropdown-menu dropdown-menu-end w-md-300px">
                    <div class="border-bottom px-3 py-2 mb-3">
                        <h5>LMS 메세지함</h5>
                    </div>

                    <div class="list-group list-group-borderless">

                        <!-- List item -->
                        <div class="list-group-item list-group-item-action d-flex align-items-start mb-3">
                            <div class="flex-shrink-0 me-3">
                                <i class="psi-data-settings text-muted fs-2"></i>
                            </div>
                            <div class="flex-grow-1 ">
                                <a href="#" class="h6 d-block mb-0 stretched-link text-decoration-none">[초급자바] 출석 요청 <span class="text-info">1</span>건</a>
                                <small class="text-muted">2023.06.12</small> 
                            </div>
                        </div>

                        <!-- List item -->
                        <div class="list-group-item list-group-item-action d-flex align-items-start mb-3">
                            <div class="flex-shrink-0 me-3">
                                <i class="psi-file-edit text-blue-200 fs-2"></i>
                            </div>
                            <div class="flex-grow-1 ">
                                <a href="#" class="h6 d-block mb-0 stretched-link text-decoration-none">[학사 일정] 기말고사</a>
                                <small class="text-muted">2023.06.26 ~ 2023.06.30</small>
                            </div>
                        </div>

                        <!-- List item -->
                        <div class="list-group-item list-group-item-action d-flex align-items-start mb-3">
                            <div class="flex-shrink-0 me-3">
                                <i class="psi-speech-bubble-7 text-green-300 fs-2"></i>
                            </div>
                            <div class="flex-grow-1 ">
                                <div class="d-flex justify-content-between align-items-start">
                                    <a href="#" class="h6 mb-0 stretched-link text-decoration-none">새 공지 알림</a>
                                    <span class="badge bg-info rounded ms-auto">NEW</span>
                                </div>
                                <small class="text-muted">기말고사 기간 안내</small>
                            </div>
                        </div>

                        <div class="text-center mb-2">
                            <a href="#" class="btn-link">Show all Notifications</a>
                        </div>

                    </div>
                </div>
            </div>
            <!-- End - Notification dropdown -->

            <!-- User dropdown -->
            <div class="dropdown me-3">

                <!-- Toggler -->
                <button class="header__btn btn btn-icon btn-lg" type="button" data-bs-toggle="dropdown" aria-label="User dropdown" aria-expanded="false">
                    <i class="psi-male"></i>
                </button>

                <!-- User dropdown menu -->
                <div class="dropdown-menu dropdown-menu-end w-md-200px">
                    <div class="d-flex align-items-center border-bottom px-2 py-2">
<!--                         <div class="flex-shrink-0"> -->
<!--                         	<i class="pli-male fs-5 me-2"></i>  -->
<!--                         </div> -->
                        <div class="flex-grow-1 list-group">
                            <a href="#" style="text-decoration: none;" class="list-group-item-action">
                            	<h5 class="mb-0">${authMember.memName }</h5>
	                            <span class="text-muted fst-italic">${authMember.memNo }</span>
                           	</a>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-md-12">

                            <!-- User menu link -->
                            <div class="list-group list-group-borderless h-100 py-3">
                                <a href="${cPath }/member/changePasswd.do" class="list-group-item list-group-item-action">
                                    <i class="pli-gear fs-5 me-2"></i> 비밀번호 변경
                                </a>

                                <form id="logoutForm" action="${cPath }/logout" method="post">
                               		<security:csrfInput/>
                          		</form>
                                <a href="javascript:$('#logoutForm').submit();" class="list-group-item list-group-item-action">
                                <i class="pli-unlock fs-5 me-2"></i> 로그아웃</a>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
            <!-- End - User dropdown -->

        </div>
    </div>
</div>
<script>

</script>


