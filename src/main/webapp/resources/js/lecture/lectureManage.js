//jsp cPath----------------------------------------------
const cPath = document.querySelector('#cPath').value;
//jsp memRole----------------------------------------------
const memRole = document.querySelector('#memRole').value;
//jsp memNo----------------------------------------------
const memNo = document.querySelector('#memNo').value;
//jsp colNo----------------------------------------------
const UsercolNo = document.querySelector('#colNo').value;
//jsp deptNo----------------------------------------------
const UserdeptNo = document.querySelector('#deptNo').value;
//jsp empNo----------------------------------------------
let empNo = null;
if(memRole == 'ROLE_EMP'){
    empNo = document.querySelector('#empNo').value;
}
//jsp proNo----------------------------------------------
let proNo = null;
if(memRole == 'ROLE_PRO'){
    proNo = document.querySelector('#proNo').value;
}
//--------------------------------------------------------
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');

// 상세 검색 구현
	let searchForm = $("#searchForm").on("submit", function(event) {
		event.preventDefault();
		
		let data = $(this).serialize();
		
		// 요일 데이터도 가져가기
// 		console.log("요일 : ", $(this).find("[name=ltdDayVal] option:selected").text());
// 		let ltdDay = $(this).find("[name=ltdDayVal] option:selected").text();
// 	    data += "&ltdDay=" + ltdDay;	
// 	    console.log("요일 포함 data : ", data);

		fn_make_li(data);
		
		lectureSearchInput.val("");

		modalClose();
		return false;
	})

	// 단과대 선택하면 그 단과대에 맞는 학과명만 보이게 하기
	let deptNo = $("[name=deptNo]");
	let colNo = $("[name=colNo]").on("change", function(event) {
		deptNo.val("");
		deptNo.prop('disabled', false);
		
		let col = $(this).val();
		console.log(col);
		deptNo.find("option").not(":first").hide();
		deptNo.find("option").filter(`.${col}`).show();
	})
	
	let startNum = 0;
	const pCnt = 10; // 몇 개씩

	let searchCnt = $("#searchCnt");
	
	let lectListUl = $("#lectListUl");
	
	let fn_make_li = (data) =>{
		// 데이터(검색어) 받아서 가기
		$.ajax({
			method:"post",
			url: `${cPath}/lectureManage/lectureList.do`,
			data: data,
			dataType: "json",
// 			contentType: "application/json; charset=UTF-8",
			success: function(data){
				lectList = data;
				console.log(lectList);
				
				lectListUl.empty();
				startNum = 0;

				searchCnt.text(lectList.length);

				$.each(lectList, function (idx, lect) {
					console.log(lect);

			        lectListUl.append(lect.lectListHTML);
					
				})
				
								
			}
		})
	};
	
	fn_make_li();
	
   // li 태그 마우스 hover 이벤트 구현
   $(document).on("mouseover", ".lect-li", function (e) {
	let arr = $(this).data("lectTime");
	arr = String(arr);
	 arr = arr.split(",");
	 $.each(arr, function(idx, td){
	 //        $(`#\${td}`).css("background-color", "green");
			$(`#lec${td}`).css("background-color", "navy");
	 })      
		
  });
  $(document).on("mouseout", ".lect-li", function (e) {
	 let arr = $(this).data("lectTime");
	 arr = String(arr);
	 arr = arr.split(",");
	 $.each(arr, function(idx, td){
//               $(`#\${td}`).css("background", "none");
		$(`#lec${td}`).css("background", "none");
	  })
	 
  });
	

// 상세보기 버튼 구현
let lectInfoModal = $("#lectInfoModal");
let lectModalOpen = () => {
	lectInfoModal.show();
}
	let lectModalClose = () => {
		lectInfoModal.hide();
}

// lectNo 가지고 강의 정보 다 불러오기
let fn_lectInfo = (lectNo) =>{
	$.ajax({
		url: `${cPath}/lectureManage/lectureInfo/`+lectNo,
		method:"post",
		dataType:"json",
		success: function(resp){
// 			모달 값 지우기
			lectInfoModal.find("[id$='M']").text("");
			lect = resp;
			console.log("lect : ", lect);
			// 강의 정보 채우기
			
			$("#subCommNameM").text(lect.subCommName);
			$("#subGradeM").text(lect.subGrade);
			$("#memNameM").text(lect.memName);
			$("#lectNameM").text(lect.lectName);
			$("#lectNoM").text(lect.lectNo);
			$("#lectOnfNameM").text(lect.lectOnfName);
			$("#lectExpM").text(lect.lectExp);
			$("#subScrM").text(lect.subScr);
			$("#subHoursM").text(lect.subHours);
			$("#colNameM").text(lect.colName);
			$("#deptNameM").text(lect.deptName);

	    	let data = ""; 
	    	 $.each(lect.lectDetailList, function(idx, ldt){
	    		data += `${ldt.ltdDay} ${ldt.ltdPeriod}교시 : ${ldt.builName} ${ldt.lrNum}호<br>`;
	    	 })
			$("#lectTimePlaceM").html(data);   	
	    	 
			// 주차별 강의 계획 넣기
			// $("#lwpM") table에 tr 추가 (td 2개: lwpWeek lwpContent)
	    	let lwpM = $("#lwpM"); 
			lwpM.append(
				$("<tr>").append(
					$("<th>").html("주차"),
					$("<th>").html("내용")
				)
			);
			
			$.each(lect.lectPlanList, function(idx, lp){
				lwpM.append(
					$("<tr>").append(
						$("<td>").html(lp.lwpWeek),
						$("<td>").html(lp.lwpContent)
						
					)		
				);
	    	 })
			
			
		}
		
	})
	
	// 모달 nav tab 초기화
	lectInfoModal.find('.nav-link').removeClass('active');
	lectInfoModal.find("#lectTab1").addClass('active');
	
	lectInfoModal.find('.tab-pane').removeClass('active show');
	lectInfoModal.find("#lectTab1Body").addClass('active show');
		
	lectModalOpen();	
}	
	
let lectInfoBtn = $(document).on("click", ".lectInfoBtn", function(){
// 	console.log("lectInfoBtn : ", this);
	console.log($(this).parents("li").data("lectNo"));
	
	let lectNo = $(this).parents("li").data("lectNo");
	
	fn_lectInfo(lectNo);
	
})


// 강의명, 교수명, 강의코드 로 검색 keyup
let fn_search_basketList = (searchData) =>{
// 	searchForm 검색조건 가져가야 함.
	let searchFormData = searchForm.serialize();
//     searchFormData += "&ltdDay=" + searchFormData.find("[name=ltdDayVal] option:selected").text();
    
	console.log("search form data : ", searchFormData);
	
	// 검색어 없을 때 전체 리스트 띄우기
    if(searchData.length == 0 || searchData == null){
    	lectListUl.empty();
    	fn_make_li(searchFormData);
        return;
    }
    // 검색어 있을 때
    // 데이터 가지고 리스트 가져오기(fn_make_li(검색어))
    searchFormData += "&searchData=" + searchData;
   	fn_make_li(searchFormData);
}

let lectureSearchInput = $("#lectureSearchInput").on("keyup", function(event) {
	let searchData = $(this).val();
	fn_search_basketList(searchData);
})

// 검색 상세 조회 모달
let searchModal = $("#searchModal");
let modalOpen = () => {
	console.log("모달");
	searchModal.show();
   
}
let modalClose = () => {
	searchModal.hide();
}

//-----------------------------------------------------------------------------------------------------------------------
let lectPlanModal = $("#lectPlanModal");
let lecturePlanTBody = $("#lecturePlanTBody");
let subjectTd = $("#subjectTd");
let subjectScore = $("#subjectScore");
let subjectTime = $("#subjectTime");
let subjectGrade= $("#subjectGrade");
let lectureRoomSelectTd = $("#lectureRoomSelectTd");
let lectureRoomMaxTd = $("#lectureRoomMaxTd");
let lectMm = $("#lectMm");
let lectDetailHidden = $("#lectDetailHidden");

let lectPlanModalOpen = () => { // 모달 보여줌
	lectPlanModal.show();
}
let lectPlanModalClose = () => { // 모달 닫음
	lectPlanModal.hide();
	$("#lectPlanForm")[0].reset();
	$(".lecTimeTd").css("background-color", "white");
	subjectGrade.text("");
	subjectScore.text("");
	subjectTime.text("");
	lectureRoomMaxTd.text("");
	cnt = 0;

}



let lectPlanBtn = $(document).on("click", "#lectPlanBtn", function(){ 
	lectureRoomSelectTd.empty();
	subjectTd.empty();

	let subjectList = JSON.parse(localStorage.getItem("userSubjectList"));
	let mySelect = $("<select>").attr({name: "subNo", id : "selectSub", class : "form-select", style:"background-color:#f3f5f9"});
	$.each(subjectList, (idx, subject)=>{
		let subjectOption = $("<option>").attr({value :subject.subNo, class : "optionSub"}).text(subject.subName);
		mySelect.append(subjectOption);
	});
	subjectTd.append(mySelect);

	let lectureRoomList = JSON.parse(localStorage.getItem("lectureRoomList"));
	let lectureRoomSelect = $("<select>").attr("id","lectureRoomSelect");
	let AllOption = $("<option>").text("선택");
	lectureRoomSelect.append(AllOption);
	$.each(lectureRoomList, (idx, lectureRoom)=>{
		let lectureRoomOption = $("<option>").attr({value :lectureRoom.lrNo, class : "optionRoom"}).text(lectureRoom.lrNo);
		lectMm.attr("value" , lectureRoom.lrMnop);
		lectureRoomSelect.append(lectureRoomOption);
	});
	lectureRoomSelectTd.append(lectureRoomSelect);

	lectPlanModalOpen();
	
})
//교과목 정보 ---------------------------------------------------------------------------------
$(document).on("change", "#selectSub", (event)=>{
	let target = event.target;
	let option = $(target).val();
	console.log(option);
	let subjectList = JSON.parse(localStorage.getItem("userSubjectList"));
	$.each(subjectList, (idx, subject)=>{
		if(option == subject.subNo){
			subjectGrade.text(subject.subGrade);
			subjectScore.text(subject.subScr);
			subjectTime.text(subject.subHours);
		}
	});
	if(subjectTime.text() != null || subjectTime.text() != ""){
		lectDetailHidden.empty();
		for(let i = 0; i < parseInt(subjectTime.text()); i++) {
			
			if($("#hiddnLrNo"+i).length == 0){
				let a =$("<input>").attr({type: "hidden", name : `lectDetailList[${i}].lrNo`, id: `hiddnLrNo${i}`})
				let b =$("<input>").attr({type: "hidden", name : `lectDetailList[${i}].ltdNo`, id: `hiddnLtdNo${i}`})
				lectDetailHidden.append(a);
				lectDetailHidden.append(b);
			}
		}
	}
	
})
//강의실 이미 차있는거 색칠-----------------------------------------------------------------------
$(document).on("change","#lectureRoomSelect",(event)=>{

	let target = event.target;
	let option = $(target).val();
	console.log(option);
	
	if(option != null){
	
	lectureRoomMaxTd.text($("#lectMm").val());
	let lectureTimePlaceList = JSON.parse(localStorage.getItem("lectureTimePlaceList"));
	$.each(lectureTimePlaceList, (idx, lectRoom)=>{
		if(option == lectRoom.lrNo){
			$(`#${lectRoom.ltdNo}`).css("background-color", "gray");
		}
	});
	}
})
// 강의실 선택------------------------------------------------------------------------------여기서 배열에 값 다 넣어버리기.
let cnt = 0;
$(document).on("click",".lecTimeTd",(event)=>{
	let target =event.target;
	let targetValue= $(target).data("value");
	console.log('이게 타겟: ' + targetValue);
	console.log('이거 시수: ' + subjectTime.text());


	if(subjectTime.text() == null || subjectTime.text() == ""){
		alert("아직강의선택 안했음. 강의 선택 체킁");
	}else{
		if($(target).css("background-color") === "rgb(128, 128, 128)" || $(target).css("background-color") === "gray"){
			console.log("색있음");
		}else if($(target).css("background-color")==="rgb(255, 0, 0)" ||$(target).css("background-color") === "red"){
			$(`#${targetValue}`).css("background-color", "white");
			console.log("색해제")
			cnt = cnt - 1;
			console.log(cnt);
			$(`#hiddnLrNo${cnt}`).attr("value", "");
			$(`#hiddnLtdNo${cnt}`).attr("value", "");
		}else{
			if(cnt == parseInt(subjectTime.text())){
				alert("시수만큼 선택했어~ 테스통~");
			}else{
				$(`#${targetValue}`).css("background-color", "red");
				cnt = cnt + 1;
				console.log(cnt);
				let lrNo =  $("#lectureRoomSelect").val();
				console.log(lrNo);
				$(`#hiddnLrNo${cnt-1}`).attr("value", lrNo);
				$(`#hiddnLtdNo${cnt-1}`).attr("value",targetValue);
			}
		}
		
	};

	
	 
	

	  

} )


$("#lectPlanInsertBtn").on("click", ()=>{
	let lectPlanForm = $("#lectPlanForm");
	let data = lectPlanForm.serialize();
	let url = `${cPath}/lectureManage/lectureInsert.do`

	$.ajax({
		url : url,
		method : "post",
		data : data,
		dataType : "json",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
			}
	}).done((resp)=>{
		console.log("체킁: ",resp);
		if(resp > 0){
			alert("성공");
			selectLectureTimePlaceList();
			lectPlanModalClose();
			
		}else{
			alert("실패 Why???");
		}

	})
});

	  
	
  
// 키업-------------------------------------------------------------------------------------
let wnd = $("#wnd");
let rl = $("#rl");
let cnf = $("#cnf");
let rhk = $("#rhk");
let gkq = $("#gkq");
wnd.on('keyup',()=>{
	if(parseInt(wnd.val()) >=0 && parseInt(wnd.val()) <=100 
	||parseInt(rl.val()) >=0 && parseInt(rl.val()) <=100
	||parseInt(cnf.val()) >=0 && parseInt(cnf.val()) <=100
	||parseInt(rhk.val()) >=0 && parseInt(rhk.val()) <=100
	){
		let result = parseInt(wnd.val()) + parseInt(rl.val()) + parseInt(cnf.val()) + parseInt(rhk.val());
		let parResult = parseInt(result);
		if( parResult >= 0 &&parResult <= 100){
			gkq.text(parResult);
		}else{
			gkq.text("입력하신 값이 올바르지 않습니다.");
		}
	}else{
		gkq.text("입력하신 값이 올바르지 않습니다.");
	}
})
rl.on('keyup',()=>{
	if(parseInt(wnd.val()) >=0 && parseInt(wnd.val()) <=100 
	||parseInt(rl.val()) >=0 && parseInt(rl.val()) <=100
	||parseInt(cnf.val()) >=0 && parseInt(cnf.val()) <=100
	||parseInt(rhk.val()) >=0 && parseInt(rhk.val()) <=100
	){
		let result = parseInt(wnd.val()) + parseInt(rl.val()) + parseInt(cnf.val()) + parseInt(rhk.val());
		let parResult = parseInt(result);
		if( parResult >= 0 &&parResult <= 100){
			gkq.text(parResult);
		}else{
			gkq.text("입력하신 값이 올바르지 않습니다.");
		}
	}else{
		gkq.text("입력하신 값이 올바르지 않습니다.");
	}
})
cnf.on('keyup',()=>{
	if(parseInt(wnd.val()) >=0 && parseInt(wnd.val()) <=100 
	||parseInt(rl.val()) >=0 && parseInt(rl.val()) <=100
	||parseInt(cnf.val()) >=0 && parseInt(cnf.val()) <=100
	||parseInt(rhk.val()) >=0 && parseInt(rhk.val()) <=100
	){
		let result = parseInt(wnd.val()) + parseInt(rl.val()) + parseInt(cnf.val()) + parseInt(rhk.val());
		let parResult = parseInt(result);
		if( parResult >= 0 &&parResult <= 100){
			gkq.text(parResult);
		}else{
			gkq.text("입력하신 값이 올바르지 않습니다.");
		}
	}else{
		gkq.text("입력하신 값이 올바르지 않습니다.");
	}
})
rhk.on('keyup',()=>{
	if(parseInt(wnd.val()) >=0 && parseInt(wnd.val()) <=100 
	||parseInt(rl.val()) >=0 && parseInt(rl.val()) <=100
	||parseInt(cnf.val()) >=0 && parseInt(cnf.val()) <=100
	||parseInt(rhk.val()) >=0 && parseInt(rhk.val()) <=100
	){
		let result = parseInt(wnd.val()) + parseInt(rl.val()) + parseInt(cnf.val()) + parseInt(rhk.val());
		let parResult = parseInt(result);
		if( parResult >= 0 &&parResult <= 100){
			gkq.text(parResult);
		}else{
			gkq.text("입력하신 값이 올바르지 않습니다.");
		}
	}else{
		gkq.text("입력하신 값이 올바르지 않습니다.");
	}
})




document.addEventListener("DOMContentLoaded", ()=>{
	selectLectureWeekPlanList();
	selectLectureTimePlaceList();
	selectLectureRoomList();
})

let selectLectureWeekPlanList = () =>{
	let url = `${cPath}/lectureManage/lectureWeekPlanList.do`
	let method = 'GET';
	$.ajax({
		url : url,
		method : method,
		dataType : "json"
	}).done((resp)=>{
		localStorage.setItem("lectureWeekPlanList", JSON.stringify(resp));
	});
}

if(!localStorage.getItem("lectureWeekPlanList")){
	selectLectureWeekPlanList();
}

let selectLectureTimePlaceList = () =>{
	let url = `${cPath}/lectureManage/lectureTimePlaceList.do`
	let method = 'GET';
	$.ajax({
		url : url,
		method : method,
		dataType : "json"
	}).done((resp)=>{
		localStorage.setItem("lectureTimePlaceList", JSON.stringify(resp));
	});
}

if(!localStorage.getItem("lectureTimePlaceList")){
	selectLectureTimePlaceList();
}

let selectLectureRoomList = () =>{
	let url = `${cPath}/lectureManage/lectureRoomList.do`
	let method = 'GET';
	$.ajax({
		url : url,
		method : method,
		dataType : "json"
	}).done((resp)=>{
		localStorage.setItem("lectureRoomList", JSON.stringify(resp));
	});
}

if(!localStorage.getItem("lectureRoomList")){
	selectLectureRoomList();
}

let getSubjectList = () => {
	let url = `${cPath}/subject/subjectManagement.do`
	let method = 'GET';
	$.ajax({
		url : url,
		method : method,
		dataType : "json"
	}).done(function(resp, textStatus, jqXHR) {
		let subjectList = [];
		for(let i=0; i<resp.length; i++){
			let data = resp[i];
			if(data.deptNo == UserdeptNo){
				subjectList.push(data);
			}
		}

		localStorage.setItem("userSubjectList", JSON.stringify(subjectList));

	});
}

if(!localStorage.getItem("userSubjectList")){ // 여기서 여러개를 체크해야하나?
	getSubjectList();
}