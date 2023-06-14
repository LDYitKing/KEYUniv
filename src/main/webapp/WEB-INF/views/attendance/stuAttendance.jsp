<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.attendListTable{
	height:500px;
	overflow:auto;
}
.attendListThead{
   margin-bottom: 0;
   border-bottom: 2px solid darkgrey;
   border-radius: 5px 5px 0px 0px;
}
.textRight{
	text-align: right;
}
.marginSpace{
	margin-right: 66px;
}
</style>

<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${what}">강의관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">출석관리</li>
	</ol>
</nav>

<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
	</div>
	  <security:authorize access="hasRole('STU')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a id="attend" href="${cPath}/attendance/attendanceStu.do?what=${what}" class="btn btn-info">출석</a>
	        <a href="${cPath}/lecture/lectEval.do?what=${what}" class="btn btn-info">평가</a>
	        <a href="<c:url value='/asgn/asgn.do?what=${what}'/>" class="btn btn-info">과제</a>
	        <a id="stuExam" href="${cPath}/exam/stuExam.do?what=${what}" class="btn btn-info">시험</a>
	        <a id="lecutreData" href="${cPath}/lecture?what=${what}" class="btn btn-info">자료실</a> 
	      </div>
	    </div>
	  </security:authorize>
</div>

<div class="space m-3 p-5">
	<h4 class="mb-4">
		<ion-icon name="stop-outline" role="img" class="md hydrated">
		</ion-icon> 출석 안내
	</h4>
	<div class="desc-space p-3 pt-4">
		<p>&emsp;  1. 수강하는 강의의 출석정보를 조회할 수 있는 '온라인 출석부'입니다.</p>
		<p>&emsp;  2. 해당 강의의 출석인정 요구시간을 충족해야 출석이 인정됩니다.</p>
		<p>&emsp;&emsp; - 성적 마감 기간 전 출석 내역을 확인하시어 불이익이 발생하지 않도록 주의하시기 바랍니다.</p>
		<p>&emsp;  3. 결석 및 지각 시, 출석인정 신청을 할 수 있습니다.</p>
		<p>&emsp;&emsp;    - 출석인정 신청시, 적절한 증거자료를 제출해야 합니다.</p>
		<p>&emsp;&emsp;    - '<a href="${cPath}/univboard/attatch/download.do?atchId=47&atchSeq=1 ">신청양식 다운로드</a>'버튼을 눌러 양식을 다운받아 사용하시기 바랍니다.</p>
	</div>
	<hr>
	<div>
		<div class="textRight mb-2">
			<a href="${cPath}/attendance/attendAdmitList.do?what=${what}" class="btn btn-warning btn-sm">
			<ion-icon name="file-tray-stacked-sharp"></ion-icon>
			&nbsp;출석인정신청조회</a>
		</div>
		<table class="table table-hover text-center attendListThead ">
		 <colgroup>
             <col width="25%"/>
             <col width="25%"/>
             <col width="25%"/>
             <col width="25%"/>
          </colgroup>
		
			<thead>
				<tr>  
					<th>강의명</th>
					<th>출석날짜</th>
					<th>출석상태</th>
					<th>출석인정</th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="attendListTable overflow-scroll scrollable-content">
		<table class="table table-hover text-center ">
		<colgroup>
             <col width="25%"/>
             <col width="25%"/>
             <col width="25%"/>
             <col width="25%"/>
          </colgroup>
			<tbody class="attendListTbody">
				<c:forEach items="${attendList }" var="attend">
					<tr>
						<td>${attend.lectName }</td>
						<td>${attend.attendDate }</td>
						<c:choose>
							<c:when test="${attend.attendState eq 'D001' }" >
								<td>출석</td>
								<td>
									<button class="btn btn-primary btn-sm" disabled>
									<ion-icon name="duplicate-sharp"></ion-icon>
									&nbsp; 신청</button>
								</td>
							</c:when>
							<c:when test="${attend.attendState eq 'D002' }" >
								<td>결석</td>
								<td>
									<a href="${cPath}/attendance/attendAdmit.do?what=${attend.attendNo}&lectNo=${what}" class="btn btn-primary btn-sm" >
									<ion-icon name="duplicate-sharp"></ion-icon>
									&nbsp; 신청</a>
								</td>
							</c:when>
							<c:when test="${attend.attendState eq 'D003' }" >
								<td>지각</td>
								<td>
									<a href="${cPath}/attendance/attendAdmit.do?what=${attend.attendNo}" class="btn btn-primary btn-sm">
									<ion-icon name="duplicate-sharp"></ion-icon>
									&nbsp; 신청</a>
								</td>
							</c:when>
							<c:otherwise>
								<td>대기중</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>