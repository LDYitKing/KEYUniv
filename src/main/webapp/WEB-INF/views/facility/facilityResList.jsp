<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<security:authentication property="principal.realUser" var="authMember"/>
<h1 style="color: white;">[${authMember.memName }]의 예약 현황</h1>
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/facility/facilityList.do">편의시설목록</a></li>
		<li class="breadcrumb-item active" aria-current="page">개인별예약현황</li>
	</ol>
</nav>
<div class="space m-3 p-5">
<div style="text-align: right">
	<a href="${cPath }/facility/facilityList.do" class="btn btn-secondary">편의시설목록보기</a>
</div>
	<form name="listForm">
		<table class="table table-bordered">
			<thead class="table-primary">
				<tr>
					<th>예약번호</th>		
					<th>편의시설명</th>
					<th>예약일자</th>
					<th style="width:100px;">예약상태</th>
					<th style="width:150px;">예약취소</th>
				</tr>
			</thead>
			<tbody id="facilityResBody" data-view-url="${cPath }/facility/facilityResPersonal.do" data-cpath="${cPath }">
			
			</tbody>
			<tfoot>

			</tfoot>
		</table>
	</form>
</div>

<script src="${cPath }/resources/js/facility/facilityResList.js"></script>