<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.marginSpace{
	margin-right: 66px;
}
</style>
 <security:authorize access="hasRole('PRO')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">자료실</li>
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
<div style="display: grid; grid-template-columns: 1fr;">
	<div style="display: grid; grid-template-columns: 1fr;">
		<div class="space m-3 p-5">
			<table class="table table-hover text-center">
				<thead>

					<tr>
						<th>자료번호</th>
						<th>강의명</th>
						<th>자료제목</th>
						<th>자료내용</th>
						<th>업로드 날짜</th>
					</tr>
				</thead>

				<tbody id="listBody" data-view-url="${cPath}/lecture/lectureView.do">

				</tbody>

				<tfoot>
					<tr>
						<td colspan="5">
							<div class="pagingArea d-flex justify-content-center"></div>

							<div id="searchUI" class="row d-flex justify-content-center">
								<div class="col-auto">
									<select name="searchType" class="form-control">
										<option value>전체</option>
										<option value="name">과제명</option>
									</select>
								</div>
								<div class="col-auto">
									<input type="text" name="searchWord" class="form-control col-auto" />
								</div>
								<div class="col-auto">
									<input type="button" value="검색" id="searchBtn" class="btn btn-primary" />
									<security:authorize access="hasRole('PRO')">
										<a href="${cPath }/lecture/lectureInsert.do" class="btn btn-secondary">신규등록</a>
									</security:authorize>
								</div>
							</div>
						</td>
					</tr>
				</tfoot>
			</table>

		</div>
		<form name="searchForm">
			<input type="hidden" name="page" placeholder="page" /> <input type="hidden" name="searchType" placeholder="searchType" /> <input type="hidden" name="searchWord" placeholder="searchWord" />
		</form>

		<script src="${cPath}/resources/js/lecture/lectureDataList.js"></script>