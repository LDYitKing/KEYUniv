package kr.or.ddit.ui;

import java.util.List;

import kr.or.ddit.lecture.vo.LectureTimePlaceVO;
import kr.or.ddit.lecture.vo.LectureVO;

public class LectureListRenderer {

	public String renderList(LectureVO lecture) {
		StringBuffer html = new StringBuffer();
		
		String lectName = lecture.getLectName(); // 강의명
		String lectNo = lecture.getLectNo(); //강의번호
		String memName = lecture.getMemName(); // 교수명
		Integer subScr = lecture.getSubScr(); // 학점
		Integer subGrade = lecture.getSubGrade(); // 학년
		String subComm = lecture.getSubCommName(); // 교과목 유형
		
		Integer lectPm = lecture.getLectPm();
		Integer lectMm = lecture.getLectMm();
		
		// 교시, 강의실
		List<LectureTimePlaceVO> lectDetailList = lecture.getLectDetailList();
		String lectTime = lecture.getLectTime(lectDetailList);
		String lectTimeNum = lecture.getLectTimeNum(lectDetailList);
		
		String deptName = lecture.getDeptName(); // 학과명
		
		boolean isSignup = lecture.isSignup(); // 수강신청여부  
		
		html.append( String.format("<li data-lect-no='%s' data-lect-time='%s' data-sub-scr='%d' class='list-group-item list-group-item-action lect-li'>", lectNo, lectTimeNum, subScr));
		html.append( "<div class='d-flex w-100 justify-content-between'>");
		html.append( String.format("<p><span class='h5 fw-bold'>%s</span>&nbsp;<span class='small'>%s</span></p>", lectName, lectNo));
		html.append( "<small>");
		html.append(String.format("<label>수강신청인원/정원&nbsp;<span class='text-info'>%d</span>/<span class='text-info'>%d</span>&nbsp;</label>", lectPm, lectMm));
		
		if(isSignup) {
			html.append( "<button id='deleteBtn' class='btn'>삭제</button>");
		}else {
			
			html.append( "<button class='btn lectInfoBtn'><ion-icon name='search-outline'></ion-icon>상세보기</button>");
			html.append( "<button id='insertBtn' class='btn'><ion-icon name='cart-outline'></ion-icon>담기</button>");
		}
		
		html.append( "</small>");
		html.append( "</div>");
		html.append( String.format("<p><label>%s</label></p>", memName));
		html.append( String.format("<small><label>%s</label>&nbsp;&nbsp;<label>%d학점</label>&nbsp;&nbsp;<label>%d학년</label>&nbsp;&nbsp;<label>%s</label></small>"
				, subComm, subScr, subGrade, lectTime));
		html.append( "</li>");

		return html.toString();
	}
}

/*
<li class="list-group-item list-group-item-action ">
	<div class=" d-flex w-100 justify-content-between">
		<p><span class="h6 fw-bold">강의명</span>&nbsp;<span class="small">강의번호</span></p>
		<small>
			<button class="btn">상세보기</button>
			<button class="btn">담기</button>
		</small>
	</div>
	<p><label>교수명</label></p>
	<small><label>학점</label>&nbsp;<label>학년</label>&nbsp;<label>구분</label>&nbsp;<label>교시</label></small>
</li>

*/