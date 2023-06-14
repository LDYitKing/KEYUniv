//cPath 설정------------------------------------------------------------------------------------
const cPath = document.querySelector('#cPath').value;
// spring 시큐리티
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');
// 업데이트 버튼 클릭 이벤트용------------------------------------------------------------------
var isUpdateButtonClicked = false; // Global flag
//-출력할 subjectListBody 체킁-------------------------------------------------------------------------
let subjectListBody = $("#subjectListBody");
//-----교육과정 리스트 출력---------------------------------------------------------------------
let curriList = $("#curriList");
//-+버튼 클릭후 myTest 누를 때 이벤트-----------------------------------------------------------
let favorites = $("#favorites");
//----즐겨찾기 찾기--------------------------------------------------------
let fn_makeTr = function(board, index) {
	//+ 버튼 만들기
	let btn = $("<button id='btn-" + index + "'>")
		.addClass("btn btn-icon btn-info btn-xs")
		.html('<ion-icon name="add-outline"></ion-icon>')
		.click(function() {
			//클릭한 td에 값 추가하기
			let parentTr = $(this).parent().parent();
			var subName = parentTr.children().eq(2).text();
			let subNo = board.subNo;
			let commName = board.commName;
			var color = colors[commName];  // commName에 해당하는 색상을 가져옵니다.
			$("#myTest td").off().on("click", function() {
				$(this).text(subName);
				$(this).data("subNo", subNo);
				if (subName == $(this).text()) {   // td의 텍스트와 subName이 일치하는 경우에만 색상을 적용합니다.
					$(this).css("background-color", color);
					$(this).addClass("no-hover");
				}
				btn.prop("disabled", true);
				$("#myTest td").off("click");  // 클릭 이벤트를 제거합니다.
				clickedSubNo = subNo;
			});
		});
	//리스트 출력
	return $("<tr>").append(
		$("<td>").html(board.rnum)
		, $("<td>").html(board.deptName)
		, $("<td>").html(board.subName)
		, $("<td>").html(board.commName)
		, $("<td>").html(board.subGrade)
		, $("<td>").html(board.subScr)
		, $("<td>").html(board.subHours)
		, $("<td>").html(btn)
	);
}
favorites.on("click", "button", function() {
    clickedSubNo = null; // Reset clickedSubNo to null when + button is clicked
});
// 이전에 클릭된 td 찾기---------------------------------------------------------------
const youTest = document.querySelector("#myTest");
// 데이터 받아서 table 생성------------------------------------------------------------
const fmkTbl = (data) => {
	let eightTbl = "";
	let period = ["1-1", "1-2", "2-1", "2-2", "3-1", "3-2", "4-1", "4-2"];
	for (let i = 0; i < 8; i++) {
		eightTbl += `
		        <div>
		        <table class="eightTbl table table-hover text-center">
		            <tbody>
		                <tr>
		                    <th>${period[i]}</th>
		                </tr>`;

		for (let j = 1; j <= 7; j++) {
			eightTbl += `
		                <tr>
		                    <td classNo = "${(i + 1) * 100 + j}" class="${(i + 1) * 100 + j} "></td>
		                </tr > `;
		}
		eightTbl += `
		            </tbody >
		        </table >
		        </div>`;
	}
	youTest.innerHTML = eightTbl;
}
fmkTbl();
//리셋 버튼 클릭시 데이터 클리어----------------------------------------------------------------
function resetInputs() {
	const inputs = document.querySelectorAll('input[type="text"]');
	inputs.forEach(input => {
		input.value = '';

	});
	//클릭한 td 출력---------------------------------------------------------------------------
	const tds = document.querySelectorAll('#myTest td');
	tds.forEach(td => {
		td.innerText = '';
	});
	//--td 숨기깅------------------------------------------------------------------------------
	const buttons = document.querySelectorAll('#resetbtn');
	buttons.forEach(button => {
		console.log(button);
		button.disabled = false;
		button.style.display = 'inline-block';
	});
	$("#_dm-verTabsHome").find("td").text('').css("background-color", "");
	$("button[id^='btn-']").prop("disabled", false);
	$("#saveBtn").show();
}
//-저장버튼 클릭시 이벤트-----------------------------------------------------------------------
$("#saveBtn").click(function() {
	let curriDetail = [];
	let numberOfCurri = $("#curriList tr").length;
	// 모든 td의 데이터를 배열에 넣습니다.
	let lastClick = null; // 마지막 클릭 위치를 저장하는 변수입니다.
	$("#myTest td").each(function() {
		let cellData = $(this).data("subNo"); // subNo를 가져옵니다.
		let classInfo = $(this).attr("class");
		let match = classInfo.match(/\d+/);  // 이 정규 표현식은 문자열에서 연속된 숫자들을 찾습니다.
		let cdPriority = match ? match[0] : null;  // 만약 숫자들을 찾았다면 그것을 사용하고, 찾지 못했다면 null을 사용합니다.
		let cdNo = $(this).data("cdNo");
		let curriNo = $(this).data("curriNo");
		console.log("있나없나?", cellData);
		if (cellData) {
			curriDetail.push({
				cdPriority: cdPriority,
				subNo: cellData,
			});
		}
	});
	if (curriDetail.length === 0) {
		Swal.fire({
			icon: 'error',
			title: '입력 오류!!',
			text: '과목을 1개 이상 넣어주세요!',
		})
		return;
	}
	//커리 최대 8개까지 등록--------------------------------------------------------------------
	if (numberOfCurri >= 8) {
		Swal.fire({
			icon: 'error',
			title: '입력 오류!!',
			text: '나의 커리는 9개 이상 등록하실 수 없습니다',
		})
		return;
	}
	var curriName = document.getElementById("curriName").value;

	if (curriName.trim() === '') {
		Swal.fire({
			icon: 'error',
			title: '입력 오류!!',
			text: '제목을 1글자 이상 등록 해주세요!!',
		})
		return;
	}
	// curri 정보를 설정합니다.
	var curriName = document.getElementById("curriName").value;

	// 서버에 전송할 데이터를 구성합니다.
	let dataToSave = {
		curriName: curriName,
		curriDetail: curriDetail,
	};

	console.log("dateToSave", dataToSave);
	// AJAX 요청을 통해 데이터를 서버에 전송합니다.
	$.ajax({
		url: `${cPath}/curri/myCurri.do/curriInsert`,
		type: 'POST',
		data: JSON.stringify(dataToSave),
		contentType: 'application/json;charset=utf-8',
		dataType: 'text',
		success: function(response) {
			$("#_dm-verTabsHome").find("td").text('').css("background-color", "");
			console.log(response);
			Swal.fire("나의 커리가 정상적으로 등록되었습니다.");
			$("#myTest td").empty();
			$('input[type="text"],input[type="number"]').val('');
			$.ajax({
				url: `${cPath}/curri/myCurri.do/curriList`,
				method: 'GET',
				dataType: "json",
				success: function(resp) {
					console.log(resp);
					curriList.empty();
					//배열에 trTag 배열안에 넣기
					let trTags = [];
					if (resp.length > 0) {
						$.each(resp, function(idx, board) {
							trTags.push(cr_makeTr(board));
						});
					} else {
						trTags.push($("<tr>").html($("<td colspan='3'>").html("저장된 나의 커리 없음.")));
					}
					curriList.append(trTags);
					$("button[id^='btn-']").prop("disabled", false);
					$("#myTest td[data-subNo='" + clickedSubNo + "']").text("undefined");
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log('Error: ' + errorThrown);
				}
			});
		},
		error: function(error) {
			console.log("error", error);
		}
	});
});
//검색기능!!(아직 적용안함)---------------------------------------------------------------------
let searchForm = $("[name=searchForm]").on("submit", function(event) {
	event.preventDefault();
	let url = this.action;
	let method = this.method;
	let data = $(this).serialize();
	$.ajax({
		url: url,
		method: method,
		data: data,
		dataType: "json"
	}).done(function(resp, textStatus, jqXHR) {
		console.log(resp);
		subjectListBody.empty();

		let trTags = [];
		if (resp.length > 0) {
			$.each(resp, function(idx, board) {
				trTags.push(fn_makeTr(board));
			});
		} else {
			trTags.push($("<tr>").html($("<td colspan='3'>").html("교과목 없음.")));
		}
		subjectListBody.append(trTags);
	});
	return false;
}).submit();
//검색 UI(아직 적용안함)------------------------------------------------------------------------
let searchUI = $("#searchUI").on("click", "#searchBtn", function() {
	$(this).parents("#searchUI").find(":input[name]").each(function(idx, input) {
		let iptName = input.name;
		let iptValue = $(input).val();
		searchForm.find(`[name=${iptName}]`).val(iptValue);
	});
	searchForm.submit();

});
//커리 리스트 출력 이벤트-----------------------------------------------------------------
let method = this.method;
let data = $(this).serialize();
$.ajax({
	url: `${cPath}/curri/myCurri.do/curriList`,
	method: method,
	data: data,
	dataType: "json"
}).done(function(resp, textStatus, jqXHR) {
	console.log(resp);
	curriList.empty();

	let trTags = [];
	if (resp.length > 0) {
		$.each(resp, function(idx, board) {
			trTags.push(cr_makeTr(board));
		});
	} else {
		trTags.push($("<tr>").html($("<td colspan='3'>").html("저장된 나의 커리 없음.")));
	}
	curriList.append(trTags);
});
// 버튼 클릭시 삭제 이벤트
let cr_makeTr = function(board) {
	let btn = $("<button style='background-color:red;border-color:red;' id='resetbtn'>")
		.addClass("btn btn-icon btn-info btn-xs")
		.html('<ion-icon name="remove-outline"></ion-icon>')
		.click(function() {
			let curriNo = $(this).parent().parent().children().eq(0).data('curriNo');
			let thisButton = $(this);
			$.ajax({
				url: `${cPath}/curri/myCurri.do/mycurriDelete`,
				method: 'POST',
				data: JSON.stringify({ curriNo: curriNo }),
				contentType: 'application/json;charset=utf-8',
				success: function(response) {
					Swal.fire("나의 커리 삭제 완료!!");
					$("#myTest td").empty();
					$("#_dm-verTabsHome").find("td").text('').css("background-color", "");
					thisButton.parent().parent().remove();
					// 커리 리스트 ajax
					$.ajax({
						url: `${cPath}/curri/myCurri.do/curriList`,
						method: 'GET',
						dataType: "json",
						success: function(resp) {
							// Similar to the previous method, render the new curriculum list
							$("#saveBtn").show();
							console.log(resp);
							curriList.empty();
							let trTags = [];
							if (resp.length > 0) {
								$.each(resp, function(idx, board) {
									trTags.push(cr_makeTr(board));
								});
							} else {
								trTags.push($("<tr>").html($("<td colspan='3'>").html("저장된 나의 커리 없음.")));
							}
							curriList.append(trTags);

						},
						error: function(jqXHR, textStatus, errorThrown) {
							console.log('Error: ' + errorThrown);
						}
					});
				},
				error: function(error) {
					console.log("error", error);
				}
			});
		});
	// a태그 클릭시 td에 text 출력시키기
	return $("<tr>").append(
		$("<td>").data('curriNo', board.curriNo).html(board.rnum) //curriNo is stored in data-curriNo, but rnum is displayed
		, $("<td>").html($("<a>").attr("href", "#").text(board.curriName))
		, $("<td>").html(board.curriRdate)
		, $("<td>").html(btn)
	);
}

//---커리디테일 화면에 띄우기---------------------------------------------------
// 커리큘럼 리스트의 각 행에 클릭 이벤트를 바인딩합니다.
let curriNo = null;
curriList.on('click', 'tr a', function() {
	let tempCurriNo = $(this).parent().prev().data('curriNo'); //get curriNo stored in data-curriNo
	if ($(this).parent().prev().text() !== curriNo) {
		curriNo = tempCurriNo;
		// 커리큘럼 세부 정보를 서버에 요청합니다.
		$.ajax({
			url: `${cPath}/curri/myCurri.do/curriDetailList`,
			method: 'POST',
			data: { curriNo: curriNo },
			dataType: 'json',
			beforeSend: function() {
				$("#saveBtn").hide();
			},
			success: function(response) {
				$("button[id^='btn-']").prop("disabled", true); // 모든 버튼 비활성화
				$("#saveBtn").hide();
				$("#_dm-verTabsHome").find("td").text('').css("background-color", "");
				curriList.on('click', 'tr a', function() {
					$.ajax({
						url: `${cPath}/curri/myCurri.do/curriDetailList`,
						method: 'POST',
						data: { curriNo: curriNo },
						dataType: 'json',
						success: function(response) {
							$("#_dm-verTabsHome").find("td").text('').css("background-color", "");
							response.forEach(detail => {
								let targetTd = $("#_dm-verTabsHome").find("td[classno='" + detail.cdPriority + "']");
								targetTd.text(detail.subName);
								targetTd.data('subNo', detail.subNo);  // subNo 값을 data-subNo 속성으로 설정합니다.
								targetTd.data('curriNo', curriNo);
								targetTd.data('commName', commName)
								var color = colors[detail.commName];  // commName에 해당하는 색상을 가져옵니다.
								if (detail.subName == targetTd.text()) {   // td의 텍스트와 subName이 일치하는 경우에만 색상을 적용합니다.
									targetTd.css("background-color", color);
								}
							});
						},
						error: function(error) {
							console.log(error);
						}
					});
				});
				response.forEach(detail => {
					let targetTd = $("#_dm-verTabsHome").find("td[classno='" + detail.cdPriority + "']");
					targetTd.text(detail.subName);
					targetTd.data('subNo', detail.subNo);  // subNo 값을 data-subNo 속성으로 설정합니다.
					targetTd.data('curriNo', curriNo);
					targetTd.data('commName', commName)
					var color = colors[detail.commName];  // commName에 해당하는 색상을 가져옵니다.
					if (detail.subName == targetTd.text()) {   // td의 텍스트와 subName이 일치하는 경우에만 색상을 적용합니다.
						targetTd.css("background-color", color);
					}
				});
			},
			error: function(error) {
				console.log(error);
			}
		});
	} else {
		$("#saveBtn").show();
		curriNo = null;  //
	}
});
$("#anotherButton").click(function() {
	// saveBtn을 다시 보이게 합니다.
	$("#saveBtn").show();
});

let sourceSubNo;

//--------------------------------------------------
$(document).on("click", ".tab-content td", function() {
	if (isUpdateButtonClicked) { // If update button was clicked, do not execute the code
		return;
	}
	let clickedSubNo = null;
	sourceSubNo = $(this);
	clickedSubNo = $(this).data("subNo");
	console.log('clickedSubNo:', clickedSubNo);
	if (clickedSubNo) { // 만약 td에 텍스트 데이터가 있다면
		// 여기서 필요한 데이터를 가공하거나 설정할 수 있습니다.

		$.ajax({
			url: `${cPath}/curri/myCurri.do/selectSubjectList`,
			method: 'POST',
			data: {
				what: clickedSubNo,
				curriNo: curriNo
			},
			dataType: 'json',
			success: function(response) {
				console.log(response);
				//교과목 정보 출력시키기
				$("#sName").val(response[0].subName);
				$("#subNo").val(response[0].subNo);
				$("#subExp").val(response[0].subExp);
				$("#subGrade").val(response[0].subGrade);
				$("#subHours").val(response[0].subHours);
				$("#subScr").val(response[0].subScr);
				$("#commName").val(response[0].commName);
				$("#colName").val(response[0].colName);
				$("#scdNo").val(response[0].cdNo);
				$("#scurriNo").val(response[0].curriNo);
				$("#scdPriority").val(response[0].cdPriority);
				$('#detailModal').show();
				clickedSubNo = null;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log('Error: ' + errorThrown);
			}
		});
	}
	// 디테일 모달 숨기기
	$('#detailModal').on('hide.bs.modal', function(e) {
		isUpdateButtonClicked = false;
	});
});
// 디테일 모달 닫기
function detailModalClose() {
	$('#detailModal').hide(); // 모달 숨기기
}

//모달 외부 클릭시 닫히기!!---------------------------------------------------------------------
$(document).on('click', function(e) {
	if ($(e.target).is('#detailModal') && !$(e.target).closest('#detailModalCont').length) {
		detailModalClose();
	}
});
//커리 디테일 삭제 함수-------------------------------------------------------------------------
let selectedTd;  // 클릭한 td를 저장하는 전역 변수

// 클릭 이벤트 핸들러를 추가하여 클릭한 td를 저장합니다.
$("#_dm-verTabsHome").on('click', 'td', function() {
	selectedTd = $(this);
});
const remove = () => {
	let cdNo = $("#scdNo").val();
	let sendData = {}
	sendData = {
		cdNo: cdNo,
	}
	$.ajax({
		url: `${cPath}/curri/myCurri.do/mycurriDetailDelete`,
		type: "post",
		data: JSON.stringify(sendData),
		contentType: "application/json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			Swal.fire("나의 커리 과목 삭제 완료");
			if (selectedTd) {
				selectedTd.css("background-color", "");  // 클릭한 td의 배경색을 제거합니다.
			}
			$("#myTest td").empty();
			detailModalClose();
			//---삭제후 리스트 재 갱신--------------------------------------------------------------
			$.ajax({
				url: `${cPath}/curri/myCurri.do/curriDetailList`,
				method: 'POST',
				data: { curriNo: curriNo },
				dataType: 'json',
				success: function(response) {
					$("button[id^='btn-']").prop("disabled", false);
					$("#_dm-verTabsHome").find("td").text('');
					response.forEach(detail => {
						let targetTd = $("#_dm-verTabsHome").find("td[classno='" + detail.cdPriority + "']");
						targetTd.text(detail.subName);
						targetTd.data('subNo', detail.subNo);  // subNo 값을 data-subNo 속성으로 설정합니다.
					});
				},
				error: function(error) {
					console.log(error);
				}
			});
		},
		error: function(error) {
			console.log("error", error);
		}
	})
}
originalCdPriority = null;
//커리 디테일 업데이틍---------------------------------------------
$(document).ready(function() {
	$("#updateButton").click(function() {
		isUpdateButtonClicked = true;
		$("#detailForm input").prop('readonly', false);
		$("#detailModal").hide();
		$("#_dm-verTabsHome td").off('click');

		$("#_dm-verTabsHome td").on('click', function() {
			if (!isUpdateButtonClicked) {
				return;
			}
			//--현재 누른 위치의 값들 저장---
			let classInfo = $(this).attr("class");
			let match = classInfo.match(/\d+/);
			let cdPriority = match ? match[0] : null;
			let curriNo = $(this).data("curriNo");
			let scurriNo = $("#scurriNo").val();
			let scdNo = $("#scdNo").val();
			let originalCdPriority = $("#scdPriority").val();
			console.log("originalPriority", originalCdPriority);

			if ($(this).data('subNo') !== undefined) {
				ssubNo = $(this).data('subNo');
				curriNo = $(this).data("curriNo");
				console.log(ssubNo);
				console.log(curriNo);
			}

			let detail = {
				sName: $("#sName").val(),
				subExp: $("#subExp").val(),
				subGrade: $("#subGrade").val(),
				subHours: $("#subHours").val(),
				subScr: $("#subScr").val(),
				colName: $("#colName").val(),
				commName: $("#commName").val(),
				scdNo: $("#scdNo").val(),
				scurriNo: $("#scurriNo").val(),
				scdPriority: $("#scdPriority").val(),
			};
			console.log(detail);

			let targetTd = $("#_dm-verTabsHome").find("td[classno='" + cdPriority + "']");
			let originalTd = $("#_dm-verTabsHome").find("td[classno='" + originalCdPriority + "']");
			if (targetTd.text().trim() !== '') {
				let originalData = originalTd.data('subNo');
				let targetData = targetTd.data('subNo');
				// 두 위치의 데이터를 교환
				originalTd.data('subNo', targetData);
				targetTd.data('subNo', originalData);
			}
			//데이터가 없을때
			if ($(this).data('subNo') === undefined) {
				let clickedElement = $(this);
				$.ajax({
					url: `${cPath}/curri/myCurri.do/mycurriDetailUpdate`,
					method: 'POST',
					data: JSON.stringify({
						cdNo: scdNo.toString(),
						scNo: scdNo,
						cdPriority: cdPriority,
						curriNo: scurriNo,
						curriDetail: detail
					}),
					contentType: "application/json",
					success: function(response) {
						Swal.fire("과목 변경 성공!!");
						console.log("값이 머가 들어올까??", response)
						ssubNo = null;
						curriNo = null;
						originalCdPriority = null;
						originalTd.text('');
						originalTd.removeData('subNo'); //Here is where you are removing the 'subNo' data from originalTd
						clickedElement.removeData('subNo');
						$("#_dm-verTabsHome td").off('click');
						isUpdateButtonClicked = false;
						updateCurriDetails(scurriNo);
						let originalColor = originalTd.css("background-color");
						originalTd.css("background-color", "white");
						clickedElement.css("background-color", originalColor);
						return;
					},
					error: function(error) {
						console.log(error);
						isUpdateButtonClicked = false;
					}
				});
			} else {//데이터가 있을때
				$.ajax({
					url: `${cPath}/curri/myCurri.do/mycurriDetailUpdate`,
					method: 'POST',
					data: JSON.stringify({
						cdNo: scdNo.toString(),
						scNo: scdNo,
						cdPriority: cdPriority,
						curriNo: scurriNo,
						curriDetail: detail
					}),
					contentType: "application/json",
					success: function(response) {
						let originalTd = $("#_dm-verTabsHome").find("td[classno='" + originalCdPriority + "']");
						let targetTd = $("#_dm-verTabsHome").find("td[classno='" + cdPriority + "']");
						originalTd.attr('class', originalTd.attr('class').replace(originalCdPriority, cdPriority));
						targetTd.attr('class', targetTd.attr('class').replace(cdPriority, originalCdPriority));
						let originalColor = originalTd.css("background-color");
						let targetColor = targetTd.css("background-color");

						originalTd.css("background-color", targetColor);
						targetTd.css("background-color", originalColor);
						updateCurriDetails();
						$.ajax({
							url: `${cPath}/curri/myCurri.do/mycurriDetailSelect`,
							method: 'POST',
							data: JSON.stringify({
								subNo: ssubNo,
								curriNo: curriNo
							}),
							contentType: 'application/json',
							dataType: 'json',
							success: function(data) {
								let cdNo = data.map(item => item.cdNo);
								console.log(data);
								console.log("cdNo값은?", cdNo);
								$.ajax({
									url: `${cPath}/curri/myCurri.do/mycurriDetailUpdate`,
									method: 'POST',
									data: JSON.stringify({
										subNo: ssubNo,
										curriNo: curriNo,
										cdPriority: originalCdPriority,
										cdNo: cdNo[0]
									}),
									contentType: 'application/json',
									dataType: 'json',
									success: function(data) {
										alert("변경 성공");
										console.log(data);
										$("#_dm-verTabsHome td").on('click');
										isUpdateButtonClicked = false;
										updateCurriDetails(scurriNo);
										ssubNo = null;
										curriNo = null;
										originalCdPriority = null;
									},
									error: function(error) {
										alert("에러났숑");
										console.log("error:", error);
									}
								})
							},
							error: function(error) {
								console.log(error);
							}
						})
					},
					error: function(error) {
						console.log(error);
						isUpdateButtonClicked = false;
					}
				});
			}
		});
	});
});

function updateCurriDetails(scurriNo) {
	$.ajax({
		url: `${cPath}/curri/myCurri.do/curriDetailList`,
		method: 'POST',
		data: { curriNo: scurriNo },
		dataType: 'json',
		success: function(response) {
			$("#_dm-verTabsHome").find("td").text('');
			response.forEach(detail => {
				let targetTd = $("#_dm-verTabsHome").find("td[classno='" + detail.cdPriority + "']");
				targetTd.text(detail.subName);
				targetTd.data('subNo', detail.subNo);
				targetTd.data("curriNo", detail.curriNo); // 추가

			});
		},
		error: function(error) {
			console.log(error);
		}
	});
}
//즐겨찾기 출력!--------------------------------------------------------------------------
$(document).ready(function() {
	let url = `${cPath}/curri/myCurri.do/favoriteList`;
	let data = $(this).serialize();
	$.ajax({
		url: url,
		method: 'POST',
		dataType: 'json',
		success: function(response) {
			favorites.empty();
			let trTags = [];
			if (response.length > 0) {
				$.each(response, function(idx, board) {
					trTags.push(fa_makeTr(board));
				});
			} else {
				trTags.push($("<tr>").html($("<td colspan='3'>").html("저장된 즐겨찾기 없음.")));
			}
			favorites.append(trTags);
		},
		error: function(error) {
			alert("에렁", error);
		}
	})
})

var colors = {
	"전공필수": "#ADFF2F",
	"전공선택": "#FFEBCD",
	"교양필수": "#E0FFFF",
	"교양선택": "#FFB6C1",
	"전공심화": "#FFDAB9",
	// 필요한 만큼 더 추가할 수 있습니다.
};
let fa_makeTr = function(board, index) {
	let btn = $("<button id='btn-" + index + "'>")
		.addClass("btn btn-icon btn-info btn-xs")
		.html('<ion-icon name="add-outline"></ion-icon>')
		.click(function() {
			let parentTr = $(this).parent().parent();
			var subName = board.subName;
			let subNo = board.subNo;
			let commName = board.commName;
			var color = colors[commName];
			$("#myTest td").off().on("click", function() {
				$(this).text(subName);
				$(this).data("subNo", subNo);
				if (subName == $(this).text()) {   // td의 텍스트와 subName이 일치하는 경우에만 색상을 적용합니다.
					$(this).css("background-color", color);
					$(this).addClass("no-hover");
				}
				btn.prop("disabled", true);  // 이 버튼만 비활성화
				$("#myTest td").off("click");  // 클릭 이벤트를 제거합니다.
			});
		});
	return $("<tr>").append(
		$("<td>").html(board.rnum)
		, $("<td>").html(board.deptName)
		, $("<td>").html(board.subName)
		, $("<td>").html(board.commName)
		, $("<td>").html(board.subGrade)
		, $("<td>").html(board.subScr)
		, $("<td>").html(board.subHours)
		, $("<td>").html(btn)
	);
}