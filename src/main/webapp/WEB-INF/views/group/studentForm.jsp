
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="${cPath }/resources/css/student/studentForm.css" type="text/css">

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/group/students">학생관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">신편입생 등록</li>
	</ol>
</nav>
<div class="space m-3 p-5">
<!-- 폼 수정 -->
	<h3 class="card-title mt-2">신편입생 등록</h3><br>
	<div id="notice-card" class="card-body mb-4">
		<p class="d-inline-block h5 btn-link text-truncate mb-2">등록 방법 안내</p>
		<p>1. 등록할 신편입생의 단과대학과 학과를 선택합니다. </p>
		<p>2. 등록할 신편입생의 수를 입력하고 추가 버튼을 누릅니다. </p>
		<p>3. 추가된 양식에 맞게 정보를 입력 후 등록 버튼을 누릅니다. </p>
		<p class="text-danger">&emsp;- 해당 양식은 모두 필수 입력 사항이며, 빠짐없이 정확하게 입력 후에 등록합니다.</p>
		<p class="">&emsp;- 등록 후 학생 정보는 학생 관리 > 학생 상세보기 창에서 수정 가능합니다. </p>
	</div>
	<hr>
	 <form id="insertForm" class="row g-3" action="<c:url value='/group/studentInsert.do'/>"
    	enctype="multipart/form-data">
		<div class="row m-2">
			<div class="col-4">
	     		<label class="form-label">년도: </label>
			    <input class="form-control" type="text" value="2023" name="ayYear" readonly/>
			</div>
		</div>
		<div class="row m-2">
			<div class="col-2">
				<label class="form-label">단과대학: </label>
				<select class="form-select" name="colNo">
					<option value=""></option>
			        <c:forEach items="${colList }" var="col">
			          <option value="${col.colNo }">${col.colName }</option>
			        </c:forEach>
				</select>
			</div>
			<div class="col-3">
				<label class="form-label">학과: </label>
		   		<select class="form-select" name="deptNo" disabled="disabled">
		        	<option value=""></option>
		        	<c:forEach items="${deptList }" var="dept">
		          		<option class="${dept.colNo }" value="${dept.deptNo }">${dept.deptName }</option>
		        	</c:forEach>
	      		</select>
			</div>
	      	<span id="deptErrorSpan" class="text-danger"></span>
		</div>
		<div class="row m-2">
			<div class="col-2">
				<label class="form-label">등록할 학생 수: </label>
				<input class="form-control" type="number" name="addCnt" />
				<span id="addErrorSpan" class="text-danger"></span>
			</div>
		</div>		
		<div class="col-12">
      		<input id="addFormBtn" class="btn btn-primary" type="button" value="추가" />		
		</div>
		<hr>
	    <div id="displayDiv" class="col-12" style="display: none">
	    	<div>
	    		<input id="autoInput" type="button" class="" value="자동완성">
	    	</div>
    	  <div>
    	  	<table class="table table-bordered mb-0 formThead">
    	  	  <colgroup>
	             <col width="6%"/>
	             <col width="9%"/>
	             <col width="5%"/>
	             <col width="10%"/>
	             <col width="11%"/>
	             <col width="11%"/>
	             <col width="11%"/>
	             <col width="11%"/>
	             <col width="11%"/>
	             <col width="5%"/>
              </colgroup>
	          <thead>
	            <tr>
	              <th>신/편입생</th>
	              <th>이름</th>
	              <th>성별</th>
	              <th>주민등록번호</th>
	              <th>전화번호</th>
	              <th>우편번호</th>
	              <th>주소</th>
	              <th>상세주소</th>
	              <th>이메일</th>
	              <th>프로필사진</th>
	            </tr>
	          </thead>
    	  	</table>
    	  </div>
	      <div id="tableDiv" class="overflow-scroll">
	        <table id="insertTable" class="table table-bordered">
	          <tbody id="insertFormArea"></tbody>
	        </table>
	      </div>
	      <input class="btn btn-primary mt-2" type="submit" id="insertFormBtn" value="등록하기" />
	    </div>
	    		
	</form>
	<div class="text-end">
		<a class="btn btn-outline-info" href="${cPath}/group/students">목록</a>
	</div>
</div>


<!-- 폼 끝 -->
 
<script src="${cPath }/resources/js/student/studentForm.js"></script>


