<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<security:authentication property="principal.realUser" var="authMember" />
<link rel="stylesheet" href="${cPath }/resources/css/sugang/sugang.css"
	type="text/css">

<!-- 강의 상세검색 모달 -->
<div id="searchModal">
   <div id="searchModalDiv" class="card border-2 border-primary">
      <div id="searchModalHead" class="card-header toolbar">
         <div class="toolbar-start">
            <h4></h4>
         </div>
         <div class="toolbar-end">
            <button onclick="modalClose()" class="btn"><ion-icon name="close-outline"></ion-icon></button>
         </div>
      </div>
      <div id="searchModalBody">
         <form id="searchForm">
            <div class="p-3 pb-0">
         <table class="table searchTable mb-0">
            <tr>
               <th width="15%"class="text-end align-middle h5">교과구분</th>
               <td colspan="2" width="40%">
                  <select name="subComm" class="form-select searchInput" style="background-color:#f3f5f9;">
                     <option value=""></option>
                        <c:forEach items="${commList }" var="comm">
                          <option value="${comm.commNo }">${comm.commName }</option>
                        </c:forEach>                     
                  </select>
               </td>
               <th width="15%" class="text-end align-middle h5">학년</th>
               <td width="30%">
                  <select class="form-select searchInput" name="subGrade" style="background-color:#f3f5f9;">
                     <option value=""></option>
                     <option value="1">1</option>
                     <option value="2">2</option>
                     <option value="3">3</option>
                     <option value="4">4</option>
                     <option value="5">5</option>
                  </select>
               </td>
            </tr>
            <tr>
               <th class="text-end align-middle h5">개설학과</th>
               <td>
                  <select name="colNo" class="form-select searchInput" style="background-color:#f3f5f9;">
                     <option value=""></option>
                       <c:forEach items="${colList }" var="col">
                         <option value="${col.colNo }">${col.colName }</option>
                       </c:forEach>
                  </select>
               </td>
               <td>
                  <select name="deptNo" class="form-select searchInput" style="background-color:#f3f5f9;">
                     <option value=""></option>
                            <c:forEach items="${deptList }" var="dept">
                                 <option class="${dept.colNo }" value="${dept.deptNo }">${dept.deptName }</option>
                            </c:forEach>
                  </select>
               </td>
               <th class="text-end align-middle h5">요일</th>
               <td>
                  <select name="ltdDay" class="form-select searchInput" style="background-color:#f3f5f9;">
                     <option value=""></option>
                     <option value="월">월</option>
                     <option value="화">화</option>
                     <option value="수">수</option>
                     <option value="목">목</option>
                     <option value="금">금</option>
                     <option value="토">토</option>
                  </select>
               </td>
<!--                <td> -->
<!--                   <label class="form-label">교시: </label> -->
<!--                   <select class="form-select searchInput" name="ltdPeriod"> -->
<!--                      <option value=""></option> -->
<%--                       <c:forEach var="i" begin="1" end="13"> --%>
<%--                         <option value=${i }>${i } (${8+i}:00 ~ ${8+i}:50)</option> --%>
<%--                       </c:forEach> --%>
<!--                   </select> -->
<!--                </td> -->
            </tr>
         </table>
            </div>
         <div class="text-center m-2">
              <button type="reset" class="btn btn-icon btn-lg m-2 mx-2"> 
            <ion-icon name="reload-outline"></ion-icon>
         </button>
         <input id="searchBtn" class="btn btn-primary" type="submit" value="검색">
         </div>
         </form>
      </div>
   </div>
</div>
<!-- 강의 상세검색 모달 끝 -->

<nav class="mb-3" aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page"><a
			href="${cPath}/sugang/info">수강신청</a></li>
	</ol>
</nav>
<div class="row mx-3 justify-content-between">
	<div class="btn-group col-3" role="group"
		aria-label="Default button group">
		<a href="${cPath }/sugang/basket" class="btn btn-info">사전수강신청</a> <a
			href="${cPath }/sugang/signup" class="btn btn-info">수강신청</a> <a
			href="${cPath }/sugang/list" class="btn btn-info">수강신청 내역</a>
	</div>
	<div class="text-white col-4 align-self-center">
		<label class="text-danger">[2023학년도 1학기]</label> <label><span>${authMember.memName }</span>
			님의 수강신청 가능 학점은 <span class="text-danger">20</span>학점 입니다.</label>
	</div>

</div>

<div class="space m-3 p-5">
	<div id="lectSearchDiv" class="col-md-8 offset-md-2 py-3 mb-4 p-3">
		<form class="searchbox input-group">
			<a href="#" onclick="modalOpen();" class="btn btn-icon btn-xs m-2"
				id="detailBtn"> <ion-icon class="fs-1 md hydrated" width="16"
					height="16" name="options-outline" role="img"
					aria-label="options outline"></ion-icon>
			</a> <input id="sugangSearchInput"
				class="searchbox__input form-control form-control-lg" type="search"
				placeholder="강의명, 교수명, 강의코드 검색" aria-label="Search">
			<div class="searchbox__btn-group">
				<a href="#"
					class="searchbox__btn btn btn-icon shadow-none border-0 btn-sm"
					type="button"> <ion-icon name="search-outline"></ion-icon>
				</a>
			</div>
		</form>
		<div class="text-center mt-2">
			<p class="lead">
				<span id="searchCnt" class="text-info">0</span>건의 강의가 조회되었습니다.
			</p>
		</div>
	</div>
	<div class="mt-4">
		<p class="mb-0 lead">
			신청가능학점 <span id="sugangMaxSubScr" class="text-info">20</span>학점 /
			신청학점 <span id="sugangSubScr" class="text-info">0</span>학점 / 신청강의 <span
				id="sugangCnt" class="text-info">0</span>강의
		</p>
	</div>
	<!-- 리스트 -->
	<div id="allListDiv" class="mt-3 m-5">
		<div id="listBody" class="">
			<div id="listTab">
				<ul class="nav nav-callout nav-fill">
					<li class="nav-item">
						<button type="button" onclick="fn_basketList();" id="listTab1"
							class="nav-link active" data-bs-toggle="tab"
							data-bs-target="#listTab1Body" aria-controls="listTab1Body"
							aria-selected="true">장바구니</button>
					</li>
					<li class="nav-item" role="presentation">
						<button type="button" onclick="fn_favoriteList();" id="listTab2"
							class="nav-link" data-bs-toggle="tab"
							data-bs-target="#listTab2Body" aria-controls="listTab2Body"
							aria-selected="false">즐겨찾기 교과목 관련 개설강의</button>
					</li>
					<li class="nav-item" role="presentation">
						<button type="button" onclick="fn_allList();" id="listTab3"
							class="nav-link" data-bs-toggle="tab"
							data-bs-target="#listTab3Body" aria-controls="listTab3Body"
							aria-selected="false">전체 강의</button>
					</li>
				</ul>

			</div>
			<div class="tab-content">
				<div id="listTab1Body" class="tab-pane fade show active"
					aria-labelledby="listTab1">
					<div id="basketListDiv"
						class="overflow-scroll scrollable-content listTabDiv">
						<ul id="basketListUl" class="list-group list-group-flush">
						</ul>

					</div>
				</div>
				<div id="listTab2Body" class="tab-pane fade"
					aria-labelledby="listTab2">
					<div id="favoriteListDiv"
						class="overflow-scroll scrollable-content listTabDiv">
						<ul id="favoriteListUl" class="list-group list-group-flush">
						</ul>

					</div>
				</div>
				<div id="listTab3Body" class="tab-pane fade"
					aria-labelledby="listTab3">
					<div id="allLectListDiv"
						class="overflow-scroll scrollable-content listTabDiv">
						<ul id="allListUl" class="list-group list-group-flush">
						</ul>

					</div>

				</div>
			</div>
		</div>
		<div id="signupDiv" class="m-2">
			<div>
				<h5 class="text-center text-primary lectListTitle">수강신청 내역</h5>
			</div>
			<div id="lectListDiv" class="overflow-scroll scrollable-content">
				<ul id="lectListUl" class="list-group list-group-flush sugangListUL">
				</ul>


			</div>
		</div>

	</div>
	<!-- 리스트 끝 -->
</div>

<script>
let searchCnt = $("#searchCnt");

let sugangMaxSubScr = $("#sugangMaxSubScr");
let sugangSubScr = $("#sugangSubScr");
let sugangCnt = $("#sugangCnt");

let basketListUl = $("#basketListUl");
let favoriteListUl = $("#favoriteListUl");
let allListUl = $("#allListUl");

let fn_basketList = () =>{
	basketListUl.empty();
	
	$.ajax({
		url:"${cPath}/sugang/basket/list",
		method:"post",
		dataType:"json",
		success:function(resp){
			basketList = resp;
			console.log("장바구니 리스트 : ", basketList);
			
			if(basketList.length > 0){
				searchCnt.text(basketList.length);
				
				$.each(basketList, function(idx, basket){
					let lect = basket.lecture;
					basketListUl.append(lect.lectListHTML);
				})
				
			}else{
				basketListUl.append("장바구니 내역이 없습니다.");
			}
		}
	})
}
fn_basketList();

let fn_favoriteList = () =>{
	favoriteListUl.empty();
	
	$.ajax({
		url:"${cPath}/sugang/list/favorites",
		method:"post",
		dataType:"json",
		success:function(resp){
			favoriteList = resp;
			console.log("즐겨찾기 리스트 : ", favoriteList);
			
			if(favoriteList.length > 0){
				searchCnt.text(favoriteList.length);
				
				$.each(favoriteList, function(idx, sub){
					let divTag = $("<div class='mt-2'>").append(
						$("<p>").html(`<ion-icon name="bookmark" class="text-warning"></ion-icon> 교과목 : <span class='h5 text-primary'>\${sub.subName}</span><small>&nbsp;\${sub.subNo}</small>`),
						$("<p class='mb-1'>").html("관련 개설 강의 :")
					);
					if(sub.lectList.length > 0&&sub.lectList[0].lectNo!=null){
						$.each(sub.lectList, function(i, lect){
							divTag.append(lect.lectListHTML);
						})
					}else{
						divTag.append("&emsp; 개설된 강의가 없습니다.");
					}
					divTag.append("<hr>");
					
					favoriteListUl.append(divTag);
					
				})
				
			}else{
				favoriteListUl.append("즐겨찾기 내역이 없습니다.");
			}
			
		}
	})	
} 

let fn_allList = (data) =>{
	allListUl.empty();
	
	console.log("searchData : ", data);
	
	$.ajax({
		method:"post",
		url: "${cPath}/sugang/basket/lectures",
		data: data,
		dataType: "json",
//			contentType: "application/json; charset=UTF-8",
		success: function(resp){
			lectList = resp;
			console.log(lectList);
			
			searchCnt.text(lectList.length);
			
			$.each(lectList, function (idx, lect) {
				console.log(lect);
				
				allListUl.append(lect.lectListHTML);
			})
		}
	})
}

//상세보기 버튼 구현
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
		url: "${cPath}/sugang/basket/lecture/"+lectNo,
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
	    		data += `\${ldt.ltdDay} \${ldt.ltdPeriod}교시 : \${ldt.builName} \${ldt.lrNum}호<br>`;
	    	 })
			$("#lectTimePlaceM").html(data);   	
	    	 
			// 주차별 강의 계획 넣기
			// $("#lwpM") table에 tr 추가 (td 2개: lwpWeek lwpContent)
	         let lwpM = $("#lwpM"); 
	         lwpM.empty();
	         $.each(lect.lectPlanList, function(idx, lp){
	            lwpM.append(
	               $("<tr>").append(
	                  $("<td>").html(lp.lwpWeek),
	                  $("<td>").html(lp.lwpContent)
	                  
	               )      
	            );
	           })
	           
           // 강의 평가 기준 넣기
           let crtrThead = $("#lectCrtrTbThead");
           let crtrTbody = $("#lectCrtrTbTbody");
           crtrThead.empty();
           crtrTbody.empty();
           
         	$.each(lect.scoreCRTRList, function(idx, crtr){
         		let size = 100 / lect.scoreCRTRList.length;
         		crtrThead.append(
         				$(`<th width='\${size}%'>`).html(crtr.commName)
         		);
         		crtrTbody.append(
         				$("<td>").html(crtr.scRatio+"%")
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
	//	console.log("lectInfoBtn : ", this);
	console.log($(this).parents("li").data("lectNo"));
	
	let lectNo = $(this).parents("li").data("lectNo");
	
	fn_lectInfo(lectNo);

})


let insertBtn = $(document).on("click", "#insertBtn", function () {
	console.log($(this).parents("li").data("lectNo"));
	let lectNo = $(this).parents("li").data("lectNo");	
	
	// 겹치는 시간대 강의가 있는지 체크
	console.log("수강신청한 강의 시간들 : ", ltdNoList);
	let lectTime = $(this).parents("li").data("lectTime");

// 	console.log("type lectTime : ", typeof(lectTime)); // 시간 하나일 때 number
	lectTime = String(lectTime);
// 	console.log("type string lectTime : ", typeof(lectTime)); 
	let arr = lectTime.split(",");

	console.log("겹치는 강의 : ", arr.filter(time => ltdNoList.includes(time)));
	if(arr.filter(time => ltdNoList.includes(time)).length > 0){
		console.log("겹치는 강의 있음");
		Swal.fire("시간이 중복되거나 동일한 강의는 담을 수 없습니다.");	
		return;
	}

	// 신청 가능 학점을 초과했는지 체크
	let maxSubScr = parseInt(sugangMaxSubScr.text()); // 최대 신청 가능 학점
	let nowSubScr = parseInt(sugangSubScr.text()); // 현재 신청 학점
	let subScr = $(this).parents("li").data("subScr"); // 강의학점
	console.log("신청가능학점: ", maxSubScr, "현재신청학점:", nowSubScr, "강의학점: ", subScr);
	console.log("현재" , subScr + nowSubScr);
	if(maxSubScr < subScr + nowSubScr){
		Swal.fire("신청 가능 학점을 초과할 수 없습니다.");	
		return;
	}
	
	
	$.ajax({
		url:"${cPath}/sugang/signup",
		method:"post",
		data:{"lectNo":lectNo},
		success:function(resp){
			console.log("수강신청 결과 : ", resp);
			let msg = "";
			
			switch (resp) {
			  case "MAXMEMBER":
				console.log("인원초과");
				msg = "인원 초과입니다.";
			    break;
			  case "OK":
				console.log("성공");
				msg = "수강신청되었습니다.";
				fn_sugangList();
			    break;
			  case "FAIL":
				console.log("실패");
				msg = "잠시 후 다시 시도하세요.";
			    break;
			  default:
			}
					
			Swal.fire(msg);			
		}		
	})

	
});

// 수강 신청한 강의 시간들
var ltdNoList = [];

// 수강 신청 내역 가져오기
let lectListUl = $("#lectListUl");
let fn_sugangList = () =>{
	ltdNoList = [];
	
	lectListUl.empty();
	
	$.ajax({
		url:"${cPath}/sugang/list",
		method:"post",
		dataType:"json",	
		success:function(resp){
			
			let subScr = 0;
			let cnt = 0;
			
			let sugangList = resp;
			if(sugangList.length > 0){
				
				console.log("수강신청 리스트 : ", sugangList);
				$.each(sugangList, function(idx, sugang){
					let lect = sugang.lecture;
					
					// 신청학점, 신청강의 수 증가
					subScr = subScr + lect.subScr;
					cnt = cnt + 1;					
					
					let courseNo = sugang.courseNo;
					
					// 리스트 띄우기
					lectListUl.append(
						$(`<div class='uldiv' data-course-no='\${courseNo}'>`).append(lect.lectListHTML)		
					);			
					
					// 강의 시간 넣기
					$.each(sugang.lecture.lectDetailList, function(i, lt){
						ltdNoList.push(lt.ltdNo);
					})
				})
			}else{
				lectListUl.append("수강 신청 내역이 없습니다.");
			}
			
			sugangSubScr.text(subScr);
			sugangCnt.text(cnt);			
		}		
	})
}
fn_sugangList();

//수강신청 삭제
let deleteBtn = $(document).on("click", "#deleteBtn", function () {
//	 	console.log($(this).parents("li").data("lectNo"));
		let courseNo = $(this).parents(".uldiv").data("courseNo");
		let lectNo = $(this).parents("li").data("lectNo");
		
		Swal.fire({
			  title: '삭제하시겠습니까?',
			  showDenyButton: true,
			  confirmButtonText: '확인',
			  denyButtonText: '취소',
			}).then((result) => {
			  if (result.isConfirmed) {
				  
				$.ajax({
					url: "${cPath}/sugang/delete.do",
					method:"post",
					data: {"courseNo":courseNo, "lectNo":lectNo},
					success: function(){
						fn_sugangList();
						
					    Swal.fire('삭제되었습니다.', '', 'success')
					}		
				})
				  
			  } else if (result.isDenied) {
				  
			  }
		})
		
	});	

// 상세 검색 구현
let searchForm = $("#searchForm").on("submit", function(event){
	event.preventDefault();
	
	let data = $(this).serialize();
	
	modalClose();
	
	$(".timeTd").css("border", "");
	
	sugangSearchInput.val("");
	
	listBody.find('.nav-link').removeClass('active');
	listBody.find("#listTab3").addClass('active');
   
	listBody.find('.tab-pane').removeClass('active show');
	listBody.find("#listTab3Body").addClass('active show');	
		
	fn_allList(data);
	
	return false;
});
// 단과대 선택하면 그 단과대에 맞는 학과명만 보이게 하기
let deptNo = $("[name=deptNo]");
let colNo = $("[name=colNo]").on("change", function(event) {
   deptNo.val("");
   deptNo.prop('disabled', false);
   
   let col = $(this).val();
   console.log(col);
   deptNo.find("option").not(":first").hide();
   deptNo.find("option").filter(`.\${col}`).show();
})

let listBody = $("#listBody");

// 강의명, 교수명, 강의코드 로 검색 keyup
let sugangSearchInput = $("#sugangSearchInput").on("keyup", function(event) {
	
	let searchFormData = searchForm.serialize();	
	let searchData = $(this).val();
	
	searchFormData += "&searchData=" + searchData;
	
	allListUl.empty();
	
	listBody.find('.nav-link').removeClass('active');
	listBody.find("#listTab3").addClass('active');
   
	listBody.find('.tab-pane').removeClass('active show');
	listBody.find("#listTab3Body").addClass('active show');	
	
	console.log("searchFormData : ", searchFormData);
	
	// keyup 딜레이
    delay(function(){
		fn_allList(searchFormData);
      
    }, 100);
   
})

// keyup 딜레이
let delay = (function(){
	  var timer = 0;
	  return function(callback, ms){
	    clearTimeout (timer);
	    timer = setTimeout(callback, ms);
	  };
})();

//검색 상세 조회 모달
let searchModal = $("#searchModal");
let modalOpen = () => {
   console.log("모달");
   searchModal.show();
   
}
let modalClose = () => {
   searchModal.hide();
}


</script>



