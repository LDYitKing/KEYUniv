/**
 * 
 */
let examBody = $("#examBody");
let viewUrlIni = examBody.data("viewUrl");
let cPath = examBody.data("cpath");

let btnSpace = $(".btnSpace");
var queryString = window.location.search;
queryString = queryString.substring(1);
var param = {};
param = queryString.split("=");
console.log(param[1]);
var lectNo = param[1];
 
 
let fn_makeTr = function(exam) {
    /* 시험 상세보기로 이동하는 a태그 만들기 */
    let aTag = $("<a>").attr("href", `javascript:fn_detail('${exam.examNo}')`)
                       .html(exam.examNo);

    let examDate = new Date(exam.examDate);
    let formattedExamDate = examDate.toLocaleDateString("ko-KR");
	
	/*출제 여부 td*/
	let submitExamTd;
	if(exam.eqSub){
		submitExamTd = $("<div>").addClass("btn btn-light").html("출제 완료").on("click",function(){
			location.href = `${cPath}/exam/proExamPaperForm.do?what=${exam.examNo}`;
		});
	}else{
		submitExamTd = $("<div>").addClass("btn btn-dark btn-sm").html("문제 출제").on("click",function(){
			location.href = `${cPath}/exam/examQue.do?what=${exam.examNo}`;
		});
	}
	

    /* 시험목록 tr */
    return $("<tr>").append(
        $("<td>").html(aTag),
        $("<td>").html(exam.examName),
        $("<td>").html(formattedExamDate),
        $("<td>").html(exam.examKind),
        $("<td>").html(submitExamTd),
        $("<td>").append($("<button>").addClass("btn btn-outline-danger").text("시험삭제").on("click", function() {
            let examNo = exam.examNo;
            $.ajax({
                url: `${cPath}/exam/examDelete.do`,
                method: "GET",
                dataType: "json",
                data: { examNo: examNo },
            }).done(function(resp) {
                if (resp.success) {
                    Swal.fire({
                        icon: 'success',
                        title: '삭제에 성공했습니다',
                        text: '삭제성공'
                    });
                    listForm.submit(); // 리스트 재조회
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: '삭제에 실패했습니다',
                        text: '삭제 실패'
                    });
                }
            }).fail(function(jqXHR, textStatus, errorThrown) {
                Swal.fire({
                    icon: 'error',
                    title: '오류가 발생했습니다',
                    text: '오류발생'
                });
            });
        }))
    );
}
/* ajax로 비동기 요청보내기 */
let listForm = $("[name=listForm]").on("submit", function(event){
	event.preventDefault();
	let url = this.action;
	let method = this.method;
	$.ajax({
		url : url,
		method : method,
		dataType : "json"
	}).done(function(resp, textStatus, jqXHR) {
		console.log(resp);
		examBody.empty();

		let trTags = [];
		if(resp.length > 0){
			$.each(resp, function(idx, exam){
				trTags.push( fn_makeTr(exam) );
				console.log("exam", exam);
			});
		} else{
			trTags.push($("<tr>").html($("<td colspan='5'>").html("등록된 시험이 없습니다.")));
		}
		examBody.append(trTags);
	});
	return false;
}).submit();


let detailExam = $(".detaileExam");
let detailView = $(".detailView");
/* 시험 상세보기 table 만들기 */
let fn_makeTable = function(examList){
	let detailtrTags = [];
	let examDate = new Date(examList.examDate);
	let formattedExamDate = examDate.toLocaleDateString("ko-KR");
	
	/* 시험 구분 td */
	let examTypeTd;
	if(examList.examType == "E001"){
		examTypeTd = "대면";
	}else{
		examTypeTd = "비대면";
	}
	
	
	detailtrTags.push($("<tr>").append(
			$("<th>").html("시험명")
			, $("<td>").html(examList.examName)
		)
	)
	detailtrTags.push($("<tr>").append(
			$("<th>").html("강의명")
			, $("<td>").html(examList.lectName)
		)
	)
	detailtrTags.push($("<tr>").append(
			$("<th>").html("학사년도 학기")
			, $("<td>").html(examList.ayYear+"년도 "+examList.aySemester+"학기")
		)
	)
	detailtrTags.push($("<tr>").append(
			$("<th>").html("시험일자")
			, $("<td>").html(formattedExamDate)
		)
	)
	detailtrTags.push($("<tr>").append(
			$("<th>").html("시험시간")
			, $("<td>").html(examList.examStime+":00 ~ "+examList.examEtime+":00")
		)
	)	
	
	detailtrTags.push($("<tr>").append(
			$("<th>").html("시험종류")
			, $("<td>").html(examList.examKind)
		)
	)
	detailtrTags.push($("<tr>").append(
			$("<th>").html("시험구분")
			, $("<td>").html(examTypeTd)
		)
	)	
	return detailtrTags;
}

/* 과제 상세보기 데이터 가져오기 */
let fn_detail = function(examNo){
	console.log("클릭?"+examNo);

	/* ajax요청으로 과제 상세보기 */
	let viewUrl = `${cPath}/exam/examView.do?what=${examNo}`;
	let viewMethod = "get"
	$.ajax({
		url : viewUrl,
		method : viewMethod,
		dataType : "json"
	}).done(function(resp, textStatus, jqXHR){
		console.log("examNo:"+resp.examNo);
		let examList = resp;
		detailView.empty();
		detailView.append( fn_makeTable(examList) );
		detailExam.show();
	});
};






