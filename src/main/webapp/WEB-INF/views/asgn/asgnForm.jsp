<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<style>
.marginSpace{
	margin-right: 66px;
}
</style>
<security:authentication property="principal.realUser" var="authMember" />

<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${what}">수강관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/asgn/asgn.do?what=${what}">과제관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">과제제출</li>
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
	<form:form modelAttribute="asgnSubmit" id="myForm" method="post" enctype="multipart/form-data">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<td colspan="2">
						<h3>과제 제출하기</h3>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>과제파일</th>
					<td>
						<input type="file" name="asFiles" />
						<input type="file" name="asFiles" />
						<form:errors path="asFile" element="span" class="text-danger"/>
					</td>
				</tr>
				<tr>
					<th>과제내용</th>
					<td>
						<form:textarea path="asContent" maxlength="4000" 
							rows="10" cols="90"/>
						<form:errors path="asContent" element="span" class="text-danger"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="제출하기" class="btn btn-success" />
						<input type="reset" value="취소" class="btn btn-secondary" />
						<a href="javascript:history.back();" class="btn btn-primary">뒤로가기</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</div>
