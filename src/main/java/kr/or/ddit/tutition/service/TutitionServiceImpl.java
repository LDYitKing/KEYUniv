package kr.or.ddit.tutition.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.tutition.dao.TuitionDAO;
import kr.or.ddit.tutition.vo.TuitionVO;
import kr.or.ddit.tutition.vo.TutiPayVO;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TutitionServiceImpl implements TutitionService {

	@Inject
	private TuitionDAO tuitionDAO;
	
	@Override
	public void createTutiPay(TutiPayVO tutipay) {
		// TODO Auto-generated method stub

	}
//등록금 납부 리스트 확인----------------------------------------------------------------
	@Override
	public List<TutiPayVO> retriveTutiPayList(Pagination<TutiPayVO> pagination, String memRole) {
//		pagination.setTotalRecord(tutitionDAO.selectTotalRecord(pagination));
		List<TutiPayVO> tutiPayList = null;
		if(memRole != null) {
			if(memRole.equals("ROLE_EMP")) {
				tutiPayList = tuitionDAO.selectTutiPayList(pagination);
			}else if(memRole.equals("ROLE_STU")) {
				tutiPayList = tuitionDAO.selectTutiPayMemList(pagination);
			}
		}
		pagination.setDataList(tutiPayList);
		return tutiPayList;
		
	}

// 등록금 납부 조회 -------------------------------------------------------
	@Override
	public TutiPayVO retrieveTutiPay(TutiPayVO tutiPay) {
		return tuitionDAO.selectTutiPay(tutiPay);
	}

// 등록금 고지서 리스트확인--------------------------------------------------
	@Override
	public List<TuitionVO> retriveTutiList(Pagination<TuitionVO> pagination, String memRole) {
		pagination.setTotalRecord(tuitionDAO.selectTotalRecord(pagination));
		List<TuitionVO> tutiList = null;
		if(memRole != null) {
			if(memRole.equals("ROLE_EMP")) {
				tutiList = tuitionDAO.selectTutiList(pagination);
			}else if(memRole.equals("ROLE_STU")) {
				tutiList = tuitionDAO.selectTutiMemList(pagination);
			}
		}
		pagination.setDataList(tutiList);
		return tutiList;
	}
	
// 등록금 고지서 상세보기---------------------------------------------------
	@Override
	public TuitionVO retriveTuti(String tuitionNo) {
		return tuitionDAO.selectTuti(tuitionNo);
	}
	
// 등록금 고지서 삭제 -----------------------------------------------------
	@Override
	public void removeTuti(TuitionVO condition) {
		retriveTuti(condition.getTuitionNo());
		tuitionDAO.deleteTuti(condition);
	}
	
// 등록금 납부 삭제 ------------------------------------------------------
	@Override
	public void removeTutiPay(TutiPayVO condition) {
		// TODO Auto-generated method stub
	
	}
	
	@Override
	public void createTuti(TuitionVO tuition) {
		tuitionDAO.insertTuti(tuition);
		
	}
}
