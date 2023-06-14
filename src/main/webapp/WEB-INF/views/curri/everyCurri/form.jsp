<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
#contentArea[contenteditable] {
	outline: none;
}
#contentArea{
	font-size: 20px; 
}
#cbTitleInput{
	font-size: 25px;
	border: none;
}

.form-control:focus {
  border-color: inherit;
  -webkit-box-shadow: none;
  box-shadow: none;
}
select option[value=""][disabled] {
/*  	display: none;  */
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
 	border: 2px solid gainsboro;
 	border-radius: 5px; 
 	padding: 5px; 
}
.curriTable th{
	
}

</style>
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item"><a href="/">Main</a></li>
		<li class="breadcrumb-item"><a href="${cPath }/curri/everyCurri">모두의 커리</a></li>
		<li class="breadcrumb-item active" aria-current="page">글쓰기</li>
	</ol>
</nav>
<!-- <h3 class="page-title d-flex flex-wrap just justify-content-center mb-3 mt-4 text-white">모두의 커리</h3> -->
<!-- <p class="text-center text-light m-4 lead" style="letter-spacing:2px;"> -->
<!-- 	<span class="h4 fw-bolder text-info">모두의 커리</span>는 KEY대학교 학생들의 원만한 학교 생활을 위해 정보를 공유하고 소통하는 게시판입니다.<br> -->
<!-- 	<small> 나의 커리큘럼을 공유하여 다른 학생들에게 추천하거나 다양한 의견을 나누며 직무 선택에 필요한 정보를 얻어 명확한 진로설계에 도움을 얻어보세요.</small> -->
<!-- </p> -->

<div class="space m-3 p-5">
	<input type="button" value="자동완성" id="autoInput">
	<form method="post" id="insertForm" class="m-3 p-5">
	<div class="mb-5">
		<input id="cbTitleInput" name="cbTitle" type="text" class="form-control" placeholder="제목 없음" required>
	</div>
		<div>
			
		</div>
		<div id="tagDiv" class="row justify-content-start align-items-center m-2 my-3">
			<div class="col-2">
				<p class="h4">
					<ion-icon name="list-outline"></ion-icon>&nbsp;&nbsp;태그<br>
				</p>
			</div>
			<div class="col-10">
				<select 
					id="tagSelect"
					class="form-select" 
					name="tagContent" 
					multiple 
					data-allow-new="true" 
					data-allow-clear="true" 
					data-placeholder="비어 있음" 
					data-separator=" " 
					data-max="5"
					data-badge-style="info"
				>
				</select>
			</div>
		</div>
		<div>
			<div id="myCurriDiv" class="row justify-content-start align-items-center m-2 my-3">
				<div class="col-2">
					<p class="h4">
						<ion-icon name="share-social-outline"></ion-icon>&nbsp;&nbsp;나의 커리
					</p>
				</div>
				<div class="col-10">
					<select id="myCurriSel" class="form-select" name="curriNo">
						<option value="" selected class="text-info">나의 커리를 공유할 수 있습니다.</option>
						<c:if test="${not empty myList }">
							<c:forEach items="${myList }" var="curri">
								<option value="${curri.curriNo }">${curri.curriName }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
			<div>
				<div id="myCurriArea" style="display: none;">
					<jsp:include page="/WEB-INF/views/curri/everyCurri/myCurriArea.jsp"/>
				</div>
			</div>
		</div>
		<hr>
		<div id="contentDiv" class="mt-2 mb-5">
			<div id="contentArea" contenteditable="true"></div>
		</div>
		<hr>
		<p class="text-end text-body fst-italic">(<span id="textLengthSpan">0</span>/2000)</p>
		
		<div class="text-center">
			<input id="insertBtn" type="button" class="btn btn-outline-info" value="등록">
		</div>
		<input type="hidden" name="cbContent" id="cbContentInput">
		<security:csrfInput/>
	</form>
	
</div>


<script>
// 자동완성
$("#autoInput").on("click", function(event){
	$("#cbTitleInput").val("컴공 커리큘럼 조언 부탁드려요");
	$("#contentArea").append(`<p style="text-align:center"><span style="font-size:22px">안녕하세요 컴퓨터공학과 22학번입니다.</span></p>

			<p style="text-align:center">&nbsp;</p>

			<p style="text-align:center"><span style="font-size:22px">저는 </span><span style="font-size:24px"><span style="color:#2980b9">데이터베이스 전문가</span></span><span style="font-size:22px">를 목표로 하고 있습니다!</span></p>

			<p style="text-align:center">&nbsp;</p>

			<p style="text-align:center"><span style="font-size:22px">다음학기부터 들을 과목으로 커리큘럼을 짜봤는데</span></p>

			<p style="text-align:center"><span style="color:#ffffff"><span style="font-size:22px"><span style="background-color:#3498db">컴공 선배님들의 조언 부탁드려요!</span></span></span></p>

			<p>&nbsp;</p>`);
	
	let totalBytes = CKEDITOR.instances.contentArea.getData().length;
    textLengthSpan.html(totalBytes);
    
})

// 나의 커리 선택
let myCurriArea = $("#myCurriArea");
let curriTb = $(".curriTb");
let myCurriSel = $("#myCurriSel").on("change", function(event) {
	let curriNo = $(this).val();
	console.log("나의 커리 curriNo : ", curriNo);
	
	if(curriNo==""){
		myCurriArea.hide();
		return;		
	}
	myCurriArea.show();
	
	curriTb.text("");
	curriTb.css("background", "none");
	
	// curriNO 가지고 커리 다 가져오기
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
	}) 
	
	
})

// ckeditor 쓰기
CKEDITOR.disableAutoInline = true;
let contentArea = CKEDITOR.inline('contentArea', {
	// 		startupFocus : true
	extraPlugins : 'editorplaceholder',
	editorplaceholder : '내용을 입력하세요.'
});


// 글 등록하기
let cbContentInput = $("#cbContentInput"); // 글 내용
let cbTitleInput = $("#cbTitleInput"); // 글 제목

let insertForm = $("#insertForm").on("click", "#insertBtn", function(event) {
	
	let cbContent = CKEDITOR.instances.contentArea.getData();
// 	console.log("cb content : ", cbContent);
	cbContentInput.val(cbContent);
	console.log("cb content hidden input : ", cbContentInput.val());
	
	// 입력 안한 값(제목, 내용) 있으면 return
	if(cbTitleInput.val()==""){
		cbTitleInput.focus();
		Swal.fire("제목을 입력하세요.");
		return false;
	}
	if(cbContent==""){
// 		CKEDITOR.instances.contentArea.focus();
		Swal.fire("내용을 입력하세요.");
		return false;
	}
	
	// 글자수 많으면 제한 return
	if(isOver){
		Swal.fire("최대 글자수는 초과하였습니다.");
		return false;
	}
	
	insertForm.submit();

})

// 글자수 제한하기
let isOver = false;
const max = 2000;
let textLengthSpan = $("#textLengthSpan");
contentArea.on( 'change', function(event) {
	let totalBytes = CKEDITOR.instances.contentArea.getData().length;
    console.log( 'Total bytes: ', totalBytes);
    
    textLengthSpan.html(totalBytes);
    
    if(totalBytes>2000){
    	textLengthSpan.addClass("text-danger");
    	isOver = true;
    }
    else {
    	textLengthSpan.removeClass("text-danger");
    	isOver = false;
    }
});

//enter 누를 때 submit 막기
$("#insertForm").keydown(function(event) {
	if (event.keyCode == '13') {
		if (window.event) {
			event.preventDefault();
			return;
		}
	}
});
</script>

<!-- Bootstrap 5 tags and initialize -->
<script src="${pageContext.request.contextPath}/resources/assets/pages/forms-tags.js" defer></script>



