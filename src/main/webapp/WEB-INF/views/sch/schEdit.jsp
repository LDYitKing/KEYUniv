<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
 .marginSpace{
	margin-right: 66px;
} 
</style>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/sch/schList.do">장학금 관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/sch/schView.do?what=${sch.schNo}">장학금 상세보기</a></li>
		<li class="breadcrumb-item active" aria-current="page">장학금 수정</li>
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
<form:form id="editForm" modelAttribute="sch" method="post" enctype="multipart/form-data">
    <form:hidden path="schNo" />
    <div class ="space m-3 p-5">
    <table class="table table-bordered">
        <tr>
            <th><spring:message code="schName" /></th>
            <td>
                <form:input path="schName" maxlength="200" class="form-control"/>
                <form:errors path="schName" element="span" class="text-danger"/>
            </td>
        </tr>

        <tr>
            <th><spring:message code="schAmount" /></th>
            <td>
                <form:input path="schAmount" type="number" class="form-control"/>
                <form:errors path="schAmount" element="span" class="text-danger"/>
            </td>
        </tr>

        <tr>
            <th><spring:message code="schCont" /></th>            
            <td>
                <form:input path="schCont" maxlength="1000" class="form-control" />
                <form:errors path="schCont" element="span" class="text-danger" />
            </td>
        </tr>
		
		<tr>
            <th><spring:message code="schReq" /></th>            
            <td>
                <form:input path="schReq" maxlength="1000" class="form-control" />
                <form:errors path="schReq" element="span" class="text-danger" />
            </td>
        </tr>
        
        <tr>
			<td colspan="3">
				<input type="submit" class="btn btn-success" value="<spring:message code='save'/>" />
				<input type="reset" class="btn btn-danger" value="<spring:message code='reset'/>" />
                <a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
			</td>
		</tr>

    </table>    
    </div>


</form:form>