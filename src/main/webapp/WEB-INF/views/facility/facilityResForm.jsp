<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
table{
    border: 2px solid #d2d2d2;
    border-collapse: collapse;
    font-size: 0.9em;
}
th, td{
    border: 1px solid #d2d2d2;
    border-collapse: collapse;
}
th{
	width: 75px;
    height: 5px;
}
td {
    width: 75px;
    height: 60px;
}
select {
  width : 100px;
  height : 100px;
}
</style>
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/facility/facilityList.do">편의시설목록</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/facility/facilityView.do?what=${facility.faciNo}">편의시설 상세보기</a></li>
		<li class="breadcrumb-item active" aria-current="page">편의시설예약</li>
	</ol>
</nav>
<div style="display: grid; grid-template-columns: 1fr 1fr;" >
<div class="space m-3 p-5">
<form:form modelAttribute="facilityRes" method="post">
	<table class="table table-boardered">
		<security:authentication property="principal.realUser" var="authMember"/>
		<tr>
			<th>편의시설명</th>
			<td>${facility.faciName}</td>
		</tr>
		<tr>
			<th>편의시설코드</th>
			<td>
				<form:input path="faciNo" class="form-control" value="${facility.faciNo}" readonly="true" />
				<form:errors path="faciNo" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>예약자(학번사번)</th>
			<td>
				<form:input path="memNo" class="form-control" value="${authMember.memNo }" readonly="true" />
				<form:errors path="memNo" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>예약가능시간</th>
			<td>
				<form:select path="ftNoList" multiple="multiple" size="5" >
		            <c:forEach items="${facilityTime}" var="facilityTimee">
		                <form:option value="${facilityTimee.ftNo}">${facilityTimee.ftDay}${facilityTimee.ftPeriod}</form:option>
		            </c:forEach>
	       		</form:select>
			</td>
		</tr>
		<tr>
			<th>사용인원</th>
			<td>
				<form:input path="frNop" class="form-control" />
				<form:errors path="frNop" element="span" class="text-danger" />
			</td>
		</tr>
		<tr>
			<th>이용목적</th>
			<td>
				<form:textarea path="frPurpose" class="form-control" />
				<form:errors path="frPurpose" element="span" class="text-danger" />
			</td>
		</tr>

		<tr>
			<td colspan="2" style="text-align: right">
				<input type="submit" class="btn btn-success" value="예약" />
				<input type="reset" class="btn btn-danger" value="초기화" />
			</td>
		</tr>
	</table>
</form:form>
</div>
<div class="space m-3 p-5">
    <table width="800" height="600" style="color: #121212">
    <h3>▶ 예약시간표 ◀</h3>
    <div style="text-align: right" >
	    <span class="h4">
		    <ion-icon name="square" style="color: gray;"></ion-icon> : 예약완료
		    <ion-icon name="square-outline"></ion-icon> : 예약가능
		    <ion-icon name="square" style="color: red;"></ion-icon> : 예약불가
	    </span>
    </div>  
      <tr width=19%>
        <th></th>
        <th>월</th>
        <th>화</th>
        <th>수</th>
        <th>목</th>
        <th>금</th>
        <th>토</th>
        <th>일</th>
      </tr>
      <c:forEach var="i" begin="1" end="13">
        <tr>
          <th>${i}</th>
         <c:forEach step="100" var="j" begin="100" end="700">
            <td id="facility${i+j}"></td>
         </c:forEach>
        </tr>
      </c:forEach>
    </table>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        // 받은 id목록
        var ftNoList = ${ftNoList};

        ftNoList.forEach(function(id) {
            var cell = document.getElementById("facility" + id);
            if (cell) {
                cell.style.backgroundColor = '#A9A9A9'; // 색상 변경     
            }
        });
    });
</script>

</div>