<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h4>샘플</h4>
<table class="table table-striped">
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list }" var="sam">
		<tr>
			<td>${sam.sampleId }</td>
			<td>${sam.sampleName }</td>
		</tr>
	</c:forEach>
		<tr>
			<td><button class="btn btn-lg btn-primary sidebar-toggler">Toggle Sidebar</button></td>
		</tr>
	</tbody>
</table>
