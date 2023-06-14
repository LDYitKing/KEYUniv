<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">편의시설목록</li>
	</ol>
</nav>
<div class="space m-3 p-5">
<div style="text-align: right">
	<a href="${cPath }/facility/facilityResPersonal.do" class="btn btn-info">개인 예약 현황</a>
</div>
<table class="table table-bordered">
	<thead class="table-primary">
		<tr>
			<th width="100px">게시글번호</th>
			<th>편의시설명</th>
			<th>주의사항</th>
		</tr>
	</thead>
	
	<tbody id="listBody" data-view-url="${cPath}/facility/facilityView.do">
	
	</tbody>
	<tfoot>
		<tr>
			<td colspan="3">
				<div class="pagingArea d-flex justify-content-center">
				
				</div>
				<div id="searchUI" class="row d-flex justify-content-center">
					<div class="col-auto">	
						<select name="searchType" class="form-control">
							<option value>전체</option>
							<option value="name">시설명</option>
						</select>
					</div>
					<div class="col-auto">	
						<input type="text" name="searchWord"  class="form-control col-auto" />
					</div>
					<div class="col-auto">	
						<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
						<security:authorize access="hasRole('EMP')">
							<a href="${cPath }/facility/facilityInsert.do" class="btn btn-secondary">신규등록</a>
						</security:authorize>
					</div>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
</div>
<form name="searchForm">
	<input type="hidden" name="page" placeholder="page"/>
	<input type="hidden" name="searchType" placeholder="searchType"/>
	<input type="hidden" name="searchWord" placeholder="searchWord"/>
</form>

<script src="${cPath }/resources/js/facility/facilityList.js"></script>