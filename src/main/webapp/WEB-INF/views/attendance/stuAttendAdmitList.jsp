<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.boldUnderbar{
	border-bottom: thick solid darkgrey;
}
.scrolDiv{
	height:500px;
	overflow:auto;
}
.redfont{
	color: red;
}
.marginSpace{
	margin-right: 66px;
}
</style>

<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${what}">강의관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/attendance/attendanceStu.do?what=${what}">출석관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">출석인정신청</li>
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
		</ion-icon> 출석인정신청 안내
	</h4>
	<div class="desc-space p-3 pt-4">
		<p>&emsp;  1. 출석인정신청 내역입니다.</p>
		<p>&emsp;&emsp; - 근거자료가 타당하지 않으면 반려될 수 있음을 알려드립니다.</p>
		<p>&emsp;  2. 출석이 인정되면 자동으로 '온라인 출석부'에 반영됩니다.</p>
		<p>&emsp;  3. 각 상태에 따라 신청이 진행되는 상태를 확인할 수 있습니다.</p>
		<p>&emsp;&emsp; - '대기': 서류를 검토중입니다. 기다려주세요.</p>
		<p>&emsp;&emsp; - '완료': 서류 검토가 완료되었습니다. 서류심사가 완료되었습니다. 결과 반영 중입니다.</p>
		<p>&emsp;&emsp; - '승인': 서류 심사 결과 '승인'되었습니다. 변경된 출석정보를 '<a href="${cPath}/attendance/attendanceStu.do?what=${what}">조회</a>'하세요.</p>
		<p>&emsp;&emsp; - '반려': 서류 심사 결과 '반려'되었습니다. 자세한 사항은 과사에 문의하세요.</p>
	</div>
</div>

<div class="space m-3 p-5">
	<h4 class="mb-3">
		<ion-icon name="stop-outline" role="img" class="md hydrated">
		</ion-icon>출석인정신청 내역
	</h4>
	<div class="scrolDiv overflow-scroll scrollable-content">
	<c:forEach items="${attendAdmitList }" var="attendAdmit" varStatus="i">
		<table class="table table-hover text-center underbar">
		<colgroup>
             <col width="25%"/>
             <col width="25%"/>
             <col width="25%"/>
             <col width="25%"/>
        </colgroup>
		<thead>
			<tr>	
				<th>출석인정신청번호</th>
				<th>출석날짜</th>
				<th>출석상태</th>
				<th>파일제출번호</th>
			</tr>
		</thead>
		<tbody>
				<tr>
					<td>${attendAdmit.aaNo }</td>
					<td>${attendAdmit.attend.attendDate }</td>
					<td>
						<c:choose>
							<c:when test="${attendAdmit.attend.attendState eq 'D001' }">출석</c:when>
							<c:when test="${attendAdmit.attend.attendState eq 'D002' }">결석</c:when>
							<c:when test="${attendAdmit.attend.attendState eq 'D003' }">지각</c:when>
						</c:choose>
					</td>
					<td>
						<c:if test="${attendAdmit.aaFile eq 0}">
							파일 누락
						</c:if>
						<c:if test="${attendAdmit.aaFile gt 0}">
							<a href="${cPath}/attend/attatch/download.do?atchId=${attendAdmit.aaFile }&atchSeq=1 ">
							파일 다운로드 
							</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>신청사유</th>
					<td colspan="4">${attendAdmit.aaReason }</td>
				</tr>
				<tr>
					<td colspan="5" class="aaStateTd${i.index}" 
							data-aastate${i.index}="${attendAdmit.aaState }"  
							data-aafile${i.index}="${attendAdmit.aaFile }">
						<div class="card-header">
							<!-- Step progress -->
							<ul id="_dm-validWizardSteps" class="step-progress my-4">
							    <li class="submit${i.index}">
							        <span class="step-label">서류접수</span>
							    </li>
							    <li class="wait${i.index}">
							        <span class="step-label">대기</span>
							    </li>
							    <li class="complete${i.index}">
							        <span class="step-label">완료</span>
							    </li>
							    <li class="approval${i.index}">
							        <span class="step-label admitResult"></span>
							    </li>
							</ul>
							<!-- END : Step progress -->
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="5" class="redfont aaRefuseAria${i.index}">${attendAdmit.aaRefuse }</td>
				</tr>
			</tbody>
		</table>
	</c:forEach>
	</div>
</div>
<script src="${cPath }/resources/js/attendance/stuAttendAdmitList.js"></script>