<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

   <div class="space m-3 p-5">
   <h1>연구</h1>
   </div>
   <div class="space m-3 p-5" id="changeStudyDiv">
  </div>
  <div class="space m-3 p-5" id="studyFormDiv" style="display:none;">
  <form:form id="studyForm" modelAttribute="studyVO" method="post" enctype="multipart/form-data" > 
  	<table>

		<tr>
			<th>교수아이디</th>
			<td><form:input type="text" path="proNo" required="required"
					maxlength="20" class="form-control" />
				<form:errors path="proNo" element="span" class="text-danger" /></td>
		</tr>
		<tr>
			<th>연구명</th>
			<td><form:input type="text" path="studyName" required="required"
					maxlength="200" class="form-control" />
				<form:errors path="studyName" element="span" class="text-danger" /></td>
		</tr>
		<tr>
			<th>주제</th>
			<td><form:input type="text" path="studySubject" maxlength="4000"
					class="form-control" />
				<form:errors path="studySubject" element="span" class="text-danger" /></td>
		</tr>
		<tr>
			<th>목표</th>
			<td><form:input type="text" path="studyPurpose" maxlength="4000"
					class="form-control" />
				<form:errors path="studyPurpose" element="span" class="text-danger" /></td>
		</tr>
		<tr>
			<th>연구자료</th>
			<td>
				<input type="file" name="stuFiles"/>
				<input type="file" name="stuFiles"/>
				<input type="file" name="stuFiles"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="등록" class="btn btn-success" />
				<input type="reset" value="취소" class="btn btn-danger" /> 
				<button onclick="initAG()" class="btn btn-outline-primary" >목록으로</button>
			</td>
		</tr>
		
		
	</table>
  </form:form>
  </div>
  
   <!-- ~~~~~~~~~~~~~~~~~~UPDATE~~~~~~~~~~~~~~~~~~~~~~ -->
  <div class="space m-3 p-5" id="studyEditDiv" style="display:none;">
  <form:form id="editForm" modelAttribute="studyVO" method="put" enctype="multipart/form-data" > 
  <form:hidden path="studyNo" id="hiddenStudyNo"/>
  	<table>

		<tr>
			<th>연구명</th>
			<td><form:input type="text" path="studyName" required="required"
					maxlength="200" class="form-control" id="studyName"/>
				<form:errors path="studyName" element="span" class="text-danger" /></td>
		</tr>
		<tr>
			<th>주제</th>
			<td><form:input type="text" path="studySubject" maxlength="4000"
					class="form-control" id="studySubject"/>
				<form:errors path="studySubject" element="span" class="text-danger" /></td>
		</tr>
		<tr>
			<th>목표</th>
			<td><form:input type="text" path="studyPurpose" maxlength="4000"
					class="form-control" id="studyPurpose"/>
				<form:errors path="studyPurpose" element="span" class="text-danger" /></td>
		</tr>
		<tr>
			<th>연구자료</th>
			<td>
				<c:set var="atchFileList" value="${study.atchFileGroup.atchfileList}" />
				<c:if test="${not empty atchFileList }">
				<c:forEach items="${atchFileList }" var="atchFile" varStatus="vs">
				<span>
												                                       <!-- 데이터 함수 생성 -->
							${atchFile.atchOrginName }<span class="btn btn-danger delFileBtn" data-atch-seq="${atchFile.atchSeq }">삭제</span> 
							
							<c:if test="${not vs.last }">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${vs.last }">
							<input type="file" name="addFiles"/>
							</c:if>
				</span>
				</c:forEach>
				</c:if>
				<c:if test="${empty atchFileList }">
					<input type="file" name="addFiles"/> <!-- atchFileList 가 세터 때문에 완전 비워짐 -->
					<input type="file" name="addFiles"/>
					<input type="file" name="addFiles"/>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="수정" class="btn btn-success" />
				<input type="reset" value="취소" class="btn btn-danger" /> 
				<button onclick="initAG()" class="btn btn-outline-primary" >목록으로</button>
			</td>
		</tr>
		
		
	</table>
  </form:form>
  </div>
   <script>
	let editForm = $("#editForm");
	$(".delFileBtn").on("click", function(event) {
		let atchSeq = $(this).data("atchSeq");
		$(this).parent("span").hide();
		//새 인풋태그를 만듬
		//인풋태그의 네임은 항상 VO의 프로퍼티명과 같아야한다.
		//뒤에서 안만들어놔도 핸들러 어뎁터는 이걸 보고 delFileGroup.delSeqs 형태로 넣어달라는걸 안다.
		let newInput = $("<input>").attr("name", "delFileGroup.delSeqs").val(atchSeq);
		editForm.append(newInput);
	})

	</script>
 
  
  <input type="hidden" id="cPath" value="${cPath}" />
  <input type="hidden" id="studyE" />
  <script src="${cPath }/resources/js/professor/professorStudyList.js"></script>
