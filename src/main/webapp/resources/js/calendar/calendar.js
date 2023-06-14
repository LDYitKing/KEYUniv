// let cPath = document.querySelector('#cPath').value;
let calendar = null;
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');
$(function() {
	const Calendar = FullCalendar.Calendar; // 캘린더 api 생성하기

	const calendarEl = document.querySelector('#calendar'); // body에 캘린더 넣을 부분 태그선택

	calendar = new Calendar(calendarEl, {
		selectable: true,
		selectHelper: true,
		editable: true,
		eventResizableFromStart: true,
		eventResizableFromEnd: true,
		select: function(res) {
			modal.show()
		},
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay'
		},
		events: `${cPath}/calevents`,  // url 서블릿 주소 써주면 됨!

		editable: true, // 편집가능

		locale: 'ko', // 한국어
		eventDrop: function(info) {
			let start = info.event.start;
			let end = info.event.end;
			let id = info.event.id;

			$.ajax({
				url: `${cPath}/calendarUpdate`,
				type: "post",
				data: JSON.stringify({ sdate: start, edate: end, id: id }),
				contentType: "application/json",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function() {
					Swal.fire("일정이 변경되었습니다.");
				},
			});
		},

		eventResize: function(info) {
			let start = info.event.start;
			let end = info.event.end;
			let id = info.event.id;

			$.ajax({
				url: `${cPath}/calendarUpdate`,
				type: "post",
				data: JSON.stringify({ sdate: start, edate: end, id: id }),
				contentType: "application/json",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function() {
					Swal.fire("일정이 변경되었습니다.");
				},
			});
		},


		// 일정 클릭하면 상세보기 모달로 보여주기
		eventClick: function(info) {
			$("#id").val(info.event.id);
			$("#title").val(info.event.title);
			$("#sdate").val(info.event.start);   // assuming sdate corresponds to start
			$("#edate").val(info.event.end);     // assuming edate corresponds to end
			$("#background-color").val(info.event.backgroundColor);
			$("#text-color").val(info.event.textColor); // assuming textColor corresponds to text-color

			var start = info.event.start;
			var end = info.event.end;
			var id = info.event.id;
			var title = info.event.title;
			var textColor = info.event.textColor; // assuming this exists in your event object
			var backgroundColor = info.event.backgroundColor;

			$.ajax({
				url: `${cPath}/calendarView`,
				type: "post",
				data: JSON.stringify({
					what: id,
					sdate: start,
					edate: end,
					title: title,
					textColor: textColor,
					backgroundColor: backgroundColor
				}),
				contentType: "application/json",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success: function(res) {
					$("#cid").val(res.id); // 아주 안좋아!
					$("#ctitle").val(res.title);
					$("#csdate").val(res.sdate);
					$("#cedate").val(res.edate);
					$("#cbackgroundColor").val(res.backgroundColor);
					$("#ctextColor").val(res.textColor);
				}
			})
			detailModal.show();
		}
	});
	calendar.render();
});

const modal = $('#modal')
const modalClose = () => {
	modal.hide();
}
const detailModal = $('.detailModal')
const detailModalClose = () => {
	detailModal.hide();
}
const insertModal = $('.insertModal')
const insertModalClose = () => {
	insertModal.hide();
}

// 모달창에서 일정 수정하기
const modify = () => {
	let id = $("#cid").val();
	let title = $("#ctitle").val();
	let start = $("#csdate").val();
	let end = $("#cedate").val();
	let backgroundColor = $("#cbackgroundColor").val();
	let textColor = $("#ctextColor").val();
	let sendData = {}
	sendData = {
		id: id,
		title: title,
		sdate: start,
		edate: end,
		backgroundColor: backgroundColor,
		textColor: textColor,
	}
	$.ajax({
		url: `${cPath}/calendarSelectUpdate`,
		type: "post",
		data: JSON.stringify(sendData),
		contentType: "application/json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			calendar.refetchEvents();
			calendar.render();
			detailModal.hide();
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	})
}
// 모달창에서 일정 추가하기
const insert = () => {
	let title = $("#title").val();
	let sdate = $("#sdate").val();
	let edate = $("#edate").val();
	let background = $("#background-color").val();
	let textColor = $("#text-color").val();

	let eventData = {
		title: title,
		sdate: sdate,
		edate: edate,
		backgroundColor: background,
		textColor: textColor
	};
	$.ajax({
		url: `${cPath}/calendarInsert`,
		type: "POST",
		data: JSON.stringify(eventData),
		contentType: "application/json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			calendar.refetchEvents();
			calendar.render();
			insertModal.hide();
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	});
};

const remove = () => {
	let id = $("#cid").val();
	let sendData = {}
	sendData = {
		id: id,
	}
	$.ajax({
		url: `${cPath}/calendarDelete`,
		type: "post",
		data: JSON.stringify(sendData),
		contentType: "application/json",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			Swal.fire("일정이 삭제되었습니다.");
			calendar.refetchEvents();
			calendar.render();
			detailModal.hide();
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	})
}
var sessionId = '<%= request.getSession().getId() %>';

$("input[name='radio-stacked']").on('change', function() {
	var selectedCalendar = $(this).next('label').text().trim();
	var memNo;

	// 선택된 캘린더에 따라 memNo를 다르게 설정합니다.
	if ($('#academic-calendar').is(':checked')) {
		memNo = 'admin';
	} else if ($('#personal-calendar').is(':checked')) {
		memNo = sessionId;
	}

	$.ajax({
		url: `${cPath}/calendarRadio`,
		type: 'POST',
		data: JSON.stringify({ 'memNo': memNo }),
		contentType: 'application/json',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			calendar.setOption('events', res);
		},
		error: function(request, status, error) {
			alert("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		}
	});
});

$(document).ready(function() {
	$('input[type=radio][name=radio-stacked]').change(function() {
		if (this.id == 'academic-calendar') {
			$('.btn.btn-primary').prop('disabled', true);

			// 캘린더의 이벤트 클릭 핸들러를 덮어쓰기
			calendar.setOption('eventClick', null);  // 아무것도 하지 않음

			// 캘린더의 선택 이벤트를 비활성화
			calendar.setOption('selectable', false);
			calendar.setOption('select', null);  // 아무것도 하지 않음

			// 캘린더의 eventDrop, eventResize 비활성화
			calendar.setOption('eventDrop', null);  // 아무것도 하지 않음
			calendar.setOption('eventResize', null);  // 아무것도 하지 않음

			// 캘린더의 editable 옵션 비활성화
			calendar.setOption('editable', false);
		}
		else if (this.id == 'personal-calendar') {
			// 개인 캘린더 선택 시
			// 개인 일정 추가 버튼 활성화
			$('.btn.btn-primary').prop('disabled', false);

			// 캘린더의 이벤트 클릭 핸들러를 원래대로 복구
			calendar.setOption('eventClick', function(info) {
				$("#id").val(info.event.id);
				$("#title").val(info.event.title);
				$("#sdate").val(info.event.start);   // assuming sdate corresponds to start
				$("#edate").val(info.event.end);     // assuming edate corresponds to end
				$("#background-color").val(info.event.backgroundColor);
				$("#text-color").val(info.event.textColor); // assuming textColor corresponds to text-color

				var start = info.event.start;
				var end = info.event.end;
				var id = info.event.id;
				var title = info.event.title;
				var textColor = info.event.textColor; // assuming this exists in your event object
				var backgroundColor = info.event.backgroundColor;

				$.ajax({
					url: `${cPath}/calendarView`,
					type: "post",
					data: JSON.stringify({
						what: id,
						sdate: start,
						edate: end,
						title: title,
						textColor: textColor,
						backgroundColor: backgroundColor
					}),
					contentType: "application/json",
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success: function(res) {
						$("#cid").val(res.id); // 아주 안좋아!
						$("#ctitle").val(res.title);
						$("#csdate").val(res.sdate);
						$("#cedate").val(res.edate);
						$("#cbackgroundColor").val(res.backgroundColor);
						$("#ctextColor").val(res.textColor);
					}
				})
				detailModal.show();
			});

			// 캘린더의 선택 이벤트를 활성화
			calendar.setOption('selectable', true);
			calendar.setOption('select', function(res) {
				modal.show()
			});

			// 캘린더의 eventDrop 활성화
			calendar.setOption('eventDrop', function(info) {
				let start = info.event.start;
				let end = info.event.end;
				let id = info.event.id;

				$.ajax({
					url: `${cPath}/calendarUpdate`,
					type: "post",
					data: JSON.stringify({ sdate: start, edate: end, id: id }),
					contentType: "application/json",
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success: function() {
						Swal.fire("일정이 변경되었습니다.");
					},
				});
			});
			// 캘린더의 editable 옵션 비활성화
			calendar.setOption('editable', true);
		}
	});
});