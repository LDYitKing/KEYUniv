<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.gridDIV{
	display: grid;
	grid-template-columns: 3fr 2fr;
}

.doughnut{
	width:260px;
	text-align: center;
	margin: auto;
}

.attendTable{
	width:95%;	
	white-space:nowrap;
	overflow-x:scroll;
}
td{
	idth:auto;
}
.socketSpace{
	text-align: right;
}
.attendTableDiv {
	overflow: auto;
	min-width: 450px;
}

/* 출석인정신청리스트 모달 */
#attendModal{
    position: fixed;
    width: 100%;
    height: 170%;
    left: 0px; 
    right: 0px;
    z-index: 9999999999;
    display: none;
    background-color: rgba(128, 128, 128, 0.5);
}

#attendModalDiv{
    width: 50%;
    height: 45%;
    margin: 100px auto;
    background-color: white;
}
 
#modalOverflow{
	max-height: 600px;
	overflow: auto;
}
/* 모달 설정 끝 */
#overflow{
	max-height: 400px;
	overflow: auto;
}
#refuseReason{
	display:none;
}
.redfont{
	color: red;
	text-align: center;
	font-weight: bold;
}
.icon{
	text-align: center;
	font-size: xx-large;
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
	<security:authorize access="hasRole('PRO')">
	  <div class="marginSpace">
	    <div class="btn-group bigfont">
	      <a id="attend" href="${cPath}/attendance/attendance.do?what=${what}" class="btn btn-info">출석</a>
	      <a href="${cPath}/lecture/lectProEval.do?what=${what}" class="btn btn-info">평가</a>
	      <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${what}" class="btn btn-info">과제</a>
	      <a id="exam" href="${cPath}/exam/exam.do?what=${what}" class="btn btn-info">시험</a>
	      <a id="score" href="${cPath}/score/proScore.do?what=${what}" class="btn btn-info">성적</a>
	      <a id="lecutreData" href="${cPath}/lecture?what=${what}" class="btn btn-info">자료실</a>
	    </div>
	  </div>
	</security:authorize>
</div>

<div class="space m-3 p-5 bigfont">
	<div class="gridDIV">
		<div>
			<h4 class="mb-4 fs-2">
				<ion-icon name="stop-outline" role="img" class="md hydrated">
				</ion-icon> 출석 안내
			</h4>
			<div class="desc-space pt-4 p-3">
			<p>&emsp; 1. 교수님의 강의의 출석을 조회하고 저장할 수 있는 '온라인 출석부'입니다.</p>
			<p>&emsp; 2. 강의 시작 전, '전자출석'버튼을 클릭하여 학생들의 출석정보를 등록해주시기 바랍니다. </p>
			<p>&emsp;&emsp; - '전자출석'코드를 입력하시고 학생 목록을 확인 후 전송하십시오.</p>
			<p>&emsp; 3. '전체보기' : 수강하는 학생들의 전체 출석정보를 확인할 수 있습니다.</p>
			<p>&emsp;&emsp; - 출석정보를 확인 후 잘못된 정보가 있을 시 수정하여 등록할 수 있습니다.</p>
			<p>&emsp;&emsp; - 출석인정 신청이 있을 경우 조회 후 결과를 등록할 수 있습니다.</p>
			</div>
		</div>
		<div>
		    <h4 class="fs-2">&nbsp;&nbsp;
		    <ion-icon name="stop-outline" role="img" class="md hydrated">
				</ion-icon>
			수업 진행률</h4>
			<div class="text-center">
			    <div class="doughnut">
					<canvas id="_dm-doughnutChart" width="100" height="100" 
					  style="display: block; box-sizing: border-box; height: 283px; width: 283px;">
					</canvas> 
				</div>
		    </div>
		</div>
	</div>
	<br><br>
	<div>
		<table class="table table-hover text-center">
			<thead>
				<div class="socketSpace mb-2">
				    <a href="<c:url value='/classRoom/view?what=${what }'/>">
				        <i class="btn btn-danger rounded-pill btn-sm">
				        <span>강의실오픈!</span></a></i>
					<button class="btn btn-warning rounded-pill btn-sm" onclick="modalOpen()">출석인정신청내역</button>
				</div>
	<hr>	
				
				<tr>
					<th width="15%">학번</th>
					<th width="15%">학과</th>
					<th width="15%">학생이름</th>
					<th width="20%">학생이메일</th>
					<th width="10%">출석</th>
					<th width="10%">결석</th>
					<th width="10%">현재수업일수</th>
				</tr>
			</thead>
		</table>
		<div id="overflow" class=" overflow-scroll scrollable-content">		
		<table class="table table-hover text-center">
			<tbody id="listBody">
				<c:forEach items="${attendList }" var="attend" >
				<tr>
					<td width="15%">${attend.studentList[0].memNo }</td>
					<td width="15%">${attend.studentList[0].deptName}</td>
					<td width="15%">${attend.studentList[0].memName }</td>
					<td width="20%">${attend.studentList[0].memEmail }</td>
					<td width="10%">${attend.countAttend }</td>
					<td width="10%">${attend.countDeattend }</td>
					<td width="10%">${attend.countCurrentAttend }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		<div style="text-align:center;">
			<button class="attendViewBtn btn btn-secondary">전체보기</button>
		</div>
	</div>
</div>
<div id="overflow" class="bigfont space m-3 p-5 attendTable attendTableDiv overflow-scroll scrollable-content" data-what="${what }"  style="display:none">
	<table class="overflow-scroll scrollable-content table table-striped table-hover text-center">
		<thead class="theadTr">
			
		</thead>
		<tbody class="tbodyTr">
			
		</tbody>
		<tfoot class="tfootTr">
		
		</tfoot>
	</table>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<script>
//Color variables based on css variable.
//----------------------------------------------
const _body           = getComputedStyle( document.body );
const primaryColor    = _body.getPropertyValue("--bs-comp-active-bg");
const successColor    = _body.getPropertyValue("--bs-success");
const infoColor       = _body.getPropertyValue("--bs-info");
const warningColor    = _body.getPropertyValue("--bs-warning");
const mutedColorRGB   = _body.getPropertyValue("--bs-muted-color-rgb");
const grayColor       = "rgba( 180,180,180, .2 )";

//Doughnut Chart
//----------------------------------------------
const circleData =[15*2,14,15*2-14];
const doughnutChart = new Chart(
 document.getElementById( "_dm-doughnutChart" ), {
     type: "doughnut",
     data: {
         labels: [ "총 출결일수", "현재 출결일수", "남은 출결일수" ],
         datasets: [{
             data: circleData,
             borderColor: "transparent",
             backgroundColor: [ infoColor, warningColor, grayColor ],
         }]
     },
     options: {
         plugins :{
             legend: {
                 display: true,
                 labels: {
                     color: `rgb( ${ mutedColorRGB })`,
                     boxWidth: 10,
                 }
             },
         }
     }
 }
);
// 차트 끝!

let socketBtn = $(".socketBtn").on("click", function(){
	let attendCode = $("[name=attendCode]").val();
	socketBtn.attr("href", `https://chart.apis.google.com/chart?cht=qr&chs=300x300&chl=\${attendCode}`);
})

//검색 상세 조회 모달
let attendModal = $("#attendModal");
let modalOpen = () => {
	attendModal.show();
}
let modalClose = () => {
	attendModal.hide();
}
$(document).ready(function() {
	let refuseOpt = $(".refuseOpt").on("change", function(){
		console.log(this.value);
		if(this.value !="D001"){
			$(this).closest("form").find("#refuseReason").css("display", "inline-block")
		}else {
			$(this).closest("form").find("#refuseReason").css("display", "none")
		}
	
	})
})
</script>
<script src="${cPath }/resources/js/attendance/attendanceList.js"></script>
