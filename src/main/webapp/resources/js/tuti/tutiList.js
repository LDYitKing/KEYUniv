let listBody = $("#listBody");
let viewUrl = listBody.data("viewUrl");
let pagingArea = $(".pagingArea");
let fn_makeTr = function(tuti){
	let aTag = $("<a>").attr("href", `${viewUrl}?what=${tuti.tuitionNo}`)
						.html(`${tuti.tuitionStuNo}`);
	let state ="대기"					
	if(tuti.commName != null){
		state = tuti.commName
	}
				
	return $("<tr>").append(
		$("<td>").html(tuti.rnum)
		, $("<td>").html(aTag)		
		, $("<td>").html(tuti.deptName)		
		, $("<td>").html(tuti.tuitionName)		
		, $("<td>").html(tuti.tuitionGrade+'학년')		
		, $("<td>").html(tuti.tuitionSemester+"학기")		
		, $("<td>").html(state)		
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
			$.each(resp.dataList, function(idx, tuti){
				trTags.push( fn_makeTr(tuti));
				console.log("tuti :",tuti);
			});
			pagingArea.html(resp.pagingHTML);
		}else{
			trTags.push($("<tr>").html($("<td colspan='5'>").html("게시글 없음.")));
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