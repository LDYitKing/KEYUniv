<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<div class="space m-3 p-5" > 
<table class="table table-boardered">
    <tr>
        <th>제목</th>
        <td>${univboard.ubTitle}</td>
    </tr>

    <tr>
        <th>작성자</th>
        <td>${univboard.ubWriter}</td>
    </tr>

    <tr>
        <th>태그</th>
        <td>${univboard.ubTag}</td>
    </tr>

    <tr>
        <th>작성일</th>
        <td>${univboard.ubWdate}</td>
    </tr>

    <tr>
        <th>조회수</th>
        <td>${univboard.ubCnt}</td>
    </tr>

    <tr>
        <th>첨부파일</th>
        <td>
			<c:forEach items="${univboard.atchFileGroup.atchfileList }" var="attatch" varStatus="vs">
				<c:url value="/univboard/attatch/download.do" var="downloadURL">
					<c:param name="atchId" value="${attatch.atchId }" />
					<c:param name="atchSeq" value="${attatch.atchSeq }"/>
				</c:url>
				<a href="${downloadURL }">${attatch.atchOrginName}</a>
				
				<c:if test="${not vs.last }">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:forEach>
		</td>
    </tr>
    
	<tr>
		<th>내용</th>
		<td>${univboard.ubContent}</td>
	</tr>

	<tr>
		<td colspan="2">
			<c:url value="/univBoard/univBoardUpdate.do" var="updateURL">
				<c:param name="what" value="${univboard.ubNo }"/>
			</c:url>
		</td>
	</tr>
</table>
	<form:form modelAttribute="univboard" action="${cPath}/univBoard/univBoardDelete.do" method="post">
		<form:hidden path="ubNo"/>
		<security:authorize access="hasRole('EMP')">
		<a class="btn btn-primary" href="${updateURL}">수정</a>
		</security:authorize>
		<security:authorize access="hasRole('EMP')">
		<input class="btn btn-danger" type="submit" value="삭제"/>
		</security:authorize>
		<a class="btn btn-info" href="${cPath }/univBoard/univBoardList.do" >목록으로</a>
		<a class="btn btn-secondary" href="javascript:history.back()">뒤로가기</a>
	</form:form>
</div>

<%-- <script src="${cPath }/resources/js/board/univBoardView.js"></script> --%>