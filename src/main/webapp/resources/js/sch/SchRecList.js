
  var stuNo = "";
  // 단과대 선택하면 그 단과대에 맞는 학과명만 보이게 하기
  let deptNo = $("[name=deptNo]");
  let colNo = $("[name=colNo]").on("change", function(event) {
	deptNo.val("");
	deptNo.prop('disabled', false);
	
	let col = $(this).val();
	console.log(col);
	
	deptNo.find("option").not(":first").hide();
    deptNo.find("option").filter(`.${col}`).show();
    
    
})


/* ajax로 비동기 요청보내기 */
let listForm = $("[name=deptNo]").on("change", function(event){
	event.preventDefault(); // 기본 동작을 취소하여 폼 제출을 방지
	
	let url = this.action; // 폼의 액션 속성에서 요청 url을 가져온다.
	let method = this.method; // 폼의 메서드 속성에서 요청 메서드를 가져온다.
	
	$.ajax({
		url : url, // 요청URL
		method : method, // 요청 메서드
		data: $("[name=deptNo]").val(),
		dataType : "json" // 응답 데이터 타입(json형식)
	}).done(function(resp, textStatus, jqXHR) {
		console.log(resp);  // 응답 데이터를 콘솔에 출력
		listBody.empty(); 

		let trTags = []; //<tr> 요소들을 담을 배열
		if(resp.dataList.length > 0){ // 
			$.each(resp.dataList, function(idx, schrec){
				trTags.push(fn_makeTr(schrec) ); // 각각의 과제 데이터에 대해 fn_ makeTr함수를 호출<tr> 요소를 생성하고 배열에 추가
				console.log("schrec", schrec); // 과제 데이터를 콘솔에 출력
			});
		} else{
			trTags.push($("<tr>").html($("<td colspan='4'>").html("해당 장학생이 없습니다.")));
		}
		listBody.append(trTags); 
	});
	return false;
}).submit();


let listBody = $("#listBody");
let viewUrl = listBody.data("viewUrl");
let pagingArea = $(".pagingArea");
let fn_makeTr = function(schrec){
	console.log(schrec);
	
	/* 시험 종류 td */
	let schRecStateTd;
	if(schrec.schRecState == "M001"){
		schRecStateTd = $("<div>").addClass("btn btn-danger").html("확인대기");
	}else if(schrec.schRecState == "M002"){
		schRecStateTd = $("<div>").addClass("btn btn-secondary").html("확인완료");
	}else if(schrec.schRecState == "M003"){
		schRecStateTd = $("<div>").addClass("btn btn-success").html("지급대기");
	}else{
		schRecStateTd = $("<div>").addClass("btn btn-info").html("지급완료");
	}
	
	
	let aTag = $("<a>").attr("href", `${viewUrl}?what=${schrec.schRecNo}`)
						.html(`${schrec.addsch.schName}`);
	return $("<tr>").append(
		$("<td>").html(schrec.rnum)		
		, $("<td>").html(schrec.schRecNo)		
		, $("<td>").html(aTag)
		, $("<td>").html(schrec.addstu.memName)		
		, $("<td>").html(schRecStateTd)		
	);
}

let searchForm = $("[name=searchForm]").on("submit", function(event){
	event.preventDefault();
	let url = this.action;
	let method = this.method;
	let data = $(this).serialize();
	$.ajax({
		url : url,
		method : method,
		data : data,
		dataType : "json"
	}).done(function(resp, textStatus, jqXHR) {
		listBody.empty();
		pagingArea.empty();
		
		let trTags = [];
		if(resp.dataList.length > 0){
			$.each(resp.dataList, function(idx, schrec){
				trTags.push( fn_makeTr(schrec) );
			});
			pagingArea.html(resp.pagingHTML);
		}else{
			trTags.push($("<tr>").html($("<td colspan='4'>").html("게시글 없음.")));
		}
		listBody.append(trTags);
	});
	return false;
}).submit();


let searchUI = $("#searchUI").on("click", "#searchBtn" , function(){
	$(this).parents("#searchUI").find(":input[name]").each(function(idx, input){
		let iptName = input.name;
		let iptValue = $(input).val();
		searchForm.find(`[name=${iptName}]`).val(iptValue);
	});
	searchForm.submit();
});
let fn_paging = function(page, event){
	searchForm.find("[name=page]").val(page);
	searchForm.submit();
	searchForm.find("[name=page]").val("");
	return false;
}