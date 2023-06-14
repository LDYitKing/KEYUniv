package kr.or.ddit.curri.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.curri.dao.MyCurriDAO;
import kr.or.ddit.curri.vo.CurriDetailVO;
import kr.or.ddit.curri.vo.CurriVO;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.subject.vo.SubjectVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MyCurriServiceImpl implements MyCurriService {
	@Inject
	private MyCurriDAO mycurriDAO;

	// 교과목 리스트 출력
	@Override
	public List<SubjectVO> retrieveSubjectList() {
		List<SubjectVO> subjectTotalList = mycurriDAO.subjectList();
		return subjectTotalList;
	}
	// 나의 커리,커리디테일 동시 Insert
	@Transactional
	@Override
	public void createCurri(CurriVO curri) {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();
		MemberVOWrapper memberwrapper = (MemberVOWrapper) authentication
				.getPrincipal();
		MemberVO realUser = memberwrapper.getRealUser();
		// Wrapper에서 CurriVO를 빼내어 작업
		curri.setCurriDesigner(realUser.getMemNo());
		mycurriDAO.insertMyCurri(curri); // 수정된 CurriVO를 사용
		log.info("curriVO에는 어떤값일까?{}", curri);
		List<CurriDetailVO> curriDetails = curri.getCurriDetail(); // Get
																	// curriDetail
																	// from the
																	// input
																	// CurriVO
		for (CurriDetailVO curriDetail : curriDetails) {
			curriDetail.setCurriNo(curri.getCurriNo());
			mycurriDAO.insertCurriDetail(curriDetail);
		}
		log.info("curriDetail에는 어떤값일까?{}", curriDetails);
	}
	// 해당 맴버의 커리 리스트 출력
	@Override
	public List<CurriVO> retrieveCurriList(String Designer) {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();
		MemberVOWrapper memberwrapper = (MemberVOWrapper) authentication
				.getPrincipal();
		MemberVO realUser = memberwrapper.getRealUser();
		Designer = realUser.getMemNo();
		List<CurriVO> curriList = mycurriDAO.selectMemCurri(Designer);
		return curriList;
	}
	// 클릭한 커리의 커리디테일 출력
	@Override
	public List<CurriDetailVO> retrieveCurriDetailList(String CuuriNo) {
		List<CurriDetailVO> curriDetailList = mycurriDAO
				.curriDetailList(CuuriNo);
		return curriDetailList;
	}
	@Override
	public List<SubjectVO> retrieveSubjectListOne(String subNo,
			String curriNo) {
		Map<String, String> params = new HashMap<>();
		params.put("subNo", subNo);
		params.put("curriNo", curriNo);
		List<SubjectVO> subjectList = mycurriDAO.selectsubjectList(params);
		return subjectList;
	}
	@Override
	public int removeCurriDetail(CurriDetailVO curriDetailVO) {
		return mycurriDAO.deleteCurriDetail(curriDetailVO);
	}
	@Override
	public int removeCurri(CurriVO curriVO) {
		return mycurriDAO.deleteCurri(curriVO);
	}
	@Override
	public int modifyCurriDetail(CurriDetailVO curriDetailVO) {
		return mycurriDAO.updateCurriDetail(curriDetailVO);

	}
	@Override
	public List<CurriDetailVO> retrieveCurriDetail(Map<String, String> params) {
		return mycurriDAO.selectCurriTd(params);
	}
	@Override
	public List<FavoriteVO> retrieveFavoriteList(String Designer ) {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();
		MemberVOWrapper memberwrapper = (MemberVOWrapper) authentication
				.getPrincipal();
		MemberVO realUser = memberwrapper.getRealUser();
		Designer = realUser.getMemNo();
		List<FavoriteVO> favoritesubjectList = mycurriDAO.selectFavoriteList(Designer);
		return favoritesubjectList;
	}

}
