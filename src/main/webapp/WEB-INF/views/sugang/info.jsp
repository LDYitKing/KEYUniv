<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>	
<link rel="stylesheet" href="${cPath }/resources/css/sugang/sugang.css" type="text/css">
<security:authentication property="principal.realUser" var="authMember"/>	
<nav class="mb-3" aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page"><a href="${cPath}/sugang/info">수강신청</a></li>
	</ol>
</nav>
<div class="row mx-3 justify-content-between">
	<div class="btn-group col-3" role="group" aria-label="Default button group">
		<a href="${cPath }/sugang/basket" class="btn btn-info">사전수강신청</a>
		<a href="${cPath }/sugang/signup" class="btn btn-info">수강신청</a>
		<a href="${cPath }/sugang/list"  class="btn btn-info">수강신청 내역</a>
	</div>
	<div class="text-white col-4 align-self-center">
		<label class="text-danger">[2023학년도 1학기]</label>
		<label><span>${authMember.memName }</span> 님의 수강신청 가능 학점은 <span class="text-danger">20</span>학점 입니다.</label>
	</div>

</div>

<div class="space m-3 p-5">
	<div id="infoMainBody">
		<div id="infoDIv1" class="infoDiv">
			<div id="sugangInfo" class="m-4">
				<h4 class="mb-4">
					<ion-icon name="stop-outline"></ion-icon>
					수강 안내
				</h4>
				<div class="p-3 pt-4 infoContent rounded">
					<p>&emsp;1. 수강신청 대상 : 전체학생(휴학생 포함) - 2학기 졸업예정자는 1학기 등록자만 가능</p>
					<p>&emsp;2. 수강신청 및 변경 후 반드시 개인 수강내역을 확인하시어 불이익이 발생하지 않도록 주의하시기 바랍니다.</p>
					<p>&emsp;3. 장바구니 신청을 하지 못한 경우에도 선착순 수강신청, 수강신청변경기간에 수강신청할 수 있습니다.</p>
					<p>&emsp;4. 수강신청 실수 사례</p>
					<p>&emsp;&emsp;- 수강 미신청 후 수강신청으로 착각하여 계속 수업에 참석(성적취득 불가)</p>
					<p>&emsp;&emsp;- 수강신청, 변경, 취소기간 종료 후 처리 요청(처리불가)</p>
					<p>&emsp;5. 수강신청에 어려움이 있을 경우 반드시 소속 단과대학(학과)에 수강지도를 받으시기 바랍니다.</p>
					<p><span class="text-danger">&emsp;[매크로 사용 및 ID를 도용하는 경우 매크로 사용 및 ID도용자는 IP를 추적 등을 통해 학칙(규정)에 따라 처리될 수 있습니다.]</span></p>
				</div>
			</div>
			<div id="preSugangInfo" class="m-4">
				<br><h4 class="mb-4">
					<ion-icon name="stop-outline"></ion-icon>
					장바구니 신청 (사전 수강신청) 안내
				</h4>
				<div class="p-3 pt-4 infoContent rounded">
					<p>&emsp;<span class="fw-bold">수강신청하는 강의를 장바구니에 담아두면 정원 이내로 신청 시 자동 확정되는 제도입니다.</span></p>
					<p>&emsp;- 장바구니 신청 기간 : 듣고 싶은 강좌 장바구니에 넣기</p>
					<p>&emsp;&emsp;정원 이내 -> 수강확정</p>
					<p>&emsp;&emsp;정원 초과 -> 수강 미확정 - 장바구니 보류 강의</p>
					<p>&emsp;- 수강 신청 기간 : 장바구니에 담아 둔 강의를 <span class="fw-bold">선착순 수강신청</span></p>
				</div>
			</div>
			<div id="sugangTimeInfo" class="m-4">
				<br><h4>
					<ion-icon name="stop-outline"></ion-icon>
					수업 교시 기준
				</h4>
				<div id="sugangInfoTb">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>구분</th>
								<th>수업시간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1교시</td>
								<td>09:00~09:50</td>
							</tr>
							<tr>
								<td>2교시</td>
								<td>10:00~10:50</td>
							</tr>
							<tr>
								<td>3교시</td>
								<td>11:00~11:50</td>
							</tr>
							<tr>
								<td>4교시</td>
								<td>12:00~12:50</td>
							</tr>
							<tr>
								<td>5교시</td>
								<td>13:00~13:50</td>
							</tr>
							<tr>
								<td>6교시</td>
								<td>14:00~14:50</td>
							</tr>
							<tr>
								<td>7교시</td>
								<td>15:00~15:50</td>
							</tr>
							<tr>
								<td>8교시</td>
								<td>16:00~16:50</td>
							</tr>
							<tr>
								<td>9교시</td>
								<td>17:00~17:50</td>
							</tr>
							<tr>
								<td>10교시</td>
								<td>18:00~18:50</td>
							</tr>
							<tr>
								<td>11교시</td>
								<td>19:00~19:50</td>
							</tr>
							<tr>
								<td>12교시</td>
								<td>20:00~20:50</td>
							</tr>
							<tr>
								<td>13교시</td>
								<td>21:00~21:50</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

		</div>
		<div id="infoDIv2" class="infoDiv">
			<h4 class="mb-4">
				<ion-icon name="stop-outline"></ion-icon>
				수강신청 기간안내
			</h4>

			<div class="timeline">
				<div class="tl-entry">
					<div class="tl-time">
						<div class="tl-time">
							<p>장바구니 신청</p>
							<p>(사전 수강신청)</p>
						</div>
					</div>
					<div class="tl-point"></div>
					<div class="tl-content card bg-info text-white">
						<div class="card-body">
							<p>2023-05-16(화) ~ 2023-05-16(화)</p>
							<p>08 : 30 ~ 16 : 00</p>
							<p>전체 학생</p>
						</div>
					</div>
				</div>
				<div class="tl-entry">
					<div class="tl-time">
						<div class="tl-time">장바구니 확정</div>
					</div>
					<div class="tl-point"></div>
					<div class="card border-2 border-info">
						<div class="card-body">
							<p>2023-05-16(화)</p>
							<p>08 : 30 ~ 16 : 00</p>
							<p>전체 학생</p>
						</div>
					</div>
				</div>
				<div class="tl-entry active">
					<div class="tl-time">
						<div class="tl-time">수강신청</div>
					</div>
					<div class="tl-point"></div>
					<div class="tl-content card bg-info text-white">
						<div class="card-body">
							<p>2023-05-22(월) ~ 2023-05-25(목)</p>
							<p>08 : 30 ~ 18 : 00</p>
							<p>※ 반드시 학생이 기간 내 수강확정</p>
						</div>
					</div>
				</div>
				<div class="tl-entry">
					<div class="tl-time">
						<div class="tl-time">수강확정</div>
					</div>
					<div class="tl-point"></div>
					<div class="card border-2 border-info">
						<div class="card-body">
							<p>2023-05-25(목)</p>
							<p></p>
						</div>
					</div>
				</div>
				<div class="tl-entry">
					<div class="tl-time">
						<div class="tl-time">수강정정</div>
					</div>
					<div class="tl-point"></div>
					<div class="card border-2 border-info">
						<div class="card-body">
							<p>2023-06-22(목) ~ 2023-07-12(수)</p>
							<p>00 : 00 ~ 23 : 59</p>
							<p>2/3 환불(~7/5), 1/2 환불(~7/12)</p>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
