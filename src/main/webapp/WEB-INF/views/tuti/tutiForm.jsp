<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<style>
.marginSpace{
	margin-right: 66px;
}
</style>

<script src="${cPath}/resources/js/cheditor/ckeditor.js"></script>

<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;<a href="${cPath}/tuti/tutiList.do">등록금 관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">등록금 안내</li>
	</ol>
</nav>

<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">등록금</h1>
	</div>

	<security:authorize access="hasRole('EMP')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a href="${cPath}/sch/schList.do" class="btn btn-info">장학금 관리</a>
	        <a href="${cPath}/sch/schRecList.do" class="btn btn-info">장학생 관리</a>
	      </div>
	    </div>
	</security:authorize>
</div>

<div class="space m-3 p-5">
<form:form modelAttribute="tuti" method="post" enctype="multipart/form-data">
			<div class="row">
	            <!-- 등록금 학생 정보 입력 -->
	            <div class="col">
	                <label class="form-label">단과대학 :</label>
	                <select class="form-select" name="tuitionCol">
	                    <option value=""></option>
	                    <c:forEach items="${colList}" var="col">
	                        <option value="${col.colNo}">${col.colName}</option>
	                    </c:forEach>
	                </select>
	            </div>
	
	            <!-- 등록금 학생 학과 선택 -->
	            <div class="col">
	                <label class="form-label">학과: </label>
	                <select class="form-select" name="tuitionDept" disabled="disabled">
	                    <option value=""></option>
	                    <c:forEach items="${deptList }" var="dept">
	                        <option class="${dept.colNo }" value="${dept.deptNo }">${dept.deptName }</option>
	                    </c:forEach>
	                </select>
	            </div>
	
	            <!-- 장학생 이름 -->
	           <div class="col">
	    <label class="form-label">이름: </label>
	    <select class="form-select" name="tuitionName" disabled="disabled" required>
	        <option value=""></option>
	        <c:forEach items="${stuList }" var="stu">
	            <option class="${stu.deptNo}" value="${tuti.tuitionName}" data-stuno="${stu.memNo}" data-name="${stu.memName }" data-email="${stu.memEmail}" data-tel="${stu.memTel}">${stu.memName }</option>
	        </c:forEach>
	    </select>
	    <form:errors path="tuitionName" element="span" class="text-control"/>
	</div>
	            
	            <!-- 장학금명 -->
				<div class="col">
					<label class="form-label">장학금명: </label>
			   		<select class="form-select" name="schNo">
			        	<option value=""></option>
			        	<c:forEach items="${schList }" var="sch">
			          		<option class="${sch.schNo}" value="${sch.schNo}" data-amount="${sch.schAmount}" data-cont="${sch.schCont} ">${sch.schName}</option>
			        	</c:forEach>
		      		</select>
				</div>
	        </div>
			<hr>
			<div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 20px;" >
			<div>
			<table class="table table-boardered">
				<!-- 학생 E-mail -->
				<tr>
					<th>E-mail</th>
					<td>
						<input type="text" value="${stu.memEmail}" id="scholarshipEmail" readonly class="form-control">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" value="${stu.memTel}" id="scholarshipPhonecall" readonly class="form-control">
					</td>
				</tr>
				<tr>
					<th>학번</th>
					<td>
						<input type="text" name="tuitionStuNo" value="${stu.memNo}" id="scholarshipStuNo" readonly class="form-control">
					</td>
				</tr>
				<tr>
					<th>장학금 금액</th>
					<td>
						<input type="text" name="tuitionSchRec" value="${sch.schAmount}" id="scholarshipAmountInput" readonly class="form-control">
					</td>
				</tr>
				<tr>
					<th>장학금 내용</th>
					<td>
						<input type="text" name="" value="${sch.schCont}" id="scholarshipContInput" readonly class="form-control">
					</td>
				</tr>
			</table>
			</div>	
			<div>
			<table class="table table-bordered text-center">
			 <tr>
	        	<th>
				 	등록금 해당 학년&nbsp; : &nbsp;&nbsp;
				</th>
	            <td>
	                <form:input path="tuitionGrade" type="number" min="1" max="4" placeholder="${tuti.tuitionGrade}" onblur="checkSemester(this)" class="form-control"/>
	                <form:errors path="tuitionGrade" element="span" class="text-control"/>
	            </td>
	        </tr>

	         <tr>
	        	<th>
				 	등록금 해당 학기&nbsp; : &nbsp;&nbsp;
				</th>
	            <td>
	                <form:input path="tuitionSemester" type="number" min="1" max="8" placeholder="${tuti.tuitionSemester}" onblur="checkSemester(this)" class="form-control"/>
	                <form:errors path="tuitionSemester" element="span" class="text-control"/>
	            </td>
	        </tr>


			<tr>
	        	<th>
				 	등록금액 &nbsp; : &nbsp;&nbsp;
				</th>
	            <td>
	                <form:input path="tuitionAmount" maxLength="200" placeholder="${tuti.tuitionAmount}" id="scholarshipAllAmount" class="form-control"/>
	                <form:errors path="tuitionAmount" element="span" class="text-control"/>
	            </td>
	        </tr>

			<tr>
				<th>
					총 납부 금액 &nbsp; : &nbsp;&nbsp;
				</th>
				<td>
					<form:input path="tuitionPayment" type="text" placeholder="${tuti.tuitionPayment}" id="scholarshipAmount" class="form-control"/>
					<form:errors path="tuitionPayment" element="span" class="text-control"/>
				</td>
			</tr>
			</table>
			</div>
				<br>
				<div style="text-align:right;">
					<input type="submit" class="btn btn-success" value="<spring:message code='save'/>" />
					<input type="reset" class="btn btn-danger" value="<spring:message code='reset'/>" />
					<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
				</div>
			<div class="col-2">
			  	<input type="text" name="tuitionName" value="${stu.memName}" id="scholarshipName" style="display: none;">
			</div>	
			</div>
</form:form>
</div>
<script src="${cPath}/resources/js/tuti/tutiInsert.js"></script>