<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<security:authentication property="principal.realUser" var="authMember"/>
<style>
#cbTitle{
	font-size: 30px;
}
.cke_textarea_inline {
/*       border: 1px solid #ccc; */
	border: none;
	padding: 10px;
	min-height: 300px;
	background: #fff;
	color: #000;
}
.cke_inner .cke_top {
	display: none;
}
.spanTags{
	border: 1.5px solid lightgray;
	border-radius: 3px;
	padding: 3px 8px;
}
.contentBorder{

	border: 1px solid #ccc;
}
#contentDiv{
	overflow: auto;
}

/* 나의 커리 가져오기 */
#myCurriArea{
	display: grid;
	grid-template-columns:repeat(8, 1fr);
	column-gap: 15px;
	
	width: 80%;
	margin: 0 auto;
}
.curriTable {
	border: white;
}
.curriDiv{
/*  	border: 1px solid #87ceeb75;  */
 	border: 2px solid gainsboro; 
 	border-radius: 5px; 
 	padding: 5px; 
}

/* 댓글 구현 */
#commentTa{
	width: 100%;
	border: none;
	resize: none;
	font-size: 20px;
}
#commentTa:focus {
  outline: none;
}

#commentForm{
/* 	border: 1px solid green; */
	background-color: #f2f2f2;
	border-top: 2px solid gainsboro;
}
#commentBox{
	border-top: 2px solid gainsboro;
}

</style>

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item"><a href="/">Main</a></li>
		<li class="breadcrumb-item"><a href="${cPath }/curri/everyCurri">모두의 커리</a></li>
		<li class="breadcrumb-item active" aria-current="page">상세보기</li>
	</ol>
</nav>
<div class="space m-3 p-5">
	<div class="px-5 mb-2 d-flex justify-content-between">
		<div>
			<c:if test="${authMember.memNo eq curriBoard.cbWriter }">
				<input id="insertBtn" type="button" class="btn btn-outline-success" value="수정">
				<input id="deleteBtn" type="button" class="btn btn-outline-success" value="삭제">
			</c:if>
		</div>
		<div>
			<a href="${cPath }/curri/everyCurri" class="btn btn-outline-info">목록</a>
		</div>
	</div>
	<div class="mx-5 p-5 contentBorder">
		<div class="p-3 ">
			<div class="mb-4">
				<p id="cbTitle">${curriBoard.cbTitle }</p>
			</div>
			<div class="d-flex justify-content-end fs-4">
				<p class="m-2" id="cbWriter">${curriBoard.memName }</p>
				<p class="m-2">|</p>
				<p class="m-2" id="cbWdate">${curriBoard.cbWdate }</p>
			</div>
		</div>
		<div id="" class='d-flex flex-wrap gap-3 mt-3'>
			<c:if test="${not empty curriBoard.tagList and curriBoard.tagList.get(0).tagNo ne null }">
				<c:forEach items="${curriBoard.tagList }" var="tag">
				
					<span class="mt-2 text-nowrap spanTags link-info fs-4">#${tag.tagContent }</span>
				</c:forEach>
			
			</c:if>
		</div>
		<div>
			<hr>
			<div id="myCurriArea" style="display: none;">
				<jsp:include page="/WEB-INF/views/curri/everyCurri/myCurriArea.jsp"/>
			</div>
			<hr>
		</div>
		<div id="contentDiv" class="mt-2 mb-5">
			<textarea class="ckeditor" wrap="hard" cols="80" id="contentArea" name="contentArea" rows="10">${curriBoard.cbContent}</textarea>
		</div>
		<hr>
		<div class="">
			<p class="fw-bold fs-3">댓글
				<button id="commentReloadBtn" class="btn btn-lg btn-icon" onclick="fn_get_commentList('${curriBoard.cbNo}')"><ion-icon name="reload-outline"></ion-icon></button>
	        </p>
		</div>
		<div class="">
			<div id="commentsArea" class="">

			</div>
			<form action="" id="commentForm" class="m-2 p-3">
				<div>
					<p class="fs-4"> ${authMember.memName }</p>
				</div>
				<div>
					<input type="hidden" name="cbNo" value="${curriBoard.cbNo }">
					<input type="hidden" name="ccWriter" value="${authMember.memName }">
					<input type="hidden" name="memNo" value="${authMember.memNo }">
					<input type="hidden" name="ccContent">
					<textarea id="commentTa" rows="5" cols="" placeholder="댓글을 남겨보세요." required></textarea>
				</div>
				<div class="text-end">
					<small id="lengthArea" class="text-end text-body fst-italic" style="display: none;">(<span id="currentLenSpan">0</span>/<span id="maxLenSpan">500</span>)</small>
					<input id="commentInsertBtn" type="button" value="등록" class="btn btn-outline-light" disabled>
				</div>
			</form>
		</div>
	</div>
	<div class="px-5 mt-2 d-flex justify-content-end">
		<div>
			<a href="${cPath }/curri/everyCurri" class="btn btn-outline-info">목록</a>
		</div>
	</div>	
</div>  
<script>

// 댓글 작성
let ccContent = $("[name=ccContent]"); // form으로 보낼 댓글
let commentTa = $("#commentTa"); // 입력한 댓글

let lengthArea = $("#lengthArea");
let currentLenSpan = $("#currentLenSpan");
const commentMax = 500; // 댓글 최대 글자수
let isOver = false; // 글자수 넘어가는지 체크

// 댓글 입력했을 때 버튼 활성화
commentTa.keyup(function(event){
// 	console.log("keyup this : ", this);
// 	console.log("keyup this val length : ", $(this).val().trim().length);
	
// 	let length = $(this).val().trim().length;
	let length = $(this).val().length;
	currentLenSpan.text(length);
	
	if(length>0){ // 댓글 입력 했을 때
		commentInsertBtn.prop("disabled", false);
		commentInsertBtn.removeClass("btn-outline-light");
		commentInsertBtn.addClass("btn-success");
		
		// 글자 수 띄우기
		lengthArea.show();
		
	}else{ // 댓글 입력 안했을 떄
		commentInsertBtn.prop("disabled", true);
		commentInsertBtn.removeClass("btn-success");
		commentInsertBtn.addClass("btn-outline-light");
		
		lengthArea.hide();
	}
	
	if(length>commentMax){
		currentLenSpan.addClass("text-danger");
		isOver = true;
	}else{
		currentLenSpan.removeClass("text-danger");
		isOver = false;
	}
	
})

//댓글 등록 버튼
let commentInsertBtn = $("#commentInsertBtn").on("click", function(event) {
   // 댓글 내용 입력 안했을 때
   let length = commentTa.val().length;
	if(length==0){
		commentTa.focus();
        return;
    }
	// 글자수 제한
	if(isOver){
		swal.fire(commentMax + "자까지 작성할 수 있습니다.");
		return;
	}
	
	let comment = commentTa.val();
	console.log("댓글 내용 : ", comment);
// 	enter -> <br> 치환
	comment = comment.replace(/(?:\r\n|\r|\n)/g, '<br>');
	console.log("댓글 내용 br 치환 : ", comment);
	
	ccContent.val(comment);
	// 댓글 등록
	commentForm.submit();
	
}); 

let cbNo = $("[name=cbNo]").val();
let commentForm = $("#commentForm").on("submit", function(event){
	event.preventDefault();
	
	let arr = $(this).serializeArray();
	console.log("data serializeArray() : ", arr);

	let data = {};
	$.each(arr, function(){
		data[this.name] = this.value;
	})
	
	data = JSON.stringify(data);
	console.log("data json : ", data);

	// 댓글 등록하기
  	$.ajax({
		url:"${cPath}/curri/everyCurri/insertComment",
		method:"post",
		data: data,
		contentType:"application/json; charset=UTF-8",
		success:function(resp){
			console.log("등록 성공");			
			// 댓글 리스트 다시 가져오기	
			fn_get_commentList(cbNo);	

			// textarea 비우기
			ccContent.val("");
			commentTa.val("");
			commentTa.keyup();
		}
	});	 
	
	return false;
	
});
 
// 댓글 리스트 가져오기
let loginMemNo = $("[name=memNo]");
let commentsArea = $("#commentsArea");
let fn_get_commentList = (cbNo) =>{
	console.log("댓글 리스트 가져오기");
	
  	$.ajax({
		url:"${cPath}/curri/everyCurri/"+cbNo+"/comment",
		method:"post",
		dataType: "json",
		success:function(resp){
			// 새로 가져온 댓글 리스트 띄우기 전에 비우기
			commentsArea.empty();
			
			console.log("댓글 리스트 ", resp);
			
			let comments = "";
			$.each(resp, function(idx, cmt){
				// <br> -> enter
				let ccContent = cmt.ccContent; 
				ccContent = ccContent.replace(/(\n|\r\n)/g, '<br>');
				
				comments +=
					`<div class="mx-2 p-3" id="commentBox">
						<div class="row">
							<div class="col-1">
								<p class="fs-4"> \${cmt.ccWriter}</p>
							</div>
							<div class="col-9 fs-4">
								<p style="color:black;">\${ccContent}</p>
							</div>
						</div>	
						<div>
								
						</div>
						<div class="d-flex justify-content-between">
							<div class="align-text-bottom mt-2">
								<span>\${cmt.ccWdate}</span>
							</div>
							<div>`;
								if(cmt.memNo==loginMemNo.val()){
									comments += 
									`<input type="button" value="수정" class='btn btn-lg' onclick="fn_cmtModifyBtn('\${cmt.ccNo}', '\${cmt.cbNo}');">
									<input type="button" value="삭제" class='btn btn-lg' onclick="fn_cmtDeleteBtn('\${cmt.ccNo}', '\${cmt.cbNo}');">`;
								}
				comments +=				
							`</div>
						</div>
					</div>`;

			})

			commentsArea.html(comments);

		}
	});	 
}  
fn_get_commentList(cbNo);

// 댓글 수정
let fn_cmtModifyBtn = (ccNo, cbNo) =>{
	console.log(ccNo, "댓글 수정");

	fn_get_commentList(cbNo);
}
// 댓글 삭제
let fn_cmtDeleteBtn = (ccNo, cbNo) =>{
	console.log(ccNo, "댓글 삭제");

	$.ajax({
		url:"${cPath}/curri/everyCurri/deleteComment",
		method:"post",
		data: {"ccNo": ccNo},
		success: function(resp){
			console.log("댓글 삭제 성공");
			
			fn_get_commentList(cbNo);
		}
	})

}

// 날짜 가져오기
 let cbWdate = $("#cbWdate");
 cbWdate.text(cbWdate.text().replace('T', ' ').substring(0, 19));

// CKEditor 가져오기
//   for (key in CKEDITOR.instances) { CKEDITOR.instances[key].destroy(true); }

  // The instanceReady event is fired when an instance of CKEditor 4 has finished
  // its initialization.
  var editor;
   CKEDITOR.inline('contentArea',{
    });
  
  CKEDITOR.on('instanceReady', function(ev) {
		editor = ev.editor;
		editor.setReadOnly(true);
  });

// 나의 커리 가져오기
let myCurriArea = $("#myCurriArea");
let curriTb = $(".curriTb");
let fn_get_curri = () => {
	
	myCurriArea.hide();
	let curriNo = "${curriBoard.curriNo}";
	console.log("curriNo : ", curriNo);
	if(curriNo=="") return false;
	
// 	console.log("커리있음");
	myCurriArea.show();
	
	curriTb.text("");
	curriTb.css("background", "none");
	
 	$.ajax({
		url:"${cPath}/curri/myCurri.do/curriDetailList",
		method:"post",
		data: {"curriNo":curriNo},
		dataType:"json",
		success:function(resp){
			console.log("curri detail : ", resp);
						
			$.each(resp, function(idx, curri){
				let priority = curri.cdPriority;
				$(`.\${priority}`).css("background-color", "#cddc397a");
// 				$(`.\${priority}`).css("background-color", "#f2f2f2");
				$(`.\${priority}`).html(`<small>\${curri.subName}</small>`);
			})
						
		}
	});	
	
}
fn_get_curri();

// 글 삭제
let deleteBtn = $("#deleteBtn").on("click", function(event){
	
	// 글 삭제 여부 alert

	

	$.ajax({
		url:"${cPath}/curri/everyCurri/deleteCurriBoard",
		method:"post",
		data: {"cbNo": cbNo},
		success: function(resp){
			console.log("댓글 삭제 성공");
			
			fn_get_commentList(cbNo);
		}
	})

})
</script>  


