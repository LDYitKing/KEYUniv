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
<nav aria-label="breadcrumb"  class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">등록금 관리</li>
	</ol>
</nav>
<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">장학생</h1>
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
<h4>등록금 상세보기</h4>
<table class="table table-boardered">
	
	<tr>
		<th>이름 :</th>
		<td>${tutipay.memName}</td>
	</tr>
	
	<tr>
		<th>단과대학:</th>
		<td>${tutipay.colName}</td>
	</tr>
	
	<tr>
		<th>학과명:</th>
		<td>${tutipay.deptName}</td>
	</tr>
	
   	<tr>
		<th>해당 학기:</th>
		<td>${tutipay.schRecSemester}</td>
	</tr>
	
	<tr>
		<th>납부일</th>
		<td>${tutipay.tpDate}</td>
	</tr>
	
	<tr>
		<th>납부 금액</th>
		<td>${tutipay.tpAmount}</td>
	</tr>
	
	<tr>
		<td colspan="2">
			<c:url value="/tuti/tutiUpdate.do" var="updateURL">
				<c:param name="what" value="${tuti.tuitionNo }"/>
			</c:url>
		</td>
	</tr>
</table>
	<form:form modelAttribute="tuti" action="${cPath}/tuti/tutiDelete.do" method="post">
		<form:hidden path="tuitionNo"/>
		<security:authorize access="hasRole('EMP')">
		<a class="btn btn-primary" href="${updateURL}">수정</a>
		</security:authorize>
		<security:authorize access="hasRole('EMP')">
		<input class="btn btn-danger" type="submit" value="삭제"/>
		</security:authorize>
		<a class="btn btn-info" href="${cPath }/tuti/tutiList.do" >목록으로</a>
		<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
	</form:form>
</div>
	
	