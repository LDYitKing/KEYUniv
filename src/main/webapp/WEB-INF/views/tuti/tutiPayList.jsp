<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>
<div class="space m-3 p-5">
	<table class="table table-bordered">
		<div class="row m-2"></div>
		<thead class="table-primary">
			<tr>
				<td>번호</td>
				<td>학번</td>
				<td>학과</td>
				<td>이름</td>
				<td>학기</td>
				<td>납부 상태</td>

			</tr>
		</thead>
		<tbody id="listBody" data-view-url="${cPath}/tuti/tutiPayView.do">
		</tbody>
		<tfoot>
			<tr>
				<td colspan="8">
					<div class="pagingArea d-flex justify-content-center">
						<div class="col-auto">
							<input type="button" value="검색" id="searchBtn"
								class="btn btn-primary" />
							<security:authorize access="hasRole('EMP')">
								<a href="${cPath}/tuti/tutiPayInsert.do"
									class="btn btn-secondary"><spring:message code="regist" /></a>
							</security:authorize>
						</div>
					</div>
		</tfoot>
	</table>
</div>
<div style="border: 1px solid green;">
	<form name="searchForm" method="post">
		<security:csrfInput />
		<input type="hidden" name="colNo" placeholder="searchWord" /> <input
			type="hidden" name="deptNo" placeholder="searchWord" />
	</form>
</div>

<script src="${cPath}/resources/js/tuti/tutiPayList.js"></script>