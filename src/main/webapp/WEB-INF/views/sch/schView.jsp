<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
 .marginSpace{
	margin-right: 66px;
} 
</style>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/sch/schList.do">장학금 관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">장학금 상세보기</li>
	</ol>
</nav>
<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">장학금</h1>
	</div>
	
	<security:authorize access="hasRole('EMP')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a href="${cPath}/sch/schList.do" class="btn btn-info">장학금 관리</a>
	        <a href="${cPath}/sch/schRecList.do" class="btn btn-info">장학생관리</a>
	      </div>
	    </div>
	</security:authorize>
</div>	
<div class="space m-3 p-5" > 
<table class="table table-boardered">
	
	<tr>
		<th>장학금명 :</th>
		<td>${sch.schName}</td>
	</tr>
	
	<tr>
		<th>장학금액 :</th>
		<td>${sch.schAmount}만원</td>
	</tr>
	
	<tr>
		<th>장학금 내용 :</th>
		<td>${sch.schCont}</td>
	</tr>
	
	<tr>
		<th>장학금 신청 조건 :</th>
		<td>${sch.schReq}</td>
	</tr>

	<tr>
		<td colspan="2">
			<c:url value="/sch/schUpdate.do" var="updateURL">
				<c:param name="what" value="${sch.schNo}"/>
			</c:url>
		</td>
	</tr>
</table>
</div>
		<form:form modelAttribute="sch" action="${cPath}/sch/schDelete.do" method="post">
		<security:authorize access="hasRole('EMP')">
		<a class="btn btn-primary" href="${updateURL}">수정</a>
		</security:authorize>
		<form:hidden path="schNo"/>
		<security:authorize access="hasRole('EMP')">
		<input class="btn btn-danger" type="submit" value="삭제"/>
		</security:authorize>
		
		<a class="btn btn-info" href="${cPath }/sch/schList.do" >목록으로</a>
		<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
		</form:form>

