<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<style>
.marginSpace{
	margin-right: 66px;
</style>
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
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${what}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${what}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${what}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${what}" class="btn btn-info">시험</a>
		        <a id="stulectureData"href="${cPath}/lecture?what=${what}"class="btn btn-info">자료실</a>
		      </div>
		    </div>
	</div>
<div style="display: grid; grid-template-columns: 1fr;">
	<div style="display: grid; grid-template-columns: 1fr;">
		<div class="space m-3 p-5">
			<c:url value="/lecture/lecutreDataUpdate.do" var="updateURL">
				<c:param name="what" value="${lectureData.ldNo}" />
			</c:url>
			<div
				style="display: flex; justify-content: flex-end; align-items: flex-start;">
				<security:authorize access="hasRole('PRO')">
				<form:form modelAttribute="lectureData"	action="${cPath }/lecture/lectureDelete.do" method="post">
					<a class="btn btn-primary" href="${updateURL }">수정</a>
					<form:hidden path="ldNo" />
					<input class="btn btn-danger" type="submit" value="삭제" />
				</form:form>
				</security:authorize>
			</div>
			<table class="table table-bordered">
				<tr>
					<th>자료번호</th>
					<td>${lectureData.ldNo}</td>
				</tr>
				<tr>
					<th>강의번호</th>
					<td>${lectureData.lectNo}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${lectureData.ldTitle}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${lectureData.ldContent}</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>${lectureData.ldWdate}</td>
				</tr>
				<tr>
					<th>강의 파일</th>
					<td><c:if test="${not empty lectureData.atchFileGroup.atchfileList[0].atchSaveName}">
								<a href="${cPath}/upload/${lectureData.atchFileGroup.atchfileList[0].atchSaveName}"
								   download="${lectureData.atchFileGroup.atchfileList[0].atchOrginName}">
									${lectureData.atchFileGroup.atchfileList[0].atchOrginName}
								</a><br>
								<a href="${cPath}/upload/${lectureData.atchFileGroup.atchfileList[1].atchSaveName}"
								   download="${lectureData.atchFileGroup.atchfileList[1].atchOrginName}">
									${lectureData.atchFileGroup.atchfileList[1].atchOrginName}
								</a><br>
								<a href="${cPath}/upload/${lectureData.atchFileGroup.atchfileList[2].atchSaveName}"
								   download="${lectureData.atchFileGroup.atchfileList[2].atchOrginName}">
									${lectureData.atchFileGroup.atchfileList[2].atchOrginName}
								</a>
							</c:if></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right">
						<div
							style="display: flex; justify-content: flex-end; align-items: flex-end;">
							<a class="btn btn-info" href="${cPath }/lecture">목록으로</a> <a
								class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
						</div>
			</table>
		</div>
	</div>
</div>