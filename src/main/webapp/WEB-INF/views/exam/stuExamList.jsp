<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<security:authentication property="principal.realUser" var="authMember"/>
<style>
.ebage{
  padding: 0.5em 1em;
  font-size: 1.2em;
}
.modal-backdrop {
   width : 0%;
   height: 0%;
}
#notice-card{
  	background-color: #f2f2f2;
  }
.marginSpace{
	margin-right: 66px;
}
</style>
<security:authorize access="hasRole('STU')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${lectNo}">수강관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">시험 정보</li>
	</ol>
</nav>
</security:authorize>
	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName }</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${what}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${what}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${what}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${what}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${what}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${what}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${what}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${what}" class="btn btn-info">평가</a>
		        <a href="${cPath}/asgn/asgn.do?what=${what}" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${what}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${what}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
	</div>
<div class="space m-3 p-5">
	<h3 class="card-title mt-2">시험</h3><br>
	<div id="notice-card" class="card-body mb-4">
		<p class="d-inline-block h5 btn-link text-truncate mb-2">시험 안내사항</p>
		<p>- 학생의 시험 응시 정보를 확인할 수 있습니다. </p>
		<p>- 시험 보기 버튼 클릭시 시험응시 페이지로 이동할 수 있습니다. </p>
		<p>- 응시한 시험은 응시여부에 결과보기 버튼이 출력됩니다. </p>
		<p>- 결과 보기 클릭시 제출한 시험 정보와, 문제의 답을 볼 수 있습니다. </p>
		<p>- 시험 점수는 100점 만점에 맞은 문제의 점수로 계산됩니다. </p>
	</div>
	<hr>
	<form name="listForm">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th>시험번호</th>
					<th>시험명</th>
					<th>시험일</th>
					<th>시험구분</th>
					<th style="width: 150px;">응시 여부</th>
				</tr>
			</thead>
			<tbody id="examBody" data-view-url="${cPath}/exam/stuExam.do" data-cpath="${cPath }">
				
			</tbody>
			<tfoot>
			</tfoot>
		</table>
	</form>
</div>

<script src="${cPath }/resources/js/exam/stuExamList.js"></script>