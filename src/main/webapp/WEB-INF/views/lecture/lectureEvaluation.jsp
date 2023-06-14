<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.marginSpace{
	margin-right: 66px;
}
</style>
<security:authentication property="principal.realUser" var="authMember"/>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${lectEval.lectNo}">수강관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">평가관리</li>
	</ol>
</nav>

<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
	</div>
	  <security:authorize access="hasRole('STU')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${lectEval.lectNo}" class="btn btn-info">출석</a>
	        <a href="${cPath}/lecture/lectEval.do?what=${lectEval.lectNo}" class="btn btn-info">평가</a>
	        <a href="${cPath}/asgn/asgn.do?what=${lectEval.lectNo}" class="btn btn-info">과제</a>
	        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${lectEval.lectNo}" class="btn btn-info">시험</a>
	        <a id="lecutreData" href="${cPath}/lecture?what=${lectEval.lectNo}" class="btn btn-info">자료실</a> 
	      </div>
	    </div>
	  </security:authorize>
</div>
<div class="space m-3 p-5">
	<form:form modelAttribute="lectEval" method="post" >
		<table class="table table-striped ">
			<thead>
				<tr>
					<th>평가번호</th>				
					<th>평가항목</th>
					<th class="text-center">아주조금</th>
					<th class="text-center">조금</th>
					<th class="text-center">보통</th>
					<th class="text-center">많이</th>
					<th class="text-center">아주많이</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${leaList }" var="lea" begin="0" end="5" varStatus="i">
				<tr>
					<td>
						${lea.leaNo }.${lea.leaQue }
						<input type="hidden" name="lectEvalList[${i.index}].leaNo" value="${lea.leaNo }"/>
						<input type="hidden" name="lectEvalList[${i.index}].lectNo" value="${lectEval.lectNo }" >
					</td>
					<td>${lea.leaContent }</td>
					<td class="text-center">
						<input type="radio" name = "lectEvalList[${i.index}].leAnswer" value="1"/>
					</td>
					<td class="text-center">
						<input type="radio" name = "lectEvalList[${i.index}].leAnswer" value="2"/>
					</td>
					<td class="text-center">
						<input type="radio" name = "lectEvalList[${i.index}].leAnswer" value="3"/>
					</td>
					<td class="text-center">
						<input type="radio" name = "lectEvalList[${i.index}].leAnswer" value="4"/>
					</td>
					<td class="text-center">
						<input type="radio" name = "lectEvalList[${i.index}].leAnswer" value="5"/>
					</td>
				</tr>
				</c:forEach>
				<tr>
					<td>
						<input type="hidden" name="lectEvalList[6].lectNo" value="${lectEval.lectNo }" >
						<input type="hidden" name="lectEvalList[6].leaNo" value="7"/>
						7.${leaList.get(6).leaQue }</td>
					<td colspan="6">
					<textarea name="lectEvalList[6].leAnswer" id="thankyou" cols="100" rows="5"></textarea>
					</td>
				</tr>
			</tbody>
			<tfoot>
			<tr class="text-center">
				<td colspan="7">
					<input type="submit" class="btn btn-primary" value="제출"/>
					<input type="button" class="btn btn-outline-primary" id="autoCompBtn" value="자동완성"/>
				</td>
			</tr>
			</tfoot>
		</table>
	</form:form>
</div>
<script>
let textarea = $("#thankyou");
$("#autoCompBtn").on("click",function(){
	textarea.val("수고하셨습니다-!")
})
</script>