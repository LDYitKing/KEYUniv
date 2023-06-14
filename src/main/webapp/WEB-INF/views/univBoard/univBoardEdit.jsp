<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form:form id="editForm" modelAttribute="univboard" method="post" enctype="multipart/form-data">
    <form:hidden path="ubNo"/>
    <div class="space m-3 p-5" > 
    <table class="table table-boardered">
        <tr>
            <th><spring:message code="univboard.ubTitle"/></th>
            <td>
                <form:input path="ubTitle" maxlength="200" class="form-control" />
                <form:errors path="ubTitle" element="span" class="text-danger" />
            </td>
        </tr>

        <tr>
            <th><spring:message code="univboard.ubWriter"/></th>
            <td>
                <form:input path="ubWriter" maxlength="80" class="form-control"/>
                <form:errors path="ubWriter" element="span" class="text-danger" />
            </td>
        </tr>

        <tr>
            <th><spring:message code="univboard.ubTag"/></th>
            <td>
                <form:input path="ubTag" maxlength="80" class="form-control"/>
                <form:errors path="ubTag" element="span" class="text-danger" />
            </td>
        </tr>

        <tr>
            <th><spring:message code="univboard.ubContent"/></th>
            <td>
                <form:input path="ubContent" maxlength="80" class="form-control"/>
                <form:errors path="ubContent" element="span" class="text-danger" />
            </td>
        </tr>
        
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name="addFiles" />
				<input type="file" name="addFiles" />
				<input type="file" name="addFiles" />
			</td>
		</tr>
        
        <tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="<spring:message code='save'/>" />
				<input type="reset" class="btn btn-danger" value="<spring:message code='reset'/>" />
			</td>
		</tr>
        
        
    </table>
    </div>
</form:form>
<script>
	let editForm = $("#editForm");
	$(".delFileBtn").on("click", function(event){
		let atchSeq = $(this).data("atchSeq");
		$(this).parent("span").hide();
		let newInput = $("<input>").attr("name", "delFileGroup.delSeqs").val(atchSeq);
		editForm.append(newInput);
	});
</script>