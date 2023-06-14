<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<style>
.table th {
    width: 150px;
}
</style>

<script src="${cPath }/resources/js/ckeditor/ckeditor.js"></script>
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/facility/facilityList.do">편의시설목록</a></li>
		<li class="breadcrumb-item active" aria-current="page">편의시설 등록</li>
	</ol>
</nav>
<div class="space m-3 p-5">
<form:form modelAttribute="facility" method="post" enctype="multipart/form-data" >
	<table class="table table-boardered">
		<tr>
			<th>편의시설명</th>
			<td>
				<form:input path="faciName"  maxlength="200" class="form-control" />
				<form:errors path="faciName" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>주의사항</th>
			<td>
				<form:textarea path="faciCaution" class="form-control" />
				<form:errors path="faciCaution" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>편의시설이미지</th>
			<td>
				<input type="file" name="facilityFiles" />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: right">
				<input type="submit" class="btn btn-success" value="등록" />
				<input type="reset" class="btn btn-danger" value="초기화" />
			</td>
		</tr>
	</table>
</form:form>
</div>


