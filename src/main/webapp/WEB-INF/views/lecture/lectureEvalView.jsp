<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.marginSpace{
	margin-right: 66px;
}
</style>
<security:authentication property="principal.realUser" var="authMember"/>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${lectEval.lectNo}">수강관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">평가관리</li>
	</ol>
</nav>

<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
	</div>
	  <security:authorize access="hasRole('STU')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${lectEval.lectNo}" class="btn btn-info">출석</a>
	        <a href="${cPath}/lecture/lectEval.do?what=${lectEval.lectNo}" class="btn btn-info">평가</a>
	        <a href="${cPath}/asgn/asgn.do?what=${lectEval.lectNo}" class="btn btn-info">과제</a>
	        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${lectEval.lectNo}" class="btn btn-info">시험</a>
	        <a id="lecutreData" href="${cPath}/lecture?what=${lectEval.lectNo}" class="btn btn-info">자료실</a> 
	      </div>
	    </div>
	  </security:authorize>
</div>
<div class="space m-3 p-5">
	<table class="table table-striped">
		<thead>
			<tr class="text-center">
				<th>평가번호</th>
				<th>평가항목</th>
				<th>평가내용</th>
				<th>응답</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${leaList}" var="lea" varStatus="i" begin="0" end="5">
				<tr>
					<td class="text-center">${lea.leaNo }</td>
					<td>${lea.leaQue }</td>
					<td>${lea.leaContent }</td>
					<td class="text-center">
					<c:choose>
						<c:when test="${lectEvalList[i.index].leAnswer eq '1'}">
						아주조금
						</c:when>
						<c:when test="${lectEvalList[i.index].leAnswer eq '2'}">
						조금
						</c:when>
						<c:when test="${lectEvalList[i.index].leAnswer eq '3'}">
						보통
						</c:when>
						<c:when test="${lectEvalList[i.index].leAnswer eq '4'}">
						많이
						</c:when>
						<c:when test="${lectEvalList[i.index].leAnswer eq '5'}">
						아주많이
						</c:when>
					</c:choose>
					</td>
				</tr>
			</c:forEach>
				<tr>
					<td class="text-center">${leaList[6].leaNo }</td>
					<td>${leaList[6].leaQue }</td>
					<td colspan="2">
						<textarea style="resize:none; border:none;" rows="5" cols="100" readonly="readonly">${lectEvalList[6].leAnswer}</textarea>
					</td>
				</tr>
		</tbody>
	</table>
</div>