/**
*
*/
let asgnBody = $("#asgnBody");
let viewUrlIni = asgnBody.data("viewUrl");
let cPath = asgnBody.data("cpath");
let btnSpace = $(".btnSpace");
var queryString = window.location.search;

queryString = queryString.substring(1);
var param = {};
param = queryString.split("=");
console.log(param[1]);
var lectNo = param[1];


/* tr Tag만들기 */
let fn_makeTr = function(asgn){
	/* 과제 상세보기로 이동하는 a태그 만들기 */
	let aTag = $("<a>").attr("href", `javascript:fn_detail('${asgn.asgnNo }')`)
						.html(asgn.asgnNo);

	/* 과제 제출여부 확인 td */
	let submitTd;
	if(asgn.asgnSub){
		submitTd = $("<div>").addClass("badge d-block bg-success").html("제출");
	}else{
		submitTd = $("<div>").addClass("badge d-block bg-danger").html("미제출");
	}
	

	/* 과제리스트 tr */
	return $("<tr>").append(
		$("<td>").html(aTag)
			, $("<td>").html(asgn.asgnName)
			, $("<td>").html(asgn.asgnRdate)
			, $("<td>").html(asgn.asgnDdate)
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
		asgnBody.empty();

		let trTags = [];
		if(resp.length > 0){
			$.each(resp, function(idx, asgn){
				trTags.push( fn_makeTr(asgn) );
				console.log("asgn", asgn);
			});
		} else{
			trTags.push($("<tr>").html($("<td colspan='5'>").html("과제가 없습니다.")));
		}
		asgnBody.append(trTags);
	});
	return false;
}).submit();


let detailAsgn = $(".detailAsgn");
let detailView = $(".detailView");
/* 과제 상세보기 table 만들기 */
let fn_makeTable = function(realAsgnSub){
	let detailtrTags = [];
	detailtrTags.push($("<tr>").append(
			$("<th>").html("과제내용")
			, $("<td>").html(realAsgnSub.asgnContent)
		)
	)

	let file;
	if(realAsgnSub.asgnFile==null){
		file = "첨부파일 없음";
	}else{
		/* 교수가 첨부파일 넣는 곳. url넣기 */
		file = [];
		let atchFileList = realAsgnSub.atchFileGroup.atchfileList
		$.each(atchFileList, function(idx, af){
			let url = `${cPath}/as/attatch/download.do?atchId=${af.atchId}&atchSeq=${af.atchSeq}`;
			file.push( $("<a>").attr("href", url).html(af.atchOrginName));
			
			if(idx < atchFileList.length -1){
				file.push($("<span>").text(" | "));
			}
		})
		/*file = realAsgnSub.asgnFile;*/
	}
	detailtrTags.push($("<tr>").append(
			$("<th>").html("첨부파일")
			, $("<td>").html(file)
		)
	)

	/* 과제를 제출 했으면
	1. stuTags를 만들고
	2. '수정하기' 버튼 */

	/* 과제를 제출 안했으면?
	1. '제출하기' 버튼 */
	console.log("realAsgnSub:", realAsgnSub);
	console.log("submitInfo:",realAsgnSub.asgnSubmitList[0]);
	let stuTags = [];

	if(realAsgnSub.asgnSubmitList.length > 0){
	let submitInfo = realAsgnSub.asgnSubmitList[0];
		if(submitInfo!=null){
			stuTags.push($("<tr>").append($("<td>").attr("colspan", "2").attr("style", "border-top: 2px solid gray; text-align:left")));
			stuTags.push($("<tr>").append(
				$("<td>").attr("colspan", "2")
						.addClass("card-header asText")
						.attr("style", "background-color:#f2f2f2; text-align:left; border-bottom:2px solid black")
						.html($("<h4>").attr("style", "font-weight:bold").html("&nbsp&nbsp과제제출정보 보기"))
				)
			);
			stuTags.push($("<tr>").append(
				$("<th>").html("제출번호")
				, $("<td>").html(`${submitInfo.asNo}`)
				)
			);
	
			stuTags.push($("<tr>").append(
				$("<th>").html("제출일자")
				, $("<td>").html(`${submitInfo.asSdate}`)
				)
			);
	
			stuTags.push($("<tr>").append(
				$("<th>").html("제출내용")
				, $("<td>").append($("<pre>").html(`${submitInfo.asContent}`))
				)
			);
	
			let asFileresult;
			if(submitInfo.asFile==null){
				asFileresult = "첨부파일 없음";
			}else{
				asFileresult = [];
				let atchFileList = submitInfo.atchFileGroup.atchfileList
				$.each(atchFileList, function(idx, af){
					let url = `${cPath}/as/attatch/download.do?atchId=${af.atchId}&atchSeq=${af.atchSeq}`;
					asFileresult.push( $("<a>").attr("href", url).html(af.atchOrginName));
					
					if(idx < atchFileList.length -1){
						asFileresult.push($("<span>").text(" | "));
					}
				})
			}
			stuTags.push($("<tr>").append(
				$("<th>").html("첨부파일")
				, $("<td>").html(asFileresult)
				)
			);
			let asScoreresult;
			if(submitInfo.asScore<1){
				asScoreresult = "채점중";
			}else{
				asScoreresult = `${submitInfo.asScore}`;
			}
			stuTags.push($("<tr>").append(
				$("<th>").html("과제점수")
				, $("<td>").html(asScoreresult)
				)
			);
	
			detailtrTags.push(...stuTags);
	
			btnSpace.empty();
			btnSpace.append(
				$("<a>").attr("href", `${cPath}/asgn/asDelete.do?asgn=${submitInfo.asNo}&what=${lectNo}`)
									.addClass("btn btn-danger btn-sm deleteBtn")
									.html("제출취소")
			);
		
		}else{
			btnSpace.empty();
			btnSpace.append(
				$("<a>").attr("href", `${cPath}/asgn/asgnInsert.do?asgn=${realAsgnSub.asgnNo}&what=${lectNo}`)
									.addClass("btn btn-success btn-sm")
									.html("제출하기")
			);
		}
	};

	return detailtrTags;

}
/*
$(document).on("click",".deleteBtn", function(){
	Swal.fire({
		title: '삭제하시겠습니까?',
		showDenyButton: false,
		showCancelButton: true,
		confirmButtonText: '삭제',
	}).then((result) => {
		if (result.isConfirmed) {
			// 삭제 작업 수행 후 이동할 URL
      		var deleteUrl = `${cPath}/asgn/asgnDelete.do?asgn=${realAsgnSub.asgnNo}&what=${lectNo}`;

			// AJAX 요청으로 삭제 작업 수행
			$.ajax({
				url: deleteUrl,
				method: 'get',
				dataType:'json',
				contentType:'application/json',
				success: function(response) {
					// 삭제 작업 성공 시 페이지 이동
					if(response>0){
						window.location.href = `${cPath}/asgn/asgn.do?what=${lectNo}`;
					}
				},
				error: function() {
			      // 삭제 작업 실패 시 에러 처리
					Swal.fire('에러 발생', '삭제 작업을 수행하는 중에 오류가 발생했습니다.', 'error');
				}
			});
		}
	})
})*/
/* 과제 상세보기 데이터 가져오기 */
let fn_detail = function(asgnNo){

	/* ajax요청으로 과제 상세보기 */
	let viewUrl = `${cPath}/asgn/asgnView.do?what=${asgnNo}`;
	let viewMethod = "get"
	$.ajax({
		url : viewUrl,
		method : viewMethod,
		dataType : "json"
	}).done(function(resp, textStatus, jqXHR){
		console.log("asgnNo:"+resp.asgnNo);
		let realAsgnSub = resp;
		detailView.empty();
		detailView.append( fn_makeTable(realAsgnSub) );
		detailAsgn.show();
	});
};