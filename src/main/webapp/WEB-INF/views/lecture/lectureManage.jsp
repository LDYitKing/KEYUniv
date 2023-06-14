<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>	
<link rel="stylesheet" href="${cPath }/resources/css/sugang/sugang.css" type="text/css">
<link rel="stylesheet" href="${cPath }/resources/css/lecture/lecturePlan.css" type="text/css">
<security:authentication property="principal.realUser" var="authMember"/>	
<!-- 강의 상세검색 모달 -->
<div id="searchModal">
	<div id="searchModalDiv" class="card border-2 border-primary">
      <div id="searchModalHead" class="card-header toolbar">
         <div class="toolbar-start">
            <h4></h4>
         </div>
         <div class="toolbar-end">
            <button onclick="modalClose()" class="btn"><ion-icon name="close-outline"></ion-icon></button>
         </div>
      </div>
      <div id="searchModalBody">
      	<form id="searchForm">
      		<div class="p-4">
			<table class="table searchTable">
				<tr>
					<th width="10%">교과구분</th>
					<td colspan="2" width="40%">
						<select name="subComm" class="form-select searchInput">
							<option value=""></option>
				            <c:forEach items="${commList }" var="comm">
				              <option value="${comm.commNo }">${comm.commName }</option>
				            </c:forEach>							
						</select>
					</td>
					<th width="10%">학년</th>
					<td colspan="2" width="40%">
						<select class="form-select searchInput" name="subGrade">
							<option value=""></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>개설학과</th>
					<td>
						<select name="colNo" class="form-select searchInput">
							<option value=""></option>
					        <c:forEach items="${colList }" var="col">
					          <option value="${col.colNo }">${col.colName }</option>
					        </c:forEach>
						</select>
					</td>
					<td>
						<select name="deptNo" class="form-select searchInput">
							<option value=""></option>
						       	<c:forEach items="${deptList }" var="dept">
						         		<option class="${dept.colNo }" value="${dept.deptNo }">${dept.deptName }</option>
						       	</c:forEach>
						</select>
					</td>
					<th>수업교시</th>
					<td colspan="2">
						<label class="form-label">요일: </label>
						<select name="ltdDay" class="form-select searchInput">
							<option value=""></option>
							<option value="월">월</option>
							<option value="화">화</option>
							<option value="수">수</option>
							<option value="목">목</option>
							<option value="금">금</option>
							<option value="토">토</option>
						</select>
					</td>
					<td>
<!-- 						<label class="form-label">교시: </label> -->
<!-- 						<select class="form-select searchInput" name="ltdPeriod"> -->
<!-- 							<option value=""></option> -->
<%-- 							 <c:forEach var="i" begin="1" end="13"> --%>
<%-- 								<option value=${i }>${i } (${8+i}:00 ~ ${8+i}:50)</option> --%>
<%-- 							 </c:forEach> --%>
<!-- 						</select> -->
					</td>
				</tr>
			</table>
      		</div>
	      <div class="text-center">
      	     <button type="reset" class="btn btn-icon btn-xs m-2"> 
				<ion-icon class="fs-1 md hydrated" name="reload-outline" role="img" aria-label="reload outline"></ion-icon>
			</button>
			<input id="searchBtn" class="btn btn-primary" type="submit" value="검색">
	      </div>
      	</form>
      </div>
   </div>
</div>
<!-- 강의 상세검색 모달 끝 -->

<nav class="mb-3" aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page"><a href="${cPath}/lectureManage/lectureManageUI.do"">강의관리</a></li>
	</ol>
</nav>
<div class="row mx-3 justify-content-between">
	<div class="btn-group col-3" role="group" aria-label="Default button group">
		<a href="${cPath }/lectureManage/lectureManageUI.do" class="btn btn-info">강의조회</a>
		<a class="btn btn-info" id="lectPlanBtn">강의등록</a>
		<a class="btn btn-info" >나의 시간표</a>
	</div>
	<div class="text-white col-4 align-self-center">
		<label class="text-danger">[2023학년도 1학기]</label>
		<label><span>${authMember.memName }</span> 님의 강의 등록 가능 시수는 총 <span class="text-danger">12</span>시수 입니다.</label>
	</div>

</div>

<div class="space m-3 p-5">
	<div id="lectSearchDiv" class="col-md-8 offset-md-2 py-3 mb-3 p-3">
		<form class="searchbox input-group">
			<a href="#" onclick="modalOpen();" class="btn btn-icon btn-xs m-2" id="detailBtn">
				<ion-icon class="fs-1 md hydrated" width="16" height="16"  name="options-outline" role="img" aria-label="options outline"></ion-icon>
			</a>
			<input id="lectureSearchInput" class="searchbox__input form-control form-control-lg" type="search" placeholder="강의명, 교수명, 강의코드 검색" aria-label="Search">
			<div class="searchbox__btn-group">
				<a href="#" class="searchbox__btn btn btn-icon shadow-none border-0 btn-sm" type="button">
					<ion-icon name="search-outline"></ion-icon>
				</a>
			</div>
		</form>
		<div class="text-center mt-2">
			<p><span id="searchCnt"></span>건의 강의가 조회되었습니다.</p>
		</div>
	</div>
	<div>
	</div>
	<div id="basketDiv">
		<div id="lectDiv" class="m-2">
			<div id="lectListDiv" class="overflow-scroll scrollable-content">
			
				<ul id="lectListUl" class="list-group list-group-flush">
<!-- 					<li class="list-group-item list-group-item-action "> -->
<!-- 						<div class=" d-flex w-100 justify-content-between"> -->
<!-- 							<p><span class="h6 fw-bold">강의명</span>&nbsp;<span class="small">강의코드</span></p> -->
<!-- 							<small> -->
<!-- 								<button class="btn">상세보기</button> -->
<!-- 								<button class="btn">담기</button> -->
<!-- 							</small> -->
<!-- 						</div> -->
<!-- 						<p><label>교수명</label></p> -->
<!-- 						<small><label>학점</label>&nbsp;<label>학년</label>&nbsp;<label>구분</label>&nbsp;<label>교시</label></small> -->
<!-- 					</li> -->
				</ul>


			</div>
		</div>
		<div id="basketTbDiv" class="m-2">
		    <table id="basketTb" class="table table-bordered" border="2px solid #80808050">
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
		            <td class="timeTd text-center" id="lec${i+j}"></td>
		         </c:forEach>
		        </tr>
		      </c:forEach>
		    </table>			
		</div>
	</div>
</div>


<!-- ~~~~~~~~~~~~~~ cPath JS파일로 가져가기~~~~~~~~~~~~~~~ -->
<input type="hidden" id="cPath" value="${cPath}" />
<!-- ~~~~~~~~~~~~~~ AuthMember JS파일로 가져가기~~~~~~~~~~~~~~~ -->
<input type="hidden" id="memRole" value="${authMember.memRole}" />
<input type="hidden" id="memNo" value="${authMember.memNo}" />
<c:if test="${authMember.memRole eq'ROLE_EMP'}"> 
	<input type="hidden" id="empNo" value="${authMember.empNo}" />
</c:if>
<c:if test="${authMember.memRole eq'ROLE_PRO'}">  
<input type="hidden" id="proNo" value="${authMember.proNo}" />
</c:if>
<input type="hidden" id="colNo" value="${authMember.colNo}" />
<input type="hidden" id="deptNo" value="${authMember.deptNo}" />
<script src="${cPath }/resources/js/lecture/lectureManage.js"></script>


