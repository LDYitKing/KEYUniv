<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>
<style>
.table th {
    width: 200px;
}
#faciImg{
	width : 300px;
	height : 300px;
}
</style>
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/facility/facilityList.do">편의시설목록</a></li>
		<li class="breadcrumb-item active" aria-current="page">편의시설 상세보기</li>
	</ol>
</nav>
<div class="space m-3 p-5">
<table class="table table-bordered">
	<tr>
		<th>편의시설명</th>
		<td>${facility.faciName}</td>
	</tr>
	<tr>
		<th>주의사항</th>
		<td>${facility.faciCaution}</td>
	</tr>
	<tr>
		<th>시설이미지</th >
		<td>
			<c:if test="${not empty facility.atchFileGroup.atchfileList[0].atchSaveName}">
				<img id="faciImg" src="${cPath }/upload/${facility.atchFileGroup.atchfileList[0].atchSaveName}" alt="${facility.atchFileGroup.atchfileList[0].atchOrginName }" />
			</c:if>
		</td>
	</tr>

	<tr>
		<td colspan="2" style="text-align: right">
			<c:url value="/facility/facilityUpdate.do" var="updateURL">
				<c:param name="what" value="${facility.faciNo }"/>
			</c:url>
			<c:url value="/facility/facilityReserve.do" var="reserveURL">
				<c:param name="what" value="${facility.faciNo }"/>
			</c:url>
			<form:form modelAttribute="facility" action="${cPath }/facility/facilityDelete.do" method="post">
				<a class="btn btn-danger" href="${reserveURL }">예약하기</a>
				
				<security:authorize access="hasRole('EMP')">
					<a class="btn btn-primary" href="${updateURL }">수정</a>
				</security:authorize>
				
			    <form:hidden path="faciNo"/>
			    <security:authorize access="hasRole('EMP')">
			    	<input class="btn btn-success" type="submit" value="삭제" />
			    </security:authorize>
			    
			    <a class="btn btn-info" href="${cPath }/facility/facilityList.do" >목록으로</a>
				<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
			</form:form>
		</td>
	</tr>
</table>
</div>