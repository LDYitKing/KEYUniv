<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
 .marginSpace{
	margin-right: 66px;
} 
</style>
<script src="${cPath}/resources/js/cheditor/ckeditor.js"></script>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/sch/schList.do">장학금 관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">장학금 등록</li>
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
<form:form modelAttribute="sch" method="post" enctype="multipart/form-data">
        <div class="space m-3 p-5">
        <table class="table-boardered">
        <tr>  
			<th>
				<spring:message code="schName"/>
			</th>
            <td>
                <form:input path="schName" maxLength="200" class="form-control"/>
                <form:errors path="schAmount" element="span" class="text-control"/>
            </td>
        </tr>
        
        <tr>  
            <th>
            	<spring:message code="schAmount"/>
            </th>
            <td>
                <form:input path="schAmount" maxLength="200" class="form-control"/>
                <form:errors path="schAmount" element="span" class="text-control"/>
            </td>
        </tr>
        
        <tr>
			<th><spring:message code="schCont" /></th>
			<td>
				<form:textarea path="schCont" class="form-control"/>
				<form:errors path="schCont" element="span" class="text-danger"/>
			</td>
		</tr>

        <tr>
			<th><spring:message code="schReq" /></th>
			<td>
				<form:textarea path="schReq" class="form-control"/>
				<form:errors path="schReq" element="span" class="text-danger"/>
			</td>
		</tr>

        <tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="<spring:message code='save'/>" />
				<input type="reset" class="btn btn-danger" value="<spring:message code='reset'/>" />
			</td>
		</tr>

    </table>
    </div>

</form:form>
<script>
	let schName("#schName");
	console.log(schName);
</script>