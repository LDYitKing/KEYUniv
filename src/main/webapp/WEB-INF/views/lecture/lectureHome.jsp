<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
#lectTable th {
  background-color : #F2F2F2;
  text-align : center;
}
.marginSpace{
	margin-right: 66px;
}

</style>
<security:authorize access="hasRole('PRO')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">강의관리</li>
	</ol>
</nav>
</security:authorize>

<security:authorize access="hasRole('STU')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">수강관리</li>
	</ol>
</nav>
</security:authorize>

	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${lecture.lectName}</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
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
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${what}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${what}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${what}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${what}" class="btn btn-info">시험</a>
		        <a id="stulectureData"href="${cPath}/lecture?what=${what}"class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
	</div>
<security:authentication property="principal.realUser" var="authMember"/>
<div class="space m-3 p-5 bigfont">
	<div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 20px;" >
		<div>
			<table class="table table-boardered underbar attendTable" id="lectTable">
					<tr>
						<th>강의명</th>
						<td>${lecture.lectName }</td>
					</tr>
					<tr>
						<th>학과</th>
						<td>${lecture.deptName }</td>
					</tr>
					<tr>
						<th>교수명</th>
						<td>${lecture.memName }</td>
					</tr>
					<tr>
						<th>학사년도</th>
						<td>${lecture.ayYear }학년도 ${lecture.aySemester }학기</td>
					</tr>
					<tr>
						<th>강의구분</th>
						<td>${lecture.subCommName } ${lecture.subGrade }학년(${lecture.subScr }학점)</td>
					</tr>
					<tr>
						<th>시간/장소</th>
						<td>
							<c:forEach items="${lecture.lectDetailList }" var="ldt">
								${ldt.ltdDay} ${ldt.ltdPeriod}교시 : ${ldt.builName} ${ldt.lrNum}호<br>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>수강인원</th>
						<td>${lecture.lectPm }/${lecture.lectMm }</td>
					</tr>
					<tr>
						<th>대면여부</th>
						<td>${lecture.lectOnfName }</td>
					</tr>
					<tr>
						<th>강의설명</th>
						<td>${lecture.lectExp }</td>
					</tr>
			</table>
			<h5 class="mb-4 fs-2">
				<ion-icon name="stop-outline"></ion-icon>
				성적처리기준
			</h5>
			<table class="table table-borered text-center">
			<thead>
				<tr>
					<c:forEach var="crtr" items="${crtrList}">
						<td>${crtr.commName}</td>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<tr>
					<c:forEach var="crtr" items="${crtrList}">
						<td>${crtr.scRatio}%</td>
					</c:forEach>
				</tr>
			</tbody>
		</table>
		</div>
		<div>
			<table class="table table-bordered">
			  <thead>
			    <tr>
			      <th>주차</th>
			      <th>내용</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:forEach items="${lecture.lectPlanList}" var="lpl" varStatus="loop">
			      <tr>
			        <td>${lpl.lwpWeek}</td>
			        <td>${lpl.lwpContent}</td>
			      </tr>
			    </c:forEach>
			  </tbody>
			</table>
		</div>
	</div>
	<hr>
</div>

