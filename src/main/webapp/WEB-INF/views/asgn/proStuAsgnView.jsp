<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>
<style>
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
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${lectNo}">강의관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/asgn/proAsgn.do?what=${lectNo}">과제조회</a></li>
		<li class="breadcrumb-item active" aria-current="page">과제 제출 현황</li>
	</ol>
</nav>
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
		      <div class="btn-group">
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
	<h3 class="mt-2 fs-2">학생 제출 과제</h3><br>
	<div id="" class="desc-space mb-4 p-4 ">
		<p class="d-inline-block fs-4 text-truncate mb-2">제출 과제</p>
		<p>- 강의별 수강 학생들 과제 제출 정보를 조회할 수 있습니다. </p>
		<p>- 교수는 과제번호와 점수 클릭시 학생의 과제점수를 수정할 수 있습니다. </p>
		<p>- 아직 과제제출을 하지 않은 학생의 테이블은 비어있습니다. </p>
		<p>- 기본 과제 점수는 0점입니다. </p>
	</div>
	<hr>
	<div style="height: 250px; overflow-y: scroll;" >
	<table class="table table-bordered table-hover" style="cursor: pointer;">
		<thead class="table-primary">
			<tr>
				<th class="text-center">학생명</th>
				<th class="text-center">과제번호</th>
				<th class="text-center">과제내용</th>
				<th class="text-center">제출일자</th>
				<th class="text-center">점수</th>
			</tr>
		</thead>
		
		<tbody id="listBody">
		
		</tbody>
	</table>
	</div>
</div>


<form name="searchForm">
	<input type="hidden" name="page" placeholder="page"/>
	<input type="hidden" name="searchType" placeholder="searchType"/>
	<input type="hidden" name="searchWord" placeholder="searchWord"/>
</form>

<script src="${cPath }/resources/js/asgn/proStuAsgnView.js"></script>