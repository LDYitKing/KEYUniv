<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<style>
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
		<li class="breadcrumb-item active" aria-current="page">시험 등록</li>
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
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${exam.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${exam.lectNo}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${exam.lectNo}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${exam.lectNo}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${exam.lectNo}" class="btn btn-info">자료실</a> 
		      </div>
		    </div>
		  </security:authorize>
	</div>
<div class="space m-3 p-5 bigfont">
	<div style="text-align:right">
		<input type="button" value="자동완성" id="autoButton">
	</div>	
	<form:form modelAttribute="exam" method="post" enctype="multipart/form-data">
		<table class="table table-boardered">
		<form:hidden path="lectNo" value="${exam.lectNo }"/>
			<tr>
				<th>시험명</th>
				<td id="examName">
					<form:input path="examName" class="form-control" />
					<form:errors path="examName" element="span" class="text-danger" />
				</td>
			</tr>
			<tr>
				<th>시험일</th>
				<td id="examDate">
					<form:input type="date" path="examDate" class="form-control" style="width:500px;"/>
					<form:errors path="examDate" element="span" class="text-danger" />
				</td>
			</tr>
			<tr>
				<th>시험시작시간</th>
				<td id="examStime">
					<form:input  path="examStime" class="form-control" style="width:100px;"/>
					<form:errors path="examStime" element="span" class="text-danger" />
				</td>
			</tr>
			<tr>
				<th>시험종료시간</th>
				<td id="examEtime">
					<form:input  path="examEtime" class="form-control" style="width:100px;"/>
					<form:errors path="examEtime" element="span" class="text-danger" />
				</td>
			</tr>
			<tr>
				<th>시험종류</th>
				<td id="examKind">
					<input type="radio" name="examKind" value="중간고사">
					<label for="examKind">중간고사</label>
					
					<input type="radio" name="examKind" value="기말고사">
					<label for="examKind">기말고사</label>
					
					<form:errors path="examKind" element="span" class="text-danger" />
				</td>
			</tr>
			<tr>
				<th>시험구분</th>
				<td id="examType">
					<input type="radio" name="examType" value="E001">
					<label for="examType">대면</label>
					<input type="radio" name="examType" value="E002">
					<label for="examType">비대면</label>
					<form:errors path="examType" element="span" class="text-danger" />
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: right">
					<input type="submit" class="btn btn-success" value="등록" />
					<input type="reset" class="btn btn-danger" value="초기화" />
				</td>
			</tr>
		</table>
	</form:form>
</div>
<script>
$(document).ready(function() {
	  $("#autoButton").click(function() {
	    const existingData = {
   		  	examName: "데이터베이스 기말고사2",
	   		examDate: "2023-06-12",
	   		examStime: "13",
	   		examEtime:"14"
	      
	    };

	    $("#examName input").val(existingData.examName);
	    $("#examDate input[type='date']").val(existingData.examDate);
	    $("#examStime input").val(existingData.examStime);
	    $("#examEtime input").val(existingData.examEtime);

	  });
	});
</script>