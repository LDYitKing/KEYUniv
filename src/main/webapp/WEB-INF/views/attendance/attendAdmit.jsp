<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
.attendTable{
	display: table;
   	table-layout: fixed;
}
.blue{
	color: blue;
	font-weight: bold;
}
.marginSpace{
	margin-right: 66px;
}
</style>

<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${attendAdmit.attend.lectNo}">강의관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/attendance/attendanceStu.do?what=${attendAdmit.attend.lectNo}">출석관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">출석인정신청</li>
	</ol>
</nav>

<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">${attendAdmit.lectName}</h1>
	</div>
	  <security:authorize access="hasRole('STU')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${attendAdmit.attend.lectNo}" class="btn btn-info">출석</a>
	        <a href="${cPath}/lecture/lectEval.do?what=${attendAdmit.attend.lectNo}" class="btn btn-info">평가</a>
	        <a href="<c:url value='/asgn/asgn.do?what=${attendAdmit.attend.lectNo}'/>" class="btn btn-info">과제</a>
	        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${attendAdmit.attend.lectNo}" class="btn btn-info">시험</a>
	        <a id="lecutreData" href="${cPath}/lecture?what=${attendAdmit.attend.lectNo}" class="btn btn-info">자료실</a> 
	      </div>
	    </div>
	  </security:authorize>
</div>

<div class="space m-3 p-5">
	<h4>
		<ion-icon name="stop-outline" role="img" class="md hydrated">
			</ion-icon> 출석 인정 신청 안내
	</h4>
	<div class="desc-space p-3 pt-4">
		<p>&emsp; 1. 결석 또는 지각에 대한 출석 인정 신청을 할 수 있습니다.</p>
		<p>&emsp; 2. <span class="blue">['출석 조회 화면']</span>에서 신청양식을 다운로드 받아 신청서를 제출하세요.</p>
		<p>&emsp;&emsp; - 양식에 맞춰 제출해야, 적절한 검토가 이루어질 수 있습니다.</p>
		<p>&emsp; 3. 신청 과정 및 결과는 <span class="blue">['출석 인정 신청 조회']</span>에서 조회 가능합니다.</p>
		<p>&emsp;&emsp; - 제출 후, 승인/반려 결과를 LMS 메세지로 안내드립니다.</p>
	</div>
	<hr>
	<form:form modelAttribute="attendAdmit" id="myForm" method="post" enctype="multipart/form-data">
		<c:set value="${attendAdmit.attend }" var="attend"/>
		<table class="attendTable table table-bordered text-center">
			<thead>
				<th>출석번호</th>
				<th>출석날짜</th>
				<th>출석상태</th>
			</thead>
			<tbody>
				<tr>
					<td>
						<form:input path="attendNo" value="${attend.attendNo }" readonly="true" class="text-center"/>
					</td>
					<td>${attend.attendDate }</td>
					<td>
						<c:choose >
							<c:when test="${attend.attendState eq 'D001' }">
								출석
							</c:when>
							<c:when test="${attend.attendState eq 'D002' }">
								결석
							</c:when>
							<c:when test="${attend.attendState eq 'D003' }">
								지각
							</c:when>
							<c:otherwise>
								대기중
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</tbody>
		</table>
		<hr>
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<td colspan="2">신청서 작성</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>사유 입력</th>
					<td>
						<form:textarea path="aaReason" maxlength="4000" required="true"
							rows="10" cols="90"/>
						<form:errors path="aaReason" element="span" class="text-danger"/>	
					</td>
				</tr>
				<tr>
					<th>파일제출</th>
					<td>
						<input type="file" name="aaFiles" required="required">
						<form:errors path="aaFiles" element="span" class="text-danger"/>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="submit" value="제출하기" class="btn btn-success" />
						<input type="reset" value="취소" class="btn btn-secondary" />
						<a href="javascript:history.back();" class="btn btn-primary">뒤로가기</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</form:form>
</div>
