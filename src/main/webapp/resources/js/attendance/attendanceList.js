let attendTableDiv = $(".attendTableDiv");
let realwhat =  attendTableDiv.data("what");
let theadTr = $(".theadTr");
let tbodyTr = $(".tbodyTr");
let tfootTr = $(".tfootTr")

let fn_update = function(formData){
	let UpdateUrl = `${$.CPATH}/attendance/attedUpdate.do`;
	let UpdateMethod = 'post';
	let UpdateData = JSON.stringify(formData);
	
	$.ajax({
		url : UpdateUrl
		, method : UpdateMethod
		, data : UpdateData
		, dataType : "json"
		, contentType : "application/json;charset=UTF-8"
	}).done(function(resp, textStatus, jqXHR){
		console.log(resp);
		if(resp>0){
			alert(`저장성공:${resp}개 변경!`)
		}else{
			alert(`저장실패:${resp}개 변경!`)
		}
		$("#attendViewBtn").trigger("click");
	})
	
}


//전체보기 버튼 누르면, 
let attendViewBtn = $(".attendViewBtn").on("click", function(event){
	console.log("체킁");
	event.preventDefault();
	
	let fn_makethTag = function(date){
		return $("<th>").html(date)
	}
	
	
	let url = `${$.CPATH}/attendance/attedStuList.do`;
	let method = 'post';
	let what = realwhat;
	
	/* ajax 전송*/
	$.ajax({
		url : url,
		method : method,
		data : {what:what}, 
		dataType : "json"
		/*결과받기 */
	}).done(function(resp, textStatus, jqXHR){
		theadTr.empty();
		tbodyTr.empty();
		tfootTr.empty();
		
		//thead만들기
		console.log(resp);
		let theadTags=[];
		let thTags=[]
		if(resp.dateSet.length > 0){
			$.each(resp.dateSet, function(idx, date){
				thTags.push(fn_makethTag(date));
			}) 
			theadTags.push(
				$("<tr>").append(
					$("<th>").html("이름"),
					thTags
				)
			);
			
		} else{
			theadTags.push($("<tr>").html($("<th>").html("-")));
		}
		theadTr.append(theadTags);
		
		
		let attendLength = 0; // tfoot용 attendLength
		//tbody만들기
		let tbodyTags=[];
		if(resp.stuList.length > 0){
			
			$.each(resp.stuList, function(m, stu){ //학생한명
				console.log("stu", stu)
				attendLength = stu.attendList.length + 1 //tfoot
				
				let attendTags=[];
				$.each(stu.attendList, function(a, attend){
					
					let select = $("<select>")
									.attr("data-attendno", attend.attendNo);
									
		            let optionO = $("<option>").attr("value", "D001").html("O");
		            let optionSlash = $("<option>").attr("value", "D002").html("/");
		            /*let optionCaret = $("<option>").attr("value", "D003").html("^");*/
		
		            select.append(optionO);
		            select.append(optionSlash);
		            /*select.append(optionCaret);*/
		
		            if (attend.attendState === "D001") {
		                optionO.attr("selected", true);
		            } else if (attend.attendState === "D002") {
		                optionSlash.attr("selected", true);
		            } /*else if (attend.attendState === "D003") {
		                optionCaret.attr("selected", true);
		            }*/
		            attendTags.push($("<td>").html(select));
				});
				let tdTags=$("<tr>");
				tdTags.append( $("<td>").html(stu.student.memName) );
				tdTags.append(attendTags);
				tbodyTags.push(tdTags);
			});
		}else{
			tbodyTags.push($("<tr>").html($("<td>").html("아직 출석조회 기간이 아닙니다.")));
		}
		$.each(tbodyTags, function(i, tr) {
		    tbodyTr.append(tr);
		});
		
		
		// tfoot 만들기
		let saveButton = $("<button>").addClass("btn btn-primary").attr("type", "submit").text("저장");
		tfootTr.append($("<tr>").append($("<td>").attr("colspan", attendLength).html(saveButton)));
		
		saveButton.click(function(event){
			event.preventDefault();
			
			let formData = [];
			let attendNo = null;
			let attendState = null;
			let attendData = [];
			tbodyTr.find("select").each(function(){
				attendNo = $(this).data("attendno");
				attendState = $(this).find("option:selected").val();
				attendData = {
					attendNo : attendNo, 
					attendState : attendState
				}
				formData.push(attendData);
			})	
			console.log("formData", formData);
			fn_update(formData);
		});
		
		//table 감싸는 div 보이게 바꾸기
		attendTableDiv.attr("style","display:inline-block; overflow:auto; ");
	});
	return false;
	
})


