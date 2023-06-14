<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${cPath }/resources/css/group/group.css" type="text/css">

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">교수/교직원 관리</li>
	</ol>
</nav>
<div class="space m-3 p-5">

<h4 class="card-header bg-primary text-white">교수/교직원 관리</h4>
<div id="groupCardBody" class="card-body">
	<div id="groupListDiv">
		<div id="groupListDiv">
			<h5 class="card-header mt-2">교수/교직원 조회</h5>
		</div>
		<div>
			<form id="searchForm">
				<div class="mt-2">
					<div class="m-2">
						<input class="form-check-input" type='radio' name='groupRadio' value='pro'><span class="fw-bold">&nbsp;&nbsp;교수&nbsp;&nbsp;</span>
						<input class="form-check-input"  type='radio' name='groupRadio' value='emp'><span class="fw-bold">&nbsp;&nbsp;교직원&nbsp;&nbsp;</span>
					</div>
					<div class="row m-2">
						<div class="pro col-12">
							<label class="form-label">소속 학과: </label>
					          <select name="deptNoSel" class="form-select">
					            <option value=""></option>
					            <c:forEach items="${deptList }" var="dept">
					              <option class="pro" value="${dept.deptNo }">${dept.deptName }</option>
					            </c:forEach>
					          </select>	
					    </div>
					    <div class="emp col-12">   				
							<label class="form-label">소속 부서: </label>
					          <select name="empDeptSel" class="form-select">
					            <option value=""></option>
								<option class="emp" value="행정과">행정과</option>
								<option class="emp" value="교무과">교무과</option>
								<option class="emp" value="인사과">인사과</option>
					          </select>					
						</div>
					</div>
					<div class="row justify-content-center m-2">
						<div class="col-5">
							<select name="searchType" class="form-select">
								<option selected value="memName">이름</option>
								<option value="memNo">사번</option>
							</select>
						</div>
						<div class="col-7">
							<input name="searchWord" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="m-2">
					<br><br>
					<button id="searchBtn" class="btn btn-primary" type="submit"><br><br>검색<br><br><br></button>
				</div>
			</form>
		</div>
		<hr>
		<div id="listTableDiv" class="overflow-scroll scrollable-content m-2">
			<table class="table table-hover" style="table-layout: fixed;">
			  <colgroup>
			    <col width="5%"/>
			    <col width="15%"/>
			    <col width="40%"/>
			    <col width="40%"/>
			  </colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="cbxMemAll"></th>
						<th>이름</th>
						<th>전화번호</th>
						<th>이메일</th>
					</tr>
				</thead>
				<tbody id="listArea">
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- group Form -->
	<div id="groupFormDiv" class="card-body overflow-scroll scrollable-content">
        <div>
          	<form id="groupForm" action="#">
             <table id="profileTb" class="table table-bordered">
               <tr>
                  <td colspan="4">
                  	<div id="profileImgDiv">
<%-- 						<img id="profileImg" src="${cPath}/resources/img/noImage.png" alt="moImage.png"> --%>
						<img id="profileImg" src="#" alt="">
                  	<input type="file" name="memPhotoFile">
                  </td>
               </tr>
               <tr>
                  <th>이름</th>
                  <td><input type="text" name="memName" class="inputContent"></td>
                  <th>이메일</th>
                  <td><input type="text" name="memEmail" class="inputContent"></td>
               </tr>
               <tr>
                  <th>사번</th>
                  <td><input type="text" name="memNo" class="inputContent" ></td>
                  <th>주민번호</th>
                  <td>
                  	<input type="text" name="memRrno1" disabled class="inputContent">-
                  	<input type="password" value="memRrno2" disabled class="inputContent">
                  	<input type="text" name="memGender" disabled class="inputContent">
                  </td>
               </tr>
               <tr>
                  <th>주소</th>
                  <td>
                  	<input type="text" name="memZip" class="inputContent" >
                  	<input type="text" name="memAdd1" class="inputContent" >
                  	<input type="text" name="memAdd2" class="inputContent" >
                  </td>
                  <th>전화번호</th>
                  <td><input type="text" name="memTel" class="inputContent"></td>
               </tr>
             </table>
        	<div class="d-flex justify-content-end">
           
           <input class="btn btn-primary" id="infoUpdateBtn" type="submit" value="저장">
        </div>
        
        <div id="proTableDiv" class="mt-4" style="display: none;">
	        <table class="table table-bordered" id="proTableTb">
	        	<tr>
	        		<th>소속단과대학/소속학과</th>
	        		<td colspan="3"><input type="text" name="colName" disabled class="inputContent"><input type="text" name="colNo" disabled class="inputContent"> / <input type="text" name="deptName" disabled class="inputContent"><input type="text" name="deptNo" disabled class="inputContent"></td>
	        	</tr>
	        	<tr>
	        		<th>입사일자</th>
	        		<td><input type="date" name="proEdate" disabled class="inputContent"></td>
	        		<th>퇴사일자</th>
	        		<td><input type="date" name="proRdate" class="inputContent"></td>
	        	</tr>
	        	<tr>
	        		<th>직위</th>
	        		<td><input type="text" name="proPos" class="inputContent"></td>
	        	</tr>
	        	<tr>
	        		<th>학력</th>
	        		<td colspan="3"><textarea class="proTa inputContent" name="proLoe" cols="" rows=""></textarea></td>
	        	</tr>
	        	<tr>
	        		<th>경력</th>
	        		<td colspan="3"><textarea class="proTa inputContent" name="proCareer" cols="" rows=""></textarea></td>
	        	</tr>
	        </table>
        </div>
        
        <div id="empTableDiv" style="display: none;">
	        <table class="table table-bordered" id="empTableTb">
	        	<tr>
	        		<th>소속부서</th>
	        		<td><input type="text" name="empDept" class="inputContent" ></td>
	        		<th>직위</th>
	        		<td><input type="text" name="empPos" class="inputContent" ></td>
	        	</tr>
	        	<tr>
	        		<th>입사일자</th>
	        		<td><input type="date" name="empEdate" disabled class="inputContent" ></td>
	        		<th>퇴사일자</th>
	        		<td><input type="date" name="empRdate" class="inputContent" ></td>
	        	</tr>
	        </table>
        </div>
        
        </form>
     </div>
             
     </div>		
	<!-- group Form End -->
	
</div>
</div>
<!-- </div> -->
<script src="${cPath }/resources/js/group/group.js"></script>
	