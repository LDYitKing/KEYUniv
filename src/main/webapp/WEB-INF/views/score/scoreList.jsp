<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<style>
th tr td{
	text-align:"center";
}
.marginSpace{
	margin-right: 66px;
}
</style>
<security:authentication property="principal.realUser" var="authMember" />
<security:authorize access="hasRole('PRO')">
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${lectNo}">강의관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">성적</li>
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
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${lectNo}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${lectNo}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${lectNo}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${lectNo}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
		  <security:authorize access="hasRole('STU')">
		    <div class="marginSpace">
		      <div class="btn-group">
		        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectEval.do?what=${lectNo}" class="btn btn-info">평가</a>
		        <a href="<c:url value='/asgn/asgn.do?what=${lectNo}'/>" class="btn btn-info">과제</a>
		        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${lectNo}" class="btn btn-info">시험</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
	</div>

<div class="space m-3 p-5" style="font-size: 120%">
	<h4 class="mb-4 fs-2">
		<ion-icon name="stop-outline"></ion-icon>
		성적처리 기준
	</h4>
	<div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 20px;" >
	<div>
	<table class="table table-borered text-center">
		<thead>
			<tr>
				<th>등급</th>
				<th>점수</th>
				<th>학점</th>
			</tr>
		</thead>
		<tbody>
			<tr>
			    <td>A+</td>
			    <td>100-95</td>
			    <td>4.5</td>
			</tr>
			<tr>
			    <td>A</td>
			    <td>94-90</td>
			    <td>4.0</td>
			</tr>
			<tr>
			    <td>B+</td>
			    <td>89-85</td>
			    <td>3.5</td>
			</tr>
			<tr>
			    <td>B</td>
			    <td>84-80</td>
			    <td>3.0</td>
			 </tr>
			<tr>
			    <td>C+</td>
			    <td>79-75</td>
			    <td>2.5</td>
			</tr>
			<tr>
			    <td>C</td>
			    <td>74-70</td>
			    <td>2.0</td>
			</tr>
			<tr>
			    <td>D+</td>
			    <td>69-65</td>
			    <td>1.5</td>
			</tr>
			<tr>
			    <td>D</td>
			    <td>64-60</td>
			    <td>1.0</td>
			</tr>
			<tr>
			    <td>F</td>
			    <td>59~</td>
			    <td>0.0</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<!-- 강의별 학생리스트 -->
	<div style="height: 450px; overflow-y: scroll;">
		<form name="listForm">
			<table class="table table-hover text-center">
				<thead>
					<tr>
						<th>학과</th>
						<th>학번</th>
						<th>이름</th>
					</tr>
				</thead>
				<tbody id="listBody" data-view-url="${cPath }/score/proScore.do" data-cpath="${cPath }">
					<c:forEach items="${studentList}" var="student" varStatus="status">
						<c:if test="${status.index < 5}">
							<tr>
								<td>${student.department}</td>
								<td>${student.studentNo}</td>
								<td style="cursor:pointer;">${student.name}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
	</div>
	<hr>
	<div>	
	<h4 class="mb-4 fs-2">
		<ion-icon name="stop-outline"></ion-icon>
			성적 입력
	</h4>
	<form id="scoreInsertForm" method="post" action="<c:url value='/score/stuScoreInsert.do?what=${lectNo}'/>">
	<security:csrfInput/>
		<input type="hidden" name="lectNo" value="${lectNo }">
		<input type="hidden" name="courseNo">
		<input type="hidden" name="stuNo">
		<table class="table table-boardered">
			<tr>
				<th>학생명:</th>
				<td>
					<input type="text" name="stuName" id="stuName">
				</td>
				<td>점수:</td>
				<td>
					<input type="text" name="stuScore" id="stuScore">
				</td>
				<td>학점:</td>
				<td>
					<input type="text" name="csScore" id="csScore">
				</td>
				<td>
					<input type="submit" class="btn btn-success" value="등록" />
				</td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
	</div>
	<div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 20px;" >
	<div>
		<h4 class="mb-4 fs-2">
			<ion-icon name="stop-outline"></ion-icon>
			강의별 성적처리기준
		</h4>
		<table class="table table-borered text-center">
			<thead>
				<tr>
					<c:forEach var="crtr" items="${crtrList}">
						<td>${crtr.commName}</td>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<tr>
					<c:forEach var="crtr" items="${crtrList}">
						<td>${crtr.scRatio}%</td>
					</c:forEach>
				</tr>
			</tbody>
		</table>
	</div>
	<div style="height: 300px; overflow-y: scroll;">
		<form name="stuScoreForm">
			<h4 class="mb-4 fs-2">
				<ion-icon name="stop-outline"></ion-icon>
				개인 세부 성적 조회
			</h4>
			<table class="table table-borered text-center">
				<thead>
					<tr>
						<td>이름</td>
						<td>중간고사</td>
						<td>기말고사</td>
						<td>출석</td>
						<td>과제</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="courseStu" items="${courseStuList}" varStatus="status">
						<tr>
							<td>${courseStu.memName}</td>
							<c:forEach var="stu" items="${stuList}">
								<c:if test="${stu.memName eq courseStu.memName}">
									<td>${stu.csdScore}점</td>
								</c:if>
							</c:forEach>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
	</div>
	
</div>
<script>
  // JSP에서 생성된 학생별 점수 데이터
  var scores = [];
  <c:forEach var="courseStu" items="${courseStuList}" varStatus="loop">
    var studentScores = {
      memName: '${courseStu.memName}',
      courseNo: '${courseStu.courseNo}',
      stuNo: '${courseStu.stuNo}',
      scores: [
        <c:forEach var="stu" items="${stuList}" varStatus="innerLoop">
          <c:if test="${stu.memName eq courseStu.memName}">
            ${stu.csdScore}<c:if test="${not innerLoop.last}">,</c:if>
          </c:if>
        </c:forEach>
      ]
    };
    scores.push(studentScores);
  </c:forEach>

  // 학생별 점수를 console.log에 출력
  for (var i = 0; i < scores.length; i++) {
    console.log("이름:", scores[i].memName, "코스 번호:", scores[i].courseNo, "학생 번호:", scores[i].stuNo, "점수:", scores[i].scores);
  }
</script>
<script>
function getStudentScore(studentName) {
	console.log(studentName);
	var crtrList = [
		  <c:forEach var="crtr" items="${crtrList}" varStatus="loop">
		    {
		      commName: '${crtr.commName}',
		      scRatio: '${crtr.scRatio}'
		    }<c:if test="${not loop.last}">,</c:if>
		  </c:forEach>
		];

	var ratioArr = crtrList.map(function(crtr) {
	  return crtr.scRatio;
	});

	console.log(ratioArr);
  
	var studentScores = null;

	for (var i = 0; i < scores.length; i++) {
	    if (scores[i].memName === studentName) {
	        studentScores = scores[i].scores;
	        break;
	    }
	}

	console.log("studentScores:", studentScores);

	var totalScore = 0;
	for (var i = 0; i < studentScores.length; i++) {
	    totalScore += parseInt(studentScores[i]) * parseInt(ratioArr[i]);
	}

	document.getElementById("stuScore").value = totalScore;

	return totalScore*0.01;
}
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 폼 요소 선택
        var form = document.getElementById("scoreInsertForm");
        var submitButton = form.querySelector("input[type='submit']");

        // 폼 제출 시 이벤트 처리
        form.addEventListener("submit", function(event) {
            event.preventDefault(); // 폼의 기본 동작 중단

            // 등록 버튼 비활성화
            submitButton.disabled = true;

            // 폼 제출
            form.submit();
            
//             Swal.fire({
//                 icon : 'success',
//                 title : '성적등록에 성공했습니다',
//                 text : '성공',
//                 timer: 2500
//             });

        });
    });
</script>
<script src="${cPath }/resources/js/score/scoreList.js"></script>