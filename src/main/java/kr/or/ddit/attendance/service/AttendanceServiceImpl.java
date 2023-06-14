package kr.or.ddit.attendance.service;

import java.io.File;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.attendance.vo.AttendanceAdmitVO;
import kr.or.ddit.attendance.vo.AttendanceVO;
import kr.or.ddit.course.vo.CourseVO;
import kr.or.ddit.student.vo.StudentVO;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	
	@Inject
	private AttendanceDAO attendDAO;
	
	@Inject
	private AttatchFileGroupService fileService;
	
	@Value("#{appInfo['attend.attatchPath']}")
	private File saveFolder;
	
	@Override
	public List<AttendanceVO> retrieveStaticsAttendList(String lectNo) {
		// 해당 강의를 수강하는 학생들의 정보 리스트
		List<AttendanceVO> attendList = attendDAO.selectCourseStu(lectNo);
		
		// 학생마다의 출석 카운트 
		for(AttendanceVO attend : attendList) {
			
			// 갯수 받을 변수
			int countAttend = 0; // 출석, 지각, 조퇴
			int countDeattend = 0; // 결석
			int countCurrentAttend = 0; // 현재까지 수업숫자
			
			// 학생 번호 뽑을 리스트
			List<StudentVO> stuList = attend.getStudentList();
			for(StudentVO stuVO : stuList) {
				countAttend = attendDAO.countStuAttend(stuVO.getMemNo()); //결과 받아옴.
				countDeattend = attendDAO.countStuDeattend(stuVO.getMemNo());
				countCurrentAttend = attendDAO.countCurrentAttend(lectNo);
			}
			// 출석vo에 넣어주기
			attend.setCountAttend(countAttend);
			attend.setCountDeattend(countDeattend);
			attend.setCountCurrentAttend(countCurrentAttend);
			
		}
		return attendList;
		
	}

	@Override
	public List<AttendanceAdmitVO> retrieveAttendAdmitListAll(String lectNo) {
		// 교수 : 모든 출석인정 신청내역 조회
		return attendDAO.selectAttendAdmitListAll(lectNo);
	}
	
	@Override
	public List<CourseVO> retrieveStuList(String lectNo) {
		return attendDAO.selectStuList(lectNo);
	}

	@Override
	public int modifyAttend(List<AttendanceVO> attendList) {
		int count=0;
		for(AttendanceVO attend : attendList) {
			int cnt = attendDAO.updateAttend(attend);
			count = count + cnt;
		}
		return count;
	}
	
	@Override
	public int createAttend(List<AttendanceVO> attendList) {
		int cnt = 0;
		for(AttendanceVO attend: attendList) {
			//stuNo, attendState, lectNo
			//출석정보가 있으면 update, 없으면 insert
			cnt += attendDAO.insertAttend(attend);
		}
		return cnt;
	}
	
	// 학생 한명의 출석정보 리스트
	@Override
	public List<AttendanceVO> retrieveMyattendList(AttendanceVO attend) {
		List<AttendanceVO> attendList = attendDAO.selectMyattendList(attend);
		String lectName = attendDAO.selectMylectname(attend.getLectNo());
		for(AttendanceVO attendOne : attendList) {
			attendOne.setLectName(lectName);
		}
		return attendList;
	}

	@Override
	public AttendanceVO retrieveMyattend(String attendNo) {
		// 내 출석정보 가져오기( 출석 인정 신청 시, 정보 제공용 )
		AttendanceVO attend = attendDAO.selectMyattend(attendNo);
		// 강의번호 가져오기( 페이지 이동용 )
		String lectNo = attendDAO.selectLectNo(attend.getCourseNo());
		attend.setLectNo(lectNo);
		 
		 return attend;
	}

	@Override
	public int createdMyattendAdmit(AttendanceAdmitVO attendAdmit) {
		// 파일먼저 작업
		AttatchFileGroupVO atchFileGroup = attendAdmit.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					//1. 파일서비스에서 metadata랑 이진데이터 넣고 1:N처리
					fileService.createAttatchFileGroup(afg, saveFolder);
					//2. C.O에 파일그룹에서 그룹id를 받아와서 저장한다.1:1처리
					attendAdmit.setAaFile(afg.getAtchId()); 
				});
		return attendDAO.insertMyattendAdmit(attendAdmit);
	}

	@Override
	public List<AttendanceAdmitVO> retrieveAttendAdmitList(AttendanceAdmitVO attendAdmit) {
		// 학생:출석인정신청 내역 조회
		return attendDAO.selectAttendAdmitList(attendAdmit);
	}

		
	//--------------------- 파일 다운로드 ------------------------//
	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) throw new RuntimeException(String.format("%d, %d 번 파일이 없음", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;
	}
	//--------------------------------------------------------//

	@Override
	public int modifyAttendAdmit(AttendanceAdmitVO attendAdmit) {
		int cnt = 0;
		// 결과 확인
		String attendState = attendAdmit.getAttendState();
		String attendNo = attendAdmit.getAttendNo();
		if(attendState.equals("D002") || attendState.equals("D003")) { // 출석상태그대로면,
			attendAdmit.setAaState("B003"); // 반려.
			attendDAO.updateAttendAdmitNo(attendAdmit); // 신청상태변경, 반려사유 등록
		}else {	// 출석으로 바꼈으면, 
			attendAdmit.setAaState("B002"); // 승인(완료)
			cnt = attendDAO.updateAttendAdmitOK(attendAdmit); // 신청상태 변경(거절사유 없는데 어떡하지?)
			AttendanceVO attend = new AttendanceVO();
			attend.setAttendNo(attendNo);
			attend.setAttendState(attendState);
			// 출석인정신청수정되었으면 출석정보 수정
			if(cnt > 0) {
				int attendCnt = attendDAO.updateAttend(attend); // 변경된 출석상태 등록
				cnt += attendCnt;
			} 
		}
		return cnt;
	}

	
}
