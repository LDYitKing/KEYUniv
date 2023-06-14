<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>

/* 등록금고지서 모달 */
 	#PaymentModal{ 
  	    position: fixed;   
 	    width: 100%; 
 	    height: 150%; 
 	    left: 0px;  
 	    right: 0px; 
  	    z-index: 9999999999;  
 	    display: none; 
 	    background-color: rgba(128, 128, 128, 0.5); 
 	} 
	#PaymentModalDiv{ 
 	    width: 50%; 
 	    height: 45%; 
 	    margin: 100px auto; 
 	    background-color: white; 
 	}  
  	#overflow{  
 		max-height: 550px;  
  		overflow: auto;  
  	}  
 .marginSpace{
	margin-right: 66px;
} 
</style>
<nav aria-label="breadcrumb"  class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">등록금 관리</li>
		<li class="breadcrumb-item active" aria-current="page">등록금 상세보기</li>
	</ol>
</nav>
<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">등록금 정보</h1>
	</div>
</div>

<div style="display:flex; justify-content:flex-end; align-items:flex-start;">
	<form:form>
		<input class="btn btn-secondary" value="고지서" id="PaymentModal" display="">
	</form:form>
</div>
	
<div class ="space m-3 p-5 bigfont">
<h3 class="fs-2">등록금 상세보기</h3>

<table class ="table table-boardered">
	<div style="display:flex; justify-content:flex-end; align-items:flex-start;">
		<button class="btn btn-warning rounded-pill btn-sm" onclick="modalOpen()">등록금 납부상세</button>
	</div>
	<tr>
		<th>이름 :</th>
		<td>${tuti.tuitionName}</td>
	</tr>
	
	<tr>
		<th>단과대학:</th>
		<td>${tuti.colName}</td>
	</tr>
	
	<tr>
		<th>학과명:</th>
		<td>${tuti.deptName}</td>
	</tr>
	
   	<tr>
		<th>해당 학기:</th>
		<td>${tuti.tuitionSemester} 학기</td>
	</tr>
	
	<tr>
		<th>납부일</th>
		<td>${tuti.tpDate}</td>
	</tr>
	
	<tr>
		<th>장학 수혜 금액</th>
		<td>${tuti.tuitionSchRec}만원</td>
	</tr>
	
	<tr>
		<th>납부 금액</th>
		<td>${tuti.tuitionAmount}만원</td>
	</tr>
	
	
	<tr>
		<th>총 납입액</th>
		<td>${tuti.tuitionPayment}만원</td>
	</tr>
	
	<tr>
		<td colspan="2">
			<c:url value="/tuti/tutiUpdate.do" var="updateURL">
				<c:param name="what" value="${tuti.tuitionNo }"/>
			</c:url>
		</td>
	</tr>
	

</table>
	<form:form modelAttribute="tuti" action="${cPath}/tuti/tutiDelete.do" method="post">
	<form:hidden path="tuitionNo"/>
		<security:authorize access="hasRole('EMP')">
			<input class="btn btn-danger" type="submit" value="삭제"/>
		</security:authorize>
		<a class="btn btn-info" href="${cPath }/tuti/tutiList.do" >목록으로</a>
		<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
	</form:form>
</div>

<script src="${cPath}/resources/js/tuti/tutiView.js"></script>