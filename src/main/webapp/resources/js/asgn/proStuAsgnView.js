/**
 * 
 */
let listBody = $("#listBody");
let viewUrl = listBody.data("viewUrl");
let pagingArea = $(".pagingArea");
let fn_makeTr = function(board){
				
	return $("<tr>").append(
		$("<td>").addClass("text-center").html(board.memName)		
		, $("<td>").addClass("text-center").html(board.asNo).on("click",function(){
				if(!board.asNo)	{
					Swal.fire({
			                icon : 'warning',
			                title : '제출한 과제가 없습니다.',
			            });
				}else{
					location.href=`${$.CPATH}/asgn/updateScore.do?what=${board.asNo}&&lect=${board.lectNo}`;
				}	
			})
		, $("<td>").html(board.asContent)			
		, $("<td>").addClass("text-center").html(board.asSdate)
		, $("<td>").addClass("text-center").html(board.asScore).on("click",function(){
				if(!board.asScore)	{
					Swal.fire({
		                icon : 'warning',
		                title : '제출한 과제가 없습니다.',
		            });
				}else{
					location.href=`${$.CPATH}/asgn/updateScore.do?what=${board.asNo}&&lect=${board.lectNo}`;
				}	
			})
	);
}
let updateScoreModal = $("#updateScoreModal").on("hidden.bs.modal", function(event) {
   error.empty();

   // form에 input reset 시키기
   updateScoreForm[0].reset();
})

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
			$.each(resp.dataList, function(idx, board){
				trTags.push( fn_makeTr(board) );
			});
			pagingArea.html(resp.pagingHTML);
		}else{
			trTags.push($("<tr>").html($("<td colspan='3'>").html("학생 없음.")));
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



