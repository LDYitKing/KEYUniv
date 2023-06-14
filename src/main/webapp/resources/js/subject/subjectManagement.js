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
const deptNo = document.querySelector('#deptNo').value;
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
// GridStack.js를 초기화하고 관련 설정을 지정합니다.
let grid = GridStack.init({
  cellHeight: 70, //그리드 내 셀 높이 설정
  acceptWidgets: true, // 위젯 드롭 할 수 있는지 여부.
  removable: '#trash', // drag-out delete class 지정 (삭제할 수 있는 위젯) 
});
//-------------------------------------------------------
//화면 로딩 완료후 시작 이벤트리스너------------------------
document.addEventListener("DOMContentLoaded", () => {
  initGS();
  getSubjectList();
  getFavorites();
});
//-------------------------------------------------------
//GridStack생성---------------------------------------------
const initGS = () => {

  // 새로운 위젯 생성 메서드 '셀렉터'. 어팬드될 위치 '바디', 헬퍼는 도움말 요소 '복사본표시'
  GridStack.setupDragIn('.newWidget', { appendTo: 'body', helper: 'clone' });
  // 생성될 그리드 전체 지정 
  //List<vo> 받기 배열+객체
  // noMove: true 움직이지 못하게함.
  //  noResize: true 사이즈 조절 못하게 함.
  //  locked: true 삭제 금지. ?? 위치 고정만 됨?
  // minW 가로 넓이 최솟값 제한. maxW 가로 넓이 최댓값 제한
  // x : 그리드 아이템 시작 열(컬럼) 위치. 0부터 시작
  // y : 그리드 아이템 시작 행(로우) 위치. 0부터 시작
  // w : 그리드 아이템 차지 가로 너비 == 컬럼차지개수
  // h : 그리드 아이템 차지 세로 높이 == 로우차지개수
  // content : 그리드 아이템 내용 지정. 텍스트나 HTML코드 넣을 수 있음. '여기안에'
  //위젯 개별생성
  //grid.addWidget($('<div><div class="grid-stack-item-content">New Widget</div></div>'), x, y, width, height, autoPosition, minWidth, maxWidth, minHeight, maxHeight, id);
  // 위젯 내용 업데이트
  //grid.addWidget($('<div><div class="grid-stack-item-content">Updated Widget</div></div>'), x, y, width, height, autoPosition, minWidth, maxWidth, minHeight, maxHeight, id);
  // 예시
  //grid.addWidget($('<div><div class="grid-stack-item-content">New Widget</div></div>'), undefined, undefined, 2, 2);
  // 아이템으로 담아서 쓰는 예시
  // let items = [
  //     {x: 0, y: 0, w: 4, h: 2, content: '1'},
  //     {x: 4, y: 0, w: 4, h: 4, noMove: true, noResize: true, locked: true, content: 'I can\'t be moved or dragged!<br><ion-icon name="ios-lock" style="font-size:300%"></ion-icon>'},
  //     {x: 8, y: 0, w: 2, h: 2, minW: 2, noResize: true, content: '<p class="card-text text-center" style="margin-bottom: 0">Drag me!<p class="card-text text-center"style="margin-bottom: 0"><ion-icon name="hand" style="font-size: 300%"></ion-icon><p class="card-text text-center" style="margin-bottom: 0">...but don\'t resize me!'},
  //     {x: 10, y: 0, w: 2, h: 2, content: '4'},
  //     {x: 0, y: 2, w: 2, h: 2, content: '5'},
  //     {x: 2, y: 2, w: 2, h: 4, content: '6'},
  //     {x: 8, y: 2, w: 4, h: 2, content: '7'},
  //     {x: 0, y: 4, w: 2, h: 2, content: '8'},
  //     {x: 4, y: 4, w: 4, h: 2, content: '9'},
  //     {x: 8, y: 4, w: 2, h: 2, content: '10'},
  //     {x: 10, y: 4, w: 2, h: 2, content: '11'},
  // ];
//  let items = [
//     {x: 0, y: 0, w: 12, h: 10, content: '1', noMove: true, minW : 12, maxW : 12 ,minH: 10}
//  ];
  //그리드 읽기
//   grid.load(items);
  /*
  해당 코드는 Gridstack.js 라이브러리에서 제공하는 이벤트 핸들러를 사용하여 그리드의 위젯이 추가, 제거 또는 변경될 때마다 실행되는 코드입니다.

  1. grid.on() 메서드는 GridStack 클래스의 인스턴스에서 발생하는 이벤트를 수신하고 처리합니다.
  2. added, removed, change는 GridStack 이벤트 유형을 나타내며, 위젯이 추가, 제거 또는 변경될 때 각각 발생합니다.
  3. function(e, items) 콜백 함수는 이벤트 객체 e와 변경된 위젯 목록인 items를 매개 변수로 사용합니다.
  4. items.forEach() 메서드는 변경된 각 위젯에 대해 콜백 함수를 실행합니다.
  5. str += ' (x,y)=' + item.x + ',' + item.y;는 변경된 위젯의 위치 (x, y)를 문자열에 추가합니다.
  6. console.log() 함수는 이벤트 유형과 변경된 위젯의 수, 위치를 포함하는 문자열을 콘솔에 출력합니다.

  따라서 아래 코드는 그리드에서 위젯이 추가, 제거 또는 변경될 때마다 콘솔에 변경된 위젯의 정보를 출력합니다. 
  */
//   grid.on('added removed change', function(e, items) {
//     let str = '';
//     items.forEach(function(item) { str += ' (x,y)=' + item.x + ',' + item.y; });
//     console.log(e.type + ' ' + items.length + ' items:' + str );
//   });
};
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
                    subjectWaitingList.push(subject); 
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
    $.each(dataList, (idx, subject)=>{
        let subName = subject.subName;
        if(subName.indexOf(searchData)!=-1){
            subjectTemp.push(subject);
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
            let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${subject.subNo}')`)
            .html(subject.subName);
            let tr = $("<tr>").append(
                    $("<input>").attr("type", "hidden").attr("id","checkSubNo").val(subject.subNo)
                    , $("<td>").html(subject.rnum)		
                    , $("<td>").html(subject.colName)		
                    , $("<td>").html(subject.deptName)		
                    , $("<td>").html(aTag)		
                    , $("<td>").html(subject.subCommName)	
                    ,(empNo!=null || proNo!=null)?$("<td>").html(subject.subStateName): null
                    ,$("<button>").addClass("btn btn-outline-primary btn-sm subjectProcessBtn").text("상세보기")		
                ).addClass("subjectCheckTr").data("subjectCheck", subject);
                trTags.push(tr);
    }
    reqListBody.append(trTags);
}
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//요청 교과목리스트에서 검색
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
    $.each(dataList, (idx, subject)=>{
        let subName = subject.subName;
        if(subName.indexOf(searchData)!=-1){
            subjectCheckTemp.push(subject);
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

//상세조회-------------------------------------------------
let fn_subjectDetail = (subNo) =>{
  let xhr = new XMLHttpRequest();
  // 글씨랑 같이 쓰면서 스크립트의 데이터를 쓸때 백틱을 씀. 스크립트데이터는 ${} 탬플릿리터럴을 사용함.
  xhr.open("GET", `${cPath}/subject/subjectView.do?what=${subNo}`, true);
  xhr.onreadystatechange = () => {
    if(xhr.readyState == 4 && xhr.status == 200){
      let subject = JSON.parse(xhr.responseText);
      
      createSubjectView(subject);

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
  let h5 = document.createElement('h5');
  h5.innerText = '교과목 상세 정보';
  th1.appendChild(h5);
  tr.appendChild(th1);

  // TD2 생성
  let td2 = document.createElement('td');
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
    tbody.appendChild(createTableRow("교과목설명",subject.subExp,"subExp"));

 


  // tfoot 생성
  let tfoot = document.createElement('tfoot');
  table.appendChild(tfoot);

  // TR tfoot
  let tfootTr = document.createElement('tr');
  tfoot.appendChild(tfootTr);

  // TD tfoot TR
  let tfootTd = document.createElement('td');
  tfootTd.setAttribute('colspan', '3');
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
  //폼태그를 임시 div에 넣기.
  momentDiv.appendChild(updateSubjectForm);
  let jebal = momentDiv.innerHTML;

  console.log(jebal);
  //그리드 생성
  let newItem = {x: 0, y: 12, w: 4, h: 7 ,content : `${jebal}`}; 
  grid.addWidget(newItem);

}
//테이블 로우 생성
let createTableRow= (thValue, tdValue , inputName) =>{
  let myTr = document.createElement("tr");
  let myTh = document.createElement("th");
  myTh.textContent = thValue;
  myTr.appendChild(myTh);


  let myTd = document.createElement("td");
  myTd.setAttribute('colspan', '2');
  let myInput = document.createElement("input");
  myInput.setAttribute('type', 'text');
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
  <!----------------------- Form wizard with step progress ------------------------------------->
  <div>
            <div class="card-header bg-success bg-opacity-75" style="--fowiz-primary-color: rgba( 0, 0, 0, .4)">

                <!-- Step progress -->
                <ul id="_dm-progWizardSteps" class="step-progress my-4">
                    <li class="active" data-step="account">
                        <span class="step-label">1단계</span>
                    </li>
                    <li data-step="profile">
                        <span class="step-label">2단계</span>
                    </li>
                    <li data-step="address">
                        <span class="step-label">3단계</span>
                    </li>
                    <li data-step="finish">
                        <span class="step-label">요청</span>
                    </li>
                </ul>
                <!-- END : Step progress -->

            </div>
            <div class="card-body">

                <!-- Form sections -->
                <form method="post" name="insertForm" id="_dm-progWizardForm" class="p-xl-3 zangdar__wizard" data-wizard="zangdar_form_d001900a-3b85-4bc8" name="zangdar_form_d001900a-3b85-4bc8">
                    <input type="hidden" name="${paramName}" value="${headerValue}"/>
                    <input type="hidden" name="deptNo" value="${deptNo}"/>
                    <input type="hidden" name="colNo" value="${colNo}"/>
                    <!-- Account section -->
                    <section data-step="account" class="zangdar__step zangdar__step__active">
                        <div class="row mb-3">
                            <label for="_dm-wStepUsername" class="col-sm-4 col-xl-3 col-form-label">교과목명</label>
                            <div class="col-sm-8 col-xl-9">
                                <input name="subName" id="_dm-wStepUsername" type="text" class="form-control">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="_dm-wStepEmail" class="col-sm-4 col-xl-3 col-form-label">교과목유형</label>
                            <div class="col-sm-8 col-xl-9">
                                <select name="subComm">
                                    <option value="A001">전공필수</option>
                                    <option value="A002">전공선택</option>
                                    <option value="A003">전공심화</option>
                                    <option value="A004">교양필수</option>
                                    <option value="A005">교양선택</option>
                                </select>
                            </div>
                        </div>

                        <div class="pt-3 d-flex justify-content-end gap-2">
                            <button type="button" data-next="" class="btn btn-primary zangdar__next">다음</button>
                        </div>
                    </section>
                    <!-- END : Account section -->

                    <!-- Profile section -->
                    <section data-step="profile" class="zangdar__step">
                        <div class="row mb-3">
                            <label for="_dm-wStepFirstName" class="col-sm-4 col-xl-3 col-form-label">학년</label>
                            <div class="col-sm-8 col-xl-9">
                                <select name="subGrade">
                                    <option value="1">1학년</option>
                                    <option value="2">2학년</option>
                                    <option value="3">3학년</option>
                                    <option value="4">4학년</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="_dm-wStepLastName" class="col-sm-4 col-xl-3 col-form-label">학점</label>
                            <div class="col-sm-8 col-xl-9">
                                <select name="subScr">
                                    <option value="1">1학점</option>
                                    <option value="2">2학점</option>
                                    <option value="3">3학점</option>
                                </select>
                            </div>
                        </div>

                        <div class="pt-3 d-flex justify-content-end gap-2">
                            <button type="button" data-prev="" class="btn btn-light zangdar__prev" style="display: none;">이전</button>
                            <button type="button" data-next="" class="btn btn-primary zangdar__next">다음</button>
                        </div>
                    </section>
                    <!-- END : Profile section -->

                    <!-- Address section -->
                    <section data-step="address" class="zangdar__step">
                        <div class="row mb-3">
                            <label for="_dm-wStepAddress" class="col-sm-4 col-xl-3 col-form-label">시수</label>
                            <div class="col-sm-8 col-xl-9">
                                <select name="subHours">
                                    <option value="1">1시간</option>
                                    <option value="2">2시간</option>
                                    <option value="3">3시간</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="_dm-wStepCity" class="col-sm-4 col-xl-3 col-form-label">교과목설명</label>
                            <div class="col-sm-8 col-xl-9">
                                <textarea name="subExp"></textarea>
                            </div>
                        </div>

                        <div class="pt-3 d-flex justify-content-end gap-2">
                            <button type="button" data-prev="" class="btn btn-light zangdar__prev" style="display: none;">이전</button>
                            <input type="button" id="check22" value="요청">
                        </div>
                    </section>
                    <!-- END : Address section -->

                </form>
                <!-- END : Form sections -->

            </div>
        </div>
 <!---------- END : Form wizard with step progress --------------------->
  `
//--------------------------------------------------------
    //그리드 생성
    let SubjectFormItem = {x: 4, y: 12, w: 4, h: 7 ,content : SubjectFormDiv, id: 'SubjectFormItem'}; 
    grid.addWidget(SubjectFormItem);


    let Formwizard = () =>{
        // Form wizard with step progress
        // ----------------------------------------------
        const progressSteps = document.getElementById( "_dm-progWizardSteps");
        const progressForm = new Zangdar( "#_dm-progWizardForm", {
            onStepChange() {

                // Remove all active variable
                progressSteps.querySelectorAll( ".active" ).forEach( el => el.classList.remove( "active" ));

                // Set active to step based on current form wizard label
                const currentStep = progressForm.getCurrentStep().label;
                progressSteps.querySelector( `[data-step="${currentStep}"]` ).classList.add( "active" );
            }
        })
    }

     Formwizard();
}

//------------------------------------------------------------------------------------------
 //교과목등록요청---------------------------------------------------------------------------------
    $(document).on("click",'#check22',function(event){
        //event.preventDefault();

        let formData = $("#_dm-progWizardForm");
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
                alert("성공");
                let SubFormItem = $("[gs-id=SubjectFormItem]");
                SubFormItem.hide(300,()=>{
                    grid.removeWidget(SubFormItem);
                })
                getSubjectList();
            }else{
                alert("실패 Why???");
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
                alert("즐찾삭제!");
                getFavorites();
            }else{
                alert("즐찾삭제실패ㅠㅠ");
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
                alert("즐찾성공!");
                getFavorites();
            }else{
                alert("즐찾실패ㅠㅠ");
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
            alert("전체승인");
            getSubjectList();
            return;
        }else{
            alert("승인할 교과목이 없거나 에러");
        }

    })
}
//===========================================================================================
//교과목 수정=================================================================================
$(document).on('click','#modifySubjectBtn', (event)=>{
    let target = event.target;
    let gridStackItem = $(target).parents(".grid-stack-item");
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
            alert("업뎃성공");
            gridStackItem.hide(300,()=>{
                grid.removeWidget(gridStackItem);
            })
            getSubjectList();
            getFavorites();
        }else{
            alert("업뎃실패~");
        }
    })
})



//===========================================================================================
//교과목 삭제=====fn_removeSubject()=================================================낼 바꿔야함.
$(document).on('click','#removeSubjectBtn',(event)=>{
    let target = event.target;
    let subNo = $(target).parents("#updateSubjectForm").find('input[name="subNo"]').val();
    let gridStackItem = $(target).parents(".grid-stack-item");
    console.log("폼데이터체킁:",subNo);
    $.ajax({
        url: `${cPath}/subject/subjectDelete.do`,
        method: "POST",
        data : {what : subNo},
        dataType : "json"
    }).done((resp)=>{
        if(resp  >0){
            alert("삭제성공");
            gridStackItem.hide(300,()=>{
                grid.removeWidget(gridStackItem);
            })
            getSubjectList();
            getFavorites();
        }else{
            alert("삭제실패");
        }
        })
})
//===========================================================================================
//교과목 처리 모달============================================================================

let subjectProcessModal = $("#subjectProcessModal");

let subjectProcessModalOpen = () => { // 모달 보여줌
	subjectProcessModal.show();
}
let subjectProcessModalClose = () => { // 모달 닫음
	subjectProcessModal.hide();
}

let subjectProcessTBody = $("#subjectProcessTBody");

let subjectProcessBtn = $(document).on("click", ".subjectProcessBtn", function(){
    let clickSubNo = $(this).closest("tr").find("#checkSubNo").val();
    console.log("버튼클릭체킁",clickSubNo); 
    let dataList = JSON.parse(localStorage.getItem("subjectCheckList"));
    
    let subReasonTextArea = $("<textarea>").attr({name: "subReason", style: "width:100%; height:250px;"});
    
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
    let subComm = $("<select>").attr({name:"subState", style: "width:100%; height:40px"});
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
            alert("처리성공!");
            getSubjectList();
            subjectProcessModalClose();
            subjectProcessTBody.empty();
        }else{
            alert("처리실패ㅠㅠ");
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
            let aTag = $("<a>").attr("href", `javascript:fn_subjectDetail('${subject.subNo}')`)
            .html(subject.subName);
            let tr = $("<tr>").append(
                    $("<input>").attr("type", "hidden").attr("id","waitingSubNo").val(subject.subNo)
                    , $("<td>").html(subject.rnum)		
                    , $("<td>").html(subject.colName)		
                    , $("<td>").html(subject.deptName)		
                    , $("<td>").html(aTag)		
                    , $("<td>").html(subject.subCommName)	
                    ,(empNo!=null || proNo!=null)?$("<td>").html(subject.subStateName): null
                    ,$("<button>").addClass("btn btn-outline-primary btn-sm subjectWaitingBtn").text("상세보기")		
                ).addClass("subjectWaitingTr").data("subjectWaiting", subject);
                trTags.push(tr);
    }
    SubjectWaitingListBody.append(trTags);
}
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//교수가 요청했던 교과목리스트에서 검색
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
    $.each(dataList, (idx, subject)=>{
        let subName = subject.subName;
        if(subName.indexOf(searchData)!=-1){
            SubjectWaitingTemp.push(subject);
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
//그리드스택툴================================================================================
let fn_GSTool = () =>{
    let GSToolBtn = $("#GSToolBtn");
    let GSTool = $("#GSTool");
    if(GSToolBtn.attr("name") == "construct-outline"){
        GSToolBtn.attr("name","construct-sharp");
        GSTool.attr("style","display:block;");
    }else{
        GSToolBtn.attr("name","construct-outline");
        GSTool.attr("style","display:none;");
    }
}
//===========================================================================================

 













