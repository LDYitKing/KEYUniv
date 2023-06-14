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

<security:authorize access="hasRole('PRO')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${lectNo}">강의관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">시험 정보</li>
	</ol>
</nav>
</security:authorize>
	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${lectNo}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${lectNo}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${lectNo}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${lectNo}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${lectNo}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${lectNo}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${lectNo}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${lectNo}" class="btn btn-info">자료실</a> 
		      </div>
		    </div>
		  </security:authorize>
	</div>
<div class="space m-3 p-5 bigfont">
	<h3 class="fs-2 mt-2">강의별 시험 정보</h3><br>
	<div id="" class="desc-space mb-4 p-4">
		<p class="d-inline-block fs-3 text-truncate mb-2">시험 정보</p>
		<p>- 강의별 시험 정보를 조회할 수 있습니다. </p>
		<p>- 시험번호 클릭시 시험에 대한 상세정보를 볼 수 있습니다. </p>
		<p>- 시험등록버튼 클릭시 시험을 정보를 등록할 수 있습니다. </p>
		<p>- 문제출제 버튼 클릭시 각 시험에 대한 문제를 등록할 수 있습니다. </p>
	</div>
	<hr>
<div style="text-align: right; margin-bottom: 10px">
	<a href="${cPath }/exam/examInsert.do?what=${lectNo}" class="btn btn-outline-info">시험 등록</a>
</div>
	<form name="listForm">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th width="10%">시험번호</th>
					<th width="25%">시험명</th>
					<th width="10%">시험일</th>
					<th width="10%">시험구분</th>
					<th width="10%">문제출제</th>
					<th width="10%">삭제</th>
				</tr>
			</thead>
			<tbody id="examBody" data-view-url="${cPath}/exam/exam.do" data-cpath="${cPath }">
				
			</tbody>
			<tfoot>
			</tfoot>
		</table>
	</form>
</div>
<div class="detaileExam space m-3 p-5 bigfont" style="display:none;">
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th colspan="2"><h4 style="font-weight:bold; text-align:left">&nbsp&nbsp시험 상세정보</h4></th>
			</tr>
		</thead>
		<tbody class="detailView">
		
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<span class="btnSpace"></span>
				</td>		
			</tr>
		</tfoot>
	</table>
</div>


<script src="${cPath }/resources/js/exam/examList.js"></script>