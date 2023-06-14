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
 
 
/* tr Tag만들기 */
let fn_makeTr = function(exam){	
	let examDate = new Date(exam.examDate);
	let formattedExamDate = examDate.toLocaleDateString("ko-KR");
	
	/* 응시여부 td */
	let submitTd;
	if(exam.asSub){
		submitTd = $("<div>").addClass("badge bg-success ebage badge-lg").html("결과보기").attr("style", "cursor:pointer").on("click",function(){
			location.href = `${cPath}/exam/stuExamPaperSubmitForm.do?what=${exam.examNo}`;
		});
	}else{
		submitTd = $("<div>").addClass("badge bg-primary ebage badge-lg").html("시험보기").attr("style", "cursor:pointer").on("click",function(){
			location.href=`${cPath}/exam/stuExamPaperForm.do?what=${exam.examNo}`;
		});
	}
	
	
	/* 시험목록 tr */
	return $("<tr>").append(
		$("<td>").html(exam.examNo)
			, $("<td>").html(exam.examName)
			, $("<td>").html(formattedExamDate)
			, $("<td>").html(exam.examKind)
			, $("<td>").html(submitTd)
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