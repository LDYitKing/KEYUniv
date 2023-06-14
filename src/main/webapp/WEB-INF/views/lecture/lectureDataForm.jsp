<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.marginSpace{
	margin-right: 66px;
</style>
<script src="${cPath }/resources/js/ckeditor/ckeditor.js"></script>
<security:authorize access="hasRole('PRO')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture?what=${what}">자료실</a></li>
		<li class="breadcrumb-item active" aria-current="page">신규등록</li>

	</ol>
</nav>
</security:authorize>
	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${what}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${what}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${what}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${what}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${what}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${what}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
	</div>
<security:authentication property="principal.realUser" var="authMember"/>
<div style="display: grid; grid-template-columns: 1fr;">
	<div style="display: grid; grid-template-columns: 1fr;">
		<div class="space m-3 p-5">
			<form:form modelAttribute="lecture" method="post" enctype="multipart/form-data">
				<table class="table table-bordered">
					<tr>
						<th>자료 제목</th>
						<td><form:input path="ldTitle" maxlength="100" class="form-control" />
						<form:errors path="ldTitle" element="span" class="text-danger" /></td>
					</tr>
					<tr>
						<th>강의명</th>
						<td><form:select path="lectNo" class="form-select">
							<c:forEach items="${lectures}" var="lectures">
								<form:option value="${lectures.lectNo}">${lectures.lectName}</form:option>
								</c:forEach>
						</form:select></td>
						<form:errors path="lectNo" element="span" class="text-danger" />
					</tr>
					<tr>
						<th>자료내용</th>
						<td><form:textarea path="ldContent" maxlength="100"
								class="form-control" /> <form:errors path="ldContent"
								element="span" class="text-danger" /></td>
					</tr>
					<tr>
						<th>첨부 파일</th>
						<td><input type="file" name="lectFiles" />
							<input type="file" name="lectFiles" />
							<input type="file" name="lectFiles" />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right"><input
							type="submit" class="btn btn-success" value="등록" /> <input
							type="reset" class="btn btn-danger" value="초기화" /></td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</div>
