  // 연구번호 study.studyNo
      // 교수아이디 study.proNo
      // 연구명 study.studyName
      // 시작일 study.studySdate
      // 마감일 study.studyEdate
      // 주제 study.studySubject
      // 목표 study.studyPurpose
      // 연구자료 study.studyFile

let studyE = document.querySelector('#studyE');
//--------jsp 에서 가져온 cPath---------------------------------------------
const cPath = document.querySelector('#cPath').value;
let hiddenStudyNo = document.querySelector('#hiddenStudyNo');

//---------연구폼div 선택-------------------------------------------------------
const studyFormDiv = document.querySelector('#studyFormDiv');
//---------연구폼 선택-------------------------------------------------------
const studyForm = document.querySelector('#studyForm');

//--------div 바꾸기--------------------------------------------------------
let changeStudyDiv = document.querySelector('#changeStudyDiv');


//--------비동기로 데이터 가져와서 빈 데이터 배열에 넣기-----------------------

const initAG = () =>{
  let xhr = new XMLHttpRequest();
  xhr.open("get", `${cPath}/professor/professorStudyList.do` , true);
  xhr.onreadystatechange = () => {
    if (xhr.readyState == 4 && xhr.status == 200) {
      studyEditDiv.style.display="none";
      studyFormDiv.style.display="none";
      studyForm.reset();
      changeStudyDiv.style.display="block";
      changeStudyDiv.innerHTML="";

      // aggrid div 생성
      const myGrid = document.createElement("div");
      myGrid.setAttribute("id", "myGrid");
      myGrid.setAttribute("style", "height: 434px;");
      myGrid.setAttribute("class", "ag-theme-alpine");
      // insert 버튼 생성
      const studyInsertBtn = document.createElement("button");
      studyInsertBtn.setAttribute("id", "studyInsertBtn");
      studyInsertBtn.setAttribute("onclick", "studyInsert()");
      studyInsertBtn.textContent = "연구 등록";

      changeStudyDiv.appendChild(myGrid);
      changeStudyDiv.appendChild(studyInsertBtn);
      

      const gridDiv = document.querySelector("#myGrid");

      //--------ag그리드 컬럼---------------------------------------------
      const columnDefs = [
        { field: "rnum", headerName: "번호" },
        // { field: "studyNo", headerName: "연구번호" },
        { field: "memName", headerName: "교수명" },
        { field: "studyName", headerName: "연구명" },
        { field: "studySubject", headerName: "주제" },
      ];

      //--------빈 데이터 배열 생성---------------------------------------------
      const rowData = [];

      console.log(xhr.responseText);
      const data = JSON.parse(xhr.responseText);
      
      data.forEach(study => {
        let professorStudy = {};
        professorStudy.rnum = study.rnum;
        professorStudy.memName = study.memName;
        professorStudy.studyName = study.studyName;
        professorStudy.studySubject = study.studySubject;
        professorStudy.studyNo = study.studyNo;

        rowData.push(professorStudy);
  
      });

       //--------옵션설정---------------------------------------------
       const gridOptions = {
        defaultColDef: {
          sortable: true,
          filter: true,
          resizable: true,
          editable: false,
        },
        columnDefs: columnDefs,
        rowData: rowData,
        pagination: true,
        //paginationAutoPageSize:true,
        paginationPageSize: 8,

        onCellClicked: function(event) {
            studyView(event);
        }
      };

      // gridOptions.api.setRowData(rowData);
      new agGrid.Grid(gridDiv, gridOptions);
    }
  };
  xhr.send();  
}

//--------실행--------------------------------------

document.addEventListener("DOMContentLoaded", () => {
  initAG();
});
//연구 상세조회 ---------------------------------------------------
const studyView = (event) =>{
  
          //----------------------상세보기-----------------------------------------
          const clickedData = event.data; // 클릭된 행(row)의 데이터
          // const clickedColDef = event.colDef; // 클릭된 열(column)의 정의
          // const clickedColKey = event.column.colId; // 클릭된 열(column)의 key
          // const clickedValue = event.value; // 클릭된 셀(cell)의 값(value)
          // console.log(clickedData.studyNo);
          // console.log(`Clicked data: ${JSON.stringify(clickedData)}`);
          // console.log(`Clicked colDef: ${JSON.stringify(clickedColDef)}`);
          // console.log(`Clicked colKey: ${clickedColKey}`);
          // console.log(`Clicked value: ${clickedValue}`);
          
          let xhr = new XMLHttpRequest();
          xhr.open("get", `${cPath}/professor/professorStudyView.do?what=${clickedData.studyNo}`, true);
          xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
              
              let study = JSON.parse(xhr.responseText);
              console.log(study);
              //---- 업데이트 폼 데이터 추가?
               


                hiddenStudyNo.value = study.studyNo;
 


              //----------------------------
              studyE.value = JSON.stringify(study);

              changeStudyDiv.innerHTML="";

              let myTable = document.createElement("table");
              myTable.setAttribute("class", "table table-hover text-center");
              let myThead = document.createElement("thead");
              let myTbody = document.createElement("tbody");
              let myTheadTr = document.createElement("tr");
              let myTheadTh = document.createElement("th");
              myThead.appendChild(myTheadTr);
              myTheadTh.colSpan = 2;
              myTheadTh.innerHTML = "<h4>연구 상세보기</h4>";
              myTheadTr.appendChild(myTheadTh);

              function createTableRow(thValue, tdValue){
                let myTr = document.createElement("tr");
                let myTh = document.createElement("th");
                myTh.textContent = thValue;
                myTr.appendChild(myTh);


                let myTd = document.createElement("td");
                myTd.textContent = tdValue;
                myTr.appendChild(myTd);

                return myTr;
              }
            // 연구번호 study.studyNo
            // 교수명 study.memName
            // 교수아이디 study.proNo
            // 연구명 study.studyName
            // 시작일 study.studySdate
            // 마감일 study.studyEdate
            // 주제 study.studySubject
            // 목표 study.studyPurpose
            // 연구자료 study.studyFile

              myTable.appendChild(myThead);
              myTable.appendChild(myTbody);
              myTbody.appendChild(createTableRow("연구번호",study.studyNo));
              myTbody.appendChild(createTableRow("교수명",study.memName));
              myTbody.appendChild(createTableRow("연구명",study.studyName));
              myTbody.appendChild(createTableRow("시작일",study.studySdate));
              myTbody.appendChild(createTableRow("마감일",study.studyEdate));
              myTbody.appendChild(createTableRow("주제",study.studySubject));
              myTbody.appendChild(createTableRow("목표",study.studyPurpose));

              let fileTr = document.createElement("tr");
              let fileTh = document.createElement("th");
              fileTh.textContent = "첨부파일";
              fileTr.appendChild(fileTh);

              let fileTd = document.createElement("td");


              myTbody.appendChild(fileTr);
              fileTr.appendChild(fileTd);
               
              let atchFileList = study.atchFileGroup.atchfileList;
                if(atchFileList!=null && atchFileList.length >0){
                  for(let i = 0; i < atchFileList.length; i++){
                    let atchFile = atchFileList[i];
                    let downloadURL = cPath+"/professor/attatch/download.do?atchId="+atchFile.atchId + "&atchSeq=" + atchFile.atchSeq;
                    let atchLink = document.createElement("a");
                    atchLink.href = downloadURL;
                    atchLink.textContent = atchFile.atchOrginName;
                    fileTd.appendChild(atchLink);

                    if(i < atchFileList.length -1){
                      let separator =document.createTextNode(" | ");
                      fileTd.appendChild(separator);
                    }

                  }
                }
              //--------------------------고쳐야해~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~updateStudy()
              
              

            // let updateURL = cPath + "/professor/professorStudyUpdate.do?what=" +study.studyNo;
            // let updateLink = document.createElement("a");
            // updateLink.href = updateURL;
            // updateLink.textContent = "수정";
            // updateLink.setAttribute("class", "btn btn-primary btn-sm");

            let updateLinkBtn = document.createElement("button");
            updateLinkBtn.textContent = "수정";
            updateLinkBtn.setAttribute("onclick", "stduyUpdate()");
            updateLinkBtn.setAttribute("class", "btn btn-primary btn-sm");

            let deleteBtn = document.createElement("button");
            deleteBtn.textContent = "삭제";
            deleteBtn.setAttribute("onclick", "studydelete()");
            deleteBtn.setAttribute("class", "btn btn-danger btn-sm");


            // let listURL = cPath + "/professor/professorStudy.do";
            // let listLink = document.createElement("a");
            // listLink.href = listURL;
            // listLink.textContent = "목록으로";
            // listLink.setAttribute("class", "btn btn-outline-primary");

            let listLinkBtn = document.createElement("button");
            listLinkBtn.textContent = "목록으로";
            listLinkBtn.setAttribute("onclick","initAG()");
            listLinkBtn.setAttribute("class", "btn btn-secondary btn-sm");


            let menuTr = document.createElement("tr");
            let menuTd = document.createElement("td");
            let menuSpan = document.createElement("span");
            menuSpan.class = "btnSpace";
            menuTd.setAttribute("colspan", "2")

            menuTd.appendChild(menuSpan);
            menuSpan.appendChild(deleteBtn);
            menuSpan.appendChild(updateLinkBtn);
            menuSpan.appendChild(listLinkBtn);

            menuTr.appendChild(menuTd);

            let myTfoot = document.createElement("tfoot");
            myTfoot.appendChild(menuTr);
            myTable.appendChild(myTfoot);


              changeStudyDiv.appendChild(myTable);
            }
          }
          xhr.send();

}
//연구 등록폼 띄우기-------------------------------------------------
const studyInsert = () =>{
  changeStudyDiv.innerHTML="";

  studyEditDiv.style.display="none";
      
  changeStudyDiv.style.display="none";
  studyFormDiv.style.display="block";
}
//연구 등록 데이터 처리하기------------------------------------------------------
studyForm.addEventListener('submit', (event) =>{
  event.preventDefault();

  let xhr = new XMLHttpRequest();
  let formData = new FormData(studyForm);
  xhr.open('post',`${cPath}/professor/professorStudyInsert.do`,true);
  xhr.setRequestHeader('enctype', 'multipart/form-data');
  xhr.onreadystatechange = () =>{
    if(xhr.readyState == 4 && xhr.status == 200){
      let cnt = xhr.responseText;
      console.log(cnt);
      if(cnt > 0){
        alert("등록성공");
        initAG();
      }else{
        alert("등록실패");
      }
    }
  }
  xhr.send(formData);

})
//연구 업데이트 ------------------------------------------------------------------------------
const studyEditDiv = document.querySelector('#studyEditDiv');


const stduyUpdate = () =>{

  changeStudyDiv.style.display="none";
  studyFormDiv.style.display="none";
  studyEditDiv.style.display="block";
  
}

editForm.on('submit', (event) =>{
  event.preventDefault();
  
  let study = JSON.parse(studyE.value);

  let xhr = new XMLHttpRequest();
  let formData = new FormData(editForm.get(0));
 

  xhr.open('POST',`${cPath}/professor/professorStudyUpdate.do?what=${study.studyNo}`, true);
  xhr.setRequestHeader('enctype', 'multipart/form-data');
  xhr.onreadystatechange = () =>{
    if(xhr.readyState == 4 && xhr.status == 200){
      let cnt = xhr.responseText;
      console.log(cnt);
      if(cnt > 0){
        alert("수정성공");
        initAG();
      }else{
        alert("수정실패");
      }

    }
  }
  xhr.send(formData);
})
//---------삭제------------------------------------------------------------
const studydelete = ()=>{
 
  // let formData = new FormData();
  // formData.append('studyNo' , hiddenStudyNo.value);

  // let xhr = new XMLHttpRequest();
  // xhr.open('POST',`${cPath}/professor/professorStudyDelete.do`,true);
  // xhr.onreadystatechange = () =>{
  //   if(xhr.readyState == 4 && xhr.status == 200){
  //     let cnt = xhr.responseText;
  //     console.log(cnt);
  //     if(cnt > 0){
  //       alert("삭제성공");
  //       initAG();
  //     }else{
  //       alert("삭제실패");
  //     }

  //   }
    
  // }
  // xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  // xhr.send(formData);

}









