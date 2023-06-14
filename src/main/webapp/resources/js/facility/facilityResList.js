/**
 * 
 */
 let facilityResBody = $("#facilityResBody");
 let viewUrlIni = facilityResBody.data("viewUrl");
 let cPath = facilityResBody.data("cpath");
 
 
let fn_makeTr = function(facility){
	/* 개인별예약현황 리스트 */
	return $("<tr>").append(
		 $("<td>").html(facility.frNo)
		, $("<td>").html(facility.faciName)
		, $("<td>").html(facility.frDate)
		, $("<td class='text-center fs-5'>")
			.append($("<div>").addClass("d-block badge bg-success")
			.html(facility.commName))
		, $("<td>").append(
        	$("<button>").addClass("btn btn-sm btn-primary").text("취소").on("click",function(){
        			let frNo = facility.frNo;
				$.ajax({
				    url: `${cPath}/facility/facilityResDelete.do`,
				    method: "GET",
				    dataType: "json",
				    data: { frNo: frNo },
				}).done(function(resp) {
				    if (resp.success) {
				        Swal.fire({
			                icon : 'success',
			                title : '예약취소에 성공했습니다',
			                text : '취소성공'
			            });
				        listForm.submit(); // 리스트 재조회
				    } else {
				        Swal.fire({
			                icon : 'warning',
			                title : '예약취소에 실패했습니다',
			                text : '취소 실패'
			            });
				    }
				}).fail(function(jqXHR, textStatus, errorThrown) {
				    	Swal.fire({
			                icon : 'error',
			                title : '오류가 발생했습니다',
			                text : '오류발생'
			            });
				});
			})
		)
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
		dataType : "json",
	}).done(function(resp, textStatus, jqXHR) {
		console.log(resp);
		facilityResBody.empty();

		let trTags = [];
		if(resp.length > 0){
			$.each(resp, function(idx, facility){
				trTags.push( fn_makeTr(facility) );
			});
		} else{
			trTags.push($("<tr>").html($("<td colspan='5'>").html("예약한 편의시설이 없습니다.")));
		}
		facilityResBody.append(trTags);
	});
	return false;
}).submit();