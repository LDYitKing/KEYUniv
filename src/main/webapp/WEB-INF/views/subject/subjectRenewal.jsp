<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<security:authentication property="principal.realUser" var="authMember"/>
<link rel="stylesheet" href="${cPath }/resources/css/subject/subjectManagement.css" type="text/css">
<link rel="stylesheet" href="${cPath }/resources/css/lecture/lecturePlan.css" type="text/css">

<nav class="mb-3" aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">교과 발전</li>
<%-- 		<li class="breadcrumb-item active" aria-current="page"><a href="${cPath}/subjectRenewal/RenewalUI.do">교과발전</a></li> --%>
	</ol>
</nav>

<div class="row mx-3 justify-content-between">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">교과발전</h1>
		</div>
<!-- 	<div class="btn-group col-3" role="group" aria-label="Default button group"> -->
<!-- 		<a class="btn btn-info">교과목</a> -->
<%-- 		<security:authorize access="hasAnyRole('PRO')"> --%>
<!-- 		<a class="btn btn-info" id="lectPlanBtn">강의등록</a> -->
<%-- 		</security:authorize> --%>
<!-- 	</div> -->
</div>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~전체 space~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<div class="space m-3 p-5">
	<!-- 버튼 -->
	<div>
		<div class="btn-group bigfont" role="group" aria-label="Default button group">
			<button type="button" class="btn btn-info" id="AllSubjectListBtn">교과목 목록</button>
			<security:authorize access="hasAnyRole('EMP')">
				<button type="button" class="btn btn-info" id="AllWaitListBtn">교과목 요청 현황</button>
			</security:authorize>
			<security:authorize access="hasAnyRole('PRO')">
				<button type="button" class="btn btn-info" id="AllProcessListBtn">교과목 처리 현황</button>
			</security:authorize>
			<security:authorize access="hasAnyRole('PRO')">
				<button type="button" class="btn btn-info" id="MyLectListBtn">나의강의 목록</button>
			</security:authorize>
			<security:authorize access="hasAnyRole('PRO','STU')">
				<button type="button" class="btn btn-info" id="FavoriteListBtn">즐겨찾기</button>
			</security:authorize>
			<security:authorize access="hasAnyRole('STU')">
				<button type="button" class="btn btn-info" id="MySugangListBtn">내가 수강한 과목</button>
			</security:authorize>
		</div>
	</div>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~리스트 보이는 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<div>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교과목리스트 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<div id="AllSubjectListBtnDiv" class="bigfont">
			<br><br>
			<h1 class="fs-2">교과목 목록</h1>
			<!-- 검색 -->
			<div class="form-group m-2">
				<div class="row align-items-center" >
					<select class="form-select" id="selectSubjectListInput"
						style="width: 15%; margin-left: 8px">
						<option value="all">전체</option>
						<option value="deptName">학과별</option>
						<option value="subCommName">교과목유형별</option>
					</select> <input type="text" id="searchSubjectListInput"
						class="form-control" placeholder="검색" style="width: 83%;" />
				</div>
			</div>
			<!-- 검색 -->
			<table class="table table-hover text-center">
				<colgroup>
					<col width="7%" />
					<col width="10%" />
					<col width="10%" />
					<col width="30%" />
					<col width="10%" />
					<security:authorize access="hasAnyRole('PRO','EMP')">
					<col width="7%" />
					</security:authorize>
				</colgroup>
				<tbody class="table-primary">
					<tr>
						<td>번호</td>
						<td>단과대학명</td>
						<td>학과명</td>
						<td>교과목명</td>
						<td>유형</td>
						<security:authorize access="hasAnyRole('PRO','EMP')">
							<td>상태</td>
						</security:authorize>
					</tr>
				</tbody>
			</table>
			<div id="subjectListDiv" style="height: 200px; overflow: auto;" class="overflow-scroll scrollable-content">
				<table class="table table-hover text-center">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="10%" />
						<col width="30%" />
						<col width="10%" />
						<security:authorize access="hasAnyRole('PRO','EMP')">
						<col width="7%" />
						</security:authorize>
					</colgroup>
					<tbody id="listBody"
						data-view-url="${cPath}/subject/subjectView.do">

					</tbody>
				</table>
			</div>
			<security:authorize access="hasAnyRole('PRO')">
				<div style="text-align:center;">
				<a href="javascript:fn_CreateSubjectInsert()"
					class="btn btn-secondary">등록</a>
				</div>
			</security:authorize>
		</div>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교과목리스트 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교과목요청현황 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<%-- 		<security:authorize access="hasAnyRole('EMP')"> --%>
		<div id="AllWaitListBtnDiv" class="bigfont">
		<br><br>
			<h1 class="fs-2">교과목 요청 현황</h1>
			<!-- 검색 -->
			<div class="form-group">
				<div class="row align-items-center">
					<select class="form-select" id="selectsubjectCheckListInput"
						style="width: 15%; margin-left: 8px">
						<option value="all">전체</option>
						<option value="deptName">학과별</option>
						<option value="subCommName">교과목유형별</option>
					</select> <input type="text" id="searchsubjectCheckListInput"
						class="form-control" placeholder="검색" style="width: 83%;" />
				</div>
			</div>
			<!-- 검색 -->
			<%-- 			<security:authorize access="hasAnyRole('EMP')"> --%>
			<%-- 			</security:authorize> --%>
			<table class="table table-hover text-center">
				<colgroup>
					<col width="7%" />
					<col width="10%" />
					<col width="10%" />
					<col width="30%" />
					<col width="10%" />
					<col width="7%" />
<%-- 						<col width="10%" /> --%>
				</colgroup>
				<thead class="table-primary">
					<tr>
						<th>번호</th>
						<th>단과대학명</th>
						<th>학과명</th>
						<th>교과목명</th>
						<th>유형</th>
						<th>상태</th>
<!-- 							<th>처리</th> -->
					</tr>
				</thead>
			</table>
			<div id="subjectCheckListDiv" style="height: 200px; overflow: auto;">
				<table class="table table-hover text-center">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="10%" />
						<col width="30%" />
						<col width="10%" />
						<col width="7%" />
<%-- 							<col width="10%" /> --%>
					</colgroup>
					<tbody id="reqListBody">

					</tbody>
				</table>
			</div>
			<div style="text-align:center;">
			<a href="javascript:fn_SubjectOKAll()" class="btn btn-secondary">전체승인</a>
			</div>
		</div>

<%-- 		</security:authorize> --%>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교과목요청현황 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교과목처리현황 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<%-- 		<security:authorize access="hasAnyRole('PRO')"> --%>
			<div id="AllProcessListBtnDiv" class="bigfont">
			<br><br>
				<h1 class="fs-2">교과목 처리 현황</h1>
				<!-- 검색 -->
				<div class="form-group mb-2">
					<div class="row align-items-center">
						<select class="form-select" id="selectSubjectWaitingListInput"
							style="width: 15%; margin-left: 8px">
							<option value="all">전체</option>
							<option value="deptName">학과별</option>
							<option value="subCommName">교과목유형별</option>
						</select> <input type="text" id="searchSubjectWaitingListInput"
							class="form-control" placeholder="검색" style="width: 83%;" />
					</div>
				</div>
				<!-- 검색 -->
				<table class="table table-hover text-center">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="10%" />
						<col width="30%" />
						<col width="10%" />
						<col width="7%" />
<%-- 						<col width="10%" /> --%>
					</colgroup>
					<thead class="table-primary">
						<tr>
							<th>번호</th>
							<th>단과대학명</th>
							<th>학과명</th>
							<th>교과목명</th>
							<th>유형</th>
							<th>상태</th>
<!-- 							<th>처리</th> -->
						</tr>
					</thead>
				</table>
				<div id="SubjectWaitingListDiv"
					style="height: 200px; overflow: auto;">
					<table class="table table-hover text-center">
						<colgroup>
							<col width="7%" />
							<col width="10%" />
							<col width="10%" />
							<col width="30%" />
							<col width="10%" />
							<col width="7%" />
<%-- 							<col width="10%" /> --%>
						</colgroup>
						<tbody id="SubjectWaitingListBody">

						</tbody>
					</table>
				</div>
			</div>

<%-- 		</security:authorize> --%>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교과목처리현황 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~즐겨찾기 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<%-- 		<security:authorize access="hasAnyRole('STU','PRO')"> --%>
		<div id="FavoriteListBtnDiv" class="bigfont">
			<br><br>
			<h1 class="fs-2">즐겨찾기 목록</h1>
			<input type="text" id="searchFavoriteSubjectInput"
				class="form-control col-auto mb-2" placeholder="교과목명 검색" />
			<table class="table table-hover text-center" id="favoriteTable">
				<colgroup>
					<col width="7%" />
					<col width="10%" />
					<col width="30%" />
					<col width="10%" />
					<col width="7%" />
					<col width="7%" />
					<col width="7%" />
				</colgroup>
				<thead class="table-primary">
					<tr>
						<th>번호</th>
						<th>학과명</th>
						<th>교과목명</th>
						<th>교과목유형</th>
						<th>학년</th>
						<th>학점</th>
						<th>시수</th>
					</tr>
				</thead>
			</table>
			<div id="favoritesDiv" style="height: 200px; overflow: auto;" class="overflow-scroll scrollable-content">
				<table class="table table-hover text-center">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="30%" />
						<col width="10%" />
						<col width="7%" />
						<col width="7%" />
						<col width="7%" />
					</colgroup>
					<tbody id="favorites">

					</tbody>
				</table>
			</div>
		</div>

<%-- 		</security:authorize> --%>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~즐겨찾기 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~내강의목록 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<%-- 		<security:authorize access="hasAnyRole('STU','PRO')"> --%>
		<div id="myLectListBtnDiv" class="bigfont">
			<br><br>
			<h1 class="fs-2">내강의 목록</h1>
			<input type="text" id="myLectInput"
				class="form-control col-auto mb-2" placeholder="교과목명 검색" />
			<table class="table table-hover text-center" id="myLectTable">
				<colgroup>
					<col width="7%" />
					<col width="30%" />
					<col width="10%" />
					<col width="7%" />
					<col width="7%" />
				</colgroup>
				<thead class="table-primary">
					<tr>
						<th>강의번호</th>
						<th>강의명</th>
						<th>교수명</th>
						<th>유형</th>
						<th>학과</th>
					</tr>
				</thead>
			</table>
			<div id="myLectDiv" style="height: 200px; overflow: auto;" class="overflow-scroll scrollable-content">
				<table class="table table-hover text-center">
					<colgroup>
						<col width="7%" />
						<col width="30%" />
						<col width="10%" />
						<col width="7%" />
						<col width="7%" />
					</colgroup>
					<tbody id="myLect">

					</tbody>
				</table>
			</div>
			<security:authorize access="hasAnyRole('PRO')">
				<div style="text-align:center;">
				<a class="btn btn-info" id="lectPlanBtn">강의등록</a>
				</div>
			</security:authorize>
		</div>

<%-- 		</security:authorize> --%>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~나의 강의목록 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~나의교과목 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<div id="MySugangListBtnDiv" class="bigfont">
		<br><br>
		<h1 class="fs-2">내가 수강한 교과목</h1>
		<div class="mySuganggridDiv" style="display:grid; grid-template-columns:3fr 2fr; width:100%;">
			<div>
				<h4 class="mb-4 fs-4">
					<ion-icon name="stop-outline" role="img" class="md hydrated">
					</ion-icon>
					나의 교과목 안내
				</h4>
				<div class="desc-space pt-4 p-3">
				<p>1. 내가 수강한 교과목들의 직업분야를 파악하여, 어떤 직업에 강점이 생기고 있는지 파악할 수 있습니다.</p>
				<p>2. 직업에 대한 교과목을 수강하였다고 해서 꼭 그 직업만 할 수 있는 것은 아니며, 참고용으로만 확인하시기 바랍니다.</p>
				<p>3. 아래의 직업별 교과목 리스트를 통해 자신이 원하는 직업에 맞는 교과목을 찾아보시고, 즐겨찾기에 추가하세요!</p>
				</div>
			</div>
			<div>
				<h4 class="fs-4">
					<ion-icon name="stop-outline" role="img" class="md hydrated">
					</ion-icon>
					나의 직업별 전문성은?
				</h4>
				<div style="text-align:center;">
					<div id="Piechart" style="width:100%;">
					</div>
				</div>
			</div>
		</div>
			<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~직업별리스트 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
			<div>
				<h1 class="fs-2">직업별 교과목 목록</h1>
				<!-- 검색 -->
				<div class="form-group">
					<div class="row align-items-center">
						<select class="form-select" id="selectJobSubjectListInput"
							style="width: 15%; margin-left: 8px">
							<option value="all">전체</option>
							<option value="jobName">직업별</option>
							<option value="subCommName">교과목유형별</option>
						</select> <input type="text" id="searchJobSubjectListInput"
							class="form-control" placeholder="검색" style="width: 83%;" />
					</div>
				</div>
				<!-- 검색 -->
				<table class="table table-hover text-center">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="30%" />
						<col width="10%" />
						<col width="7%" />
						<col width="7%" />
					</colgroup>
					<tbody class="table-primary">
						<tr>
							<td>번호</td>
							<td>직업명</td>
							<td>교과목명</td>
							<td>유형</td>
							<td>학년</td>
							<td>학점</td>
						</tr>
					</tbody>
				</table>
				<div id="jobSubjectListDiv"style="height: 200px; overflow: auto;" class="overflow-scroll scrollable-content">
					<table class="table table-hover text-center">
						<colgroup>
							<col width="7%" />
							<col width="10%" />
							<col width="30%" />
							<col width="10%" />
							<col width="7%" />
							<col width="7%" />
						</colgroup>
						<tbody id="jobListBody"
							data-view-url="${cPath}/subject/subjectView.do">
	
						</tbody>
					</table>
				</div>
			</div>
			<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~직업별리스트 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		</div>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~나의교과목 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	</div>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~리스트 보이는 div~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교수추천~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<security:authorize access="hasAnyRole('PRO','STU')">
	<br><br><hr>
	<div id="professorSugDiv" class="midiumfont">
		<h5 class="fw-bold fs-2"><ion-icon name="pricetags"></ion-icon>&nbsp;${authMember.deptName } 교수 추천 교과목!</h5>
	<hr>
	<div style="display: grid; grid-template-columns: 1fr 1fr 1fr;"
		class="m-1" id="ProfessorSuggestion">
		<div class="card border-2 border-success m-2">
			<div class="card-body pt-2">
                <!-- Profile picture and short information -->
                <div class="text-center position-relative">
                    <div class="pb-3 pt-3">
                        <img class="img-lg rounded-circle" src="${cPath}/resources/img/pro1.jpg" alt="Profile Picture" loading="lazy">
                    </div>
                    <p class="h5" id="sugProfessorName0"></p>
                    <p class="text-muted" id="sugProfessorLoe0"></p>
                </div>

                <!-- END : Profile picture and short information -->

                <!-- Social media buttons -->
                <div class="mt-4 pt-3 text-center border-top text-muted" >
                	<table style="margin-left:8px">
                		<tbody id="sugFavorite0"></tbody>
                	</table>
                </div>
                <!-- END : Social media buttons -->

            </div>
		</div>
		<div class="card border-2 border-success m-2">	
			<div class="card-body pt-2">
                <!-- Profile picture and short information -->
                <div class="text-center position-relative">
                    <div class="pb-3 pt-3">
                        <img class="img-lg rounded-circle" src="${cPath}/resources/img/pro2.jpg" alt="Profile Picture" loading="lazy">
                    </div>
                    <p class="h5" id="sugProfessorName1"></p>
                    <p class="text-muted" id="sugProfessorLoe1"></p>
                </div>

                <!-- END : Profile picture and short information -->

                <!-- Social media buttons -->
                <div class="mt-4 pt-3 text-center border-top text-muted">
                	<table style="margin-left:8px">
                		<tbody id="sugFavorite1"></tbody>
                	</table>
               
                </div>
                <!-- END : Social media buttons -->

            </div>
		</div>
		<div class="card border-2 border-success m-2">
			<div class="card-body pt-2">
                <!-- Profile picture and short information -->
                <div class="text-center position-relative">
                    <div class="pb-3 pt-3">
                        <img class="img-lg rounded-circle" src="${cPath}/resources/img/pro3.png" alt="Profile Picture" loading="lazy">
                    </div>
                    <p class="h5" id="sugProfessorName2"></p>
                    <p class="text-muted" id="sugProfessorLoe2"></p>
                </div>

                <!-- END : Profile picture and short information -->

                <!-- Social media buttons -->
                <div class="mt-4 pt-3 text-center border-top text-muted">
                	<table style="margin-left:8px">
                		<tbody id="sugFavorite2"></tbody>
                	</table>
               
                </div>
                <!-- END : Social media buttons -->

            </div>
		</div>
	</div>
	</div>
	</security:authorize>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~교수추천~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
</div>
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~전체 space~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->


<!-- ~~~~~~~~~~~~~~ cPath JS파일로 가져가기~~~~~~~~~~~~~~~ -->
<input type="hidden" id="cPath" value="${cPath}" />
<!-- ~~~~~~~~~~~~~~ AuthMember JS파일로 가져가기~~~~~~~~~~~~~~~ -->
<input type="hidden" id="memRole" value="${authMember.memRole}" />
<input type="hidden" id="memNo" value="${authMember.memNo}" />
<c:if test="${authMember.memRole eq'ROLE_EMP'}"> 
	<input type="hidden" id="empNo" value="${authMember.empNo}" />
</c:if>
<c:if test="${authMember.memRole eq'ROLE_PRO'}">  
<input type="hidden" id="proNo" value="${authMember.proNo}" />
</c:if>
<c:if test="${authMember.memRole ne 'ROLE_EMP'}"> 
<input type="hidden" id="colNo" value="${authMember.colNo}" />
<input type="hidden" id="deptNo" value="${authMember.deptNo}" />
</c:if>
<!-- ~~~~~~~~~~~~~~ JS파일 연결~~~~~~~~~~~~~~~ -->
<script src="${cPath }/resources/js/subject/subjectRenewal.js"></script>


