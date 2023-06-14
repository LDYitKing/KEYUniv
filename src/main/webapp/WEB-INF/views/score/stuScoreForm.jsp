<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal.realUser" var="authMember" />
<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">성적관리</li>
	</ol>
</nav>
<div class="space m-3 p-5">
	<h2 class="mb-4">
		<ion-icon name="stop-outline"></ion-icon>
		성적 관리
	</h2>
	<div class="lineChart">
		<canvas id="chart" width="100%" height="20%" ></canvas> 
	</div>
	<br>
	<br>
	<h5>
	    <ion-icon name="chevron-forward-outline"></ion-icon>
	    ${authMember.memName }의 필수 이수 학점 : 
	    <span style="color: red;">전공 90학점, 교양 50학점, 자유이수 0학점, 총 140학점</span>
	</h5>
	<table class="table table-borderd text-center">
		<thead>
			<tr>
				<th>영역</th>
				<th>전공</th>
				<th>교양</th>
				<th>총학점</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>취득학점</td>
				<td>32</td>
				<td>18</td>
				<td>50</td>
			</tr>
			<tr>
				<td>필요학점</td>
				<td>58</td>
				<td>32</td>
				<td>90</td>
			</tr>
		</tbody>
	</table>
	<hr>
	<br>
	<br>
	<h5>
	    <ion-icon name="chevron-forward-outline"></ion-icon>
		년도 / 학기별 취득학점 현황
	</h5>
	<table class="table table-borderd text-center">
		<thead>
			<tr>
				<th>학년도</th>
				<th>학기</th>
				<th>신청학점</th>
				<th>전공</th>
				<th>교양</th>
				<th>총 취득학점</th>
				<th>최종 평점</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>2022</td>
				<td>1</td>
				<td>18</td>
				<td>9</td>
				<td>9</td>
				<td>18</td>
				<td>3.0</td>
			</tr>
			<tr>
				<td>2022</td>
				<td>2</td>
				<td>21</td>
				<td>12</td>
				<td>9</td>
				<td>21</td>
				<td>2.5</td>
			</tr>
			<tr>
				<td>2023</td>
				<td>1</td>
				<td>11</td>
				<td>11</td>
				<td>0</td>
				<td>11</td>
				<td>4.0</td>
			</tr>
		</tbody>
	</table>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<script>
const lineChart = new Chart(
		  document.getElementById("chart"),
		  {
		    type: "line",
		    data: {
		      labels: ["1학년 1학기", "1학년 2학기", "2학년 1학기"],
		      datasets: [
		        {
		          label: '학기평점',
		          data: [3.0, 2.5, 4.0],
		          fill: false,
		          borderColor: 'rgb(75, 192, 192)',
		          tension: 0.1
		        }
		      ]
		    },
		    options: {
		      scales: {
		        y: {
		          min: 0,
		          max: 4.5,
		          ticks: {
		            stepSize: 0.5,
		            callback: function(value, index, values) {
		              return value.toFixed(1);
		            }
		          }
		        }
		      }
		    }
		  }
		);
</script>
















