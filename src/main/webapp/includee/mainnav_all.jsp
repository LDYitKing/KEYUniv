<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<div class="mainnav__inner">
<%-- <%pageContext.setAttribute("memRole", "STU"); %> --%>
    <security:authentication property="principal.realUser" var="authMember"/>
    <!-- Navigation menu -->
    <div class="mainnav__top-content scrollable-content pb-5">

   <!-- role checking -->
   <security:authorize access="hasAnyRole('STU')">
        <!-- Profile Widget -->
        <div class="mainnav__profile mt-3 d-flex3">

            <div class="mt-2 d-mn-max"></div>

            <!-- Profile picture  -->
            <div class="mininav-toggle text-center py-2">
            <c:if test="${authMember.memPhoto eq null }">
                <img class="mainnav__avatar img-lg rounded-circle border" src="${cPath}/resources/img/stu.png" alt="Profile Picture">
            </c:if>
            <c:if test="${authMember.memPhoto ne null }">
                <img class="mainnav__avatar img-lg rounded-circle border" src="${cPath}/resources/memberfiles/${authMember.atchSaveName}" alt="${authMember.atchOrginName }">
            </c:if>

            </div>

            <div class="mininav-content collapse d-mn-max">
                <div class="d-grid">

                    <!-- User name and position -->
                    <button class="d-block btn shadow-none p-2" data-bs-toggle="collapse" data-bs-target="#usernav" aria-expanded="false" aria-controls="usernav">
                        <span class="d-flex justify-content-center align-items-center">
 							<h6 class="mb-0 me-0">${authMember.memName }

                               <c:choose>
                                  <c:when test="${authMember.stuGdate eq null }">
                                     <small>학생</small>
                                  </c:when>
                                  <c:when test="${authMember.stuGdate ne null }">
                                     <small>졸업생</small>
                                </c:when>
                               </c:choose>

                            </h6>
                        </span>
                        <small class="text-muted">${authMember.deptName } </small>
                    </button>

                    <!-- Collapsed user menu -->

                </div>
            </div>

        </div>
        <!-- End - Profile widget -->

        <!-- menu -->
        <div class="mainnav__categoriy py-3">
            <h6 class="mainnav__caption mt-0 px-3 fw-bold"><hr></h6>
            <ul class="mainnav__menu nav flex-column">

            <!-- role menu -->
                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-home fs-5 me-2"></i>
                        <span class="nav-label ms-1">마이페이지</span>
                    </a>
                    <c:if test="${authMember.stuGdate eq null}">
                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">개인정보 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">개인 자격증/활동</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/score/stuScore.do'/>" class="nav-link">성적관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="${cPath}/sch/schRecList.do" class="nav-link">장학금</a>
                        </li>
                        <li class="nav-item">
                            <a href="${cPath}/tuti/tutiList.do" class="nav-link">등록금</a>
                        </li>
                    </ul>

                </li>
                
                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-bar-chart fs-5 me-2"></i>
                        <span class="nav-label ms-1">자기주도적 미래설계</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="${cPath}/curri" class="nav-link">홈</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/subjectRenewal/RenewalUI.do'/>" class="nav-link">교과발전</a>
                        </li>
                        <li class="nav-item">
                            <a href="${cPath}/curri/myCurri.do" class="nav-link">나의커리</a>
                        </li>
                        <li class="nav-item">
                            <a href="${cPath}/curri/everyCurri" class="nav-link">모두의커리</a>
                        </li>
                    </ul>

                </li>
                <li class="nav-item">
                    <a href="${cPath}/sugang/info" class="nav-link mininav-toggle collapsed">
                        <i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">수강신청</span>
                    </a>
                </li>


                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link collapsed">
                        <i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label ms-1">수강강의</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <c:forEach items="${navLectureList }" var="navLecture">
                        <li class="nav-item has-sub">
                            <a href="${cPath}/lecture/lectureHome.do?what=${navLecture.lectNo}" class="nav-link">&emsp;${navLecture.lectName }</a>
                        </li>
                        </c:forEach>
                    </ul>
                </li>


                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label ms-1">학적관리</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">학적변동관리</a>
                        </li>
                    </ul>

                </li>



                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label ms-1">상담</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">상담신청</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">상담이력</a>
                        </li>
                    </ul>

                </li>
                </c:if>

            <!-- End - role menu -->
   </security:authorize>





   <security:authorize access="hasRole('PRO')">
        <!-- Profile Widget -->
        <div class="mainnav__profile mt-3 d-flex3">

            <div class="mt-2 d-mn-max"></div>

            <!-- Profile picture  -->
            <div class="mininav-toggle text-center py-2">
            <c:if test="${authMember.memPhoto eq null }">
                <img class="mainnav__avatar img-lg rounded-circle border" src="${cPath}/resources/img/realMan.png" alt="Profile Picture">
            </c:if>
            <c:if test="${authMember.memPhoto ne null }">
                <img class="mainnav__avatar img-lg rounded-circle border" src="${cPath}/resources/memberfiles/${authMember.atchSaveName}" alt="${authMember.atchOrginName }">
            </c:if>
            </div>

            <div class="mininav-content collapse d-mn-max">
                <div class="d-grid">

                    <!-- User name and position -->
                    <button class="d-block btn shadow-none p-2" data-bs-toggle="collapse" data-bs-target="#usernav" aria-expanded="false" aria-controls="usernav">
                        <span class="d-flex justify-content-center align-items-center">
                            <h6 class="mb-0 me-0">${authMember.memName } <small>교수님</small></h6>
                        </span>
                      <small class="text-muted">${authMember.deptName }</small>
                    </button>

                    <!-- Collapsed user menu -->

                </div>
            </div>

        </div>
        <!-- End - Profile widget -->

        <!-- menu -->
        <div class="mainnav__categoriy py-3">
            <h6 class="mainnav__caption mt-0 px-3 fw-bold"><hr></h6>
            <ul class="mainnav__menu nav flex-column">

            <!-- role menu -->
                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-home fs-5 me-2"></i>
                        <span class="nav-label ms-1">마이페이지</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">개인정보 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">경력/학력 사항</a>
                        </li>
                    </ul>

                </li>

                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label ms-1">학과</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">입학/취업률 정보</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">상담 및 지도 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/subjectRenewal/RenewalUI.do'/>" class="nav-link">교과발전</a>
                        </li>
                    </ul>

                </li>
                
                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label ms-1">강의관리</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <c:forEach items="${navLectureList }" var="navLecture">
                        <li class="nav-item has-sub">
                            <a href="${cPath}/lecture/lectureHome.do?what=${navLecture.lectNo}" class="nav-link">${navLecture.lectName }</a>
                        </li>
                        </c:forEach>
                    </ul>

                </li>

                <li class="nav-item">
                    <a href="<c:url value='/professor/professorStudy.do'/>" class="nav-link mininav-toggle collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">연구</span>
                    </a>
                </li>


                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-bar-chart fs-5 me-2"></i>
                        <span class="nav-label ms-1">자기주도적 미래설계</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="${cPath}/curri/myCurri.do" class="nav-link">학과커리</a>
                        </li>
                        <li class="nav-item">
                            <a href="${cPath}/curri/everyCurri" class="nav-link">모두의커리</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">이달의선배</a>
                        </li>
                    </ul>

                </li>
                <!-- End - role menu -->
   </security:authorize>





   <security:authorize access="hasRole('EMP')">
        <!-- Profile Widget -->
        <div class="mainnav__profile mt-3 d-flex3">

            <div class="mt-2 d-mn-max"></div>

            <!-- Profile picture  -->
            <div class="mininav-toggle text-center py-2">
            <c:if test="${authMember.memPhoto eq null }">
                <img class="mainnav__avatar img-lg rounded-circle border" src="${cPath}/resources/img/emp.png" alt="Profile Picture">
            </c:if>
            <c:if test="${authMember.memPhoto ne null }">
                <img class="mainnav__avatar img-lg rounded-circle border" src="${cPath}/resources/memberfiles/${authMember.atchSaveName}" alt="${authMember.atchOrginName }">
            </c:if>

            </div>

            <div class="mininav-content collapse d-mn-max">
                <div class="d-grid">

                    <!-- User name and position -->
                    <button class="d-block btn shadow-none p-2" data-bs-toggle="collapse" data-bs-target="#usernav" aria-expanded="false" aria-controls="usernav">
                        <span class="d-flex justify-content-center align-items-center">
                            <h6 class="mb-0 me-0">${authMember.memName } <small>님</small></h6>
                        </span>
                        <small class="text-muted">${authMember.empDept }</small>
                    </button>

                    <!-- Collapsed user menu -->

                </div>
            </div>

        </div>
        <!-- End - Profile widget -->

        <!-- menu -->
        <div class="mainnav__categoriy py-3">
            <h6 class="mainnav__caption mt-0 px-3 fw-bold"><hr></h6>
            <ul class="mainnav__menu nav flex-column">

                <!-- role menu -->
                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">마이페이지</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${cPath}/group/students" class="nav-link mininav-toggle collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">학생관리</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${cPath}/group/members" class="nav-link mininav-toggle collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">교수/교직원 관리</span>
                    </a>
                </li>


                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label ms-1">교과목/강의 관리</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="<c:url value='/subjectRenewal/RenewalUI.do'/>" class="nav-link">학과별 교과목 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">학과별 강의 관리</a>
                        </li>
                    </ul>

                </li>


                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">학과 관리</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${cPath}/tuti/tutiList.do" class="nav-link mininav-toggle collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">등록금 관리</span>
                    </a>
                </li>


                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label ms-1">장학금 관리</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                       <!-- 장학금지급내역도 여기서 관리하면 어떨까요? -->
                        <li class="nav-item">
                           <a href="${cPath}/sch/schList.do" class="nav-link">장학금 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="${cPath}/sch/schRecList.do" class="nav-link">장학생 관리</a>
                        </li>
                    </ul>

                </li>

                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-bar-chart fs-5 me-2"></i>
                        <span class="nav-label ms-1">자기주도적 미래설계</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">학과커리탭 관리</a>
                        </li>
                        <!-- 신고관리 여기서 해주세요. -->
                        <li class="nav-item">
                            <a href="#" class="nav-link">모두의커리탭 관리</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">이달의선배탭 관리</a>
                        </li>
                    </ul>

                </li>
                <!-- End - role menu -->
   </security:authorize>





                <hr>

                <!-- all menu -->
                <li class="nav-item">
                    <a href="<c:url value='/univBoard/univBoardList.do'/>" class="nav-link mininav-toggle collapsed"><i class="pli-idea fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">공지게시판</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed"><i class="pli-idea fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">식당정보</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="<c:url value='/facility/facilityList.do'/>" class="nav-link mininav-toggle collapsed"><i class="pli-idea fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1 fw-bold">편의시설</span>
                    </a>
                </li>
                <hr>
<!-- 새 메세지가 있으면 span태그의 NEW 뜰 수 있도록 한다. c:if -->
                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed">
                        <i class="pli-data-center fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1 flex-fill">
                            <span class="d-flex flex-row w-100">
                                LMS 메세지함 <span class="badge bg-info ms-auto">NEW</span>
                            </span>
                        </span>
                    </a>
                </li>

                <hr>

                <!-- End - all menu -->

   <c:if test="${memRole eq 'EMP' || memRole eq 'PRO' }">
                <!-- +role menu -->
                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed"><i class="pli-roller fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1 fw-bold">구성원조회</span>
                    </a>
                </li>
    </c:if>
                <!-- End - +role menu -->
            </ul>
        </div>
        <!-- End - menu -->
    </div>
</div>