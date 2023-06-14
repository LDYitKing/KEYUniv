<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
  h1 {
    text-align: center;
  }
</style>
<script>
	var time = 3599;
	var min = "";
	var sec = "";
	
	var x = setInterval(function(){
		min = parseInt(time/60);
		sec = time%60;
		
		document.getElementById("timer").innerHTML = min + ":" + sec;
		if (time <= 300) {
		      document.getElementById("timer").style.color = "red";
		    }
		
		time--;
		
		if(time < 0){
			clearInterval(x);
			document.getElementById("timer").innerHTML = "시험종료";
			location.href="${cPath}/facility/facilityList.do";	
		}
	},1000);
</script>

<security:authentication property="principal.realUser" var="authMember"/>
<div class="space m-3 p-5">
	<h1>2023학년도 제 1학기 [${exam.lectName }] [${exam.examKind }]</h1>
	<h1 style="display: flex; align-items: center; justify-content: flex-end;">
	  <ion-icon name="timer-outline" style="margin-right: 5px;"></ion-icon>
	  <div id="timer"></div>
	</h1>
	<h5 style="color: red;">주의사항 : 모든 정답을 체크해야 시험제출이 가능합니다.</h5>
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
	<form id="examForm" method="post" action="<c:url value='/exam/stuExamPaperForm.do?what=${exam.examNo}'/>" class="row g-2" > 
	  <security:csrfInput/>
	  <input type="hidden" name="stuNo" value="${authMember.memNo}"/>
	  <input type="hidden" name="lectNo" value="${exam.lectNo}"/>
	  <input type="hidden" name="examNo" value="${exam.examNo}"/>
	  <c:forEach var="examQue" items="${examQue}">
	    <hr>
	    <h4>${examQue.eqNumber}. ${examQue.eqQue} <span style="color:blue;">(${examQue.eqScore}점)</span><br></h4>
	    <c:forEach var="examText" items="${examText}">
	      <c:if test="${examText.eqNo eq examQue.eqNo}">
	        <h5>
	          <input type="radio" name="asAnswer_${examQue.eqNo}" value="${examText.etNo}">
	          ${examText.etNo}. ${examText.etQue}
	        </h5>
	      </c:if>
	    </c:forEach>
	  </c:forEach>
	  <hr>
	  <div style="text-align:right;">
	    <input id="submitBtn" type="submit" value="제출" class="btn btn-success btn-lg">
	  </div>
	</form>
</div>