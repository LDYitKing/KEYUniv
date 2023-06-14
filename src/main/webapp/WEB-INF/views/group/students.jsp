<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib
uri="http://www.springframework.org/security/tags" prefix="security"%> <%@taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="${cPath }/resources/css/student/studentList.css" type="text/css">

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">학생관리</li>
	</ol>
</nav>
<div class="space m-3 p-5">
<!-- <div class="card"> -->
<!-- 	<div class="card-header"> -->
<h4 class="card-header bg-primary text-white">학생관리</h4>
<div id="searchUI" class="row justify-content-between m-3">
  <div class="col-auto align-self-end">
    <label>총&nbsp;<span id="totalRecord" class="text-info"></span>건</label>&emsp;
    <select id="sel1" class="form-select" name="screenSize">
      <option value="10" selected="selected">10</option>
      <option value="30">30</option>
      <option value="100">100</option>
    </select>
    <label>개씩 보기</label>
  </div>
  <div class="col-auto">
    <div class="input-group flex-nowrap float-end">
      <select name="searchType" class="form-select rounded-0 input-group-a">
        <option value="">전체</option>
        <option value="name">성명</option>
        <option value="no">학번</option>
      </select>
      <input class="form-control-sm input-group-b" type="text" name="searchWord" />
      <button id="searchBtn" class="btn btn-primary rounded-0">
        검색
      </button>
    </div>
  </div>
    <div class="col-auto">
      <a class="btn btn-info" href="${cPath }/group/studentForm">등록</a>
    </div>
</div>
<!-- 	</div> -->
<!-- 	<div class="card-body"> -->
 <div class="float-start m-3">
   <button class="btn btn-icon btn-xs m-2" id="detailBtn">
	<ion-icon class="fs-1 md hydrated" width="16" height="16" name="options-outline" role="img" aria-label="options outline"></ion-icon>
	</button><br>
  </div>
  <div class="table-responsive mt-4">
    <table class="table table-hover">
      <thead>
        <tr>
          <th class="th1"><input id="cbxStuAll" type="checkbox" /></th>
          <th class="th2">학적</th>
          <th class="th3">성명</th>
          <th class="th4">학번</th>
          <th class="th5">학과(부)</th>
          <th class="th6">학년</th>
          <th class="th7">성별</th>
          <th class="th8">휴대폰번호</th>
          <th class="th9">이메일</th>
        </tr>
        <tr id="detailTr" style="display: none">
        <td></td>
        <td>
          <select name="stuState">
            <option value=""></option>
            <c:forEach items="${commList }" var="comm">
              <option value="${comm.commNo }">${comm.commName }</option>
            </c:forEach>
          </select>
        </td>
        <td></td>
        <td></td>
        <td>
          <select name="deptNo">
            <option value=""></option>
            <c:forEach items="${deptList }" var="dept">
              <option value="${dept.deptNo }">${dept.deptName }</option>
              <%-- <form:option value="${ }" label=""></form:option> --%>
            </c:forEach>
          </select>
        </td>
        <td>
        <select name="stuYear">
            <option value=""></option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
          </select>
        </td>
        <td>
          <select name="memGender">
            <option value=""></option>
            <option value="M">남</option>
            <option value="W">여</option>
          </select>
        </td>
        <td></td>
        <td></td>
      </tr>
    </thead>
    <tbody id="listBody"></tbody>
    <tfoot>
      <tr>
        <td colspan="2">
          <!-- <input type="submit"> -->
        </td>
      </tr>
    </tfoot>
  </table>
</div>
<nav id="pagingArea" class="text-align-center mt-5" aria-label="Table navigation"></nav>
<form name="searchForm" action="<c:url value='/group/students' />">
  <input type="hidden" name="page" />
  <input type="hidden" name="screenSize" />
  <input type="hidden" name="searchType" />
  <input type="hidden" name="searchWord" />

  <input type="hidden" name="deptNo" />
  <input type="hidden" name="stuYear" />
  <input type="hidden" name="memGender" />
  <input type="hidden" name="stuState" />
</form>
</div>
<!-- </div> -->

<script src="${cPath }/resources/js/student/studentList.js"></script>

