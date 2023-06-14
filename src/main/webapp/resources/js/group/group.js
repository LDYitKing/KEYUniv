/**
 * 
 */
	let listArea = $("#listArea");
	let proSel = $(".pro").hide();
	let empSel = $(".emp").hide();
	let groupRadio = $("input[name=groupRadio]").on("change", function(event) {
		proSel.hide();
		empSel.hide();

		$("[name=deptNoSel]").val("");
		$("[name=empDeptSel]").val("");
		$("[name=searchWord]").val("");
		
		$(`.${$("input[name=groupRadio]:checked").val()}`).show();
		
		searchForm.submit();
	})
	
	let searchForm = $("#searchForm").on("submit", function(event) {
		event.preventDefault();
		
		listArea.empty();
		
		// radio (memRole)
		// deptNo
		// empDept
		// memNo
		// memName
		let groupRadio = $("input[name='groupRadio']:checked").val();
		if(groupRadio==null) return;
		
		let url = `${$.CPATH}/group/members/${groupRadio}`;
		
		let data = {};
		data["deptNo"] = $("[name=deptNoSel]").val();
		data["empDept"] = $("[name=empDeptSel]").val();
		
		data[`${$('[name=searchType]').val()}`] = $("[name=searchWord]").val();

		console.log("data:", data);
		
		$.ajax({
			url: url,
			method: "post",
			data: data,
			dataType: "json",
			success: function(resp) {
				let trTags = [];
				
				if(resp.length > 0){
					$.each(resp, function(idx, member){
						trTags.push(fn_makeTr(member, groupRadio));
					})
					
				}else{
					trTags.push($("<tr>").html($("<td colspan='4'>").html("조회 결과가 없습니다.")));
				}
				
				listArea.append(trTags);
				
			}
		})
		
		return false;
	})
	
	let fn_makeTr = (member, group) => {

	   // tr 태그 만들어서 td 태그들을 append
	   // return tr태그 (data속성에 member memNo 넣어줌)
	   
	   let trTag = $("<tr>").append(
	      $("<td>").html("<input onclick='event.cancelBubble=true' type='checkbox' name='cbkMem'>")
	      , $("<td>").html(member.memName)
	      , $("<td>").html(member.memTel)
	      , $("<td>").html(member.memEmail)
	   ).addClass("memTr")
	   .data("member", member.memNo)
	   .data("group", group);
	   return trTag;
	}
	
	// 체크 박스 구현
	let cbxMemAll = $("#cbxMemAll").on("click", function () {
	   // 만약 cbkMemAll이 checked true이면 cbkMem 모두 checked true
	   // 아니면(false) cbkMem 모두 checked false

	   $(this).prop("checked", (i, v) => {
	      //          console.log("v:",v);
	      $("[name=cbkMem]").prop("checked", v);
	   })

	});	
	
	let groupFormDiv = $("#groupFormDiv");
	let profileImgDiv = $("#profileImgDiv");
	let fn_get_mem = (memNo, group) => {
		
		$.ajax({
			url:`${$.CPATH}/group/members/${group}/${memNo}`,
			method:"post",
			dataType:"json",
			success: function(resp){
				// member view 비우기
				groupFormDiv.find(":input[name]").val("");
				
//       			console.log(groupFormDiv.find(":input[name]"));
				// member view에 정보 넣기
      			groupFormDiv.find(":input[name]").each(function(idx, input){
      				let iptName = input.name;
      				let iptValue = resp[`${iptName}`];
      				$(`[name=${iptName}]`).val(iptValue);
      			});			
      			
				// 프로필 사진 넣기
				//$("#profileImg").attr("src", "#");
				if(resp.atchSaveName!=null){
// 					console.log("사진있음");
					$("#profileImg").attr("src", `${$.CPATH}/resources/memberfiles/${resp.atchSaveName}`);
				}else{
//					console.log("사진없음");
					$("#profileImg").attr("src", `${$.CPATH}/resources/img/noImage.png`);
				}
			}
		})
	}
	
	let proTableDiv = $("#proTableDiv");
	let empTableDiv = $("#empTableDiv");
	
	// tr 태그 누르면 member view 보이는 기능 구현
	let memTr = $(document).on("click", ".memTr", function() {
		
		let memNo = $(this).data("member");
		let group = $(this).data("group");
		
		if(group=="pro"){
			proTableDiv.show();
			empTableDiv.hide();
		}else{
			proTableDiv.hide();
			empTableDiv.show();
		}
		
		fn_get_mem(memNo, group);
		
	});
	
