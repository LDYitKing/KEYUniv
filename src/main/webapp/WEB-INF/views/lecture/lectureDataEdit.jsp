<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<style>
.marginSpace{
	margin-right: 66px;
</style>
<security:authorize access="hasRole('PRO')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">강의관리</li>
	</ol>
</nav>
</security:authorize>

<security:authorize access="hasRole('STU')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">자료실</li>
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
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${what}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${what}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${what}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${what}" class="btn btn-info">시험</a>
		        <a id="stulectureData"href="${cPath}/lecture?what=${what}"class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
	</div>
<security:authentication property="principal.realUser" var="authMember"/>
<div class="space m-3 p-5">
	<form:form id="editForm" modelAttribute="lecture" method="post"
		enctype="multipart/form-data">
		<table class="table table-boardred">

			<tr>
				<th>자료 제목</th>
				<td><form:input path="ldTitle" maxlength="100"
						class="form-control" /> <form:errors path="ldTitle"
						element="span" class="text-danger" /></td>
			</tr>
			<tr>
				<th>자료내용</th>
				<td><form:textarea path="ldContent" maxlength="100"
						class="form-control" /> <form:errors path="ldContent"
						element="span" class="text-danger" /></td>
			</tr>
			<tr>
				<th>강의 명</th>
				<td>
					<form:input path="lectNo" class="form-control" readonly="true"/>
				</td>
			</tr>
			<tr>
				<th>기존첨부파일</th>
				<td><c:forEach items="${lecture.atchFileGroup.atchfileList }"
						var="attatch" varStatus="vs">
						<span> ${attatch.atchOrginName }<span
							class="btn btn-danger delFileBtn"
							data-atch-seq="${attatch.atchSeq }">삭제</span> <c:if
								test="${not vs.last }">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>
						</span>
					</c:forEach></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="addFiles" /></td>
				<td><input type="file" name="addFiles" /></td>
				<td><input type="file" name="addFiles" /></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: right"><input type="submit"
					class="btn btn-success" value="저장" /> <input type="reset"
					class="btn btn-danger" value="초기화" /></td>
			</tr>
		</table>
	</form:form>
</div>
<script>
	let editForm = $("#editForm");
	$(".delFileBtn").on(
			"click",
			function(event) {
				let atchSeq = $(this).data("atchSeq");
				$(this).parent("span").hide();
				let newInput = $("<input>")
						.attr("name", "delFileGroup.delSeqs").val(atchSeq);
				editForm.append(newInput);
			});
</script>