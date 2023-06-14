<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	.curriTable{
		table-layout: fixed;
	}
	
	#curriDiv{
		display: grid;
		grid-template-columns: 1fr 5fr;
	}
	
	#curriDiv *{
		font-size: 101%; 
	}

	#rankDiv, #listDiv, #searchUI{
/* 		border: 1px solid green; */
	}
	#rankDiv{
		height: 660px;
	}		
	
	.aTags{
		text-decoration: none;
		border: 1.5px solid lightgray;
		border-radius: 3px;
		padding: 3px 8px;
	}
	.tagTd{
		overflow:hidden;
	}
	#tagRank{
	}
	.everyCurriTitle{
		text-decoration: none;
		letter-spacing: 5pt;
	}
	.cbtitleTag{
		text-decoration: none;
		color: black;
	}
</style>	
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item"><a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">모두의 커리</li>
	</ol>
</nav>    
<div id="searchUI" class="m-2 pb-3 row justify-content-center">
	<div>
		<h3 class="page-title d-flex flex-wrap just justify-content-center mb-3 mt-2"><a class="link-light everyCurriTitle fw-bold" href="${cPath }/curri/everyCurri">모두의 커리</a></h3>
	</div>
	<div class="col-6">
		<input id="searchInput" class="form-control" type="text" name="tag" placeholder="#태그 검색">
	</div>
	<div class="col-1">
<!-- 			<input type="button" id="searchBtn" value="검색"> -->
           <button id="searchBtn" type="button" class="btn btn-icon btn-info">
              <ion-icon name="search-outline" class="demo-pli-mine fs-3"></ion-icon>
		</button>
		
	</div>
</div>
<div class="space m-3 px-5">
	
	<div id="curriDiv">
		<div id="rankDiv" class="mt-4">
			<div class="mt-4">
				<p class="mb-3 fw-bold fs-4"># 인기 태그 TOP 5</p>
				<div id="tagRank" class='d-flex flex-wrap gap-3'>
				</div>
			</div>
			<br>
			<div class="mt-4">
				<p class="mb-3 fw-bold fs-4"># 추천 태그</p>
				<div id="" class='d-flex flex-wrap gap-3'>
					<span><a class="aTags mt-2 text-nowrap" href="javascript:fn_clickTag('나의커리');"><span class="spanTags link-success">#나의커리</span></a></span>
					<span><a class="aTags mt-2 text-nowrap" href="javascript:fn_clickTag('추천');"><span class="spanTags link-success">#추천</span></a></span>
					<span><a class="aTags mt-2 text-nowrap" href="javascript:fn_clickTag('꿀팁');"><span class="spanTags link-success">#꿀팁</span></a></span>
					<span><a class="aTags mt-2 text-nowrap" href="javascript:fn_clickTag('교양');"><span class="spanTags link-success">#교양</span></a></span>
					<span><a class="aTags mt-2 text-nowrap" href="javascript:fn_clickTag('전공');"><span class="spanTags link-success">#전공</span></a></span>
				</div>
			</div>				
		</div>
		<div id="listDiv" class="m-2">
			<div class="text-end m-2">
				<input type="button" class="btn btn-outline-primary" value="글쓰기" onclick="location.href='${cPath}/curri/everyCurri/form'">
			</div>
			<div class="m-3">
				<table class="table table-bordered curriTable">
					<thead>
						<tr>
							<th width="4%">No</th>
							<th width="25%" class="text-truncate">제목</th>
							<th width="40%">태그</th>
							<th width="10%">작성자</th>
							<th width="15%">작성일</th>
							<th width="6%">조회수</th>
						</tr>
					</thead>
					<tbody id="listBody">

					</tbody>
					<tfoot></tfoot>
				</table>
			</div>
			
			<nav id="pagingArea" class="text-align-center mt-5" aria-label="Table navigation"></nav>
			
			
			<form id="searchForm">
				<input type="hidden" name="tag">
				<input type="hidden" name="page">
			</form>

		</div>
	</div>
</div>

<script>

let listBody = $("#listBody");
let pagingArea = $("#pagingArea");

let searchUI = $("#searchUI").on("click", "#searchBtn", function(event){
	console.log("searchUI 버튼 실행");

	searchForm.find('[name=tag]').val(searchInput.val());
	searchForm.submit();	
})

let searchForm = $("#searchForm").on("submit", function(event) {
	event.preventDefault();
	
	let lastPage = sessionStorage.getItem('currentPage');
	let lastTag = sessionStorage.getItem('currentTag');
	if(lastPage) $(this).find("[name=page]").val(lastPage);
	if(lastTag) $(this).find("[name=tag]").val(lastTag);
	
   listBody.empty();
   pagingArea.empty();
	
	let data = $(this).serialize();
	console.log("data : ", data);
	
	$.ajax({
		url:"",
		method:"post",
		data: data,
		dataType: "json",
		success:function(resp){
			let pagination = resp;
			console.log("pagination : ", resp);
			
			let curriList = pagination.dataList;
			console.log("curri board list : ", curriList);
			
			// tr 만들기
			$.each(curriList, function(idx, curri){
				listBody.append(fn_makeTr(curri))
			})
			
			pagingArea.append(pagination.pagingHTML);
			sessionStorage.setItem('page', searchForm.find("[name=page]").val()); // 현재 페이지
			sessionStorage.setItem('tag', searchForm.find("[name=tag]").val()); // 현재 검색어
			
			sessionStorage.removeItem('currentPage');
			sessionStorage.removeItem('currentTag');
			searchForm.find("[name=page]").val("");
			
		}
		
	})
	
	return false;
	
}).submit();

// 검색어 입력하고 enter 누르면 검색
let searchInput = $("#searchInput").on("keyup",function(key){
        if(key.keyCode==13) {
            // 엔터키 이벤트
			$("#searchBtn").click();
        }
});

// tr 태그 (curri 하나) 만들기
let fn_makeTr = (curri) =>{
	let tagList = curri.tagList;
	console.log("tagList : ", tagList);
	
	// tag 가 있는지 없는지 확인
	let tagTd = $("<td  class='tagTd'>");
	if(tagList.length>0 && tagList[0].tagNo!=null){
		console.log("태그 있음");
		// 태그 뱃지 리스트 div 넣기
		tagTd.append(fn_makeBadge(tagList));
	}
	let titleTag = `<a class="cbtitleTag" href="javascript:fn_view('\${curri.cbNo}');">\${curri.cbTitle}</a>`;
	
	let trTag = $("<tr>").append(
		$("<td>").html(curri.rnum)
		, $("<td>").html(titleTag)
		, tagTd
		, $("<td>").html(curri.memName)
		, $("<td>").html(curri.cbWdate)
		, $("<td class='text-center'>").html(curri.cbCnt)
	).addClass("curriTr").data("cbNo", curri.cbNo);

	return trTag;
}

// 제목 누르면 view로 이동 (페이징 가지고 가기)
let fn_view = (cbNo) =>{
// 	console.log(cbNo, "게시글로 이동")

// 	let page = searchForm.find("[name=page]").val();
// 	console.log("페이지 : ", page);
// // 	if(!page) currentPage=1;
	
// 	let currentPage = page ?? 1;
// 	console.log("현재 페이지 : ", currentPage);
// 	sessionStorage.setItem('currentPage', currentPage);

	sessionStorage.setItem('currentPage', sessionStorage.getItem('page'));
	sessionStorage.setItem('currentTag', sessionStorage.getItem('tag')); 
	
	location.href="${cPath}/curri/everyCurri/" + cbNo;
}

// badge (curri 하나의 tagList) 만들기 
let fn_makeBadge = (tagList) =>{

	let div = $("<div class='d-flex flex-wrap gap-2'>").data("tag", tagList[0].cbNo);
// 	console.log("div tag data 속성 : ", div.data("tag"));
	$.each(tagList, function(i, tag){
		div.append(
			$("<span>")
				.html(`<a class='aTags mt-2 text-nowrap' href='javascript:fn_clickTag("\${tag.tagContent}");'><span class='spanTags'>#\${tag.tagContent}</span></a>`)
		);
	})

	return div;

}

// 태그 클릭하면 태그로 검색 결과 가져오기
let fn_clickTag = (tagContent) =>{
	// 태그내용을 search input에 넣고 submit
	$("[name=tag]").val(tagContent);
	searchForm.submit();
}

let resetBtn = $("#resetBtn").on("click", function(event){
	$("[name=tag]").val("");
	searchForm.submit();

})

// 페이지 누르면 페이지 이동
let fn_paging = (page, event) => {
   event.preventDefault();
   searchForm.find("[name=page]").val(page);
   searchForm.submit();
   return false;
}

// 태그 랭크 가져오기
let tagRank = $("#tagRank");

let fn_tagRank = () =>{
	
	$.ajax({
		url:"${cPath}/curri/everyCurri/tagRank",
		method:"post",
		dataType:"json",
		success:function(resp){
			console.log("tag rank 5 : ", resp);
			// tagContent

			$.each(resp, function(idx, tag){
				
				tagRank.append(
					$("<span>")
						.html(`<a class='aTags mt-2 text-nowrap' href='javascript:fn_clickTag("\${tag.tagContent}");'><span class='spanTags link-danger'>#\${tag.tagContent}</span></a>`)
				);
			})

		}
	})

}
fn_tagRank();

</script>
