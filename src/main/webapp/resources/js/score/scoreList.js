/**
 * 
 */
let listBody = $("#listBody");
let detailScore = $("#detailScore");
let viewUrlIni = listBody.data("viewUrl");
let cPath = listBody.data("cpath");
let btnSpace = $(".btnSpace");
var queryString = window.location.search;
queryString = queryString.substring(1);
var param = {};
param = queryString.split("=");
console.log(param[1]);
var lectNo = param[1];

/* 학생 리스트 tr Tag만들기 */
let fn_makeTr = function(list){

		/* 수강생리스트 tr */
		return $("<tr>").append(
	    $("<td>").html(list.deptName),
	    $("<td>").html(list.stuNo),
	    $("<td>").html(list.memName).on("click", function () {
	        var studentName = $(this).html();
	        $("input[name='stuName']").val(studentName);
	
	        var studentScore = getStudentScore(studentName);
	        $("input[name='stuScore']").val(studentScore);
	
	        var studentData = getStudentData(studentName);
	        $("input[name='courseNo']").val(studentData.courseNo).attr("type", "hidden");
	        $("input[name='stuNo']").val(studentData.stuNo).attr("type", "hidden");
	
	        var csScore = studentScore >= 95 ? 4.5 : studentScore >= 90 ? 4.0 : studentScore >= 85 ? 3.5 :
	            	      studentScore >= 80 ? 3.0 : studentScore >= 75 ? 2.5 : studentScore >= 70 ? 2.0 :
	                      studentScore >= 65 ? 1.5 : studentScore >= 60 ? 1.0 : "";
	        $("input[name='csScore']").val(csScore);
	    })
	);
  
	  function getStudentData(studentName) {
	    for (var i = 0; i < scores.length; i++) {
	      if (scores[i].memName === studentName) {
	        return scores[i];
	      }
	    }
	    return null;
	  }
};

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
		listBody.empty();

		let trTags = [];
		if(resp.length > 0){
			$.each(resp, function(idx, list){
				trTags.push( fn_makeTr(list) );
				console.log("list", list);
			});
		} else{
			trTags.push($("<tr>").html($("<td colspan='3'>").html("학생이 없습니다.")));
		}
		listBody.append(trTags);
	});
	return false;
}).submit();











