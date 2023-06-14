//gridStackDiv 선택----------------------------------------------
const gridStackDiv = document.querySelector('#gridStackDiv');
//jsp cPath----------------------------------------------
const cPath = document.querySelector('#cPath').value;
//jsp memRole----------------------------------------------
const memRole = document.querySelector('#memRole').value;
//jsp memNo----------------------------------------------
const memNo = document.querySelector('#memNo').value;

//jsp colNo----------------------------------------------
let colNo = null;
let deptNo = null;
if(memRole != 'ROLE_EMP'){
    colNo = document.querySelector('#colNo').value;
//jsp deptNo----------------------------------------------
    deptNo = document.querySelector('#deptNo').value;
}
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
//리스트 관련 선택-----------------------------------------
let listBody = $("#listBody");
let reqListBody = $("#reqListBody");
let SubjectWaitingListBody = $("#SubjectWaitingListBody");
let viewUrl = listBody.data("viewUrl");
//시큐리티-------------------------------------------------
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');
//-------------------------------------------------------
//화면 로딩 완료후 시작 이벤트리스너------------------------
document.addEventListener("DOMContentLoaded", () => {
  getSubjectList();
  getFavorites();
  getSuggestions();
  getJobSubjectList();
  $("#AllSubjectListBtn").click();
  pieChart();
  selectLectureWeekPlanList();
  selectLectureTimePlaceList();
  selectLectureRoomList();
});
//-------------------------------------------------------
//리스트 출력=====================================================================================
//리스트 생성 함수--------------------------------------------------------------------------------
let fn_makeSubListTr = (pStart,subjectList)=>{
    if(subjectList == null){
        subjectList = JSON.parse(localStorage.getItem('subjectList'));
    }

    let endNum = pStart + pCnt;
    if(endNum > subjectList.length){
        endNum = subjectList.length;
    }

    let trTags = [];
    for(let i=pStart; i < endNum; i++){
        let subject = subjectList[i];
            let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${subject.subNo}')`)
            .html(subject.subName);
            let tr = $("<tr>").append(
                    $("<td>").html(subject.rnum)		
                    , $("<td>").html(subject.colName)		
                    , $("<td>").html(subject.deptName)		
                    , $("<td>").html(aTag)		
                    , $("<td>").html(subject.subCommName)	
                    ,(empNo!=null || proNo!=null)?$("<td>").html(subject.subStateName): null		
                ).addClass("subjectTr").data("subject", subject);
                trTags.push(tr);
    }
    listBody.append(trTags);
}
//-----------------------------------------------------------------------------------------------
//--교과목리스트-----------------------------------------------------------------------------------------
let getSubjectList = () => {
        let url = `${cPath}/subject/subjectManagement.do`
        let method = 'GET';
        $.ajax({
            url : url,
            method : method,
            dataType : "json"
        }).done(function(resp, textStatus, jqXHR) {
            if(memRole == "ROLE_EMP"){
            reqListBody.empty();
            startSubjectCheckNum = 0;
            subjectCheckTemp = [];
            }

            listBody.empty();
            startSubjectNum = 0;
            subjectTemp = [];

            if(memRole == "ROLE_PRO"){
            SubjectWaitingListBody.empty();
            startSubjectWaitingNum = 0;
            SubjectWaitingTemp = [];
            }

            console.log(resp);
            let subjectCompleteList = []; // 이건 교수, 교직원, 학생
            let subjectWaitingList = []; // 이건 교수가 보는 것.
            let subjectCheckList = []; // 이건 교직원.

            for(let i =0; i < resp.length; i++) {
                let subject = resp[i];
                if(subject.subState == 'B001'){
                    subjectCheckList.push(subject);
                }

                if(subject.subState == 'B002'){
                    subjectCompleteList.push(subject);
                }else{
                    if(subject.deptNo == deptNo){
                        subjectWaitingList.push(subject); 
                    }
                }
            }

            localStorage.setItem("subjectList", JSON.stringify(subjectCompleteList));
            localStorage.setItem("subjectWaitingList", JSON.stringify(subjectWaitingList));
            localStorage.setItem("subjectCheckList", JSON.stringify(subjectCheckList));

            fn_makeSubListTr(startSubjectNum);
            if(memRole == "ROLE_EMP") fn_makeSubjectCheckListTr(startSubjectCheckNum);
            if(memRole == "ROLE_PRO") fn_makeSubjectWaitingListTr(startSubjectWaitingNum);
        });
}

if(!localStorage.getItem("subjectList")){ // 여기서 여러개를 체크해야하나?
    getSubjectList();
}
//------------------------------------------------------------------------------------------------------
//교과목리스트에서 검색
let selectSubjectListInput = $("#selectSubjectListInput");
let searchSubjectListInput = $("#searchSubjectListInput");
let startSubjectNum = 0;
let subjectTemp = [];

let searchSubjectList = (searchData) => {
    if(searchData.length == 0 || searchData == null){
        listBody.empty();
        startSubjectNum = 0;
        subjectTemp = [];
        fn_makeSubListTr(startSubjectNum);
        return;
    }
    subjectTemp = [];
    let dataList = JSON.parse(localStorage.getItem("subjectList"));
    let searchOption = selectSubjectListInput.val();

    $.each(dataList, (idx, subject)=>{
        let subName ="";
        if(searchOption != "all"){
            subName = subject[searchOption];
            console.log(subject[searchOption]);
            if(subName.indexOf(searchData)!=-1){
                subjectTemp.push(subject);
            }
        }else{
            subName = subject.subName;
            if(subName.indexOf(searchData)!=-1){
                subjectTemp.push(subject);
            }
        }
     
    });
    listBody.empty();
    startSubjectNum = 0;

    fn_makeSubListTr(startSubjectNum,subjectTemp);
}

searchSubjectListInput.on('keyup',()=>{
    let searchData = searchSubjectListInput.val();
    searchSubjectList(searchData);
})
//-------------------------------------------------------------------------------------------
// 교과목리스트 무한스크롤 subjectListDiv
const subjectListDiv = document.querySelector("#subjectListDiv");
subjectListDiv.addEventListener("scroll", () =>{
    console.log("체킁리스틍: 발생했나?")
    let scrollTop = subjectListDiv.scrollTop;
    let clientHeight = subjectListDiv.clientHeight;
    let scrollHeight = subjectListDiv.scrollHeight;

    if((scrollTop + clientHeight) > (scrollHeight - 30)){
        startSubjectNum += 5;
        console.log("pppp");
        console.log(startSubjectNum);
        console.log("temp:",subjectTemp);
        if(subjectTemp.length > 0){
            fn_makeSubListTr(startSubjectNum,subjectTemp);
        }else{
            fn_makeSubListTr(startSubjectNum);
        }
    }

});

//-------------------------------------------------------------------------------------------
//교과목 요청 리스트====================================================================================
//요청 리스트 생성 함수--------------------------------------------------------------------------------
let fn_makeSubjectCheckListTr = (pStart,subjectCheckList)=>{
    if(subjectCheckList == null){
        subjectCheckList = JSON.parse(localStorage.getItem('subjectCheckList'));
    }

    let endNum = pStart + pCnt;
    if(endNum > subjectCheckList.length){
        endNum = subjectCheckList.length;
    }

    let trTags = [];
    for(let i=pStart; i < endNum; i++){
        let subject = subjectCheckList[i];
            // let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${subject.subNo}')`)
            // .html(subject.subName);
            let tr = $("<tr>").append(
                    $("<input>").attr("type", "hidden").attr("id","checkSubNo").val(subject.subNo)
                    , $("<td>").html(subject.rnum)		
                    , $("<td>").html(subject.colName)		
                    , $("<td>").html(subject.deptName)		
                    // , $("<td>").html(aTag)		
                    , $("<td>").html(subject.subName)		
                    , $("<td>").html(subject.subCommName)	
                    ,(empNo!=null || proNo!=null)?$("<td>").html(subject.subStateName): null
                    // ,$("<button>").addClass("btn btn-outline-dark subjectProcessBtn").attr("style","--bs-btn-padding-y: .200rem; --bs-btn-padding-x: .100rem; --bs-btn-font-size: .100rem;" ).text("상세보기")		
                ).addClass("subjectCheckTr subjectProcessBtn").data("subjectCheck", subject);
                trTags.push(tr);
    }
    reqListBody.append(trTags);
}
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//요청 교과목리스트에서 검색
let selectsubjectCheckListInput = $("#selectsubjectCheckListInput");

let searchsubjectCheckListInput = $("#searchsubjectCheckListInput");
let startSubjectCheckNum = 0;
let subjectCheckTemp = [];

let searchsubjectCheckList = (searchData) => {
    if(searchData.length == 0 || searchData == null){
        reqListBody.empty();
        startSubjectCheckNum = 0;
        subjectCheckTemp = [];
        fn_makeSubjectCheckListTr(startSubjectCheckNum);
        return;
    }
    subjectCheckTemp = [];
    let dataList = JSON.parse(localStorage.getItem("subjectCheckList"));

    let searchOption = selectsubjectCheckListInput.val();

    $.each(dataList, (idx, subject)=>{
        let subName ="";

        if(searchOption != "all"){
            subName = subject[searchOption];
            console.log(subject[searchOption]);
            if(subName.indexOf(searchData)!=-1){
                subjectCheckTemp.push(subject);
            }
        }else{
            subName = subject.subName;
            if(subName.indexOf(searchData)!=-1){
                subjectCheckTemp.push(subject);
            }
        }
        
    });
    reqListBody.empty();
    startSubjectCheckNum = 0;

    fn_makeSubjectCheckListTr(startSubjectCheckNum,subjectCheckTemp);
}

searchsubjectCheckListInput.on('keyup',()=>{
    let searchData = searchsubjectCheckListInput.val();
    searchsubjectCheckList(searchData);
})
//-------------------------------------------------------------------------------------------
//요청 교과목리스트 무한스크롤 subjectCheckListDiv
if(memRole == "ROLE_EMP"){
const subjectCheckListDiv = document.querySelector("#subjectCheckListDiv");
subjectCheckListDiv.addEventListener("scroll", () =>{
    console.log("체킁리스틍: 발생했나?")
    let scrollTop = subjectCheckListDiv.scrollTop;
    let clientHeight = subjectCheckListDiv.clientHeight;
    let scrollHeight = subjectCheckListDiv.scrollHeight;

    if((scrollTop + clientHeight) > (scrollHeight - 30)){
        startSubjectCheckNum += 5;
        console.log("pppp");
        console.log(startSubjectCheckNum);
        console.log("temp:",subjectCheckTemp);
        if(subjectCheckTemp.length > 0){
            fn_makeSubjectCheckListTr(startSubjectCheckNum,subjectCheckTemp);
        }else{
            fn_makeSubjectCheckListTr(startSubjectCheckNum);
        }
    }

});
}

//===========================================================================================

//상세조회====================================================================================
let subjectViewModal = $("#subjectViewModal");

let subjectViewModalOpen = () => { // 모달 보여줌
	subjectViewModal.show();
}
let subjectViewModalClose = () => { // 모달 닫음
	subjectViewModal.hide();
    $("#subjectViewModalBody").text("");
}
//상세조회-------------------------------------------------
let fn_subjectDetail = (subNo) =>{
  let xhr = new XMLHttpRequest();
  // 글씨랑 같이 쓰면서 스크립트의 데이터를 쓸때 백틱을 씀. 스크립트데이터는 ${} 탬플릿리터럴을 사용함.
  xhr.open("GET", `${cPath}/subject/subjectView.do?what=${subNo}`, true);
  xhr.onreadystatechange = () => {
    if(xhr.readyState == 4 && xhr.status == 200){
      let subject = JSON.parse(xhr.responseText);
      
      createSubjectView(subject);
      subjectViewModalOpen();

    }
  }
  xhr.send();
  
}
//상세 조회 테이블 생성-------------------------------------------
let createSubjectView= (subject)=> {
   // 폼 생성
   let updateSubjectForm = document.createElement("form");
   updateSubjectForm.id = 'updateSubjectForm';
   updateSubjectForm.method = 'POST';

   //csrf token 숨기기
   let csrfToken = document.createElement("input");
   csrfToken.type = 'hidden';
   csrfToken.value = headerValue;
   csrfToken.name = paramName;
   updateSubjectForm.appendChild(csrfToken);

  // 테이블 생성
  let table = document.createElement('table');
  table.className = 'table table-hover text-center';

  // hidden tag (교과목번호 추가)
  let hiddenTag = document.createElement('input');
  hiddenTag.type = 'hidden';
  hiddenTag.name = 'subNo';
  hiddenTag.value = subject.subNo;
  table.appendChild(hiddenTag);


  // thead 생성
  let thead = document.createElement('thead');
  table.appendChild(thead);

  // TR 생성
  let tr = document.createElement('tr');
  thead.appendChild(tr);

  // TH 생성
  let th1 = document.createElement('th');
  th1.setAttribute('colspan', '3');
  th1.setAttribute('width', '80%');
  let h5 = document.createElement('h5');
  h5.innerText = '교과목 상세 정보';
  h5.setAttribute('class', 'fs-2');
  th1.appendChild(h5);
  tr.appendChild(th1);

  // TD2 생성
  let td2 = document.createElement('th');
  td2.setAttribute('colspan', '1');
  tr.appendChild(td2);

  // 즐겨찾기 버튼생성
  let favoriteButton = document.createElement('button');
  favoriteButton.className = 'btn btn-sm btn-icon btn-hover btn-white shadow-none';
  favoriteButton.setAttribute = ('id','favoriteBtn');
  favoriteButton.type = 'button';
  td2.appendChild(favoriteButton);

  // 즐겨찾기 아이콘추가
  let favoriteIonIcon = document.createElement('ion-icon');
  favoriteIonIcon.id = 'favorite';
  favoriteIonIcon.setAttribute('name','star-outline');
  //로컬스토리지 값 비교. 별 체크
  let favorites =  JSON.parse(localStorage.getItem("favorites"));

  for(let i = 0; i < favorites.length; i++){
      let favorite = favorites[i];
        if(favorite.subNo === subject.subNo){
            favoriteIonIcon.setAttribute('name','star');
            break;
          }else{
            favoriteIonIcon.setAttribute('name','star-outline');
      
        }
  }
  favoriteIonIcon.style.fontSize = '20px';
  favoriteIonIcon.style.color = 'orange';
  favoriteButton.appendChild(favoriteIonIcon);
  
  // tbody 생성
  let tbody = document.createElement('tbody');
  tbody.id = 'detailSubject';
  table.appendChild(tbody);

  

    // tbody에 데이터 꽂아버리기
    tbody.appendChild(createTableRow("교과목명",subject.subName,"subName"));
    tbody.appendChild(createTableRow("단과대학명",subject.colName,"colName"));
    tbody.appendChild(createTableRow("학과명",subject.deptName,"deptName"));
    tbody.appendChild(createTableRow("교과목유형명",subject.subCommName,"subCommName"));
    tbody.appendChild(createTableRow("학년",subject.subGrade,"subGrade"));
    tbody.appendChild(createTableRow("시수",subject.subHours,"subHours"));
    tbody.appendChild(createTableRow("학점",subject.subScr,"subScr"));
    // tbody.appendChild(createTableRow("교과목설명",subject.subExp,"subExp"));
    // 교과목 설명 따로 만들기.--------------------------------------------------------------
    let myTrSub = document.createElement("tr");
    let myThSub = document.createElement("th");
    myThSub.setAttribute('width', '20%');
    myThSub.textContent = "교과목설명";
    myTrSub.appendChild(myThSub);
  
    let myTdSub = document.createElement("td");
    myTdSub.setAttribute('colspan', '3');
    let myInputSub = document.createElement("textArea");
    myInputSub.setAttribute('class', 'form-control overflow-scroll scrollable-content');
    myInputSub.setAttribute('style', 'background-color:#f3f5f9; width:100%; resize: none;');
    if((memRole == 'ROLE_PRO' && "subExp" == "colName") ||
       (memRole == 'ROLE_PRO' && "subExp" == "deptName") ||
       (memRole == 'ROLE_PRO' && "subExp" == "subCommName")
    ) {
      myInputSub.setAttribute('disabled', 'disabled');
    }
    if(memRole != 'ROLE_PRO') {
      myInputSub.setAttribute('disabled', 'disabled');
    }
    // myInputSub.setAttribute('value', subject.subExp);
    myInputSub.textContent = subject.subExp;
    myInputSub.setAttribute('name', "subExp");
  
    myTdSub.appendChild(myInputSub);
    myTrSub.appendChild(myTdSub);
    tbody.appendChild(myTrSub);
    

	


  // tfoot 생성
  let tfoot = document.createElement('tfoot');
  table.appendChild(tfoot);

  // TR tfoot
  let tfootTr = document.createElement('tr');
  tfoot.appendChild(tfootTr);

  // TD tfoot TR
  let tfootTd = document.createElement('td');
  tfootTd.setAttribute('colspan', '4');
  tfootTr.appendChild(tfootTd);

  // Create span inside the TD
  let btnSpace = document.createElement('span');
  btnSpace.className = 'btnSpace';
  tfootTd.appendChild(btnSpace);

  if(memRole == 'ROLE_PRO') {
    let modifySubjectBtn = document.createElement('button');
    modifySubjectBtn.setAttribute('type','button');
    modifySubjectBtn.setAttribute('id','modifySubjectBtn');
    modifySubjectBtn.setAttribute('class','btn btn-secondary');
    modifySubjectBtn.textContent = '수정';
    btnSpace.appendChild(modifySubjectBtn);

    let removeSubjectBtn = document.createElement('button');
    removeSubjectBtn.setAttribute('type','button');
    removeSubjectBtn.setAttribute('id','removeSubjectBtn');
    removeSubjectBtn.setAttribute('class','btn btn-danger');
    removeSubjectBtn.textContent = '삭제';
    btnSpace.appendChild(removeSubjectBtn);

  }


  //잠시 들리는 div
  let momentDiv = document.createElement('div');
  //테이블을 폼태그에 넣기
  updateSubjectForm.appendChild(table);
  //모달에 넣기.
  $("#subjectViewModalBody").append(updateSubjectForm);
//   momentDiv.appendChild(updateSubjectForm);
//   let jebal = momentDiv.innerHTML;

//   console.log(jebal);

}
//테이블 로우 생성
let createTableRow= (thValue, tdValue , inputName) =>{
  let myTr = document.createElement("tr");
  let myTh = document.createElement("th");
  myTh.setAttribute('width', '20%');
  myTh.textContent = thValue;
  myTr.appendChild(myTh);


  let myTd = document.createElement("td");
  myTd.setAttribute('colspan', '3');
  let myInput = document.createElement("input");
  myInput.setAttribute('type', 'text');
  myInput.setAttribute('class', 'form-control');
  myInput.setAttribute('style', 'background-color:#f3f5f9; width:100%;');
  if((memRole == 'ROLE_PRO' && inputName == "colName") ||
     (memRole == 'ROLE_PRO' && inputName == "deptName") ||
     (memRole == 'ROLE_PRO' && inputName == "subCommName")
  ) {
    myInput.setAttribute('disabled', 'disabled');
  }
  if(memRole != 'ROLE_PRO') {
    myInput.setAttribute('disabled', 'disabled');
  }
  myInput.setAttribute('value', tdValue);
  myInput.setAttribute('name', inputName);

  myTd.appendChild(myInput);
  myTr.appendChild(myTd);

  return myTr;
}

//--------------------------------------------------------
//===========================================================================================
//교과목 등록 그리드 생성======================================================================
//등록 폼 생성---------------------------------------------
let fn_CreateSubjectInsert = () =>{
  let SubjectFormDiv = `
  <div>
                <form method="post" name="insertForm" id="subjectInsertForm">
                    <input type="hidden" name="${paramName}" value="${headerValue}"/>
                    <input type="hidden" name="deptNo" value="${deptNo}"/>
                    <input type="hidden" name="colNo" value="${colNo}"/>

                    <div class="row mb-3">
                        <label>교과목명</label>
                        <div class="col-sm-8 col-xl-12">
                            <input name="subName" id="_dm-wStepUsername" type="text" style="width:100%; background-color:#f3f5f9;" class="form-control">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label>교과목유형</label>
                        <div class="col-sm-8 col-xl-12">
                            <select name="subComm" class="form-select" style="width:100%; background-color:#f3f5f9;">
                                <option value="A001">전공필수</option>
                                <option value="A002">전공선택</option>
                                <option value="A003">전공심화</option>
                                <option value="A004">교양필수</option>
                                <option value="A005">교양선택</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label>학년</label>
                        <div class="col-sm-8 col-xl-12">
                            <select name="subGrade" class="form-select" style="width:100%; background-color:#f3f5f9;" >
                                <option value="1">1학년</option>
                                <option value="2">2학년</option>
                                <option value="3">3학년</option>
                                <option value="4">4학년</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label>학점</label>
                        <div class="col-sm-8 col-xl-12">
                            <select name="subScr" class="form-select" style="width:100%; background-color:#f3f5f9;" >
                                <option value="1">1학점</option>
                                <option value="2">2학점</option>
                                <option value="3">3학점</option>
                            </select>
                        </div>
                    </div>


                        <div class="row mb-3">
                            <label>시수</label>
                            <div class="col-sm-8 col-xl-12">
                                <select name="subHours" class="form-select" style="width:100%; background-color:#f3f5f9;" >
                                    <option value="1">1시간</option>
                                    <option value="2">2시간</option>
                                    <option value="3">3시간</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label>교과목설명</label>
                            <div class="col-sm-8 col-xl-12">
                                <textarea name="subExp" class="form-control" style="width:100%; resize: none; background-color:#f3f5f9;" ></textarea>
                            </div>
                        </div>
                        <div class="text-center">
                            <input type="button" class="btn btn-primary" id="check22" value="요청">
                            <input type="button" class="btn btn-primary" id="autoSubject" value="자동완성">
                        </div>
                </form>
    </div>
  `
  $("#subjectViewModalBody").html(SubjectFormDiv);
  subjectViewModalOpen();

   
}

//------------------------------------------------------------------------------------------

//자동 완성
$(document).on('click', '#autoSubject', ()=>{
    $("[name='subName']").val("컴퓨터공학기초");
    $("[name='subComm']").val("A001");
    $("[name='subGrade']").val("1");
    $("[name='subScr']").val("3");
    $("[name='subHours']").val("3");
    $("[name='subExp']").text("컴퓨터 공학에 대한 기초를 배운다.");

})
 //교과목등록요청---------------------------------------------------------------------------------
    $(document).on("click",'#check22',function(event){
        //event.preventDefault(); subjectInsertForm

        let formData = $("#subjectInsertForm");
        let url = `${cPath}/subject/subjectInsert.do`;

        let data = formData.serialize(); //$('#myForm').serialize(); 이런느낌.
        console.log(data);
        console.log(url);
        $.ajax({
            url : url,
            method : "post",
            data : data,
            dataType : "json" ,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
                }
        }).done(function(resp, textStatus, jqXHR) {
            console.log("체킁: ",resp);
            
            if(resp > 0){
                Swal.fire({title:"성공했습니다."});
                getSubjectList();
                subjectViewModalClose();
            }else{
                Swal.fire({title:"실패했습니다."});
            }
        });
    });
//------------------------------------------------------------------------------------------
      
//즐겨찾기-------------------------------------------------
$(document).on("click", "#favorite", function(event) {
    console.log(event);
    // $(event);

    let favorite = $(this);
    // let sub = $(this).parents("table").find("#detailSubject").find("td:first-child").val();
    let sub = $(this).parents("table").find("[name='subNo']").val();
   
    if(favorite.attr("name") == "star"){
        favorite.attr("name","star-outline");
        // 즐겨찾기 삭제
        console.log(sub);
        let data = {subNo : sub , memNo : memNo};
        $.ajax({
            url : `${cPath}/favorite/favoriteDelete.do`,
            method : "POST",
            data : JSON.stringify(data),
            dataType : "json",
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp>0){
                Swal.fire({title:"즐겨찾기에서 삭제했습니다."});
                getFavorites();
            }else{
                Swal.fire({title:"즐겨찾기 삭제에 실패했습니다."});
            }
        })

    }else if(favorite.attr("name") == "star-outline"){
        favorite.attr("name","star");
        let data = {subNo : sub , memNo : memNo};
        // 즐겨찾기 추가
        console.log(sub);
        $.ajax({
            url : `${cPath}/favorite/favoriteInsert.do`,
            method : "POST",
            data : JSON.stringify(data),
            dataType : "json",
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp>0){
                Swal.fire({title:"즐겨찾기에 추가했습니다."});
                getFavorites();
            }else{
                Swal.fire({title:"즐겨찾기 등록에 실패했습니다."});
            }
        })
        
    }


});
//-------------------------------------------------------------------------------------------
//즐겨찾기 리스트 ----------------------------------------------------------------------------
// 검색 input태그 체크
let searchFavoriteSubjectInput = $("#searchFavoriteSubjectInput");
// Tbody 선택
let favoritesTbody = $("#favorites");

// 로컬스토리지에 저장 함수. 
let getFavorites = () =>{
    $.ajax({
        url : `${cPath}/favorite/favorites.do`
        , method : 'get'
        , dataType : 'json'
        , success : (resp) => {
            favoritesTbody.empty();
            startNum = 0;
            temp = [];

            console.log("체체킁~");
            console.log(resp);
            localStorage.setItem("favorites", JSON.stringify(resp)); //리스트에 데이터가 추가 될 때마다 setItem 해주어야함.
            fn_makeFavorite(startNum);
        }

    })
}

//로컬스토리지에 즐겨찾기리스트 저장 실행
if(!localStorage.getItem("favorites")){
    getFavorites();
}
//검색 리스트 저장.
let temp = [];

// localStorage에서 favorites 가져와서 바디 만드는 함수.
let fn_makeFavorite = (pStart,dataList) =>{
    // 데이터리스트에 값을 안주면, 로컬스토리지에서 꺼내오기
    if(dataList == null){
        dataList = JSON.parse(localStorage.getItem("favorites"));
    }
    //종료 조건
    let endNum = pStart + pCnt;
    if(endNum > dataList.length){
        endNum = dataList.length;
    }

    // 정해진 숫자(pStart)만큼 페이지에 띄우기.
    let trTags = [];
    for(let i=pStart; i < endNum; i++) {
        let favorite = dataList[i];
        let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${favorite.subNo}')`)
        .html(favorite.subName);
        let tr = $("<tr>").append(
                    $("<td>").html(favorite.rnum)		
                    , $("<td>").html(favorite.deptName)		
                    , $("<td>").html(aTag)		
                    , $("<td>").html(favorite.subCommName)	
                    , $("<td>").html(favorite.subGrade)	
                    , $("<td>").html(favorite.subScr)	
                    , $("<td>").html(favorite.subHours)	
                ).addClass("favoriteTr").data("favorite", favorite);
            trTags.push(tr);
    }
    favoritesTbody.append(trTags);
    //.empty()
}

let startNum = 0;
const pCnt = 5; // 몇개씩?


let searchFavoriteSubject = (searchData)=>{
    if(searchData.length == 0 || searchData == null){
        favoritesTbody.empty();
        startNum = 0;
        temp = [];
        fn_makeFavorite(startNum);
        return;
    }
    // let result = [];
    temp = [];
    let dataList = JSON.parse(localStorage.getItem("favorites"));
    $.each(dataList,(idx, favorite)=>{
        let subName = favorite.subName;
        console.log("쳌쳌");
        console.log(dataList);
        console.log(favorite);
        console.log(subName);
        if(subName.indexOf(searchData)!=-1){
            // result.push(favorite);
            // 임시저장소.
            temp.push(favorite);
        }
    });
    favoritesTbody.empty();
    startNum = 0;

    fn_makeFavorite(startNum, temp);
    // fn_makeFavorite(startNum, result);
}

// 검색 keyup
searchFavoriteSubjectInput.on('keyup', () =>{
    let searchData = searchFavoriteSubjectInput.val();
    searchFavoriteSubject(searchData);
})
//-------------------------------------------------------------------------------------------------------
// [엉터리] 무한 스크롤
// 무한 스크롤 구현 div
const favoritesDiv = document.querySelector("#favoritesDiv");
favoritesDiv.addEventListener("scroll", () =>{
    console.log("체킁: 발생했나?")
    let scrollTop = favoritesDiv.scrollTop;
    let clientHeight = favoritesDiv.clientHeight;
    let scrollHeight = favoritesDiv.scrollHeight;

    if((scrollTop + clientHeight) > (scrollHeight - 30)){
        startNum += 5;
        console.log("pppp");
        console.log(startNum);
        console.log("temp:",temp);
        if(temp.length > 0){
            fn_makeFavorite(startNum,temp);
        }else{
            fn_makeFavorite(startNum);
        }
    }

});

//-------------------------------------------------------------------------------------------
//교과목 대기 전체 승인========================================================================
let fn_SubjectOKAll = () =>{
    $.ajax({
        url : `${cPath}/subject/subjectOKAll.do`,
        method : 'get',
        dataType : 'json'
    }).done((resp)=>{ // 프로미스 객체를 반환 jQuery 3.0 이상버전만 가능. success대신 done을 쓰자.
        if(resp>0){
            Swal.fire({title:"전체 승인되었습니다."});
            getSubjectList();
            return;
        }else{
            Swal.fire({title:"승인할 교과목이 없거나 에러가 발생했습니다."});
        }

    })
}
//===========================================================================================
//교과목 수정=================================================================================
$(document).on('click','#modifySubjectBtn', (event)=>{
    let target = event.target;
    console.log(target);
    let formData = $(target).parents('#updateSubjectForm');
    let url = `${cPath}/subject/subjectUpdate.do`;
    let data = formData.serialize();
    console.log(data);
    
    $.ajax({
        url: url,
        method: "POST",
        data : data,
        dataType : "json",
        beforeSend : function(xhr){
            xhr.setRequestHeader(header, token);
        }
    }).done((resp)=>{
        if(resp > 0){
            Swal.fire({title:"업데이트를 성공했습니다."});
            getSubjectList();
            getFavorites();
            subjectViewModalClose();
        }else{
            Swal.fire({title:"업데이트에 실패했습니다."});
        }
    })
})



//===========================================================================================
//교과목 삭제=====fn_removeSubject()=================================================낼 바꿔야함.
$(document).on('click','#removeSubjectBtn',(event)=>{
    let target = event.target;
    let subNo = $(target).parents("#updateSubjectForm").find('input[name="subNo"]').val();
    console.log("폼데이터체킁:",subNo);
    $.ajax({
        url: `${cPath}/subject/subjectDelete.do`,
        method: "POST",
        data : {what : subNo},
        dataType : "json"
    }).done((resp)=>{
        if(resp  >0){
            Swal.fire({title:"삭제에 성공했습니다."});
            getSubjectList();
            getFavorites();
            subjectViewModalClose();
        }else{
            Swal.fire({title:"삭제에 실패했습니다."});
        }
        })
})
//===========================================================================================
//교과목 처리 모달============================================================================

let subjectProcessModal = $("#subjectProcessModal");
let subjectProcessTBody = $("#subjectProcessTBody");

let subjectProcessModalOpen = () => { // 모달 보여줌
	subjectProcessModal.show();
}
let subjectProcessModalClose = () => { // 모달 닫음
	subjectProcessModal.hide();
    subjectProcessTBody.text("");
    $("#subjectProcessForm")[0].reset();

}



let subjectProcessBtn = $(document).on("click", ".subjectProcessBtn", function(){
    let clickSubNo = $(this).closest("tr").find("#checkSubNo").val();
    console.log("버튼클릭체킁",clickSubNo); 
    let dataList = JSON.parse(localStorage.getItem("subjectCheckList"));
    
    let subReasonTextArea = $("<textarea>").attr({name: "subReason", style: "width:100%; height:50px;"});
    
    let processSubNo =$("<input>").attr("type", "hidden").attr("id","processSubNo").attr("name","subNo").val(clickSubNo);
    subjectProcessTBody.append(processSubNo);
    
    $.each(dataList, (idx, subject)=>{
        if(clickSubNo == subject.subNo){
            subjectProcessTBody.append(fn_subjectProcessDetailTr("교과목명",subject.subName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("단과대학명",subject.colName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("학과명",subject.deptName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("교과목유형명",subject.subCommName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("학년",subject.subGrade));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("시수",subject.subHours));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("학점",subject.subScr));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("교과목설명",subject.subExp));
        }
    });
    let subComm = $("<select>").attr({name:"subState", id:"new72Change", style: "width:100%; height:40px"});
    let subCommOption1 = $("<option>").attr("value","B001").text("대기");
    let subCommOption2 = $("<option>").attr("value","B002").text("완료");
    let subCommOption3 = $("<option>").attr("value","B003").text("반려");
    let subCommOption4 = $("<option>").attr("value","B004").text("취소");
    subComm.append(subCommOption1);
    subComm.append(subCommOption2);
    subComm.append(subCommOption3);
    subComm.append(subCommOption4);

    let subCommTr = $("<tr>");
    let subCommTd = $("<td>").attr("colspan", "2");
    subCommTd.append(subComm);
    subCommTr.append(subCommTd);

    let subReasonTextAreaTr = $("<tr>");
    let subReasonTextAreaTd = $("<td>").attr("colspan", "2");
    subReasonTextAreaTd.append(subReasonTextArea);
    subReasonTextAreaTr.append(subReasonTextAreaTd);

    let subProcessClearBtnTr = $("<tr>");
    let subProcessClearBtnTd = $("<td>").attr("colspan", "2");
    let subProcessClearBtn = $("<button>").attr({id :"subProcessClearBtn", type : "button", class:"btn btn-outline-warning", style : "width:100%; height:100%"}).text("처리");
    subProcessClearBtnTd.append(subProcessClearBtn);
    subProcessClearBtnTr.append(subProcessClearBtnTd);

    subjectProcessTBody.append(subCommTr);
    subjectProcessTBody.append(subReasonTextAreaTr);
    subjectProcessTBody.append(subProcessClearBtnTr);
	
    subjectProcessModalOpen();
	
})
let fn_subjectProcessDetailTr = (thValue, tdValue) =>{
    let myTr = $("<tr>");
    let myTh = $("<th>").text(thValue);
    myTr.append(myTh);

    let myTd = $("<td>").html(tdValue);
    myTr.append(myTd);

    return myTr;
}

$(document).on("change", "#new72Change",(event)=>{
    let target = event.target;
	let option = $(target).val();
    if(option == 'B002'){ //완료
        $("[name='subReason']").text("이상 없음");
    }
    if(option == 'B003'){ //반려
        $("[name='subReason']").text("교과목에 대한 설명 부족");
    }
    if(option == 'B004'){ //취소
        $("[name='subReason']").text("학과와 관련 없는 강의");
    }
})

let subProcessClearBtn = $(document).on("click","#subProcessClearBtn", ()=>{
   let subjectProcessForm = $("#subjectProcessForm");
   let data = subjectProcessForm.serialize();
   $.ajax({
    url : `${cPath}/subject/subjectProcess.do`,
    data : data,
    method : "POST",
    dataType : "json",
    beforeSend : function(xhr){
        xhr.setRequestHeader(header, token);
    }
   }).done((resp)=>{
        if(resp>0){
            Swal.fire({title:"처리 성공했습니다."});
            getSubjectList();
            subjectProcessModalClose();
            subjectProcessTBody.empty();
        }else{
            Swal.fire({title:"처리 실패했습니다."});
        }

   })

})

//===========================================================================================
 //교수 요청했던 리스트 생성 함수--------------------------------------------------------------------------------

 let fn_makeSubjectWaitingListTr = (pStart,SubjectWaitingList)=>{
    if(SubjectWaitingList == null){
        SubjectWaitingList = JSON.parse(localStorage.getItem('subjectWaitingList'));
    }

    let endNum = pStart + pCnt;
    if(endNum > SubjectWaitingList.length){
        endNum = SubjectWaitingList.length;
    }

    let trTags = [];
    for(let i=pStart; i < endNum; i++){
        let subject = SubjectWaitingList[i];
            // let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${subject.subNo}')`)
            // .html(subject.subName);
            let tr = $("<tr>").append(
                    $("<input>").attr("type", "hidden").attr("id","waitingSubNo").val(subject.subNo)
                    , $("<td>").html(subject.rnum)		
                    , $("<td>").html(subject.colName)		
                    , $("<td>").html(subject.deptName)		
                    // , $("<td>").html(aTag)		
                    , $("<td>").html(subject.subName)		
                    , $("<td>").html(subject.subCommName)	
                    ,(empNo!=null || proNo!=null)?$("<td>").html(subject.subStateName): null
                    // ,$("<button>").addClass("btn btn-outline-primary btn-sm subjectWaitingBtn").text("상세보기")		
                ).addClass("subjectWaitingTr subjectWaitingBtn").data("subjectWaiting", subject);
                trTags.push(tr);
    }
    SubjectWaitingListBody.append(trTags);
}
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//교수가 요청했던 교과목리스트에서 검색
let selectSubjectWaitingListInput = $("#selectSubjectWaitingListInput");

let searchSubjectWaitingListInput = $("#searchSubjectWaitingListInput");
let startSubjectWaitingNum = 0;
let SubjectWaitingTemp = [];

let searchSubjectWaitingList = (searchData) => {
    if(searchData.length == 0 || searchData == null){
        SubjectWaitingListBody.empty();
        startSubjectWaitingNum = 0;
        SubjectWaitingTemp = [];
        fn_makeSubjectWaitingListTr(startSubjectWaitingNum);
        return;
    }

    SubjectWaitingTemp = [];
    let dataList = JSON.parse(localStorage.getItem("subjectWaitingList"));

    let searchOption = selectSubjectWaitingListInput.val();

    $.each(dataList, (idx, subject)=>{
        let subName ="";
        if(searchOption != "all"){
            subName = subject[searchOption];
            console.log(subject[searchOption]);
            if(subName.indexOf(searchData)!=-1){
                SubjectWaitingTemp.push(subject);
            }
        }else{
            subName = subject.subName;
            if(subName.indexOf(searchData)!=-1){
                SubjectWaitingTemp.push(subject);
            }
        }

    });
    SubjectWaitingListBody.empty();
    startSubjectWaitingNum = 0;

    fn_makeSubjectWaitingListTr(startSubjectWaitingNum,SubjectWaitingTemp);
}

searchSubjectWaitingListInput.on('keyup',()=>{
    let searchData = searchSubjectWaitingListInput.val();
    searchSubjectWaitingList(searchData);
})
//-------------------------------------------------------------------------------------------
//교수가 요청했던 교과목리스트 무한스크롤 SubjectWaitingListDiv
if(memRole == 'ROLE_PRO') {
const SubjectWaitingListDiv = document.querySelector("#SubjectWaitingListDiv");
SubjectWaitingListDiv.addEventListener("scroll", () =>{
    console.log("체킁리스틍: 발생했나?")
    let scrollTop = SubjectWaitingListDiv.scrollTop;
    let clientHeight = SubjectWaitingListDiv.clientHeight;
    let scrollHeight = SubjectWaitingListDiv.scrollHeight;

    if((scrollTop + clientHeight) > (scrollHeight - 30)){
        startSubjectWaitingNum += 5;
        console.log("pppp");
        console.log(startSubjectWaitingNum);
        console.log("temp:",SubjectWaitingTemp);
        if(SubjectWaitingTemp.length > 0){
            fn_makeSubjectWaitingListTr(startSubjectWaitingNum,SubjectWaitingTemp);
        }else{
            fn_makeSubjectWaitingListTr(startSubjectWaitingNum);
        }
    }

});
}

//-------------------------------------------------------------------------------------------subjectWaitingBtn
let subjectWaitingBtn = $(document).on("click", ".subjectWaitingBtn", function(){
    subjectProcessTBody.empty();

    let waitingSubNo = $(this).closest("tr").find("#waitingSubNo").val();
    console.log("버튼클릭체킁",waitingSubNo); 
    let dataList = JSON.parse(localStorage.getItem("subjectWaitingList"));
    
    let waitViewSubNo =$("<input>").attr("type", "hidden").attr("id","waitViewSubNo").attr("name","subNo").val(waitingSubNo);
    subjectProcessTBody.append(waitViewSubNo);
    
    $.each(dataList, (idx, subject)=>{
        if(waitingSubNo == subject.subNo){
            subjectProcessTBody.append(fn_subjectProcessDetailTr("교과목명",subject.subName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("단과대학명",subject.colName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("학과명",subject.deptName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("교과목유형명",subject.subCommName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("학년",subject.subGrade));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("시수",subject.subHours));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("학점",subject.subScr));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("교과목설명",subject.subExp));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("상태",subject.subStateName));
            subjectProcessTBody.append(fn_subjectProcessDetailTr("사유",subject.subReason));
        }
    });
	
    subjectProcessModalOpen();
	
})

//===========================================================================================
// 리스트 디스플레이 버튼 이벤트
let AllSubjectListBtnDiv = $("#AllSubjectListBtnDiv");
let AllWaitListBtnDiv = $("#AllWaitListBtnDiv");
let AllProcessListBtnDiv = $("#AllProcessListBtnDiv");
let FavoriteListBtnDiv = $("#FavoriteListBtnDiv");
let MySugangListBtnDiv = $("#MySugangListBtnDiv");
let myLectListBtnDiv = $("#myLectListBtnDiv");

let professorSugDiv = $("#professorSugDiv"); 

$(document).on('click','#MyLectListBtn',()=>{
    AllSubjectListBtnDiv.attr("style","display:none;");
    AllWaitListBtnDiv.attr("style","display:none;");
    AllProcessListBtnDiv.attr("style","display:none;");
    FavoriteListBtnDiv.attr("style","display:none;");
    MySugangListBtnDiv.attr("style","display:none;");
    professorSugDiv.attr("style","display:block;");
    myLectListBtnDiv.attr("style","display:block;");

    imsilect();
})
$(document).on('click','#AllSubjectListBtn',()=>{
    AllSubjectListBtnDiv.attr("style","display:block;");
    AllWaitListBtnDiv.attr("style","display:none;");
    AllProcessListBtnDiv.attr("style","display:none;");
    FavoriteListBtnDiv.attr("style","display:none;");
    MySugangListBtnDiv.attr("style","display:none;");
    professorSugDiv.attr("style","display:block;");
    myLectListBtnDiv.attr("style","display:none;");
})
$(document).on('click','#AllWaitListBtn',()=>{
    AllWaitListBtnDiv.attr("style","display:block;");
    AllSubjectListBtnDiv.attr("style","display:none;");
    AllProcessListBtnDiv.attr("style","display:none;");
    FavoriteListBtnDiv.attr("style","display:none;");
    MySugangListBtnDiv.attr("style","display:none;");
    professorSugDiv.attr("style","display:block;");
    myLectListBtnDiv.attr("style","display:none;");
})
$(document).on('click','#AllProcessListBtn',()=>{
    AllProcessListBtnDiv.attr("style","display:block;");
    AllSubjectListBtnDiv.attr("style","display:none;");
    AllWaitListBtnDiv.attr("style","display:none;");
    FavoriteListBtnDiv.attr("style","display:none;");
    MySugangListBtnDiv.attr("style","display:none;");
    professorSugDiv.attr("style","display:block;");
    myLectListBtnDiv.attr("style","display:none;");
})
$(document).on('click','#FavoriteListBtn',()=>{
    FavoriteListBtnDiv.attr("style","display:block;");
    AllSubjectListBtnDiv.attr("style","display:none;");
    AllWaitListBtnDiv.attr("style","display:none;");
    AllProcessListBtnDiv.attr("style","display:none;");
    MySugangListBtnDiv.attr("style","display:none;");
    professorSugDiv.attr("style","display:block;");
    myLectListBtnDiv.attr("style","display:none;");
})
$(document).on('click','#MySugangListBtn',()=>{
    MySugangListBtnDiv.attr("style","display:block;");
    AllSubjectListBtnDiv.attr("style","display:none;");
    AllWaitListBtnDiv.attr("style","display:none;");
    AllProcessListBtnDiv.attr("style","display:none;");
    FavoriteListBtnDiv.attr("style","display:none;");
    professorSugDiv.attr("style","display:none;");
    myLectListBtnDiv.attr("style","display:none;");
})

//------------------------------------------------------------------------------------------------------------------
//교수 추천리스트!
let ProfessorSuggestion = $("#ProfessorSuggestion");

// 로컬스토리지에 저장 함수. 
let getSuggestions = () =>{
    console.log(`이녀석의 학과번호${deptNo}`);
    $.ajax({
        url : `${cPath}/favorite/Suggestions.do`
        , method : 'get'
        ,data : {"dept": `${deptNo}`}
        , dataType : 'json'
        , success : (resp) => {
            console.log(resp);
            // localStorage.setItem("suggestions", JSON.stringify(resp)); //리스트에 데이터가 추가 될 때마다 setItem 해주어야함.
            fn_makeSuggestions(resp);
        }

    })
}

//로컬스토리지에 추천리스트 저장 실행
// if(!localStorage.getItem("suggestions")){
//     getSuggestions();
// }


// localStorage에서 favorites 가져와서 바디 만드는 함수.
let fn_makeSuggestions = (dataList) =>{
    // 데이터리스트에 값을 안주면, 로컬스토리지에서 꺼내오기
    // if(dataList == null){
    //     dataList = JSON.parse(localStorage.getItem("suggestions"));
    // }
//--------------------------------------------------------------------아 집갈시간이야-----------------------------------------
let temp = "";
let cnt = -1;


    $.each(dataList, (idx, favorite)=>{

        console.log("무슨데이터를 가져왔을까", dataList);


       
        let trTags = [];
        

        let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${favorite.subNo}')`)
        .html(favorite.subName);
        let tr = $("<tr>").append(
                    $("<td>").attr("width", "20%").html(favorite.rnum+"순위")		
                    // , $("<td>").attr("width", "35%").html(favorite.deptName)		
                    , $("<td>").attr("width", "60%").html(aTag)		
                    , $("<td>").attr("width", "30%").html(favorite.subCommName)	
                ).addClass("favoriteTr").data("favorite", favorite);
            trTags.push(tr);
                        
            if(temp != favorite.memNo){
                temp = favorite.memNo;
                cnt++;
                $(`#sugFavorite${cnt}`).append(trTags);
            }else{
                $(`#sugFavorite${cnt}`).append(trTags);
            }

            $(`#sugProfessorName${cnt}`).text(`${favorite.memName} 교수`);
            $(`#sugProfessorLoe${cnt}`).text(`${favorite.proLoe}`);

           
                
    })
}
//----------------------------------------------------------------------------------------------------------------------------------------

//리스트 생성 함수--------------------------------------------------------------------------------
let fn_makeJobSubListTr = (pStart,jobSubjectList)=>{
    if(jobSubjectList == null){
        jobSubjectList = JSON.parse(localStorage.getItem('jobSubjectList'));
    }

    let endNum = pStart + pCnt;
    if(endNum > jobSubjectList.length){
        endNum = jobSubjectList.length;
    }

    let trTags = [];
    for(let i=pStart; i < endNum; i++){
        let jobSubject = jobSubjectList[i];
            let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${jobSubject.subNo}')`)
            .html(jobSubject.subName);
            let tr = $("<tr>").append(
                    $("<td>").html(jobSubject.rnum)		
                    , $("<td>").html(jobSubject.jobName)		
                    , $("<td>").html(aTag)		
                    , $("<td>").html(jobSubject.subCommName)	
                    , $("<td>").html(jobSubject.subGrade)		
                    , $("<td>").html(jobSubject.subScr)		

                ).addClass("jobSubjectTr").data("jobSubject", jobSubject);
                trTags.push(tr);
    }
    jobListBody.append(trTags);
}
//-----------------------------------------------------------------------------------------------
//--교과목리스트-----------------------------------------------------------------------------------------
let jobListBody = $("#jobListBody");

let getJobSubjectList = () => {
        let url = `${cPath}/subject/jobSubjectList.do`
        let method = 'GET';
        $.ajax({
            url : url,
            method : method,
            dataType : "json"
        }).done(function(resp, textStatus, jqXHR) {

            jobListBody.empty();
            startJobSubjectNum = 0;
            jobSubjectTemp = [];

            console.log(resp);

            localStorage.setItem("jobSubjectList", JSON.stringify(resp));

            fn_makeJobSubListTr(startJobSubjectNum);
        });
}

if(!localStorage.getItem("jobSubjectList")){ // 여기서 여러개를 체크해야하나?
    getJobSubjectList();
}
//------------------------------------------------------------------------------------------------------
//교과목리스트에서 검색
let selectJobSubjectListInput = $("#selectJobSubjectListInput");
let searchJobSubjectListInput = $("#searchJobSubjectListInput");
let startJobSubjectNum = 0;
let jobSubjectTemp = [];


let searchJobSubjectList = (searchData) => {
    if(searchData.length == 0 || searchData == null){
        jobListBody.empty();
        startJobSubjectNum = 0;
        jobSubjectTemp = [];

        fn_makeJobSubListTr(startJobSubjectNum);
        return;
    }
    jobSubjectTemp = [];
    let dataList = JSON.parse(localStorage.getItem("jobSubjectList"));
    let searchOption = selectJobSubjectListInput.val();

    $.each(dataList, (idx, subject)=>{
        let subName ="";
        if(searchOption != "all"){
            subName = subject[searchOption];
            console.log(subject[searchOption]);
            if(subName.indexOf(searchData)!=-1){
                jobSubjectTemp.push(subject);
            }
        }else{
            subName = subject.subName;
            if(subName.indexOf(searchData)!=-1){
                jobSubjectTemp.push(subject);
            }
        }
     
    });
    jobListBody.empty();
    startJobSubjectNum = 0;

    fn_makeJobSubListTr(startJobSubjectNum,jobSubjectTemp);
}

searchJobSubjectListInput.on('keyup',()=>{
    let searchData = searchJobSubjectListInput.val();
    searchJobSubjectList(searchData);
})
//-------------------------------------------------------------------------------------------
// 교과목리스트 무한스크롤 subjectListDiv
const jobSubjectListDiv = document.querySelector("#jobSubjectListDiv");
jobSubjectListDiv.addEventListener("scroll", () =>{
    console.log("체킁리스틍: 발생했나?")
    let scrollTop = jobSubjectListDiv.scrollTop;
    let clientHeight = jobSubjectListDiv.clientHeight;
    let scrollHeight = jobSubjectListDiv.scrollHeight;

    if((scrollTop + clientHeight) > (scrollHeight - 30)){
        startJobSubjectNum += 5;
        console.log("pppp");
        console.log(startJobSubjectNum);
        console.log("temp:",jobSubjectTemp);
        if(jobSubjectTemp.length > 0){
            fn_makeJobSubListTr(startJobSubjectNum,jobSubjectTemp);
        }else{
            fn_makeJobSubListTr(startJobSubjectNum);
        }
    }

});


//차트------------------------------------------------------------------------------------------------------------------
let pieChart = () =>{
    $.ajax({
        url : `${cPath}/subject/myListenSub.do`,
        method : 'get',
        dataType : 'json'
    }).done((resp)=>{
        console.log("엉터리엉터리",resp);
        let dataList = JSON.parse(localStorage.getItem("jobSubjectList"));
        let data = [];

        $.each(resp,(idx, jobSub)=>{
            let subNo = jobSub.subNo;
            $.each(dataList,(idxA, subject)=>{
                if(subNo == subject.subNo){
                    let a= { 
                        "jobName" : subject.jobName,
                        "jobNo" : subject.jobNo};
                    
                    data.push(a);
                }

            })
        })
        console.log("이중이치체킁",data);
        
        // 중복 값을 체크하여 카운트하기 위한 객체
        let countMap = {};

        // 중복 값을 제거한 결과를 저장할 배열
        let result = [];

        // 중복 값을 체크하고 카운트하는 과정
        for (let i = 0; i < data.length; i++) {
        let obj = data[i];
        let key = Object.values(obj)[0];

        if (countMap[key]) {
            countMap[key]++;
        } else {
            countMap[key] = 1;
        }
        }

        // 중복 값을 제거한 결과를 배열에 추가
        for (let key in countMap) {
        result.push([key, countMap[key]]);
        }

        console.log(result);



        c3.generate({
            bindto : "#Piechart",
            size : {
                width: 600, // 차트 너비
                height: 300 // 차트 높이
            },
            data: {
                // iris data from R
                columns: 
                     result
                // [
                //     ['data1', 30],
                //     ['data2', 120],
                // ]
                ,
                type : 'pie',
            },
			legend: {  
                show: true,  
                position: 'right'  
            }  
        });
        


    })
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

	let subjectList = JSON.parse(localStorage.getItem("subjectList"));
	let mySelect = $("<select>").attr({name: "subNo", id : "selectSub", class : "form-select", style:"background-color:#f3f5f9"});
	$.each(subjectList, (idx, subject)=>{
        if(subject.deptNo == deptNo){
            let subjectOption = $("<option>").attr({value :subject.subNo, class : "optionSub"}).text(subject.subName);
            mySelect.append(subjectOption);
        }
	});
	subjectTd.append(mySelect);

	let lectureRoomList = JSON.parse(localStorage.getItem("lectureRoomList"));
	let lectureRoomSelect = $("<select>").attr("id","lectureRoomSelect");
	let AllOption = $("<option>").text("선택");
	lectureRoomSelect.append(AllOption);
	$.each(lectureRoomList, (idx, lectureRoom)=>{
        if(lectureRoom.deptNo == deptNo){
		let lectureRoomOption = $("<option>").attr({value :lectureRoom.lrNo, class : "optionRoom"}).text(lectureRoom.lrNo);
		lectMm.attr("value" , lectureRoom.lrMnop);
		lectureRoomSelect.append(lectureRoomOption);
    }
	});
	lectureRoomSelectTd.append(lectureRoomSelect);

	lectPlanModalOpen();
	
})
//교과목 정보 ---------------------------------------------------------------------------------
$(document).on("change", "#selectSub", (event)=>{
	let target = event.target;
	let option = $(target).val();
	console.log(option);
	let subjectList = JSON.parse(localStorage.getItem("subjectList"));
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
    //강의실 전체 색 비우기
    $(".lecTimeTd").css("background-color", "white");
    
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
		Swal.fire({title:"강의를 선택하지 않았습니다. 확인해보세요."});
	}else{
		if($(target).css("background-color") === "rgb(128, 128, 128)" || $(target).css("background-color") === "gray"){
            Swal.fire({title:"이미 같은 시간에 다른 강의가 존재합니다."})
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
				Swal.fire({title:"이미 시수만큼 선택했습니다."});
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

//강의 계획서 등록
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
			Swal.fire({title:"강의가 등록되었습니다."});
			selectLectureTimePlaceList();
			lectPlanModalClose();
            myLectListBody.empty();
            imsilect();

			
		}else{
			Swal.fire({title:"입력하신 정보가 잘못되었습니다."});
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

// let getUserSubjectList = () => {
// 	let url = `${cPath}/subject/subjectManagement.do`
// 	let method = 'GET';
// 	$.ajax({
// 		url : url,
// 		method : method,
// 		dataType : "json"
// 	}).done(function(resp, textStatus, jqXHR) {
// 		let subjectList = [];
// 		for(let i=0; i<resp.length; i++){
// 			let data = resp[i];
// 			if(data.deptNo == UserdeptNo){
// 				subjectList.push(data);
// 			}
// 		}

// 		localStorage.setItem("userSubjectList", JSON.stringify(subjectList));

// 	});
// }

// if(!localStorage.getItem("userSubjectList")){ // 여기서 여러개를 체크해야하나?
// 	getUserSubjectList();
// }

$(document).on('click', '#autoLecture', ()=>{
    $("[name='subNo']").val("S0201026").trigger("change");
    $("[name='lectName']").val("함께 공부하는 자바");
    $("[name='lectExp']").text("함께 공부하면 더 행복한 자바 공부~");
    $("#kujae").text("혼자서 공부하는 자바");
    $("#kujae").text("혼자서 공부하는 자바");
    $("#kujae").text("혼자서 공부하는 자바");
    $("#wnd").val("10").trigger("keyup");
    $("#rl").val("20").trigger("keyup");
    $("#cnf").val("30").trigger("keyup");
    $("#rhk").val("40").trigger("keyup");
    for(let i= 0; i < 15; i++){
        $(`[name='lectPlanList[${i}].lwpContent']`).text(`${i+1}주차`);
    };
    
    $("#lectureRoomSelect").val("B101").trigger("change");
});

let myLectListBody = $("#myLect");
let fn_myLectListTr = (myLectList)=>{
    let trTags = [];
    $.each(myLectList, (idx,myLect)=>{
            let tr = $("<tr>").append(
                    $("<td>").html(myLect.lectNo) //강의번호		
                    ,$("<td>").html(myLect.lectName) //강의명		
                    , $("<td>").html(myLect.memName) //교수명		
                    , $("<td>").html(myLect.subCommName) // 유형	
                    , $("<td>").html(myLect.deptName)// 학과	
                    // , $("<td>").html(myLect.lectTime) // 강의시간		

                ).addClass("myLectTr").data("myLect", myLect);
                trTags.push(tr);
    })
    myLectListBody.append(trTags);
}

let imsilect = ()=>{
    let url = `${cPath}/favorite/mylectList.do`
	let method = 'GET';
	$.ajax({
		url : url,
		method : method,
		dataType : "json"
	}).done((resp)=>{
        let temp = [];
        let lectNoSet = new Set();

        $.each(resp, (idx , mylect)=>{
              if (!lectNoSet.has(mylect.lectNo)) {
                    temp.push(mylect);
                    lectNoSet.add(mylect.lectNo);
                }
        })
        myLectListBody.empty();
        fn_myLectListTr(temp);
		
	});
}
















