//gridStackDiv 선택---------------------------------------------------------------------------------------------------------------------------
const gridStackDiv = document.querySelector('#gridStackDiv');
//jsp cPath------------------------------------------------------------------------------------------------------------------------------------
const cPath = document.querySelector('#cPath').value;
//jsp memRole---------------------------------------------------------------------------------------------------------------------------------
const memRole = document.querySelector('#memRole').value;
//jsp memNo-----------------------------------------------------------------------------------------------------------------------------------
const memNo = document.querySelector('#memNo').value;
//시큐리티 토큰---------------------------------------------------------------------------------------------------------------------------------
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');
// 그리드스택 시작------------------------------------------------------------------------------------------------------------------------------
let grid = GridStack.init({
	cellHeight: 70, //그리드 내 셀 높이 설정
	acceptWidgets: true, // 위젯 드롭 할 수 있는지 여부.
	removable: '#trash', // drag-out delete class 지정 (삭제할 수 있는 위젯)
});
//화면 로딩 완료후 시작 이벤트리스너-------------------------------------------------------------------------------------------------------------
document.addEventListener("DOMContentLoaded", () => {
	initGS();
});
// 구성원의 그리드 리스트 배열 생성--------------------------------------------------------------------------------------------------------------
let items = [];
//GridStack생성--------------------------------------------------------------------------------------------------------------------------------
const initGS = () => {
    // 새로운 위젯 생성 메서드 '셀렉터'. 어팬드될 위치 '바디', 헬퍼는 도움말 요소 '복사본표시'
    GridStack.setupDragIn('.newWidget', { appendTo: 'body', helper: 'clone' });
    // 생성될 그리드 전체 지정
    //List<vo> 받기 배열+객체
    // noMove: true 움직이지 못하게함.
    //  noResize: true 사이즈 조절 못하게 함.
    //  locked: true 위치 고정만 됨
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


    $.ajax({
        url : `${cPath}/selectUserGridList.do`,
        method : 'GET',
        dataType : 'json'
    }).done((resp)=>{
        console.log("이걸 가져왔더라", resp);
        if(resp.length > 0) {
            //그리드생성은 여기서 -----------------------------------------------------------------------------
            $.each(resp, (idx, userGrid)=>{
                let minMyW = 0;
                let minMyH = 0;
                switch(userGrid.gridCode){
                    case 'Z001':
                        minMyW = 10;
                        minMyH = 6;
                        break;
                    case 'Z002':
                        minMyW = 5;
                        minMyH = 11;
                        break;
                    case 'Z003':
                        minMyW = 4;
                        minMyH = 11;
                        break;
                    case 'Z004':
                        minMyW = 3;
                        minMyH = 6;
                        break;
                    case 'Z005':
                        minMyW = 3;
                        minMyH = 5;
                        break;
                    case 'Z006':
                        minMyW = 2;
                        minMyH = 6;
                        break;
                }

                let grid = {
                    x : userGrid.gridX
                    , y : userGrid.gridY
                    , w : userGrid.gridW
                    , h : userGrid.gridH
                    , id : userGrid.gridCode
                    , minW : minMyW
                    , minH : minMyH
                };
                items.push(grid);
            })
            console.log(items);
            grid.load(items);
            //그리드 잠금-----------------------------------------------------------------------------------
            fn_lockGrid();
            //여기에 비동기 처리 함수들 넣기-------------------------------------------------------------------
            fn_sikDan();
            fn_timePlan();
            fn_calendar();
            fn_gongji();
            fn_score();
            fn_news();
        }else{
            fn_insertGrid();
        }

    })
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
//    let items = [
//       {x: 0, y: 0, w: 12, h: 10, minW : 12, maxW : 12 ,minH: 10, maxH: 20, noMove: true, noResize: true}
//    ];
    //그리드 읽기
    // grid.load(items);
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
    grid.on('added removed change', function(e, items) {
      let str = '';
      items.forEach(function(item) {
        str += ' (x,y)=' + item.x + ',' + item.y;
    });
      console.log(e.type + ' ' + items.length + ' items:' + str );
    });
  };
//그리드스택툴----------------------------------------------------------------------------------------------------------------------------------
let fn_GSTool = () =>{
    let GSToolBtn = $("#GSToolBtn");
    let GSTool = $("#GSTool");
    if(GSToolBtn.attr("name") == "lock-closed-sharp"){
        // 툴 열기
        GSToolBtn.attr("name","lock-open-sharp");
        // GSTool.attr("style","display:block;");
        GSTool.addClass("d-block");
        GSTool.removeClass("d-none");
        fn_unlockGrid();
    }else{
        // 툴 닫기
        GSToolBtn.attr("name","lock-closed-sharp");
        // GSTool.attr("style","display:none;");
        GSTool.addClass("d-none");
        GSTool.removeClass("d-block");
        fn_lockGrid();
    }
}
//업데이트 그리드---------------------------------------------------------------------------------------------------------------------------------
let fn_updateGrid = () =>{
    let updateGridList = [];
    let deleteGridList = [];
    for(let i=1; i<=6; i++){
        let a = $(`[gs-id=Z00${i}]`);
        //삭제
        if(a.length === 0){
            let deleteGrid = {
                gridCode : `Z00${i}`,
                memNo : memNo,
            }
            console.log("잘들어왔나 딜리트", deleteGrid);
            deleteGridList.push(deleteGrid);

        }else{
            //수정
            let updateGrid = {
                gridCode : a.attr("gs-id"),
                memNo : memNo,
                gridX : a.attr("gs-x"),
                gridY : a.attr("gs-y"),
                gridW : a.attr("gs-w"),
                gridH : a.attr("gs-h"),
                gridStatus : "Z100"

            };
            console.log("잘들어왔나 포문", updateGrid);
            updateGridList.push(updateGrid);
        }
    }

    if(deleteGridList.length > 0){
        $.ajax({
            url : `${cPath}/girdDelete.do`,
            method : "POST",
            dataType : "json",
            data : JSON.stringify(deleteGridList),
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp > 0){
               // Swal.fire({title:"성공적으로 변경되었습니다."});
            }else{
                //Swal.fire({title:"삭제실패"});
            }

        })
    }

    if(updateGridList.length > 0){
        $.ajax({
            url : `${cPath}/girdUpdate.do`,
            method : "POST",
            dataType : "json",
            data : JSON.stringify(updateGridList),
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp > 0){
                Swal.fire({title:"성공적으로 변경되었습니다."});
            }else{
               // Swal.fire({title:"업뎃실패"});
            }

        })

    }


    // let foundZ006 = $("[gs-id=Z006]");
    // console.log("파운드공공육 : " ,foundZ006);
    // let grid = {
    //     gridCode : foundZ006.attr("gs-id"),
    //     memNo : memNo,
    //     gridX : foundZ006.attr("gs-x"),
    //     gridY : foundZ006.attr("gs-y"),
    //     gridW : foundZ006.attr("gs-w"),
    //     gridH : foundZ006.attr("gs-h"),
    //     gridStatus : "Z100"

    // };
    // console.log("잘들어왔나", grid);


}
//인서트 그리드---------------------------------------------------------------------------------------------------------------------------------
let fn_insertGrid = ()=>{
    let gridList = [];
    //나의성적----------------------------------------------------------------------------------
    let Z001 ={
        gridCode:"Z001"
        ,gridX: 0
        ,gridY: 0
        ,gridW: 10
        ,gridH: 6
        ,gridStatus:"Z100"
        ,memNo: memNo
    };
    gridList.push(Z001);
    //나의캘린더----------------------------------------------------------------------------------
    let Z002 ={
        gridCode:"Z002"
        ,gridX: 3
        ,gridY: 6
        ,gridW: 5
        ,gridH: 11
        ,gridStatus:"Z100"
        ,memNo: memNo
    };
    gridList.push(Z002);
    //내시간표----------------------------------------------------------------------------------
    let Z003 ={
        gridCode:"Z003"
        ,gridX: 8
        ,gridY: 6
        ,gridW: 4
        ,gridH: 11
        ,gridStatus:"Z100"
        ,memNo: memNo
    };
    gridList.push(Z003);
    //오늘의뉴스----------------------------------------------------------------------------------
    let Z004 ={
        gridCode:"Z004"
        ,gridX: 0
        ,gridY: 6
        ,gridW: 3
        ,gridH: 6
        ,gridStatus:"Z100"
        ,memNo: memNo
    };
    gridList.push(Z004);
     //공지----------------------------------------------------------------------------------
     let Z005 ={
        gridCode:"Z005"
        ,gridX: 0
        ,gridY: 12
        ,gridW: 3
        ,gridH: 5
        ,gridStatus:"Z100"
        ,memNo: memNo
    };
    gridList.push(Z005);
    //식단----------------------------------------------------------------------------------
    let Z006 ={
        gridCode:"Z006"
        ,gridX: 10
        ,gridY: 0
        ,gridW: 2
        ,gridH: 6
        ,gridStatus:"Z100"
        ,memNo: memNo
    };
    gridList.push(Z006);


    console.log("새로만든다------------------------");
    console.log(gridList);


    $.ajax({
        url : `${cPath}/gridInsert.do`,
        method : 'post',
        dataType : 'json',
        data : JSON.stringify(gridList),
        contentType : "application/json;charset=utf-8"
    }).done((resp)=>{
        if(resp > 0){
            initGS();
        }else{
            Swal.fire({title:"실패"});
        }

    })
}

//Z001 나의 성적 콘텐츠---------------------------------------------------------------------------------------------------------------------------
let fn_score = () =>{

    //처리코드-------------------------------------------------------------------------------------------------------


	// 데이터 가져오기
	let deptDgrade = ""; // 학과 졸업요건
	let stuDgrade = ""; // 학생 졸업요건
    $.ajax({
        url : `${cPath}/getDgrade.do`,
        method : 'post',
        dataType : 'json'
    }).done((resp)=>{
		console.log("이수학점 : ", resp);
		$.each(resp, function(i, data){
			if(data.drNo.startsWith('STU')){
				stuDgrade = data;
			}
			if(data.drNo.startsWith('DR')){
				deptDgrade = data;
			}

		})
		console.log("stuDgrade : ", stuDgrade);
		console.log("deptDgrade : ", deptDgrade);

		let learnDgr = stuDgrade.drMc + stuDgrade.drLac; // 현재 이수 학점 (전공 + 교양)

	    //--Z00*만 바꾸면됨.-------------------------------------------------------------------------------------------------
	    let foundZ001 = $("[gs-id=Z001]").children("div.grid-stack-item-content");
	    console.log(foundZ001);

		let content = `
        <div style="margin: 18px 18px;">
            <div style="height : 20px; display: flex; justify-content: space-between;">
                <h3>나의 성적</h3>
                <a href="#"><ion-icon name="add-circle-sharp" size="large"></ion-icon></a>
            </div>
            <hr>
            <div>
                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr;">
				<div>
	                <div id="chart2" style="display: inline-block;"></div>
					<div class="lead fs-5 mb-2 me-4 text-center">
						<p>이수<span class="text-info fw-bold">${learnDgr}</span>
							신청<span class="text-success fw-bold">${stuDgrade.countScr}</span>
							졸업학점<span class="fw-bold">${stuDgrade.drGrades}</span>
						</p>
					</div>
				</div>
                <div id="chart1" style="width: 400px; height: 300px;"></div>
                <div style="text-align:center;" class="mt-4">
                    <table class="table">
                            <tr>
                                <th style="background-color: #FFE400;">구분</th>
                                <th scope="col" style="background-color: #FFE400;">취득학점</th>
                                <th scope="col" style="background-color: #FFE400;">학과졸업요건</th>
                                <!-- <th scope="col">조회수</th> : 밀려난 셀 제거-->
                            </tr>
                            <tr>
                                <th>전공</th>
                                <td>${stuDgrade.drMc}</td>
                                <td>${deptDgrade.drMc}</td>
                            </tr>
                            <tr>
                                <th>교양</th>
                                <td>${stuDgrade.drLac}</td>
                                <td>${deptDgrade.drLac}</td>
                            </tr>
                            <tr>
                                <th>기타</th>
                                <td>${stuDgrade.drFcc}</td>
                                <td>${deptDgrade.drFcc}</td>
                            </tr>
                            <tr>
                                <th>합계</th>
                                <td>${learnDgr}</td>
                                <td>${deptDgrade.drGrades}</td>
                            </tr>
                            <tr>
								<td colspan="2"></td>
                            </tr>
                    </table>
                </div>
                </div>
            </div>
        </div>
                `;

	    foundZ001.html(content);

	    fn_myScoreScr(stuDgrade.drMc, stuDgrade.drLac, stuDgrade.drFcc);

		let per = stuDgrade.drGrades - learnDgr - stuDgrade.countScr;
	    var data = [
	        {label: '이수', value: learnDgr, color: '#1E96FF'},
	        {label: '신청', value: stuDgrade.countScr, color: '#70F170'},
	        {label: '졸업학점', value: per, color: '#dcdcdc'},
	    ];

	    var width = 400,
	        height = 250,
	        radius = Math.min(width, 500) / 2;

	    var pie = d3.pie()
	        .sort(null)
	        .startAngle(-Math.PI / 2)
	        .endAngle(Math.PI / 2)
	        .value(function(d) { return d.value; });

	    var arc = d3.arc()
	        .outerRadius(radius * 0.9)
	        .innerRadius(radius * 0.5);

	    var svg = d3.select('#chart2').append('svg')
	        .attr('width', width)
	        .attr('height', height)
	        .append('g')
	        .attr('transform', 'translate(' + width / 2 + ',' + 500 / 2 + ')');  // 변경: SVG를 가운데로 이동

	    var g = svg.selectAll('arc')
	        .data(pie(data))
	        .enter().append('g')
	        .attr('class', 'arc');

	    g.append('path')
	        .attr('d', arc)
	        .style('fill', function(d) { return d.data.color; });

	    // Center text
	    svg.append('text')
	        .attr('text-anchor', 'middle')
	        .attr('dy', '.35em')
	        .style('font-size', '16px');  // 글씨 크기 조정
	        /* .text('이수' + learnDgr + ' 신청' + stuDgrade.countScr + ' 졸업학점' + stuDgrade.drGrades); */
	    })


}
//Z002 나의 캘린더 콘텐츠-------------------------------------------------------------------------------------------------------------------------
let fn_calendar = () =>{
        //처리코드-------------------------------------------------------------------------------------------------------
        let content = `

                    <div style="margin: 18px 18px;">
                        <div style="height : 20px; display: flex; justify-content: space-between;">
                            <h3>캘린더</h3>
                            <a href="#"><ion-icon name="add-circle-sharp" size="large"></ion-icon></a>
                        </div>
                        <hr>
                                    <!-- Calendar sidebar -->
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                        <div>
                                        <button type="button" class="btn btn-icon btn-outline-success btn-sm" onclick="$('#calendarInsertModal').show()"><ion-icon name="add-outline" style="font-size: 20px;"></ion-icon></button>
                                        </div>

                                        <!-- Calendar - Checkboxes -->
                                        <div>
                                            <input id="personal-calendar" class="btn-check" type="radio" value=""  name="radio-stacked" autocomplete="off" checked>
                                            <label for="personal-calendar" class="btn btn-icon btn-outline-light btn-sm"> 개인</label>

                                            <input id="academic-calendar" class="btn-check" type="radio" value=""  name="radio-stacked" autocomplete="off">
                                            <label for="academic-calendar" class="btn btn-icon btn-outline-light btn-sm"> 학사</label>
                                        </div>

                                        <!-- END : Calendar - Checkboxes -->
                                        <!-- END : Calendar - Upcoming event -->
                                    </div>
                                    <!-- END : Calendar sidebar -->

                                    <!-- Full calendar container -->
                                    <div id='calendar-container' class="calendarCenter"
                                        style="width: 100%; height: 100%;">
                                        <div id='calendar' width: 100%; height: 100%;></div>
                                        <!-- 캘린더가 생성되는 곳-->
                                    </div>
                                <!-- END : Full calendar container -->
                    </div>

                    `
        //--Z00*만 바꾸면됨.-------------------------------------------------------------------------------------------------
        let foundZ002 = $("[gs-id=Z002]").children("div.grid-stack-item-content");
        console.log(foundZ002);
        foundZ002.html(content);

        //캘린더.js 데이터 가져옴--------------------------------------------------------------------------------------------
        fn_calendarApi();
        fn_calendarApi2();


}
//Z003 나의 시간표 콘텐츠-------------------------------------------------------------------------------------------------------------------------
let fn_timePlan = () =>{
    $.ajax({
        url : `${cPath}/sugang/list`,
        method : "post",
        dataType : "json"
    }).done((resp)=>{
        const colorList = ["#FEA47F", "#F8EFBA", "#D6A2E8", "#EAB543", "#55E6C1", "#ffcccc", "#BEF5BE", "#A4C3FF", "#FFE4B5"];

        let content = `
        <div style="margin: 18px 18px; height: auto;">
        <div style="height : 20px; display: flex; justify-content: space-between;">
            <h3>시간표</h3>
            <a href="#"><ion-icon name="add-circle-sharp" size="large"></ion-icon></a>
        </div>
        <hr>
        <div>
        <table id="myTimeTb" class="table table-bordered"  style="table-layout:fixed;" border="2px solid black">
        <tr>
            <th class="myTimWkTh"></th>
            <th class="myTimWkTh">월</th>
            <th class="myTimWkTh">화</th>
            <th class="myTimWkTh">수</th>
            <th class="myTimWkTh">목</th>
            <th class="myTimWkTh">금</th>
            <th class="myTimWkTh">토</th>
        </tr>`
        for(let i = 1; i <=13; i++){
            content += ` <tr><th class="myTimeTh">${i}</th>`
            for(let j = 100; j <= 600; j+=100){
                content += `<td class="myTimeTd text-center" id="myTime${i+j}" data-value="${i+j}"></td>`
            }
            content += `</tr>`
        }
        content += `</table></div></div>`

        let foundZ003 = $("[gs-id=Z003]").children("div.grid-stack-item-content");
        console.log(foundZ003);
        foundZ003.html(content);
        if(resp.length>0){
            $.each(resp,(idx, course)=>{
                let lect = course.lecture;
                let color = colorList[idx%10];
                        $.each(lect.lectDetailList, (idx, lt)=>{
                            let td = lt.ltdNo;
                            $(`#myTime${td}`).css("background-color", color);
                            $(`#myTime${td}`).html(`<small>${lect.lectName}</small>`);
                        })
            })
        }
    })

}
//Z004 뉴스 콘텐츠--------------------------------------------------------------------------------------------------------------------------------
let fn_news = () =>{
    //ajax---------------------------------------------------------------------------------------------------------------
    $.ajax({
        url: `${cPath}/CurriNews.do`,
        method: "GET",
        dataType: "json"
    }).done((resp) => {
        let content = `
        <div style="margin: 18px 18px;">
            <div style="display: flex; justify-content: space-between; height : 20px;">
                <h3>뉴스</h3>
                <a href="#"><ion-icon name="add-circle-sharp" size="large"></ion-icon></a>
            </div>
            <hr>
            <div>
                    `;
        //처리코드-------------------------------------------------------------------------------------------------------
        $.each(resp, (idx, myNews) => {
            if(idx === 7){
                return false;
            }

            content += `
            <div class="p-2 mb-2 " style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
            <a href="${myNews[0]}" class="text-decoration-none text-primary">${myNews[1]}</a>
        </div>
            `

        })
        content += `
                    </div>
                </div>`
        console.log("each문 통과");
        //--Z00*만 바꾸면됨.-------------------------------------------------------------------------------------------------
        let foundZ004 = $("[gs-id=Z004]").children("div.grid-stack-item-content");
        console.log(foundZ004);
        foundZ004.html(content);
    })

}
//Z005 공지 콘텐츠--------------------------------------------------------------------------------------------------------------------------------
let fn_gongji = () =>{
    //ajax---------------------------------------------------------------------------------------------------------------
    $.ajax({
        url: `${cPath}/univBoard/noticeUnivBoardList.do`,
        method: "GET",
        dataType: "json"
    }).done((resp) => {
        let content = `
        <div style="margin: 18px 18px;">
            <div style="display: flex; justify-content: space-between; height : 20px;">
                <h3>공지</h3>
                <a href="${cPath}/univBoard/univBoardList.do"><ion-icon name="add-circle-sharp" size="large"></ion-icon></a>
            </div>
            <hr>
            <div style="border:2px solid gray; border-radius:10px;">
                <table class="table text-center">
                    <colgroup>
			             <col width="20%"/>
			             <col width="10%"/>
			             <col width="13%"/>
			        </colgroup>
                    <tr style="background-color:#FFD900">
                        <th>제목</th>
                        <th>작성자</th>
                        <th>날짜</th>
                    </tr>
                    <div id="mainNotice">

                    `;
        //처리코드-------------------------------------------------------------------------------------------------------
        $.each(resp, (idx, univBoard) => {
            if(idx === 3){
                return false;
            }

            console.log("번호:",idx);
            console.log("보드:",univBoard);

            let date = univBoard.ubWdate;

            let ubTitle = univBoard.ubTitle;
            let memName = univBoard.memName;

            content += `
                <tr>
                    <td>${ubTitle}</td>
                    <td>${memName}</td>
                    <td>${date}</td>
                </tr>
            `

        })
        content += `
                </div>
                        </table>
                    </div>
                </div>`
        console.log("each문 통과");
        //--Z00*만 바꾸면됨.-------------------------------------------------------------------------------------------------
        let foundZ005 = $("[gs-id=Z005]").children("div.grid-stack-item-content");
        console.log(foundZ005);
        foundZ005.html(content);
    })

}
//Z006 식단 콘텐츠--------------------------------------------------------------------------------------------------------------------------------
let fn_sikDan = () =>{
    //ajax---------------------------------------------------------------------------------------------------------------
    $.ajax({
        url : `${cPath}/carte/carteList.do`,
        method : "GET",
        dataType : "json"
    }).done((resp)=>{
        let content = "";
        //처리코드-------------------------------------------------------------------------------------------------------
        $.each(resp,(idx, carte)=>{
            console.log(carte);
            let DOTW = carte.carteDay;

            let date = carte.carteDate;
            let month = date.substr(5,2);
            let day = date.substr(8,2);

            let lunch = carte.lunchMenu;
            let dinner = carte.dinnerMenu;

            let lunch2 = carte.lunchMenu2;
            let dinner2 = carte.dinnerMenu2;


            content = `
            <div style="margin: 18px 18px;">
                <div style="height : 20px; display: flex; justify-content: space-between;">
                    <h3>식단표</h3>
                    <a href="#"><ion-icon name="add-circle-sharp" size="large"></ion-icon></a>
                </div>
                <hr>
                <div style="border:2px solid gray; border-radius:10px;">
                    <table class="table table-bordered" border="2px solid black" style="height:280px;">
                        <tr>
                            <td colspan='2' style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 18px; text-align: center; vertical-align: middle; '>${month}월${day}일 (${DOTW}요일) </td>
                        </tr>
                        <tr>
                            <td colspan='2' style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; background-color: #FFE400'>중식</td>
                        </tr>
                        <tr>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>병한가</td>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>다영식당</td>
                        </tr>
                        <tr>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>${lunch}</td>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>${lunch2}</td>
                        </tr>
                        <tr>
                            <td colspan='2' style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; background-color: #FFE400'>석식</td>
                        </tr>
                        <tr>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>병한가</td>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>다영식당</td>
                        </tr>
                        <tr>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>${dinner}</td>
                            <td style='padding: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 13px; text-align: center; vertical-align: middle; '>${dinner2}</td>
                        </tr>
                    </table>
                </div>
            </div>

                    `
        })
        //--Z00*만 바꾸면됨.-------------------------------------------------------------------------------------------------
        let foundZ006 = $("[gs-id=Z006]").children("div.grid-stack-item-content");
        console.log(foundZ006);
        foundZ006.html(content);
    })
}
//Z001 나의 성적 생성---------------------------------------------------------------------------------------------------------------------------
let fn_Newscore = () =>{
    let a = $("[gs-id=Z001]");
    if(a.length === 0){
        // 보이는 것 생성 -------------------------------------------------------------------------
        //{x: 0, y: 0, w: 12, h: 10, minW : 12, maxW : 12 ,minH: 10, maxH: 20, noMove: true, noResize: true}
        let newScore = {x: 0, y: 0, w: 10, h: 6, id: 'Z001', minW: 10, minH: 6};
        grid.addWidget(newScore);
        fn_score();
        // DB데이터 추가-----------------------------------------------------------------------------
        let Z001InsertList = [];
        let Z001 ={
            gridCode:"Z001"
            ,gridX: 0
            ,gridY: 0
            ,gridW: 10
            ,gridH: 6
            ,gridStatus:"Z100"
            ,memNo: memNo
        };
        Z001InsertList.push(Z001);


        console.log("새로만든다Z001------------------------");
        console.log(Z001InsertList);


        $.ajax({
            url : `${cPath}/gridInsert.do`,
            method : 'post',
            dataType : 'json',
            data : JSON.stringify(Z001InsertList),
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp > 0){
                // Swal.fire({title:"성공"});
            }else{
                Swal.fire({title:"실패"});
            }

        })

    }else{
        Swal.fire({title:"이미 존재하는 위젯입니다."});
    }


}
//Z002 나의 캘린더 생성-------------------------------------------------------------------------------------------------------------------------
let fn_Newcalendar = () =>{
    let a = $("[gs-id=Z002]");
    if(a.length === 0){
        // 보이는 것 생성 -------------------------------------------------------------------------
        //{x: 0, y: 0, w: 12, h: 10, minW : 12, maxW : 12 ,minH: 10, maxH: 20, noMove: true, noResize: true}
        let newCalendar = {x: 3, y: 6, w: 5, h: 11, id: 'Z002', minW: 5, minH: 11};
        grid.addWidget(newCalendar);
        fn_calendar();
        // DB데이터 추가-----------------------------------------------------------------------------
        let Z002InsertList = [];
        let Z002 ={
            gridCode:"Z002"
            ,gridX: 3
            ,gridY: 6
            ,gridW: 5
            ,gridH: 11
            ,gridStatus:"Z100"
            ,memNo: memNo
        };
        Z002InsertList.push(Z002);


        console.log("새로만든다Z002------------------------");
        console.log(Z002InsertList);


        $.ajax({
            url : `${cPath}/gridInsert.do`,
            method : 'post',
            dataType : 'json',
            data : JSON.stringify(Z002InsertList),
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp > 0){
                // Swal.fire({title:"성공"});
            }else{
                Swal.fire({title:"실패"});
            }

        })

    }else{
        Swal.fire({title:"이미 존재하는 위젯입니다."});
    }

}
//Z003 나의 시간표 생성-------------------------------------------------------------------------------------------------------------------------
let fn_NewtimePlan = () =>{
    let a = $("[gs-id=Z003]");
    if(a.length === 0){
        // 보이는 것 생성 -------------------------------------------------------------------------
        //{x: 0, y: 0, w: 12, h: 10, minW : 12, maxW : 12 ,minH: 10, maxH: 20, noMove: true, noResize: true}
        let newtimePlan = {x: 8, y: 6, w: 4, h: 11, id: 'Z003', minW: 4, minH: 11};
        grid.addWidget(newtimePlan);
        fn_timePlan();
        // DB데이터 추가-----------------------------------------------------------------------------
        let Z003InsertList = [];
        let Z003 ={
            gridCode:"Z003"
            ,gridX: 8
            ,gridY: 6
            ,gridW: 4
            ,gridH: 11
            ,gridStatus:"Z100"
            ,memNo: memNo
        };
        Z003InsertList.push(Z003);


        console.log("새로만든다Z003------------------------");
        console.log(Z003InsertList);


        $.ajax({
            url : `${cPath}/gridInsert.do`,
            method : 'post',
            dataType : 'json',
            data : JSON.stringify(Z003InsertList),
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp > 0){
                // Swal.fire({title:"성공"});
            }else{
                Swal.fire({title:"실패"});
            }

        })

    }else{
        Swal.fire({title:"이미 존재하는 위젯입니다."});
    }

}
//Z004 뉴스 생성--------------------------------------------------------------------------------------------------------------------------------
let fn_Newnews = () =>{
    let a = $("[gs-id=Z004]");
    if(a.length === 0){
        // 보이는 것 생성 -------------------------------------------------------------------------
        //{x: 0, y: 0, w: 12, h: 10, minW : 12, maxW : 12 ,minH: 10, maxH: 20, noMove: true, noResize: true}
        let newNews = {x: 0, y: 6, w: 3, h: 6, id: 'Z004', minW: 3, minH: 6};
        grid.addWidget(newNews);
        fn_news();
        // DB데이터 추가-----------------------------------------------------------------------------
        let Z004InsertList = [];
        let Z004 ={
            gridCode:"Z004"
            ,gridX: 0
            ,gridY: 6
            ,gridW: 3
            ,gridH: 6
            ,gridStatus:"Z100"
            ,memNo: memNo
        };
        Z004InsertList.push(Z004);


        console.log("새로만든다Z004------------------------");
        console.log(Z004InsertList);


        $.ajax({
            url : `${cPath}/gridInsert.do`,
            method : 'post',
            dataType : 'json',
            data : JSON.stringify(Z004InsertList),
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp > 0){
                // Swal.fire({title:"성공"});
            }else{
                Swal.fire({title:"실패"});
            }

        })

    }else{
        Swal.fire({title:"이미 존재하는 위젯입니다."});
    }

}
//Z005 공지 생성--------------------------------------------------------------------------------------------------------------------------------
let fn_Newgongji = () =>{
    let a = $("[gs-id=Z005]");
    if(a.length === 0){
        // 보이는 것 생성 -------------------------------------------------------------------------
        //{x: 0, y: 0, w: 12, h: 10, minW : 12, maxW : 12 ,minH: 10, maxH: 20, noMove: true, noResize: true}
        let newGongji = {x: 0, y: 12, w: 3, h: 5, id: 'Z005', minW: 3, minH: 5};
        grid.addWidget(newGongji);
        fn_gongji();
        // DB데이터 추가-----------------------------------------------------------------------------
        let Z005InsertList = [];
        let Z005 ={
            gridCode:"Z005"
            ,gridX: 0
            ,gridY: 12
            ,gridW: 3
            ,gridH: 5
            ,gridStatus:"Z100"
            ,memNo: memNo
        };
        Z005InsertList.push(Z005);


        console.log("새로만든다Z005------------------------");
        console.log(Z005InsertList);


        $.ajax({
            url : `${cPath}/gridInsert.do`,
            method : 'post',
            dataType : 'json',
            data : JSON.stringify(Z005InsertList),
            contentType : "application/json;charset=utf-8"
        }).done((resp)=>{
            if(resp > 0){
                // Swal.fire({title:"성공"});
            }else{
                Swal.fire({title:"실패"});
            }

        })

    }else{
        Swal.fire({title:"이미 존재하는 위젯입니다."});
    }
}
//Z006 식단 생성--------------------------------------------------------------------------------------------------------------------------------
let fn_NewsikDan = () =>{
    let a = $("[gs-id=Z006]");
        if(a.length === 0){
            // 보이는 것 생성 -------------------------------------------------------------------------
            //{x: 0, y: 0, w: 12, h: 10, minW : 12, maxW : 12 ,minH: 10, maxH: 20, noMove: true, noResize: true}
            let newsikDan = {x: 10, y: 0, w: 2, h: 6, id: 'Z006', minW: 2, minH: 6};
            grid.addWidget(newsikDan);
            fn_sikDan();
            // DB데이터 추가-----------------------------------------------------------------------------
            let Z006InsertList = [];
            let Z006 ={
                gridCode:"Z006"
                ,gridX: 10
                ,gridY: 0
                ,gridW: 2
                ,gridH: 6
                ,gridStatus:"Z100"
                ,memNo: memNo
            };
            Z006InsertList.push(Z006);


            console.log("새로만든다Z006------------------------");
            console.log(Z006InsertList);


            $.ajax({
                url : `${cPath}/gridInsert.do`,
                method : 'post',
                dataType : 'json',
                data : JSON.stringify(Z006InsertList),
                contentType : "application/json;charset=utf-8"
            }).done((resp)=>{
                if(resp > 0){
                    // Swal.fire({title:"성공"});
                }else{
                    Swal.fire({title:"실패"});
                }

            })

        }else{
            Swal.fire({title:"이미 존재하는 위젯입니다."});
        }
}
//포틀릿 잠금------------------------------------------------------------------------------------------------------------------------------------
let fn_lockGrid = () =>{
        grid.enableMove(false);
        grid.enableResize(false);
}
//포틀릿 해제------------------------------------------------------------------------------------------------------------------------------------
let fn_unlockGrid = () =>{
    grid.enableMove(true);
    grid.enableResize(true);
}
//캘린더========================================================================================================================================
//---------------------------------------------------------------------------------------------------------------------------------------------
let calendar = null;

let fn_calendarApi = () => {
	const Calendar = FullCalendar.Calendar; // 캘린더 api 생성하기

	const calendarEl = document.querySelector('#calendar'); // body에 캘린더 넣을 부분 태그선택

	calendar = new Calendar(calendarEl, {
		selectable: true,
		selectHelper: true,
		editable: true,
		displayEventTime: false,
		eventResizableFromStart: true,
		eventResizableFromEnd: true,
		select: function(res) {
		},
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay'
		},
		events: `${cPath}/calevents`,  // url 서블릿 주소 써주면 됨!

		editable: true, // 편집가능

		locale: 'ko', // 한국어
		eventDrop: function(info) {
			let start = info.event.start;
			let end = info.event.end;
			let id = info.event.id;

			$.ajax({
				url: `${cPath}/calendarUpdate`,
				type: "post",
				data: JSON.stringify({ sdate: start, edate: end, id: id }),
				contentType: "application/json",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function() {
					Swal.fire("일정이 수정 되었습니다.");
				},
			});
		},

		eventResize: function(info) {
			let start = info.event.start;
			let end = info.event.end;
			let id = info.event.id;

			$.ajax({
				url: `${cPath}/calendarUpdate`,
				type: "post",
				data: JSON.stringify({ sdate: start, edate: end, id: id }),
				contentType: "application/json",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function() {
					Swal.fire("일정이 수정 되었습니다.");
				},
			});
		},


		// 일정 클릭하면 상세보기 모달로 보여주기
		eventClick: function(info) {
			$("#id").val(info.event.id);
			$("#title").val(info.event.title);
			$("#sdate").val(info.event.start);   // assuming sdate corresponds to start
			$("#edate").val(info.event.end);     // assuming edate corresponds to end
			$("#background-color").val(info.event.backgroundColor);
			$("#text-color").val(info.event.textColor); // assuming textColor corresponds to text-color

			var start = info.event.start;
			var end = info.event.end;
			var id = info.event.id;
			var title = info.event.title;
			var textColor = info.event.textColor; // assuming this exists in your event object
			var backgroundColor = info.event.backgroundColor;

			$.ajax({
				url: `${cPath}/calendarView`,
				type: "post",
				data: JSON.stringify({
					what: id,
					sdate: start,
					edate: end,
					title: title,
					textColor: textColor,
					backgroundColor: backgroundColor
				}),
				contentType: "application/json",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function(res) {
					$("#cid").val(res.id); // 아주 안좋아!
					$("#ctitle").val(res.title);
					$("#csdate").val(res.sdate);
					$("#cedate").val(res.edate);
					$("#cbackgroundColor").val(res.backgroundColor);
					$("#ctextColor").val(res.textColor);
				}
			})
			$('#calendarDetailModal').show();
		}
	});
	calendar.render();
}


let calendarDetailModalClose = () => { $('#calendarDetailModal').hide(); $("#calendarDetailForm")[0].reset(); }

let calendarInsertModalClose = () => { $('#calendarInsertModal').hide(); $("#calendarinsertForm")[0].reset(); }


// 모달창에서 일정 수정하기
let modify = () => {
	let id = $("#cid").val();
	let title = $("#ctitle").val();
	let start = $("#csdate").val();
	let end = $("#cedate").val();
	let backgroundColor = $("#cbackgroundColor").val();
	let textColor = $("#ctextColor").val();
	let sendData = {}
	sendData = {
		id: id,
		title: title,
		sdate: start,
		edate: end,
		backgroundColor: backgroundColor,
		textColor: textColor,
	}
	$.ajax({
		url: `${cPath}/calendarSelectUpdate`,
		type: "post",
		data: JSON.stringify(sendData),
		contentType: "application/json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			Swal.fire("일정이 수정 되었습니다.");
			calendar.refetchEvents();
			calendar.render();
			$('#calendarDetailModal').hide();
			$("#calendarinsertForm")[0].reset();
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	})
}

let insert = () => {
	let title = $("#title").val();
	let sdate = $("#sdate").val();
	let edate = $("#edate").val();
	let background = $("#background-color").val();
	let textColor = $("#text-color").val();

	let eventData = {

		title: title,
		sdate: sdate,
		edate: edate,
		backgroundColor: background,
		textColor: textColor
	};
	$.ajax({
		url: `${cPath}/calendarInsert`,
		type: "POST",
		data: JSON.stringify(eventData),
		contentType: "application/json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			Swal.fire("일정이 추가 되었습니다.");
			calendar.refetchEvents();
			calendar.render();
			$('#calendarInsertModal').hide();
			$("#calendarinsertForm")[0].reset();
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	});
};

let remove = () => {
	let id = $("#cid").val();
	let sendData = {}
	sendData = {
		id: id,
	}
	$.ajax({
		url: `${cPath}/calendarDelete`,
		type: "post",
		data: JSON.stringify(sendData),
		contentType: "application/json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			Swal.fire("일정삭제 완료!!");
			calendar.refetchEvents();
			calendar.render();
			$('#calendarDetailModal').hide();
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	})
}

var sessionId = '<%= request.getSession().getId() %>';

$(document).on('change', "input[name='radio-stacked']", function() {
	var selectedCalendar = $(this).next('label').text().trim();
	var memNo;
	console.log("이벤트를 체크하고 있나");

	// 선택된 캘린더에 따라 memNo를 다르게 설정합니다.
	if ($('#academic-calendar').is(':checked')) {
		memNo = '8888001';
	} else if ($('#personal-calendar').is(':checked')) {
		memNo = sessionId;
	}

	$.ajax({
		url: `${cPath}/calendarRadio`,
		type: 'POST',
		data: JSON.stringify({ 'memNo': memNo }),
		contentType: 'application/json',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			calendar.setOption('events', res);
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	});
});


let fn_calendarApi2 = () => {
	$('input[type=radio][name=radio-stacked]').change(function() {
		if (this.id == 'academic-calendar') {
			$('.btn.btn-primary').prop('disabled', true);

			// 캘린더의 이벤트 클릭 핸들러를 덮어쓰기
			calendar.setOption('eventClick', null);  // 아무것도 하지 않음

			// 캘린더의 선택 이벤트를 비활성화
			calendar.setOption('selectable', false);
			calendar.setOption('select', null);  // 아무것도 하지 않음

			// 캘린더의 eventDrop, eventResize 비활성화
			calendar.setOption('eventDrop', null);  // 아무것도 하지 않음
			calendar.setOption('eventResize', null);  // 아무것도 하지 않음

			// 캘린더의 editable 옵션 비활성화
			calendar.setOption('editable', false);
		}
		else if (this.id == 'personal-calendar') {
			// 개인 캘린더 선택 시
			// 개인 일정 추가 버튼 활성화
			$('.btn.btn-primary').prop('disabled', false);

			// 캘린더의 이벤트 클릭 핸들러를 원래대로 복구
			calendar.setOption('eventClick', function(info) {
				$("#id").val(info.event.id);
				$("#title").val(info.event.title);
				$("#sdate").val(info.event.start);   // assuming sdate corresponds to start
				$("#edate").val(info.event.end);     // assuming edate corresponds to end
				$("#background-color").val(info.event.backgroundColor);
				$("#text-color").val(info.event.textColor); // assuming textColor corresponds to text-color

				var start = info.event.start;
				var end = info.event.end;
				var id = info.event.id;
				var title = info.event.title;
				var textColor = info.event.textColor; // assuming this exists in your event object
				var backgroundColor = info.event.backgroundColor;

				$.ajax({
					url: `${cPath}/calendarView`,
					type: "post",
					data: JSON.stringify({
						what: id,
						sdate: start,
						edate: end,
						title: title,
						textColor: textColor,
						backgroundColor: backgroundColor
					}),
					contentType: "application/json",
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success: function(res) {
						$("#cid").val(res.id); // 아주 안좋아!
						$("#ctitle").val(res.title);
						$("#csdate").val(res.sdate);
						$("#cedate").val(res.edate);
						$("#cbackgroundColor").val(res.backgroundColor);
						$("#ctextColor").val(res.textColor);
					}
				})
				$('.calendarDetailModal').show();
			});

			// 캘린더의 선택 이벤트를 활성화
			calendar.setOption('selectable', true);
			calendar.setOption('select', function(res) {
			});

			// 캘린더의 eventDrop 활성화
			calendar.setOption('eventDrop', function(info) {
				let start = info.event.start;
				let end = info.event.end;
				let id = info.event.id;

				$.ajax({
					url: `${cPath}/calendarUpdate`,
					type: "post",
					data: JSON.stringify({ sdate: start, edate: end, id: id }),
					contentType: "application/json",
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success: function() {
						alert("일정이 변경되었습니다.");
					},
				});
			});
			// 캘린더의 editable 옵션 비활성화
			calendar.setOption('editable', true);
		}
	});
};
//성적 스크립트 함수---------------------------------------------------------------------------------------------------
let fn_myScoreScr = (mc, lac, fcc) => {
	let chart = c3.generate({
		bindto: '#chart1',
		data: {
			columns: [
				['전공', mc],
				['교양', lac],
				['기타', fcc]
			],
			type: 'bar'
		},
		bar: {
			width: {
				ratio: 0.5 // this makes bar width 50% of length between ticks
			}
			// or
			//width: 100 // this makes bar width 100px
		}
	});

}

