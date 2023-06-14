<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
 .marginSpace{
	margin-right: 66px;
} 
</style>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/sch/schRecList.do">장학생 관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/sch/schRecView.do?what=${schRec.schRecNo}">장학생 상세보기</a></li>
		<li class="breadcrumb-item active" aria-current="page">장학생 수정</li>
	</ol>
</nav>
<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">장학생</h1>
	</div>
	
	<security:authorize access="hasRole('EMP')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a href="${cPath}/sch/schList.do" class="btn btn-info">장학금 관리</a>
	        <a href="${cPath}/sch/schRecList.do" class="btn btn-info">장학생관리</a>
	      </div>
	    </div>
	</security:authorize>
</div>	
<form:form id="editForm" modelAttribute="schRec" method="post" enctype="multipart/form-data">
    <form:hidden path="schRecNo" />
    <div class ="space m-3 p-5">
    <table class="table table-bordered">
      <!-- 장학생 해당 단과대학 선택 -->
			<div class="col-2">
				<label class="form-label">단과대학: </label>
				<select class="form-select" name="colNo">
					<option value=""></option>
			        <c:forEach items="${colList }" var="col">
			          <option value="${col.colNo }">${col.colName }</option>
			        </c:forEach>
				</select>
			</div>

<!-- 장학생 해당 학과 선택 -->
			<div class="col-2">
				<label class="form-label">학과: </label>
		   		<select class="form-select" name="deptNo" disabled="disabled">
		        	<option value=""></option>
		        	<c:forEach items="${deptList }" var="dept">
		          		<option class="${dept.colNo }" value="${dept.deptNo }">${dept.deptName }</option>
		        	</c:forEach>
	      		</select>
			</div>
 	<tr> 

<!-- 장학생 이름 -->
			<div class="col-2">
				<label class="form-label">이름: </label>
		   		<select class="form-select" name="stuNo" disabled="disabled">
		        	<option value=""></option>
		        	<c:forEach items="${stuList }" var="stu">
		          		<option class="${stu.deptNo}" value="${stu.memNo }">${stu.memName }</option>
		        	</c:forEach>
	      		</select>
			</div>
			
<!-- 장학금명 -->
			<div class="col-2">
				<label class="form-label">장학금명: </label>
		   		<select class="form-select" name="schNo">
		        	<option value=""></option>
		        	<c:forEach items="${schList }" var="sch">
		          		<option class="${sch.schNo}" value="${sch.schNo}" data-amount="${sch.schAmount}" data-cont="${sch.schCont} ">${sch.schName}</option>
		        	</c:forEach>
	      		</select>
			</div>	
					
<!-- 장학금 금액 -->
		<div class="col-2">
		  <label class="form-label">장학금액:</label>
		  <input type="number" value="${sch.schAmount}" id="scholarshipAmountInput" readonly>
		</div>	

<!-- 장학금 내용 -->
		<div class="col-2">
		  <label class="form-label">장학금 내용:</label>
		  <input type="text" value="${sch.schCont}" id="scholarshipContInput" readonly>
		</div>	

        <tr>
        	<th>
			 	장학금 등록 비고 :
			</th>
            <td>
                <form:input path="addsch.schCont" maxLength="200" placeholder="${addsch.schCont}" class="form-control"/>
                <form:errors path="addsch.schCont" element="span" class="text-control"/>
            </td>
        </tr>

        
        <tr>
        	<th>
			 	장학금 수혜 일자 :
			</th>
            <td>
                <form:input path="schRecDate" type="date" />
                <form:errors path="schRecDate" element="span" class="text-control"/>
            </td>
        </tr>
        
        <tr>
        	<th>
			 	장학금 수혜 학기 :
			</th>
            <td>
                <form:input path="schRecSemester" type="number" min="1" max="8" placeholder="${schRecSemester}" onblur="checkSemester(this)" class="form-control"/>
                <form:errors path="schRecSemester" element="span" class="text-control"/>
            </td>
        </tr>
        
        <tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="<spring:message code='save'/>" />
				<input type="reset" class="btn btn-danger" value="<spring:message code='reset'/>" />
				<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
			</td>
		</tr>
       
    </table>    
    </div>
</form:form>

<script src="${cPath}/resources/js/sch/SchRecUpdate.js"></script>

<script>
    function checkSemester(input) {
        var semester = parseInt(input.value);
        if (semester > 8) {
            alert("해당 학기를 잘못 입력했습니다.");
            input.value = 0; // 입력된 값이 8보다 큰 경우에는 입력값을 8로 변경합니다.
        } else if (semester <= 1){
        	alert("해당 학기를 잘못 입력했습니다.");
            input.value = 1; // 입력된 값이 8보다 큰 경우에는 입력값을 8로 변경합니다.
        }
    }
</script>	