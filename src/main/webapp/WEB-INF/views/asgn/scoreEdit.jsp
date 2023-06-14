<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.marginSpace{
	margin-right: 66px;
}

</style>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${as.lectNo}">강의관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/asgn/proAsgn.do?what=${as.lectNo}">과제조회</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/asgn/proStuAsgnView.do?what=${as.asgnNo}&&lect=${as.lectNo}">과제 제출 현황</a></li>
		<li class="breadcrumb-item active" aria-current="page">제출 과제 상세보기</li>
	</ol>
</nav>
	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${as.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${as.lectNo}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${as.lectNo}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${as.lectNo}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${as.lectNo}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${as.lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${as.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${as.lectNo}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${as.lectNo}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${as.lectNo}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${as.lectNo}" class="btn btn-info">자료실</a> 
		      </div>
		    </div>
		  </security:authorize>
	</div>
<div class="space m-3 p-5 bigfont">
<form:form id="editForm" modelAttribute="as" method="post" enctype="multipart/form-data">
	<form:hidden path="asNo"/>
	<table class="table table-boardered">
		<tr>
			<th>학생명</th>
			<td>
				<form:input path="memName" class="form-control" readonly="true" />
				<form:errors path="memName" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>과제명</th>
			<td>
				<form:input path="asgnName" class="form-control" readonly="true" />
				<form:errors path="asgnName" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>과제내용</th>
			<td>
				<form:textarea path="asContent" class="form-control" readonly="true" />
				<form:errors path="asContent" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>제출일자</th>
			<td>
				<form:input path="asSdate" class="form-control" readonly="true"/>
				<form:errors path="asSdate" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>점수</th>
			<td>
				<form:input path="asScore" class="form-control" maxlength="3"/>
				<form:errors path="asScore" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<c:choose>
					<c:when test="${not empty as.atchFileGroup.atchfileList}">
						<c:forEach items="${as.atchFileGroup.atchfileList}" var="attach" varStatus="vs">
							<span>
								<a href="${cPath }/as/attatch/download.do?atchId=${attach.atchId}&atchSeq=${attach.atchSeq}">
						            ${attach.atchOrginName}
						        </a>
							</span>
							<c:if test="${not vs.last}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						파일 없음
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: right">
				<input type="submit" class="btn btn-success" value="저장" onclick="updateScore(event)"/>
				<input type="reset" class="btn btn-danger" value="초기화" />
			</td>
		</tr>
	</table>
</form:form>
</div>
<script>
function updateScore(event) {
    event.preventDefault(); // 폼 제출 방지
    
    Swal.fire({
        title: "점수 수정이 완료되었습니다.",
        icon: "success",
        confirmButtonText: "확인"
    }).then((result) => {
        // 확인 버튼을 눌렀을 때만 폼 submit
        if (result.isConfirmed) {
            document.getElementById("editForm").submit();
        }
    });
}
</script>