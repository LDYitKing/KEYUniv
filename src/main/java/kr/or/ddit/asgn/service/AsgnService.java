package kr.or.ddit.asgn.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.asgn.vo.AsgnSubmitVO;
import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.vo.Pagination;

public interface AsgnService {
	// ----------------- 학생 강의별 과제 관리 시작 ----------------- //
	/**
	 * 학생이 과제 하나를 제출하는 기능
	 * @param asgnSubmit
	 * @return
	 */
	public int createdAsgnSubmit(AsgnSubmitVO asgnSubmit); // 학생과제 제출
	public String removeAsngSubmit(String asNo); // 학생과제 삭제
	public List<AsgnVO> retrieveAsgnList(String lectNo); //강의과제 여러개 조회
	public AsgnVO retrieveAsgn(String asgnNo); //강의과제 한개 조회
	public AttatchFileVO download(AttatchFileVO condition); // 파일 다운로드
	
//------------------------------------------- 교수 과제
	
	public int createAsgn(AsgnVO asgn); // 교수 과제 등록
	public List<AsgnVO> retrieveProAsgnList(String lectNo); // 교수 강의별 과제 조회
	public void retrieveProStuAsgnList(Pagination<AsgnVO> pagination); // 강의별 학생 과제제출 조회
	public void modifyScore(AsgnSubmitVO asVO); // 과제 점수 수정
	public AsgnSubmitVO retrieveAsgnSubmitInfo(String asNo); // 과제 상세조회
	
	
	
	
	
	
	// ----------------- 학생 강의별 과제 관리 취소 ----------------- //
//	/**
//	 * 학생이 제출한 과제를 삭제하는 기능
//	 * @param asgnSubmit
//	 * @return
//	 */
//	public int removeAsgnSubmit(AsgnSubmitVO asgnSubmit);

//	/**
//	 * 강의별 과제 전체와 그 과제 전체에 대한 학생들의 제출정보를 조회하는 기능
//	 * @return 
//	 */
//	public List<AsgnVO> retrieveAsgnList(String lectNo);
//	
//	/**
//	 * 학생이 과제 하나의 상세보기와 학생한명의 제출정보를 조회하는 기능
//	 * @param asgn
//	 * @return
//	 */
//	public AsgnVO retrieveAsgn(AsgnSubmitVO asVO);	
}
