<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<security:authentication property="principal.realUser" var="authMember" />
<style>
.marginSpace{
	margin-right: 66px;
}
</style>
<security:authorize access="hasRole('PRO')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${asgn.lectNo}">강의관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/asgn/proAsgn.do?what=${asgn.lectNo}">과제 조회</a></li>
		<li class="breadcrumb-item active" aria-current="page">과제 등록</li>
	</ol>
</nav>
</security:authorize>
<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${lect }</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${asgn.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${asgn.lectNo}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${asgn.lectNo}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${asgn.lectNo}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${asgn.lectNo}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${asgn.lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${asgn.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${asgn.lectNo}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${asgn.lectNo}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${asgn.lectNo}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${asgn.lectNo}" class="btn btn-info">자료실</a> 
		      </div>
		    </div>
		  </security:authorize>
	</div>
<div class="space m-3 p-5 bigfont">
	<div style="text-align:right">
		<input type="button" value="자동완성" id="autoButton">
	</div>	
	<form:form modelAttribute="asgn" id="proForm" method="post" enctype="multipart/form-data">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<td colspan="2">
						<h3 class="fs-2">과제 등록</h3>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>과제명</th>
					<td id="asgnName">
						<form:textarea path="asgnName" maxlength="20" rows="2" cols="90" />
						<form:errors path="asgnName" element="span" class="text-danger"/>
					</td>
				</tr>
				<tr>
					<th>과제내용</th>
					<td id="asgnContent">
						<form:textarea path="asgnContent" maxlength="4000" 
							rows="10" cols="90"/>
						<form:errors path="asgnContent" element="span" class="text-danger"/>
					</td>
				</tr>
				<tr>
					<th>과제마감일자</th>
					<td id="asgnDate">
						<form:input type="date" path="asgnDdate"/>
						<form:errors path="asgnDdate" element="span" class="text-danger"/>
					</td>
				</tr>
				<tr>
					<th>과제첨부파일</th>
					<td>
						<input type="file" name="asgnFiles" />
						<input type="file" name="asgnFiles" />
						<input type="file" name="asgnFiles" />
						<form:errors path="asgnFile" element="span" class="text-danger"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="과제 생성" class="btn btn-success" />
						<input type="reset" value="취소" class="btn btn-secondary" />
						<a href="javascript:history.back();" class="btn btn-primary">뒤로가기</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</div>
<script>
$(document).ready(function() {
	  $("#autoButton").click(function() {
	    const existingData = {
	      asgnName: "데이터베이스 15주차 과제입니다.",
	      asgnContent: "자신이 설계한 쇼핑몰 ERD를 작성해 제출하세요",
	      asgnDate: "2023-06-15"
	    };

	    $("#asgnName textarea").val(existingData.asgnName);
	    $("#asgnContent textarea").val(existingData.asgnContent);
	    $("#asgnDate input[type='date']").val(existingData.asgnDate);
	  });
	});
</script>