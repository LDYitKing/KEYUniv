<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>
<style>
 .marginSpace{
	margin-right: 66px;
} 

</style>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">장학금 관리</li>
	</ol>	
</nav>
<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">장학금</h1>
	</div>
	
	<security:authorize access="hasRole('EMP')">
	    <div class="marginSpace">
	      <div class="btn-group">
	        <a href="${cPath}/sch/schList.do" class="btn btn-info">장학금 관리</a>
	        <a href="${cPath}/sch/schRecList.do" class="btn btn-info">장학생관리</a>
	      </div>
	    </div>
	</security:authorize>
</div>	
<div class="space m-3 p-3">
<h3>장학금 목록 LIST</h3>

<div class="space m-3 p-3">
	<div id="notice-card" class="card-body mb-4">
	<h3 class="card-title mt-2">장학금 안내</h3><br>
		<p class="d-inline-block h5 btn-link text-truncate mb-2">장학금 목록</p></br>
		<div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 8px;" >
	<div>
	<table class ="table table-bordered">
	<tr>
		<h5><li>입학 성적우수장학금</li></h5>
		<pre> 1) 입학 성적이 전체 수석․차석, 학과별 수석․차석인 자</pre><br>
		
		<h5><li>성적우수 장학금</li></h5>
		<pre> 1) 품행이 단정하고 직전학기 성적이 우수한 자 </pre><br>
		
		<h5><li>보훈 장학금</li></h5>
		<pre> 1) 보훈관계법령에 의한 보훈대상자 본인, 배우자 및 그 자녀에 한한다. </pre><br>
		
		<h5><li>생활보조장학금</li></h5>
		<pre> 1) 가정형편이 곤란한 학생(소년소녀가장, 기초수급대상자)</pre>
		<pre> 2) 사회복지시설 생활자 및 장애우(1-4급 본인 및 직계존비속)</pre>
		<pre> 3) 산업재해 직계가족</pre><br>
	</tr>
	</table>
	</div>
	
	<table class ="table table-bordered">
	<div>
		<h5><li>기타 입학전형에 규정된 내용은 학생생활운영위원회의 심의․의결을 거쳐 정한다.</li></h5>
		<pre> 1) 교외 장학단체에서 해당 장학생을 지정하지 않은 경우에는 교외 장학생수의 학과별 비율을 고려 
	입시학생처장의 추천을 받아 학생생활 운영위원회의 심의를 거쳐 총장이추천한다.</pre>
		<pre> 2) 교외 장학단체에서 해당 장학생을 지정하지 않은 경우에는 교외 장학생수의 학과별 비율을 고려
	입시학생처장의 추천을 받아 학생생활 운영위원회의 심의를 거쳐 총장이 추천한다.</pre><br>
		
		<h5><li>국가장학금(I, II 유형)</li></h5>
		<pre> 1) 국가장학금I유형 : 신입생, 재학생 직전학기 성적 80점 이상인 자</pre>
		<pre> 2) 국가장학금II유형 : 대학자체기준 수립 신입생은 지원불가, 재학생은 지원가능</pre>
		<pre> 3) 국가근로장학금 : 가계곤란자로 국가근로 장학생 선발 기준에 해당하는 자</pre><br>
		
		<h5><li>기타 사항</li></h5>
		<pre> 1) 문의 사항은 학과 사무실로 연락바랍니다. </pre>
		<pre> 2) 성적기반 장학금은 차후 학기 등록금에 반영됩니다. </pre>
	</div>
	</table>
	</div>
</div>


<table class ="table table-bordered">
	<thead class ="table-primary">
		<tr>
			<td><spring:message code="schNo" /></td>
			<td><spring:message code="schName" /></td>
			<td>작성자</td>
		</tr>
	</thead>
	<tbody id="listBody" data-view-url="${cPath}/sch/schView.do">
	
	<tfoot>
		<tr>
			<td colspan="8">
			<div class ="pagingArea d-flex justify-content-center" >
			</div>
			
			<div id="searchUI" class="row d-flex justify-content-center">
				<div class="col-auto">
					<select name="searchType" class="form-control">
						<option value><spring:message code="all"/></option>
						<option value="sname"><spring:message code="schName"/></option>
						<option value="content"><spring:message code="schCont"/></option>
						<option value="request"><spring:message code="schReq"/></option>
					</select>
				</div>

				<div class="col-auto">
					<input type="text" name="searchWord" class="form-control col-auto" />
				</div>
				<div class="col-auto">
					<input type="button" value="검색" id="searchBtn" class="btn btn-primary" /> 
					<security:authorize access="hasRole('EMP')">
					<a href="${cPath}/sch/schInsert.do" class="btn btn-secondary"><spring:message code="regist" /></a> 
					</security:authorize>
				</div>
			</div>
	</tbody>
</table>
</div>
<div style="border: 1px solid green;">
	<form name ="searchForm" method="post">
	<security:csrfInput/>
	<input type="hidden" name="page" placeholder="page" />
	<input type="hidden" name="searchType" placeholder="searchType" />
	<input type="hidden" name="searchWord" placeholder="searchWord" />
	</form>
</div>

<script src="${cPath}/resources/js/sch/SchList.js"></script>