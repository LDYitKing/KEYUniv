<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
  h1 {
    text-align: center;
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
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/exam/exam.do?what=${exam.lectNo}">시험정보</a></li>
		<li class="breadcrumb-item active" aria-current="page">시험지</li>
	</ol>
</nav>
</security:authorize>
	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${exam.lectName}</h1>
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
<security:authentication property="principal.realUser" var="authMember"/>
<div class="space m-3 p-5 bigfont">
	  <div style="text-align:right;">
	    <a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
	  </div>
	<h1 class="fs-1">2023학년도 제 1학기 [${exam.lectName }] [${exam.examKind }]</h1>
	<br>
	<h3 class="fs-2" style="text-align:right;">출제자 : ${authMember.memName }</h3>
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th>학과</th>
				<th>강의명</th>
				<th>시험명</th>
				<th>시험종류</th>
				<th>시험일</th>
				<th>시험시간</th>					
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${authMember.deptName }</td>				
				<td>${exam.lectName }</td>				
				<td>${exam.examName }</td>
				<td>${exam.examKind }</td>
				<td>${exam.examDate }</td>
				<td>${exam.examStime }:00 ~ ${exam.examEtime }:00</td>
			</tr>
		</tbody>
		<tfoot>
		</tfoot>
	</table>
	<hr>
	<form> 
	  <security:csrfInput/>
	  <c:forEach var="examQue" items="${examQue}">
	    <hr>
	    <h4 class="fs-3">${examQue.eqNumber}. ${examQue.eqQue} <span style="color:blue;">(${examQue.eqScore}점)</span><br></h4>
	    <c:forEach var="examText" items="${examText}">
	      <c:if test="${examText.eqNo eq examQue.eqNo}">
	        <h5 class="fs-4">
	          <input type="radio" name="asAnswer_${examQue.eqNo}" value="${examText.etNo}">
	          ${examText.etNo}. ${examText.etQue}
	        </h5>
	      </c:if>
	    </c:forEach>
	  </c:forEach>
	</form>
</div>