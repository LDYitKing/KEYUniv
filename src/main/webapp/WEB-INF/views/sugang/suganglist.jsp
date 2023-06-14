<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<link rel="stylesheet" href="${cPath }/resources/css/sugang/sugang.css"
	type="text/css">
<security:authentication property="principal.realUser" var="authMember" />

<nav class="mb-3" aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page"><a
			href="${cPath}/sugang/info">수강신청</a></li>
	</ol>
</nav>
<div class="row mx-3 justify-content-between">
	<div class="btn-group col-3" role="group"
		aria-label="Default button group">
		<a href="${cPath }/sugang/basket" class="btn btn-info">사전수강신청</a>
		<a href="${cPath }/sugang/signup" class="btn btn-info">수강신청</a>
		<a href="${cPath }/sugang/list"  class="btn btn-info">수강신청 내역</a>
	</div>
	<div class="text-white col-4 align-self-center">
		<label class="text-danger">[2023학년도 1학기]</label> <label><span>${authMember.memName }</span>
			님의 수강신청 가능 학점은 <span class="text-danger">20</span>학점 입니다.</label>
	</div>

</div>

<div class="space m-3 p-5">
	<div id="suganglistDiv">
		<div id="listDiv" class="m-2">
			<div>
				<p class="lead">신청가능학점 <span class="text-info">20</span>학점 / 신청학점 
				<span id="sugangSubScr" class="text-info">0</span>학점 / 신청강의 
				<span id="sugangCnt" class="text-info">0</span>강의
				</p>
			</div>
			<hr>
			<div id="lectListDiv" class="overflow-scroll scrollable-content">

				<ul id="lectListUl" class="list-group list-group-flush">
				</ul>


			</div>
		</div>
		<div id="suganglistTbDiv" class="m-2">
			<table id="basketTb" class="table table-bordered">
				<tr>
					<th class="wkTh"></th>
					<th class="wkTh">월</th>
					<th class="wkTh">화</th>
					<th class="wkTh">수</th>
					<th class="wkTh">목</th>
					<th class="wkTh">금</th>
					<th class="wkTh">토</th>
				</tr>
				<c:forEach var="i" begin="1" end="13">
					<tr>
						<th class="timeTh">${i}</th>
						<c:forEach step="100" var="j" begin="100" end="600">
							<td class="timeTd text-center" id="sugang${i+j}"></td>
						</c:forEach>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>

<script>
let sugangSubScr = $("#sugangSubScr"); // 신청학점
let sugangCnt = $("#sugangCnt"); // 신청강의

let lectListUl = $("#lectListUl");

const colorList = ["#FEA47F", "#F8EFBA", "#D6A2E8", "#EAB543", "#55E6C1", "#ffcccc", "#BEF5BE", "#A4C3FF", "#FFE4B5"];

let fn_makeLi = () =>{
	lectListUl.empty();
	
	$(".timeTd").empty();
	$(".timeTd").css("background", "none");
	
	$.ajax({
		url:"${cPath}/sugang/list",
		method:"post",
		dataType:"json",	
		success:function(resp){
			let courseList = resp;
			console.log("courseList : ", courseList);
			
			let subScr = 0;
			let cnt = 0;
			
			if(courseList.length > 0){
				$.each(courseList, function(idx, course){
					
					let lect = course.lecture;
					console.log("lect : ", lect);
					
					// 신청학점, 신청강의 수 증가
					subScr = subScr + lect.subScr;
					cnt = cnt + 1;
					
					let courseNo = course.courseNo;
					
					// 리스트 띄우기
					lectListUl.append(
						$(`<div class='uldiv' data-course-no='\${courseNo}'>`).append(lect.lectListHTML)		
					);
// 					lectListUl.append(lect.lectListHTML);
					
					let color = colorList[idx%10];
					$.each(lect.lectDetailList, function(i, lt){
						let td = lt.ltdNo;
						$(`#sugang\${td}`).css("background-color", color);
						$(`#sugang\${td}`).html(`<small>\${lect.lectName}</small>`);						
					})
				})
				
			}else {
				
			}
			
			sugangSubScr.text(subScr);
			sugangCnt.text(cnt);
		}
	})
	
}
fn_makeLi();

//수강신청 삭제
	 let deleteBtn = $(document).on("click", "#deleteBtn", function () {
//		 	console.log($(this).parents("li").data("lectNo"));
			let courseNo = $(this).parents(".uldiv").data("courseNo");
			let lectNo = $(this).parents("li").data("lectNo");
			
			Swal.fire({
				  title: '삭제하시겠습니까?',
				  showDenyButton: true,
				  confirmButtonText: '확인',
				  denyButtonText: '취소',
				}).then((result) => {
				  if (result.isConfirmed) {
					  
					$.ajax({
						url: "${cPath}/sugang/delete.do",
						method:"post",
						data: {"courseNo":courseNo, "lectNo":lectNo},
						success: function(){
							fn_makeLi();		
						    Swal.fire('삭제되었습니다.', '', 'success')
						}		
					})
					  
				  } else if (result.isDenied) {
					  
				  }
			})
			
		});	

	
</script>


