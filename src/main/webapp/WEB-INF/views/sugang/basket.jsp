<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>   
<link rel="stylesheet" href="${cPath }/resources/css/sugang/sugang.css" type="text/css">
<security:authentication property="principal.realUser" var="authMember"/>

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
               <th width="15%" class="text-end align-middle h5">교과구분</th>
               <td colspan="2" width="40%">
                  <select name="subComm" class="form-select searchInput" style="background-color:#f3f5f9;">
                     <option value=""></option>
                        <c:forEach items="${commList }" var="comm">
                          <option value="${comm.commNo }">${comm.commName }</option>
                        </c:forEach>                     
                  </select>
               </td>
               <th width="15%" class="text-end align-middle h5" >학년</th>
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
      <li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
      <li class="breadcrumb-item active" aria-current="page"><a href="${cPath}/sugang/info">수강신청</a></li>
   </ol>
</nav>
<div class="row mx-3 justify-content-between">
   <div class="btn-group col-3" role="group" aria-label="Default button group">
      <a href="${cPath }/sugang/basket" class="btn btn-info">사전수강신청</a>
      <a href="${cPath }/sugang/signup" class="btn btn-info">수강신청</a>
      <a href="${cPath }/sugang/list"  class="btn btn-info">수강신청 내역</a>
   </div>
   <div class="text-white col-4 align-self-center">
      <label class="text-danger">[2023학년도 1학기]</label>
      <label><span>${authMember.memName }</span> 님의 수강신청 가능 학점은 <span class="text-danger">20</span>학점 입니다.</label>
   </div>

</div>

<div class="space m-3 p-5">
   <div id="lectSearchDiv" class="col-md-8 offset-md-2 py-3 mb-3 p-3">
      <form class="searchbox input-group">
         <a href="#" onclick="modalOpen();" class="btn btn-icon btn-xs m-2" id="detailBtn">
            <ion-icon class="fs-1 md hydrated" width="16" height="16"  name="options-outline" role="img" aria-label="options outline"></ion-icon>
         </a>
         <input id="basketSearchInput" class="searchbox__input form-control form-control-lg" type="search" placeholder="강의명, 교수명, 강의코드 검색" aria-label="Search">
         <div class="searchbox__btn-group">
            <a href="#" class="searchbox__btn btn btn-icon shadow-none border-0 btn-sm" type="button">
               <ion-icon name="search-outline"></ion-icon>
            </a>
         </div>
      </form>
      <div class="text-center mt-2">
         <p class="lead"><span id="searchCnt" class="text-info"></span>건의 강의가 조회되었습니다.</p>
      </div>
   </div>
   <div>
   </div>
   <div id="basketDiv">
      <div id="lectDiv" class="m-2">
         <div>
            <p class="lead">신청가능학점 <span id="sugangMaxSubScr" class="text-info">20</span>학점 / 담은학점 <span id="basketSubScr" class="text-info"></span>학점</p>
         </div>
         <hr>
         <div id="lectListDiv" class="overflow-scroll scrollable-content">
         
            <ul id="lectListUl" class="list-group list-group-flush">
<!--                <li class="list-group-item list-group-item-action "> -->
<!--                   <div class=" d-flex w-100 justify-content-between"> -->
<!--                      <p><span class="h6 fw-bold">강의명</span>&nbsp;<span class="small">강의코드</span></p> -->
<!--                      <small> -->
<!--                         <button class="btn">상세보기</button> -->
<!--                         <button class="btn">담기</button> -->
<!--                      </small> -->
<!--                   </div> -->
<!--                   <p><label>교수명</label></p> -->
<!--                   <small><label>학점</label>&nbsp;<label>학년</label>&nbsp;<label>구분</label>&nbsp;<label>교시</label></small> -->
<!--                </li> -->
            </ul>


         </div>
      </div>
      <div id="basketTbDiv" class="m-2">
          <table id="basketTb" class="table table-bordered">
            <tr>
              <th class="wkTh"></th>
              <th class="wkTh">월</th>
              <th class="wkTh">화</th>
              <th class="wkTh">수</th>
              <th class="wkTh">목</th>
              <th class="wkTh">금</th>
              <th class="wkTh">토</th>
            </tr>
            <c:forEach var="i" begin="1" end="13">
              <tr>
                <th class="timeTh">${i}</th>
               <c:forEach step="100" var="j" begin="100" end="600">
                  <td class="timeTd text-center" id="basket${i+j}"></td>
               </c:forEach>
              </tr>
            </c:forEach>
          </table>         
      </div>
   </div>
</div>

<div class="space m-3 p-5">
   <h4 class="card-title">장바구니 내역&nbsp;<span id="basketCnt" class="badge bg-primary">0</span></h4><hr>
   <div id="inBasketDiv" class="">
      <div>
         <table class="inBasket inBasketThead table table-bordered caption-top">
          <caption class="tbCaption">-강의명 클릭 시 상세정보를 볼 수 있습니다.</caption>
           <colgroup>
             <col width="10%"/>
             <col width="30%"/>
             <col width="7%"/>
             <col width="7%"/>
             <col width="15%"/>
             <col width="10%"/>
             <col width="10%"/>
             <col width="10%"/>
           </colgroup>
            <thead>
               <tr>
                  <th>이수구분</th>
                  <th>강의명</th>
                  <th class="text-center">학년</th>
                  <th class="text-center">학점</th>
                  <th class="text-center">대면여부</th>
                  <th class="text-center">정원</th>
                  <th class="text-center">장바구니신청인원</th>
                  <th></th>
               </tr>
            </thead>
         </table>
      </div>
      <div class="inBasket inBasketTbody overflow-scroll scrollable-content">
         <table class="table table-hover">
           <colgroup>
             <col width="10%"/>
             <col width="30%"/>
             <col width="7%"/>
             <col width="7%"/>
             <col width="15%"/>
             <col width="10%"/>
             <col width="10%"/>
             <col width="10%"/>
           </colgroup>
            <tbody id="basketTbody">
            </tbody>
         </table>
      </div>
   </div>

</div>

<script>

   // 상세 검색 구현
   let searchForm = $("#searchForm").on("submit", function(event) {
      event.preventDefault();
      
      let data = $(this).serialize();
      
      // 요일 데이터도 가져가기
//       console.log("요일 : ", $(this).find("[name=ltdDayVal] option:selected").text());
//       let ltdDay = $(this).find("[name=ltdDayVal] option:selected").text();
//        data += "&ltdDay=" + ltdDay;   
//        console.log("요일 포함 data : ", data);
      modalClose();
		
      $(".timeTd").css("border", "");
      
      fn_make_li(data);
      basketSearchInput.val("");

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
      deptNo.find("option").filter(`.\${col}`).show();
   })
   
   let startNum = 0;
   const pCnt = 10; // 몇 개씩

   let searchCnt = $("#searchCnt");
   
   let lectListUl = $("#lectListUl");
   
   let fn_make_li = (data) =>{
      // 데이터(검색어) 받아서 가기
      $.ajax({
         method:"post",
         url: "${cPath}/sugang/basket/lectures",
         data: data,
         dataType: "json",
//          contentType: "application/json; charset=UTF-8",
         success: function(resp){
        	 lectList = resp;
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
             $(`#basket\${td}`).css("border", "2px solid red");
      })      
         
   });
   $(document).on("mouseout", ".lect-li", function (e) {
	   let arr = $(this).data("lectTime");
	   arr = String(arr);
	   arr = arr.split(",");
	   $.each(arr, function(idx, td){
//               $(`#\${td}`).css("background", "none");
			$(`#basket\${td}`).css("border", "");
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
      url: "${cPath}/sugang/basket/lecture/"+lectNo,
      method:"post",
      dataType:"json",
      success: function(resp){
//          모달 값 지우기
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
//    console.log("lectInfoBtn : ", this);
   console.log($(this).parents("li").data("lectNo"));
   
   let lectNo = $(this).parents("li").data("lectNo");
   
   fn_lectInfo(lectNo);
   
})

// 장바구니 담기
let insertBtn = $(document).on("click", "#insertBtn", function () {
	
   console.log($(this).parents("li").data("lectNo"));
   let lectNo = $(this).parents("li").data("lectNo");
   
   // 장바구니 담은 학점이 신청 가능 학점 초과했는지 체크
   let maxSubScr = parseInt(sugangMaxSubScr.text());
   let nowSubScr = parseInt(basketSubScr.text());
   let subScr = $(this).parents("li").data("subScr");
   
	if(maxSubScr < subScr + nowSubScr){
		Swal.fire("신청 가능 학점을\n 초과할 수 없습니다.");	
		return;
	}   
   
   // 시간 중복 강의 제외 
    let arr = $(this).parents("li").data("lectTime");
    arr = String(arr);
    arr = arr.split(",");
    console.log("arr : ", arr);
    
    let isEmpty = true;
    $.each(arr, function(idx, td){
       console.log($(`#basket\${arr[idx]}`).css("background-color"));
       if($(`#basket\${arr[idx]}`).css("background-color")!="rgba(0, 0, 0, 0)"){
          console.log("색있음");
          isEmpty = false;
       }
       
    })    
    if(!isEmpty){
       Swal.fire("시간이 중복되거나 동일한 강의는\n 담을 수 없습니다.");
       return;
    }
//    let insertBtn = $(this);
   
   $.ajax({
      url: "${cPath}/sugang/basket/insert.do",
      method:"post",
      data: {"lectNo" : lectNo},
      success: function(resp){
         console.log(resp);
         
         let message = "";
         if(resp=="OK") message = "장바구니에 담았습니다.";
         else if(resp=="FAIL")  message = "잠시후 다시 시도하세요.";
         else  message = "이미 장바구니에 존재합니다.";
         
         Swal.fire(message);
         
         // 색칠하는거 실행
         fn_color();      
      }      
   })
});

let sugangMaxSubScr = $("#sugangMaxSubScr"); // 최대 신청 학점
let basketSubScr = $("#basketSubScr"); // 장바구니 담은 학점
let basketCnt = $("#basketCnt"); // 장바구니 담은 개수
let basketTbody = $("#basketTbody");
const colorList = ["#ffcccc", "#BEF5BE", "#FEA47F", "#F8EFBA", "#D6A2E8", "#EAB543", "#55E6C1", "#A4C3FF", "#FFE4B5"];
let fn_color = () =>{
   basketTbody.empty();

   $(".timeTd").empty();
   $(".timeTd").css("background", "none");
//    $(".timeTd").css("border", "1px solid #f2f2f2");
   
   $.ajax({
      url:"${cPath}/sugang/basket/list",
      method:"post",
      dataType:"json",
      success:function(data){
         basketList = data;
         console.log("장바구니 담은 강의 리스트 : ", basketList);
         
         let basketSubScrSum = 0;
         let   cnt = basketList.length;
         
         let trTags = [];
         if(basketList.length > 0){
            $.each(basketList, function(idx, basket){
               let lect = basket.lecture;
               basketSubScrSum += lect.subScr;
               
               // 장바구니 리스트 테이블에 tr 추가
               trTags.push(fn_makeTr(basket));
               
               // 장바구니에 담은 과목 색칠하기
               console.log("basket : ", basket);
               let color = colorList[idx%10];
               console.log("color : ", color);
               
               let lectName = lect.lectName;
               let arr = lect.lectDetailList;
               
               $.each(arr, function(i, lt){
                  let td = lt.ltdNo;
                  console.log("강의 추가 색칠 td : ", td, $(`#basket\${td}`));
                  $(`#basket\${td}`).css("background-color", color);
                  $(`#basket\${td}`).html(`<small>\${lectName}</small>`);
               });
               
            })
            
         }else{
               trTags.push($("<tr>").html($("<td colspan='8'>").html("장바구니 내역이 없습니다.")));
            
         }
         basketSubScr.text(basketSubScrSum);
         basketCnt.text(cnt);
         
         basketTbody.append(trTags);
      }
   });
}
fn_color();

let fn_makeTr = (basket) =>{
   // 장바구니 내역 tr 누르면 강의 상세 정보 모달 띄우기
   let lect = basket.lecture;
   let trTag = $("<tr>").append(
      $("<td>").html(lect.subCommName)
      , $("<td>").html(`<a href='javascript:fn_lectInfo(\${basket.lectNo});'>`+lect.lectName+`</a>`)
      , $("<td class='text-center'>").html(lect.subGrade)
      , $("<td class='text-center'>").html(lect.subScr)
      , $("<td class='text-center'>").html(lect.lectOnfName)
      , $("<td class='text-center'>").html(lect.lectMm)
      , $("<td class='text-center'>").html(basket.basketNum)
      , $("<td>").html("<input id='basketDeleteBtn' class='btn btn-outline-light' type='button' value='삭제'>")
   ).data("lectNo", basket.lectNo).data("basketNo", basket.basketNo);
   
   return trTag;
}

// 강의명, 교수명, 강의코드 로 검색 keyup
let fn_search_basketList = (searchData) =>{
//    searchForm 검색조건 가져가야 함.
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

let basketSearchInput = $("#basketSearchInput").on("keyup", function(event) {
   let searchData = $(this).val();
   fn_search_basketList(searchData);
})

// 장바구니 삭제하는 버튼 기능 구현
let deleteBtn = $(document).on("click", "#basketDeleteBtn", function (event) {
   let basketNo = $(this).parents("tr").data("basketNo");
   console.log("delete basketNo : ", basketNo);
   
   $.ajax({
      url: "${cPath}/sugang/basket/delete.do",
      method:"post",
      data: {"basketNo" : basketNo},
      success: function(resp){
         console.log(resp);
         
         let message = "";
         if(resp=="OK") message = "삭제되었습니다.";
         else if(resp="NOTFOUND") message = "강의를 찾을 수 없습니다.";
         else message = "잠시후 다시 시도하세요.";
         
         Swal.fire(message);
         
         // 색칠하는거 실행
         fn_color();      
      }      
   })   
   
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
</script>



