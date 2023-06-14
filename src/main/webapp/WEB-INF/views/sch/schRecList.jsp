<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>
<style>
 .marginSpace{
	margin-right: 66px;
} 
</style>
<nav aria-label="breadcrumb"  class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">장학생 관리</li>
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
<div class="space m-3 p-5">
<h3>장학생 LIST</h3>
<table class ="table table-bordered">
<div class="row m-2">
			
<div class="row m-2">
			<div class="col-2">
				<select class="form-select" name="colNo">
					<option value="">단과대학</option>
			        <c:forEach items="${colList }" var="col">
			          <option value="${col.colNo }">${col.colName }</option>
			        </c:forEach>
				</select>
			</div>
			

			<div class="col-3">
		   		<select class="form-select" name="deptNo" disabled="disabled">
		        	<option value="">학과</option>
		        	<c:forEach items="${deptList }" var="dept">
		          		<option class="${dept.colNo }" value="${dept.deptNo }">${dept.deptName }</option>
		        	</c:forEach>
	      		</select>
			</div>
</div>
	<thead class ="table-primary">
		<tr>
			<td>일련번호</td>
			<td>수혜번호</td>
			<td>장학금명</td>
			<td>장학생명</td>
			<td>지급상태</td>
		</tr>
	</thead>
	<tbody id="listBody" data-view-url="${cPath}/sch/schRecView.do">
	</tbody>
	<tfoot>
		<tr>
			<td colspan="8">
			<div class ="pagingArea d-flex justify-content-center" >
			</div>

				<div class="col-auto">
					<input type="button" value="검색" id="searchBtn" class="btn btn-primary" /> 
					<security:authorize access="hasRole('EMP')">
					<a href="${cPath}/sch/schRecInsert.do" class="btn btn-secondary"><spring:message code="regist" /></a> 
					</security:authorize>
				</div>
			</div>
	</tfoot>
</table>
</div>
<div style="border: 1px solid green;">
	<form name ="searchForm" method="post">
	<security:csrfInput/>
	<input type="hidden" name="colNo" placeholder="searchWord" />
	<input type="hidden" name="deptNo" placeholder="searchWord" />
	</form>
</div>

<script src="${cPath}/resources/js/sch/SchRecList.js"></script>