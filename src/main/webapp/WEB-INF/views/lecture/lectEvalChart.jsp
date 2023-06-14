<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.gridDIV{
	display: grid;
	grid-template-columns: 1fr 1fr;
}
.no{
	margin-left: 10px;
	width: 102.5%;
}
.gridDESC{
	display: grid;
	grid-template-columns: 2fr 3fr;
}
.chart-view{
	text-align:center;
}
.marginSpace{
	margin-right: 30px;
}
</style>
<nav aria-label="breadcrumb" class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/lecture/lectureHome.do?what=${what}">강의관리</a></li>
		<li class="breadcrumb-item active" aria-current="page">평가관리</li>
	</ol>
</nav>

<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">${lectName}</h1>
	</div>
	<security:authorize access="hasRole('PRO')">
	  <div class="marginSpace">
	    <div class="btn-group bigfont">
	      <a id="attend" href="${cPath}/attendance/attendance.do?what=${what}" class="btn btn-info">출석</a>
	      <a href="${cPath}/lecture/lectProEval.do?what=${what}" class="btn btn-info">평가</a>
	      <a id="proAsgn" href="${cPath}/asgn/proAsgn.do?what=${what}" class="btn btn-info">과제</a>
	      <a id="exam" href="${cPath}/exam/exam.do?what=${what}" class="btn btn-info">시험</a>
	      <a id="score" href="${cPath}/score/proScore.do?what=${what}" class="btn btn-info">성적</a>
	      <a id="lecutreData" href="${cPath}/lecture?what=${what}" class="btn btn-info">자료실</a> 
	    </div>
	  </div>
	</security:authorize>
</div>

<div class="no bigfont">
	<div class="space m-2 p-3 gridDESC">
		<div class="p-5">
		<h4 class="mb-4 fs-2">
			<ion-icon name="stop-outline" role="img" class="md hydrated">
			</ion-icon> 강의평가 안내
		</h4>
			<p>&emsp; 1. 교수님의 강의에 대한 평가 내용 입니다.</p>
			<p>&emsp; 2. 각 영역에 대해 교수님의 강의의 강점을 표시하고 있습니다.</p>
			<p>&emsp; 3. 평가 내용을 반영하여 양질의 교육을 제공하여 주시기 바랍니다.</p>
			<p>&emsp; 4. 다음은 각 평가 항목의 평가 내용입니다.</p>
		</div>
		<div class="p-5">
			<br><br><br>
			<p>&emsp;&emsp; - 전문 지식 습득 : 전공 분야에서 필요한 기본 지식과 전문적인 지식을 습득할 수 있다.</p>
			<p>&emsp;&emsp; - 사고력과 문제 해결 능력 향상 : 강의를 통해 독립적인 사고력과 문제 해결 능력을 향상시킬 수 있다.</p>
			<p>&emsp;&emsp; - 창의성과 혁신력 강화 : 새로운 아이디어를 도출하고 창의성과 혁신력을 향상 시킬 수 있다.</p>
			<p>&emsp;&emsp; - 비판적 사고 능력 강화 : 강의를 통해 비판적 사고 능력을 강화할 수 있다.</p>
			<p>&emsp;&emsp; - 커뮤니케이션 능력 향상 : 강의를 통해 적극적으로 의사소통을 할 수 있는 능력을 향상시킬 수 있다.</p>
			<p>&emsp;&emsp; - 취업과 진로 지원 : 강의를 통해 취업과 진로에 필요한 능력과 정보를 습득할 수 있다.</p>
		</div>
	</div>
</div>
<div class="gridDIV bigfont">
	<div class="space m-3 p-5 chartDIV">
		<div data-v-6a145b43 class="chart-view">
			<canvas id="_dm-radarChart" width="550" height="550" style="display: inline-block; box-sizing: border-box; height: 600px; width: 600px;"></canvas>
		</div>
	</div>
	<div class="space m-3 p-5">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>
						자유평가내용
					</th>
				</tr>		
			</thead>
			<tbody>
				<c:forEach items="${leAnswerList }" var="leAnswer">
					<tr>
						<td>${leAnswer}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<script>

let labels = [];
let radarDatas = [];
console.log(${lectEvalAVG.size()});
if(${lectEvalAVG.size()>0}){
	labels.push(`${lectEvalAVG.get(0).leaQue}`);
	labels.push(`${lectEvalAVG.get(1).leaQue}`);
	labels.push(`${lectEvalAVG.get(2).leaQue}`);
	labels.push(`${lectEvalAVG.get(3).leaQue}`);
	labels.push(`${lectEvalAVG.get(4).leaQue}`);
	labels.push(`${lectEvalAVG.get(5).leaQue}`);
	radarDatas.push(`${lectEvalAVG.get(0).avgAnswer}`);
	radarDatas.push(`${lectEvalAVG.get(1).avgAnswer}`);
	radarDatas.push(`${lectEvalAVG.get(2).avgAnswer}`);
	radarDatas.push(`${lectEvalAVG.get(3).avgAnswer}`);
	radarDatas.push(`${lectEvalAVG.get(4).avgAnswer}`);
	radarDatas.push(`${lectEvalAVG.get(5).avgAnswer}`);


//----------------------------------------------
// const radarData =[4.3,2,2,2,1,1];
// let radarData =[lectEvalAVG[0].avgAnswer,lectEvalAVG[1].avgAnswer,lectEvalAVG[2].avgAnswer,lectEvalAVG[3].avgAnswer,lectEvalAVG[4].avgAnswer,lectEvalAVG[5].avgAnswer];
	const doughnutChart = new Chart(
		document.getElementById("_dm-radarChart"),{
			type: 'radar',
			data: {
				labels: labels,
				datasets: [{
					label: '강의 평가 평균',
					data: radarDatas,
					borderColor: "rgba(247, 129, 159,1)",
					backgroundColor: "rgba(247, 129, 159,.5)"
				}]
			},
			options: {
				responsive: false,
				scale: {
			        beginAtZero: true,
			        max: 5,
			        min: 0, 
			        stepSize: 1,
			      },
				plugins: {
					title: {
						display: true,
						text: '강의평가'
					}
				}
			}
			
		}
	);
//차트 끝!
}
</script>