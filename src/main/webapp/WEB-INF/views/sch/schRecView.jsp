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
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/sch/schRecList.do">장학생 관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">장학생 상세보기</li>
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
<table class="table table-boardered">  

	<tr>
		<th>단과대학:</th>
		<td>${schrec.colName}</td>
	</tr>
	
	<tr>
		<th>학과명:</th>
		<td>${schrec.deptName}</td>
	</tr>
	
	<tr>
		<th>장학생학번 :</th>
		<td>${schrec.addstu.memNo}</td>
	</tr>
	
	<tr>
		<th>장학생명 :</th>
		<td>${schrec.memName}</td>
	</tr>
	
	<tr>
		<th>장학금액 :</th>
		<td>${schrec.addsch.schAmount} 만원</td>
	</tr>
	
	<tr>
		<th>장학금 수혜일자 :</th>
		<td>${schrec.schRecDate}</td>
	</tr>	
	
	<tr>
		<th>장학금 수혜학기 :</th>
		<td>${schrec.schRecSemester} 학기</td>
	</tr>
	
	<tr>
		<th>장학금 내용 :</th>
		<td>${schrec.addsch.schCont}</td>
	</tr>
	
	<tr>
		<th>장학금 지급상태:</th>
		 <td colspan="2">${schrec.commName}&nbsp&nbsp 
		 <a class="btn btn-primary" id="changeState" data-urlsch="${cPath}/sch/schRecView.do"  data-sch-rec-no="${schrec.schRecNo }" >진행상황</a>
		</td>
	</tr>
	 

	<tr>
		<td colspan="2">
			<c:url value="/sch/schRecUpdate.do" var="updateURL">
				<c:param name="what" value="${schrec.schRecNo}"/>
			</c:url>
		</td>
	</tr>
</table>
		<form:form modelAttribute="schrec" action="${cPath}/sch/schRecDelete.do" method="post">
			<security:authorize access="hasRole('EMP')">
				<a class="btn btn-primary" href="${updateURL}">수정</a>
			</security:authorize>
				<form:hidden path="schRecNo"/>
			<security:authorize access="hasRole('EMP')">
				<input class="btn btn-danger" type="submit" value="삭제"/>
			</security:authorize>
			
			<a class="btn btn-info" href="${cPath}/sch/schRecList.do" >목록으로</a>
			<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
		</form:form>
</div>

<div id="detailViewDiv" class="space m-3 p-5" style="display:none;">
	<table class="table table-hover text-center">

		<thead>
			<tr>
				<th colspan="2"><h4 style="font-weight:bold; text-align:left">&nbsp&nbsp장학금 상세보기</h4></th>
			</tr>
		</thead>
		<tbody class="detailView" >
		
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

<script>
  var commName = "${schrec.commName}";
</script>
<script src="${cPath}/resources/js/sch/SchRecView.js"></script>