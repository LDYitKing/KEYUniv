<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<style>
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
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${exam.lectNo}">강의관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/exam/exam.do?what=${exam.lectNo }">시험 정보</a></li>
		<li class="breadcrumb-item active" aria-current="page">문제 출제</li>
	</ol>
</nav>
</security:authorize>
	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${exam.lectName}</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${exam.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${exam.lectNo}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${exam.lectNo}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${exam.lectNo}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${exam.lectNo}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${exam.lectNo}" class="btn btn-info">자료실</a> 
		      </div>
		    </div>
		  </security:authorize>
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${exam.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${exam.lectNo}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${exam.lectNo}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${exam.lectNo}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${exam.lectNo}" class="btn btn-info">자료실</a> 
		      </div>
		    </div>
		  </security:authorize>
	</div>
<div class="space m-3 p-5">
	<h3 class="card-title mt-2">문제 출제</h3><br>
	<div id="notice-card" class="card-body mb-4">
		<p class="d-inline-block h5 btn-link text-truncate mb-2">문제 출제 안내사항</p>
		<p>1) 시험문제는 4지선다형입니다. </p>
		<p>   - 시험 출제 시 교수는 한 문제에 대한 정답란에는 모두 같은 번호를 입력해주셔야합니다.
		<p>2) 최대 출제 문제수는 10문제입니다.</p>
		<p>   - 문제수를 바꾸고싶으실 경우 다시 출제할 문제수를 입력하고 추가버튼을 눌러주셔야합니다.
		<p>3) 문제 배점 및 점수 계산 안내 </p>
		<p>   - 교수는 시험을 출제할 때 문제당 배점을 같이 입력해야합니다.</p>
	</div>
	<hr>
	<form id="insertForm" class="row g-3"  enctype="multipart/form-data" >
	<input type="hidden" value="${exam.examNo }" id="examNo">
		<div class="row m-2">
			<div class="col-4">
	     		<label class="form-label">시험명: </label>
			    <input class="form-control" type="text" value="${exam.examName}" name="" readonly/>
			</div>
		</div>
		<div class="row m-2">
			<div class="col-2">
				<label class="form-label">출제할 문제 수: </label>
				<input class="form-control" type="number" name="addCnt" />
				<span id="addErrorSpan" class="text-danger"></span>
			</div>
		</div>	
			
		<div class="col-12">
      		<input id="addFormBtn" class="btn btn-primary" type="button" value="추가" />		
		</div>
	
	<hr>
	<div id="displayDiv" class="col-12" style="display: none">
	<div style="text-align:right;">
		<input type="button" id="autoInput" value="자동완성">
   		<a href="${cPath}/exam/exam.do?what=${exam.lectNo}" class="btn btn-info">시험정보</a>
   	</div>
	  <div id="tableDiv">
	    <table id="insertTable" class="table table-bordered">
	      <thead class="fixed-header">
	        <tr>
	          <th style="width: 10%; text-align: center;">문제번호</th>
	          <th style="width: 35%; text-align: center;">문제</th>
	          <th style="width: 10%; text-align: center;">배점</th>
	          <th style="width: 10%; text-align: center;">지문번호</th>
	          <th style="width: 35%; text-align: center;">보기문항</th>
	          <th style="width: 5%; text-align: center;">정답</th>
	        </tr>
	      </thead>
	      <tbody id="insertFormArea" class="scrollable-body"></tbody>
	    </table>
	  </div>
	  <input class="btn btn-primary mt-2" type="submit" id="insertFormBtn" value="등록하기" />
	</div>
    </form>
</div>
<!-- 폼 끝 -->
<script src="${cPath }/resources/js/exam/examQueForm.js"></script>

