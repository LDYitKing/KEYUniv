<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<security:authentication property="principal.realUser" var="authMember"/>
<link rel="stylesheet" href="${cPath }/resources/css/subject/subjectManagement.css" type="text/css">
  <!-- ~~~~~~~~~~~~~~~전체 div~~~~~~~~~~~~~~~ -->
    <!-- ~~~~~~~~~~~~~~~~~~그리드스택 툴 영역~~~~~~~~~~~~~~~~~~ -->
    <a href="javascript:location.reload(true);" class="btn btn-icon btn-success">
    	<ion-icon name="refresh-outline" style="font-size: 300%;"></ion-icon>
    </a>
    
     <a href="javascript:fn_GSTool()" class="btn btn-icon btn-success">
    	<ion-icon id="GSToolBtn" name="construct-outline" style="font-size: 300%;"></ion-icon>
    </a>
    <div class="col" id="GSTool" style="display: none;" >
      <div id="trash" style="padding: 5px; margin-bottom: 15px;" class="text-center">
        <div>
          <ion-icon name="trash-outline" style="font-size: 500%;"></ion-icon>
        </div>
      </div>
<!--       <div class="newWidget grid-stack-item"> -->
<!--         <div class="grid-stack-item-content" style="padding: 5px;" > -->
<!--           <div class="text-center"> -->
<!--             <ion-icon name="add-circle-sharp" style="font-size: 500%"></ion-icon> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
    </div>
    <!-- ~~~~~~~~~~~~~~~~~~그리드스택 툴 영역 끝~~~~~~~~~~~~~~~~~~ -->
    <!-- ~~~~~~~~~~~~~~~메인 대시보드 영역~~~~~~~~~~~~~~~ -->
	<!-- 컬럼영역을 12개로 쪼갬. 제일 작은거 한줄에 12개까지 가능 -->
    <div class="col-sm-12">
    
		<!-- ~~~~~그리드스택 시작~~~~~ -->
		<div class="grid-stack" id="gridStackDiv">
			<!-- ~~~~~~리스트 영역~~~~~~ -->
			<div
				class="grid-stack-item ui-resizable ui-draggable ui-resizable-autohide"
				gs-x="0" gs-y="0" gs-w="6" gs-h="7"  gs-min-h="7" gs-min-w="6" gs-max-w="12" style="">
				<div class="grid-stack-item-content p-4" >
				<h1>교과목 리스트(전체)</h1>
				<input type="text" id="searchSubjectListInput"  class="form-control col-auto" placeholder="교과목명 검색"/>
				<security:authorize access="hasAnyRole('PRO','EMP')">
						<a href="javascript:fn_CreateSubjectInsert()" class="btn btn-secondary">등록</a>
				</security:authorize>
					<table class="table table-hover text-center">
					 <colgroup>
			             <col width="7%"/>
			             <col width="10%"/>
			             <col width="10%"/>
			             <col width="30%"/>
			             <col width="10%"/>
			             <col width="7%"/>
			           </colgroup>
						<tbody class="table-primary">
							<tr>
								<td>번호</td>
								<td>단과대학명</td>
								<td>학과명</td>
								<td>교과목명</td>
								<td>유형</td>
								<security:authorize access="hasAnyRole('PRO','EMP')">
								<td>상태</td>
								</security:authorize>
							</tr>
						</tbody>
					</table>
					<div id="subjectListDiv" style="height: 200px; overflow : auto;">
					<table class="table table-hover text-center">
						 <colgroup>
				             <col width="7%"/>
				             <col width="10%"/>
				             <col width="10%"/>
				             <col width="30%"/>
				             <col width="10%"/>
				             <col width="7%"/>
				           </colgroup>
						<tbody id="listBody" data-view-url="${cPath}/subject/subjectView.do">
						
						</tbody>
					</table>
					</div>
				</div>
				<div class="ui-resizable-handle ui-resizable-se"
				style="z-index: 100; user-select: none;"></div>
			</div>
			<!-- ~~~~~~~~~리스트 영역 끝~~~~~~~~~ -->
			
			<!-- ~~~~~~ 요청 리스트 영역~~~~~~ -->
			<security:authorize access="hasAnyRole('EMP')">
			<div
				class="grid-stack-item ui-resizable ui-draggable ui-resizable-autohide"
				gs-x="6" gs-y="0" gs-w="6" gs-h="7" gs-min-h="7" gs-min-w="6" gs-max-w="12" style="" >
				<div class="grid-stack-item-content p-4" >
				<h1>교과목 요청 리스트(교직원)</h1>
				<input type="text" id="searchsubjectCheckListInput"  class="form-control col-auto" placeholder="교과목명 검색"/>
<%-- 			<security:authorize access="hasAnyRole('EMP')"> --%>
					<a href="javascript:fn_SubjectOKAll()" class="btn btn-secondary">전체승인</a>
<%-- 			</security:authorize> --%>
					<table class="table table-hover text-center">
						 <colgroup>
				             <col width="7%"/>
				             <col width="10%"/>
				             <col width="10%"/>
				             <col width="30%"/>
				             <col width="10%"/>
				             <col width="7%"/>
				             <col width="10%"/>
				           </colgroup>
						<thead class="table-primary">
							<tr>
								<th>번호</th>
								<th>단과대학명</th>
								<th>학과명</th>
								<th>교과목명</th>
								<th>유형</th>
								<th>상태</th>
								<th>처리</th>
							</tr>
						</thead>
					</table>
					<div id="subjectCheckListDiv" style="height: 200px; overflow : auto;">
					<table class="table table-hover text-center">
						 <colgroup>
				             <col width="7%"/>
				             <col width="10%"/>
				             <col width="10%"/>
				             <col width="30%"/>
				             <col width="10%"/>
				             <col width="7%"/>
				             <col width="10%"/>
				           </colgroup>
						<tbody id="reqListBody">
						
						</tbody>
					</table>
					</div>
				</div>
				<div class="ui-resizable-handle ui-resizable-se"
				style="z-index: 100; user-select: none;"></div>
			</div>
			</security:authorize>
			<!-- ~~~~~~~~~요청 리스트 영역 끝~~~~~~~~~ -->
			<!-- ~~~~~~ 교수가 신청했던 리스트 영역~~~~~~ -->
			<security:authorize access="hasAnyRole('PRO')">
			<div
				class="grid-stack-item ui-resizable ui-draggable ui-resizable-autohide"
				gs-x="6" gs-y="0" gs-w="6" gs-h="7" gs-min-h="7" gs-min-w="6" gs-max-w="12" style="" >
				<div class="grid-stack-item-content p-4" >
				<h1>교과목 내가 요청했던 리스트(교수)</h1>
				<input type="text" id="searchSubjectWaitingListInput"  class="form-control col-auto" placeholder="교과목명 검색"/>
					<table class="table table-hover text-center">
						 <colgroup>
				             <col width="7%"/>
				             <col width="10%"/>
				             <col width="10%"/>
				             <col width="30%"/>
				             <col width="10%"/>
				             <col width="7%"/>
				             <col width="10%"/>
				           </colgroup>
						<thead class="table-primary">
							<tr>
								<th>번호</th>
								<th>단과대학명</th>
								<th>학과명</th>
								<th>교과목명</th>
								<th>유형</th>
								<th>상태</th>
								<th>처리</th>
							</tr>
						</thead>
					</table>
					<div id="SubjectWaitingListDiv" style="height: 200px; overflow : auto;">
					<table class="table table-hover text-center">
						 <colgroup>
				             <col width="7%"/>
				             <col width="10%"/>
				             <col width="10%"/>
				             <col width="30%"/>
				             <col width="10%"/>
				             <col width="7%"/>
				             <col width="10%"/>
				           </colgroup>
						<tbody id="SubjectWaitingListBody">
						
						</tbody>
					</table>
					</div>
				</div>
				<div class="ui-resizable-handle ui-resizable-se"
				style="z-index: 100; user-select: none;"></div>
			</div>
			</security:authorize>
			<!-- ~~~~~~~~~교수가 신청했던 리스트 영역 끝~~~~~~~~~ -->
			
			<!-- ~~~~~~즐겨찾기 리스트 영역~~~~~~ -->
<%-- 			<security:authorize access="hasAnyRole('STU')"> --%>
			<div
				class="grid-stack-item ui-resizable ui-draggable ui-resizable-autohide"
				gs-x="0" gs-y="0" gs-w="6" gs-h="7" gs-min-h="7" gs-min-w="6" gs-max-w="12" style="" >
				<div class="grid-stack-item-content p-4">
				<h1>즐겨찾기(학생)</h1>
				<input type="text" id="searchFavoriteSubjectInput"  class="form-control col-auto" placeholder="교과목명 검색"/>
					<table class="table table-hover text-center" id="favoriteTable">
						 <colgroup>
				             <col width="7%"/>
				             <col width="10%"/>
				             <col width="30%"/>
				             <col width="10%"/>
				             <col width="7%"/>
				             <col width="7%"/>
				             <col width="7%"/>
				           </colgroup>
						<thead class="table-primary">
							<tr>
								<th>번호</th>
								<th>학과명</th>
								<th>교과목명</th>
								<th>교과목유형</th>
								<th>학년</th>
								<th>학점</th>
								<th>시수</th>
							</tr>
						</thead>
					</table>
					<div id="favoritesDiv" style="height: 200px; overflow : auto;">
					<table class="table table-hover text-center">
					 	<colgroup>
				             <col width="7%"/>
				             <col width="10%"/>
				             <col width="30%"/>
				             <col width="10%"/>
				             <col width="7%"/>
				             <col width="7%"/>
				             <col width="7%"/>
				           </colgroup>
						<tbody id="favorites">
						
						</tbody>
					</table>
					</div>
				</div>
				<div class="ui-resizable-handle ui-resizable-se"
				style="z-index: 100; user-select: none;"></div>
			</div>
<%-- 			</security:authorize> --%>
			<!-- ~~~~~~~~~즐겨찾기 리스트 영역 끝~~~~~~~~~ -->
			
	</div>
		<!-- ~~~~~그리드스택 끝~~~~~ -->
    </div>
    <!-- ~~~~~~~~~~~~~~~메인 대시보드 영역끝~~~~~~~~~~~~~~~ -->
  <!-- ~~~~~~~~~~~~~~~전체 div끝~~~~~~~~~~~~~~~ -->
  
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
  <c:if test="${authMember.memRole ne 'ROLE_EMP'}"> 
  <input type="hidden" id="colNo" value="${authMember.colNo}" />
  <input type="hidden" id="deptNo" value="${authMember.deptNo}" />
  </c:if>
  <!-- ~~~~~~~~~~~~~~ JS파일 연결~~~~~~~~~~~~~~~ -->
  <script src="${cPath }/resources/js/subject/subjectManagement.js"></script>
