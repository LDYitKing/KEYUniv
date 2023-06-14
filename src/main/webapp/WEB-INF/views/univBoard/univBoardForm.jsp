<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>    
    
<script src="${cPath }/resources/js/ckeditor/ckeditor.js"></script>


<form:form modelAttribute="univboard" method="post" enctype="multipart/form-data">
	<div class="space m-3 p-5" > 
	<table class="table table-boardered">
		<tr>
			<th><spring:message code="univboard.ubTitle"/></th>
			<td>
				<form:input path="ubTitle" maxlength="200" class="form-control"/>
				<form:errors path="ubTitle" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th><spring:message code="univboard.ubWriter"/></th>
			<td>
				<form:input path="ubWriter" maxlength="80" class="form-control"/>
				<form:errors path="ubWriter" element="span" class="text-danger"/>
			</td>
		</tr>
		<tr>
			<th><spring:message code="univboard.ubTag" /></th>
			<td>
				<form:input path="ubTag" maxlength="80" class="form-control"/>
				<form:errors path="ubTag" element="span" class="text-danger"/>
			</td>
		</tr>
		<tr>
			<th><spring:message code="univboard.ubContent" /></th>
			<td>
				<form:textarea path="ubContent" class="form-control"/>
				<form:errors path="ubContent" element="span" class="text-danger"/>
			</td>
		</tr>
		
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name="ubFiles" />
				<input type="file" name="ubFiles" />
				<input type="file" name="ubFiles" />
			</td>
		</tr>
		
		<tr>
			<td colspan="3">
				<input type="submit" class="btn btn-success" value="<spring:message code='save'/>" />
				<input type="reset" class="btn btn-danger" value="<spring:message code='reset'/>" />
				<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
			</td>
		</tr>
	</table>
	</div>
	
</form:form>
<!-- <script> -->
// 	CKEDITOR.replace('ubContent', {
// 		filebrowserUploadUrl:"${cPath}/univboard/imageUpload.do?type=image"
// 	});
<!-- </script> -->
