<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/facility/facilityList.do">편의시설목록</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/facility/facilityView.do?what=${facility.faciNo}">편의시설 상세보기</a></li>
		<li class="breadcrumb-item active" aria-current="page">편의시설 수정</li>
	</ol>
</nav>
<div class="space m-3 p-5">
<form:form id="editForm" modelAttribute="facility" method="post" enctype="multipart/form-data">
	<form:hidden path="faciNo"/>
	<table class="table table-boardered">
		<tr>
			<th>시설명</th>
			<td>
				<form:input path="faciName"   class="form-control" />
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
			<th>기존첨부파일</th>
			<td>
				<c:forEach items="${facility.atchFileGroup.atchfileList }" var="attatch" varStatus="vs">
					<span>
						${attatch.atchOrginName }<span class="btn btn-danger delFileBtn" data-atch-seq="${attatch.atchSeq }">삭제</span>
						<c:if test="${not vs.last }">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>
					</span>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name="addFiles" />
			</td>
		</tr>

		<tr>
			<td colspan="2" style="text-align: right">
				<input type="submit" class="btn btn-success" value="저장" />
				<input type="reset" class="btn btn-danger" value="초기화" />
			</td>
		</tr>
	</table>
</form:form>
</div>
<script>
	let editForm = $("#editForm");
	$(".delFileBtn").on("click", function(event){
		let atchSeq = $(this).data("atchSeq");
		$(this).parent("span").hide();
		let newInput = $("<input>").attr("name", "delFileGroup.delSeqs").val(atchSeq);
		editForm.append(newInput);
	});
</script>