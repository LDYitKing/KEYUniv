<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
.marginSpace{
	margin-right: 66px;
}
</style>
<security:authentication property="principal.realUser" var="authMember"/>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${what}">수강관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">과제관리</li>
	</ol>
</nav>

<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
	</div>
	  <security:authorize access="hasRole('STU')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${what}" class="btn btn-info">출석</a>
	        <a href="${cPath}/lecture/lectEval.do?what=${what}" class="btn btn-info">평가</a>
	        <a href="${cPath}/asgn/asgn.do?what=${what}" class="btn btn-info">과제</a>
	        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${what}" class="btn btn-info">시험</a>
	        <a id="lecutreData" href="${cPath}/lecture?what=${what}" class="btn btn-info">자료실</a> 
	      </div>
	    </div>
	  </security:authorize>
</div>

<div class="space m-3 p-5">
	<form name="listForm">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th>과제번호</th>
					<th>과제명</th>
					<th>과제등록일자</th>
					<th>과제마감일자</th>
					<th>제출여부</th>
				</tr>
			</thead>
			<tbody id="asgnBody" data-view-url="${cPath}/asgn/asgn.do" data-cpath="${cPath }">
			
			</tbody>
			<tfoot>
			</tfoot>
		</table>
	</form>
</div>
<div class="detailAsgn space m-3 p-5" style="display:none;">
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th colspan="2"><h4 style="font-weight:bold; text-align:left">&nbsp&nbsp과제 상세보기</h4></th>
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

<script src="${cPath }/resources/js/asgn/asgnList.js"></script>

