<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    
<style>
.gridDIV{
	display: grid;
	grid-template-columns: 2fr 3fr;
}
.redfont{
	color: red;
}
.attendTable{
 table-layout: fixed;
 width:100%;	
}
.attendTableDiv {
	overflow: auto;
	min-width: 500px;
}
.marginSpace{
	margin-right: 30px;
}

</style>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${lectNo}">강의관리</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/attendance/attendance.do?what=${lectNo}">출석관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">전자출결시스템</li>
	</ol>
</nav>
<div class="d-flex justify-content-between " style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
	</div>
	  <security:authorize access="hasRole('PRO')">
		    <div class="marginSpace">
		      <div class="btn-group bigfont">
		        <a id="attend" href="${cPath}/attendance/attendance.do?what=${lectNo}" class="btn btn-info">출석</a>
		        <a href="${cPath}/lecture/lectProEval.do?what=${lectNo}" class="btn btn-info">평가</a>
		        <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${lectNo}" class="btn btn-info">과제</a>
		        <a id="exam" href="${cPath}/exam/exam.do?what=${lectNo}" class="btn btn-info">시험</a>
		        <a id="score" href="${cPath}/score/proScore.do?what=${lectNo}" class="btn btn-info">성적</a>
		        <a id="lecutreData" href="${cPath}/lecture?what=${lectNo}" class="btn btn-info">자료실</a>
		      </div>
		    </div>
		  </security:authorize>
</div>
<div class="gridDIV bigfont" >
	<div class="space m-3 p-5">
		<div>
			<h4 class="mb-4 fs-2">
				<ion-icon name="stop-outline" role="img" class="md hydrated">
				</ion-icon> 전자출결 시스템 사용안내
			</h4>
			<div class="desc-space pt-4 p-3">
			<p class="redfont">&emsp; 🚩교수님, 강의실 출석을 오픈하기 전, 모든 학생들에게 로그인이 되었는지 확인해주세요.</p>
			<p>&emsp; -- 전자출결 시스템 이용순서 -- </p>
			<p>&emsp; 1. 강의실 출석 오픈을 선택한다.  </p>
			<p>&emsp; 2. 학생들의 출석을 응답을 기다린다.</p>
			<p>&emsp; 3. 적당한 시간을 제공했다면, 강의실 출석을 닫아주세요.</p>
			<p>&emsp; 4. 학생들의 출석을 확인하고 저장버튼을 눌러주세요.</p>
			<p>&emsp; 5. 등록된 데이터의 갯수를 확인해주세요.</p>
			</div>
		</div><br><br>
		<div class="">
			<img src="${cPath }/resources/img/autoAttend.jpg" width="600px"/>
		</div>
	</div>
	<div class="space m-3 p-5 attendTableDiv overflow-scroll scrollable-content">
		<button class="openBtn" data-role="connect">ROOM ID(${lectName}) 강의실 출석 오픈!</button><br><br>
		<button class="openBtn" data-role="disconnect" disabled="disabled">ROOM ID(${lectName}) 강의실 출석 종료!</button><br><br>
		<table class="table table-hover text-center underbar attendTable">
			<thead>
				<tr>
					<th> <h4>출석 학생 리스트</h4> </th>
				</tr>
			</thead>
			<tbody id="stdTBODY">
				<c:forEach items='${cosStuList }' var="usr">
					<tr>
						<td id="stu_${usr.stuNo}" data-stu-no="${usr.stuNo}">
							${usr.student.memName } :
<%-- 							${usr.student.memName } : <span class="bg-danger outAttend">출석</span> --%>
							<input type="radio" name="${usr.stuNo}_attendState_in" value="D001" />
							<label for="${usr.stuNo}_attendState_in" class="outAttend" >출석</label>
							
							<input type="radio" name="${usr.stuNo}_attendState_out" value="D002" checked="checked"/>
							<label for="${usr.stuNo}_attendState_out" class="bg-danger outAttend">결석</label>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td>
						<button class="openBtn saveBtn btn btn-primary" disabled="disabled">저장</button>
					</td>
				</tr>
			</tfoot>
		</table>
		<security:authentication property="principal.realUser" var="authUser" />
	</div>
</div>
<script>
	const ROOMID = `${lectName}`;
	const openBtns = document.querySelectorAll(".openBtn");
	let client = null;
	
	// radio버튼 전환하기
	let inOriginRadio = document.querySelectorAll("input[type='radio']:not(:checked)");
	let outOriginRadio = document.querySelectorAll("input[type='radio']:checked");
	
	for(let i=0; i<inOriginRadio.length; i++){
		outOriginRadio[i].addEventListener("change", function(){
			inOriginRadio[i].checked = false;
			inOriginRadio[i].nextElementSibling.classList.remove("bg-success", "inAttend");
			outOriginRadio[i].checked = true;
			outOriginRadio[i].nextElementSibling.classList.add("bg-danger", "outAttend");
		})
		
		inOriginRadio[i].addEventListener("change", function(){
			inOriginRadio[i].checked = true;
			inOriginRadio[i].nextElementSibling.classList.add("bg-success", "inAttend");
			outOriginRadio[i].checked = false;
			outOriginRadio[i].nextElementSibling.classList.remove("bg-danger", "outAttend");
		})
	}
	
	
	// openBtn : 스톰프 시작
	function openBtnOn(targetBtn){
		
		// 스톰프 객체 생성
		client = new StompJs.Client({
			brokerURL:"ws://192.168.36.36${cPath}/ws/classroom",
			debug:function(str){
				console.log(str);
			},
			// 연결되고서 수행하는 내용
			onConnect:function(frame){
				const subscription1 = this.subscribe(`/user/classroom/\${ROOMID}`, function(msgFrame){
					let payload = JSON.parse(msgFrame.body);
					let stdTD = stdTBODY.querySelector(`#stu_\${payload.sender}`);
					if(stdTD){
						
						let radios = stdTD.querySelectorAll("input[type='radio']");
						let inRadio = radios[0];
						let outRadio = radios[1];
						
						console.log(inRadio, ":inRadio");
						console.log(outRadio, ":outRadio");
						
						inRadio.checked = true;
						inRadio.nextElementSibling.classList.add("bg-success", "inAttend");
						outRadio.checked = false;
						outRadio.nextElementSibling.classList.remove("bg-danger", "outAttend");
					}
				});

				// 실제보내는 내용 : destination으로 메세지 구분
				this.publish({
					destination:"/classroom/open",
					body:JSON.stringify({
						classRoomId:ROOMID,
						professor:"${authUser.proNo}"
					}),
					headers:{"content-type":"application/json"}
				})
			}
		});
		client.activate();
	}
	
	
	// 위 버튼을 누르면,
	openBtns[0].addEventListener("click",()=>{
		// 버튼 토글하고, 
		openBtns[0].disabled = true;
		openBtns[1].disabled  = false;
		openBtns[2].disabled  = true;
		
		// 연결
		openBtnOn(openBtns[0]);
	})

	// 아래 버튼을 누르면, 
	openBtns[1].addEventListener("click",()=>{
		// 버튼 토글하고, 
		openBtns[1].disabled = true;
		openBtns[0].disabled  = false;
		openBtns[2].disabled  = false;
		
		// 연결 종료!
		client.deactivate();
	})

	// 이거 다 바꿔 
	let saveBtn = document.querySelector(".saveBtn")
	saveBtn.addEventListener("click", ()=>{
		// 체크된 라디오들 전부모여!
		let checkedRadios = document.querySelectorAll("input[type='radio']:checked");
		
		//controller로 전송할
		//경로 설정
		let attendUrl = `\${$.CPATH}/attendance/attendInsert.do`
		
		//데이터 설정
		let lectNo = ${lectNo};
		// 학생들의 학번 뽑아내자.
		// 학생마다 출석, 결석 value를 넣은 객체를 만들자!
		let stus = [];
		attendDatas = [];
		checkedRadios.forEach(function(checkedRadio){
			attendData = {
				stuNo : checkedRadio.parentNode.dataset.stuNo,
				attendState : checkedRadio.value,
				lectNo : lectNo
			}
			attendDatas.push(attendData);
		})
		 
		console.log(attendDatas);

		//ajax로 전송하자.
		$.ajax({
			url : attendUrl,
			method : "post", 
			data : JSON.stringify(attendDatas),
			dataType : "json",
			contentType : "application/json"
		}).done(function(resp, textStatus, jqXHR) {
			Swal.fire({title: '출석 데이터가 변경되었습니다.'});
// 			alert("출석 데이터가 변경되었습니다. 결과 :  " + resp);
		})
		
	});
	
</script>