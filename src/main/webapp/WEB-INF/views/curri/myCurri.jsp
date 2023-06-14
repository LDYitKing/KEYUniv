<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.modal-backdrop {
	/*    width : 0%; */
	/*    height: 0%; */

}

.table-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-column-gap: 25px;
}

.hover-darken:hover {
	background-color: attr(color hover) !important;
}

.tab-base .nav-tabs, .tab-base .nav-tabs .nav-link {
	width: 50px;
}

.table-fixed {
	width: 100%;
	background-color: #f3f3f3;
}

tbody {
	height: 300px;
	overflow-y: auto;
	width: 100%;
}

.detailModal {
	position: fixed;
	width: 100%;
	/* fixed일 때는 height:100% 동작 */
	height: 100%;
	left: 0px;
	top: 0px;
	background-color: rgba(0, 0, 0, 0.274);
	/* 무조건 크겡! */
	z-index: 315;
	display: none;
}

.card-header {
	margin-right: 20px;
}

#subjectListBody {
	background-color: white;
}

#favorites {
	background-color: white;
	margin-left: 20px; /* Add this line */
}

.modalCont {
	width: 400px;
	height: 400px;
	/* 수평 가운데 정렬 */
	margin: 15% auto;
	padding-left: 20px;
	border-radius: 5%;
	background-color: rgb(255, 255, 255);
	color: rgb(9, 9, 8);
}

.modalSubmit {
	margin-left: 230px;
}

.modalHead {
	left: 10px;
}

.detailModalCont {
	width: 700px;
	height: 700px;
	margin-top: 7%;
	margin-left: 32%;
	padding-left: 25px;
	border-radius: 2%;
	background-color: rgb(255, 255, 255);
	color: rgb(9, 9, 8);
}

.eightTbl {
	border: 2px solid gainsboro!important;
 	border-radius: 5px!important;
 	padding: 3px!important;
}

th, td {
/* 	padding: 0; */
}

thead tr th, tbody tr td {
	width: calc(100%/ 8); /* 수정된 부분 - 총 8개의 열이므로 각각 12.5%의 너비를 가지게 설정 */
}

tbody {
	height: 200px;
	overflow-y: auto;
	width: 100%;
}

td {
	width: 100px;
	height: 50px;
}

.tab-content {
	height: 500px;
}

.table {
	flex: 3;
}

#curriList tbody {
	overflow-y: auto !important;
	max-height: 500px;
}

#curriTable {
	height: 500px;
	background-color: white;
	text-align: center;
}

#curriTable td {
	height: 50px;
}

ion-icon:not(.iconBtn) {
	font-size: 64px;
}

button {
	margin: 1px;
}

.myCurriTitle{
	text-decoration: none;
	letter-spacing: 5pt;
}
.myCurriDiv{
	display: grid;
	grid-template-columns: 3fr 1.2fr;
}
.listDiv{
	border-top: 2px solid #f2f2f2;
	border-bottom: 2px solid #f2f2f2;
	height: 200px;
	overflow: auto;
}
</style>
<security:authorize access="hasRole('PRO')">
<!-- 일정을 클릭하면 나오는 모달 -->
<div id="detailModal" class="detailModal">
	<div id="detailModalCont" class="detailModalCont">
		<div id="modalHead" class="card-header toolbar">
			<div class="toolbar-start" style="font-size: 15px;">교과목 정보</div>
			<div class="toolbar-end">
				<button onclick="detailModalClose()">X</button>
			</div>
		</div>
		<form action="${cPath}/selectSubjectList" method="post" id="detailForm">
			<div class="modalInput">
				<input type="text" id="scdNo" class="form-control" value=""> 과목명:&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" id="sName" class="form-control" value="" readonly="readonly" /> 커리명:<input type="text" id="scurriNo" class="form-control" value="" readonly="readonly" /> 클래스명:<input type="text" id="scdPriority" class="form-control" value="" readonly="readonly" /> 설명: <input type="text" id="subExp" class="form-control" value="" readonly="readonly" /> 학점: <input type="text" id="subGrade" class="form-control" value="" readonly="readonly" /> 시간: <input type="text" id="subHours" class="form-control" value="" readonly="readonly" /> 학점: <input type="text" id="subScr" class="form-control" value="" readonly="readonly" /> 단과 대학명: <input type="text" id="colName" class="form-control" value="" readonly="readonly" /> 교과목 유형: <input type="text" id="commName" class="form-control" value="" readonly="readonly" />
			</div>
		</form>
		<div class="toolbar-end" style="margin-left: auto;">
			<button class="btn btn-danger" id="updateButton">수정</button>
			<button class="btn btn-danger" onclick="remove()">삭제</button>
		</div>
	</div>
</div>
<!-- 일정을 클릭하면 나오는 모달 끝 -->

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item"><a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">학과 커리</li>
	</ol>
</nav>
<div id="searchUI" class="m-2 pb-3 row justify-content-center">
	<div>
		<h3 class="page-title d-flex flex-wrap just justify-content-center mb-3 mt-2"><a class="link-light myCurriTitle fw-bold" href="${cPath }/curri/myCurri.do">학과 커리</a></h3>
	</div>
</div>
<div class="space m-3 px-5">
	<div class="myCurriDiv">
		<div class="tab-content">
			<div class="d-flex justify-content-end p-2 mt-4 row">
				<div class="col-2 text-end mt-3">
					<p class="lead fw-bold fs-4 mb-2">커리 설계</p>
				</div>
				<div class="col-7 m-2">
					<input type="text" id="curriName" class="form-control" placeholder="커리 명을 입력하세요.">
				</div>
				<div class="col-2 m-2">
					<button type="button" class="btn btn-info" id="saveBtn">저장</button>
					<button type="button" class="btn btn-icon btn-lg text-primary" onclick="resetInputs()"><ion-icon class="iconBtn" name="reload-outline"></ion-icon></button>
				</div>
			</div>
			<div id="_dm-verTabsHome" class="tab-pane fade show active" role="tabpanel" aria-labelledby="home-tab">
				<div class="row" id="myTest" style="display: grid; grid-template-columns: repeat(8, 1fr);">
					<!-- Buttons -->
					<!-- Buttons -->
				</div>
			</div>
		</div>
		<div class="m-3 px-3">
			<div class="text-center">
				<p class="lead fw-bold fs-4 m-2">학과 커리 목록</p>
			</div>
			<table class="table table-hover text-center scrolltable table-fixed" id="curriTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>커리이름</th>
						<th>날짜</th>
						<th>삭제</th>
						<!-- More columns as needed -->
					</tr>
				</thead>
				<tbody id="curriList">
				</tbody>
				<tfoot>
				</tfoot>
			</table>
		</div>
	</div>
</div>
<div style="display: grid; grid-template-columns: 1fr;">
	<div style="display: grid; grid-template-columns: 1fr;">
		<div class="space m-3 p-5">
			<div>
				<div class="table-container">
					<div>
						<div class="text-center">
							<p class="lead fw-bold fs-4 mb-2">교과목 리스트</p>
						</div>
						<table id="subjectclickList" class="table table-hover text-center scrolltable table-fixed mb-0">
							<thead>
								<tr>
									<th>번호</th>
									<th>학과명</th>
									<th>과목명</th>
									<th>유형</th>
									<th>학년</th>
									<th>학점</th>
									<th>시수</th>
									<th>추가</th>
								</tr>
							</thead>
						</table>
						<div id="subjectListDiv" class="listDiv">
							<table class="table table-hover text-center scrolltable table-fixed">
								<tbody id="subjectListBody" data-view-url="">
								</tbody>
							</table>
						</div>
						<div id="searchUI" class="row d-flex justify-content-center mt-2">
							<div class="col-auto">
								<select name="searchType" class="form-control">
									<option value>전체</option>
									<option value="name">과제명</option>
								</select>
							</div>
							<div class="col-auto">
								<input type="text" id="searchInputSubject" class="form-control col-auto" />
							</div>
							<div class="col-auto">
								<input type="button" value="검색" id="searchBtn" class="btn btn-primary" />
							</div>
						</div>
					</div>
					<div>
						<div class="text-center">
							<p class="lead fw-bold fs-4 mb-2">즐겨찾기 교과목</p>
						</div>
							<table id="favoriteclickList" class="table table-hover text-center scrolltable table-fixed mb-0">
								<thead>
									<tr>
										<th>번호</th>
										<th>학과명</th>
										<th>과목명</th>
										<th>유형</th>
										<th>학년</th>
										<th>학점</th>
										<th>시수</th>
										<th>추가</th>
									</tr>
								</thead>
							</table>
							<div id="subjectListDiv" class="listDiv">
								<table class="table table-hover text-center scrolltable table-fixed">
									<tbody id="favorites" data-view-url="">
									</tbody>
								</table>
							</div>
						<div id="searchUI" class="row d-flex justify-content-center mt-2">
							<div class="col-auto">
								<select name="searchType" class="form-control">
									<option value>전체</option>
									<option value="name">과제명</option>
								</select>
							</div>
							<div class="col-auto">
								<input type="text" id="searchInputFavorite" class="form-control col-auto" placeholder="교과목명 검색" />
							</div>
							<div class="col-auto">
								<input type="button" value="검색" id="searchBtn" class="btn btn-primary" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form name="searchForm">
</security:authorize>
<security:authorize access="hasRole('STU')">
<!-- 일정을 클릭하면 나오는 모달 -->
<div id="detailModal" class="detailModal">
	<div id="detailModalCont" class="detailModalCont">
		<div id="modalHead" class="card-header toolbar">
			<div class="toolbar-start" style="font-size: 15px;">교과목 정보</div>
			<div class="toolbar-end">
				<button onclick="detailModalClose()">X</button>
			</div>
		</div>
		<form action="${cPath}/selectSubjectList" method="post" id="detailForm">
			<div class="modalInput">
				<input type="text" id="scdNo" class="form-control" value=""> 과목명:&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" id="sName" class="form-control" value="" readonly="readonly" /> 커리명:<input type="text" id="scurriNo" class="form-control" value="" readonly="readonly" /> 클래스명:<input type="text" id="scdPriority" class="form-control" value="" readonly="readonly" /> 설명: <input type="text" id="subExp" class="form-control" value="" readonly="readonly" /> 학점: <input type="text" id="subGrade" class="form-control" value="" readonly="readonly" /> 시간: <input type="text" id="subHours" class="form-control" value="" readonly="readonly" /> 학점: <input type="text" id="subScr" class="form-control" value="" readonly="readonly" /> 단과 대학명: <input type="text" id="colName" class="form-control" value="" readonly="readonly" /> 교과목 유형: <input type="text" id="commName" class="form-control" value="" readonly="readonly" />
			</div>
		</form>
		<div class="toolbar-end" style="margin-left: auto;">
			<button class="btn btn-danger" id="updateButton">수정</button>
			<button class="btn btn-danger" onclick="remove()">삭제</button>
		</div>
	</div>
</div>
<!-- 일정을 클릭하면 나오는 모달 끝 -->

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item"><a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">나의 커리</li>
	</ol>
</nav>
<div id="searchUI" class="m-2 pb-3 row justify-content-center">
	<div>
		<h3 class="page-title d-flex flex-wrap just justify-content-center mb-3 mt-2"><a class="link-light myCurriTitle fw-bold" href="${cPath }/curri/myCurri.do">나의 커리</a></h3>
	</div>
</div>
<div class="space m-3 px-5">
	<div class="myCurriDiv">
		<div class="tab-content">
			<div class="d-flex justify-content-end p-2 mt-4 row">
				<div class="col-2 text-end mt-3">
					<p class="lead fw-bold fs-4 mb-2">커리 설계</p>
				</div>
				<div class="col-7 m-2">
					<input type="text" id="curriName" class="form-control" placeholder="커리 명을 입력하세요.">
				</div>
				<div class="col-2 m-2">
					<button type="button" class="btn btn-info" id="saveBtn">저장</button>
					<button type="button" class="btn btn-icon btn-lg text-primary" onclick="resetInputs()"><ion-icon class="iconBtn" name="reload-outline"></ion-icon></button>
				</div>
			</div>
			<div id="_dm-verTabsHome" class="tab-pane fade show active" role="tabpanel" aria-labelledby="home-tab">
				<div class="row" id="myTest" style="display: grid; grid-template-columns: repeat(8, 1fr);">
					<!-- Buttons -->
					<!-- Buttons -->
				</div>
			</div>
		</div>
		<div style="margin:20px 0px 20px 20px; ">
			<div class="text-center">
				<p class="lead fw-bold fs-4 m-2">나의 커리 목록</p>
			</div>
			<table class="table table-hover text-center scrolltable table-fixed" id="curriTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>커리이름</th>
						<th>날짜</th>
						<th>삭제</th>
						<!-- More columns as needed -->
					</tr>
				</thead>
				<tbody id="curriList">
				</tbody>
				<tfoot>
				</tfoot>
			</table>
		</div>
	</div>
</div>
<div style="display: grid; grid-template-columns: 1fr;">
	<div style="display: grid; grid-template-columns: 1fr;">
		<div class="space m-3 p-5">
			<div>
				<div class="table-container">
					<div>
						<div class="text-center">
							<p class="lead fw-bold fs-4 mb-2">교과목 리스트</p>
						</div>
						<table id="subjectclickList" class="table table-hover text-center scrolltable table-fixed mb-0">
							<thead>
								<tr>
									<th>번호</th>
									<th>학과명</th>
									<th>과목명</th>
									<th>유형</th>
									<th>학년</th>
									<th>학점</th>
									<th>시수</th>
									<th>추가</th>
								</tr>
							</thead>
						</table>
						<div id="subjectListDiv" class="listDiv">
							<table class="table table-hover text-center scrolltable table-fixed">
								<tbody id="subjectListBody" data-view-url="">
								</tbody>
							</table>
						</div>
						<div id="searchUI" class="row d-flex justify-content-center mt-2">
							<div class="col-auto">
								<select name="searchType" class="form-control">
									<option value>전체</option>
									<option value="name">과제명</option>
								</select>
							</div>
							<div class="col-auto">
								<input type="text" id="searchInputSubject" class="form-control col-auto" />
							</div>
							<div class="col-auto">
								<input type="button" value="검색" id="searchBtn" class="btn btn-primary" />
							</div>
						</div>
					</div>
					<div>
						<div class="text-center">
							<p class="lead fw-bold fs-4 mb-2">즐겨찾기 교과목</p>
						</div>
							<table id="favoriteclickList" class="table table-hover text-center scrolltable table-fixed mb-0">
								<thead>
									<tr>
										<th>번호</th>
										<th>학과명</th>
										<th>과목명</th>
										<th>유형</th>
										<th>학년</th>
										<th>학점</th>
										<th>시수</th>
										<th>추가</th>
									</tr>
								</thead>
							</table>
							<div id="subjectListDiv" class="listDiv">
								<table class="table table-hover text-center scrolltable table-fixed">
									<tbody id="favorites" data-view-url="">
									</tbody>
								</table>
							</div>
						<div id="searchUI" class="row d-flex justify-content-center mt-2">
							<div class="col-auto">
								<select name="searchType" class="form-control">
									<option value>전체</option>
									<option value="name">과제명</option>
								</select>
							</div>
							<div class="col-auto">
								<input type="text" id="searchInputFavorite" class="form-control col-auto" placeholder="교과목명 검색" />
							</div>
							<div class="col-auto">
								<input type="button" value="검색" id="searchBtn" class="btn btn-primary" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form name="searchForm">
	<input type="hidden" name="searchType" placeholder="searchType" /> <input type="hidden" name="searchWord" placeholder="searchWord" />
</form>
</security:authorize>
<input type="hidden" id="cPath" value="${cPath}" />
<script src="${cPath}/resources/js/myCurri/myCurri.js"></script>