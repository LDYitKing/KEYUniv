<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
  h1 {
    text-align: center;
  }
.marginSpace{
	margin-right: 66px;
}  
</style>

<security:authorize access="hasRole('STU')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${exam.lectNo}">수강관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/exam/stuExam.do?what=${exam.lectNo}">수강관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">시험 성적 확인</li>
	</ol>
</nav>
</security:authorize>
	<div class="d-flex justify-content-between" style="align-items: center;">
		<div class="px-2">
		  <h1 class="m-2 text-light" style="margin-right: 20px;">${exam.lectName }</h1>
		</div>
		  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${exam.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${exam.lectNo}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${exam.lectNo}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${exam.lectNo}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${exam.lectNo}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${exam.lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${exam.lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${exam.lectNo}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${exam.lectNo}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${exam.lectNo}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${exam.lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
	</div>
<security:authentication property="principal.realUser" var="authMember"/>
<div class="space m-3 p-5">
	<h1>2023학년도 제 1학기 [${exam.lectName }] [${exam.examKind }]</h1>
	<h5 style="color: red;">- 정답지문은 빨간색으로 표시됩니다.</h5>
	<h5 style="color: black;">- 학생이 제출한 답은 radio check로 표시됩니다.</h5>
	<br>
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th>시험명</th>
				<th>시험일</th>
				<th>학과</th>
				<th>이름</th>
				<th>학번</th>					
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${exam.examName }</td>
				<td>${exam.examDate }</td>
				<td>${authMember.deptName }</td>
				<td>${authMember.memName }</td>
				<td>${authMember.memNo }</td>
			</tr>
		</tbody>
		<tfoot>
		</tfoot>
	</table>
	<hr>
	<form> 
    <security:csrfInput/>
    <input type="hidden" name="stuNo" value="${authMember.memNo}" id="stuNo"/>
    <input type="hidden" name="lectNo" value="${exam.lectNo}"/>
    <input type="hidden" name="examNo" value="${exam.examNo}" id="examNo"/>
    <c:set var="esFscore" value="0"/>
    
    <c:forEach var="examQue" items="${examQue}" varStatus="status">
        <hr>
        <h4>${examQue.eqNumber}. ${examQue.eqQue}<span style="color:blue;">(${examQue.eqScore}점)</span><br></h4>
        
        <c:forEach var="examText" items="${examText}">
            <c:if test="${examText.eqNo eq examQue.eqNo}">
                <h5>
                    <c:choose>
                        <c:when test="${examText.etNo eq answerSubmit[status.index].etNo && examText.etNo eq examText.etRightAnswer}">
                            <!-- 맞은문제 -->
                            <c:set var="esFscore" value="${esFscore + examQue.eqScore}"/>
                        </c:when>
                        <c:otherwise>
							<!-- 틀린문제 -->
                        </c:otherwise>
                    </c:choose>
                    
                    <input type="radio" name="asAnswer_${examQue.eqNo}" value="${examText.etNo}" 
                           <c:if test="${examText.etNo eq answerSubmit[status.index].etNo}">checked</c:if>>
                    <c:choose>
                        <c:when test="${examText.etNo eq examText.etRightAnswer}">
                            <span style="color: red;">
                                ${examText.etNo}. ${examText.etQue}
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: black;">
                                ${examText.etNo}. ${examText.etQue}
                            </span>
                        </c:otherwise>
                    </c:choose>
                </h5>           
            </c:if>
        </c:forEach>
    </c:forEach>
    <input type="hidden" name="esFscore" value="${esFscore}" id="esFscore"/>
    <h2 style="text-align:right;"> 점수: <sapn style="color:red;">${esFscore}</sapn>/100</h2>
</form>
</div>

<script src="${cPath }/resources/js/exam/stuExamPaperSubmitForm.js"></script>
