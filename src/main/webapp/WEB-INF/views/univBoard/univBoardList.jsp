<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>

<div class="space m-3 p-5" > 
<table class="table table-bordered">
	<thead class="table-primary">
		<tr>
			<th><spring:message code="univboard.ubNo" /></th>
			<th><spring:message code="univboard.ubTitle"/></th>
			<th><spring:message code="univboard.ubWriter"/></th>
			<th><spring:message code="univboard.ubWdate"/></th>
			<th><spring:message code="univboard.ubCnt"/></th>
		</tr>
	</thead>
	<!-- js에서 cPath 못쓰니까 여기서 데이터함수를 써서 가져간다. 그래서 listBody.data("viewUrl") 하면 JS에서도 사용할 수 있다. -->
	<tbody id="listBody" data-view-url="${cPath}/univBoard/univBoardView.do">
	
	
	<tfoot>
		<tr>
			<td colspan="8">
			<div class="pagingArea d-flex justify-content-center">
			
			</div>
			<div id="searchUI" class="row d-flex justify-content-center">
					<div class="col-auto">	
						<select name="searchType" class="form-control">
							<option value><spring:message code="all" /></option>
							<option value="writer"><spring:message code="univboard.ubWriter"/></option>
							<option value="content"><spring:message code="univboard.ubContent"/></option>
						</select>
					</div>
					<div class="col-auto">	
						<input type="text" name="searchWord"  class="form-control col-auto" />
					</div>
					<div class="col-auto">	
						<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
						<security:authorize access="hasRole('EMP')">
						<a href="${cPath }/univBoard/univBoardInsert.do" class="btn btn-secondary" ><spring:message code="regist" /></a>
						</security:authorize>
					</div>

				</div>
			</td>
		</tr>
	</tfoot>
</table>
</div>
<div style="border: 1px solid green;">
<!-- 	<h4>검색 조건 전송을 위한 Hidden Form</h4> -->
	<form name="searchForm" method="post">
	<security:csrfInput/>
	<input type="hidden" name="page" placeholder="page"/>
	<input type="hidden" name="searchType" placeholder="searchType"/>
	<input type="hidden" name="searchWord" placeholder="searchWord"/>
	</form>
</div>

<script src="${cPath }/resources/js/univboard/UnivBoardList.js"></script>
	