package kr.or.ddit.asgn.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.asgn.vo.AsgnSubmitVO;
import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.vo.Pagination;

/**
 * 과제 DAO
 * - 23.05.03 생성
 * @author Lee Da Young
 *
 */
@Mapper
public interface AsgnDAO {
	
	// ----------------- 학생 강의별 과제 관리 시작 ----------------- //
	/**
	 * 강의 하나에 대한 과제들 조회
	 * @param paramAsgn
	 * @return
	 */
	public List<AsgnVO> selectAsgnList(Map<String, String> paramAsgn);
	/**
	 * 강의 하나에 대한 학생 한명의 과제 조회
	 * @param asVO
	 * @return
	 */
	public AsgnSubmitVO selectAsgnSubmit(AsgnSubmitVO asVO);
	/**
	 * 강의 하나에 대한 학생 한명의 과제제출번호로 과제제출 조회
	 * @param asNo
	 * @return
	 */
	public AsgnSubmitVO selectASonAsNo(String asNo);
	/**
	 * 강의 하나에 대한 과제 하나 조회
	 * @param asgnNo
	 * @return
	 */
	public AsgnVO selectAsgn(String asgnNo);
	/**
	 * 학생이 과제 하나를 제출하는 기능
	 * @param asgnSubmit
	 * @return
	 */
	public int insertAsgnSubmit(AsgnSubmitVO asgnSubmit);
	/**
	 * 학생이 제출과제 하나를 삭제하는 기능
	 * @param asNo
	 * @return
	 */
	public int deleteAsngSubmit(String asNo);
	
// --------------교수 과제--------------
	
	/**
	 * 교수가 과제를 등록하는 기능
	 * @param asgn
	 * @return
	 */
	public int insertProAsgn(AsgnVO asgn);
	
	/**
	 * 교수 강의별로 과제 리스트 조회
	 * @param lectNo
	 * @return
	 */
	public List<AsgnVO> selectProAsgnList(String lectNo);
	
	/**
	 * 강의별 학생 과제제출 정보 조회(페이징)
	 * @param asgn
	 * @return
	 */
	public List<AsgnVO> selectProStuAsgnList(Pagination<AsgnVO> pagination);
	
	/**
	 * 페이징처리를 위한 전체 레코드 수 조회(학생 과제제출 정보 리스트)
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<AsgnVO> pagination);
	
	/**
	 * 과제 점수 업데이트 기능
	 * @param asVO
	 * @return
	 */
	public int updateScore(AsgnSubmitVO asVO);
	
	/**
	 * 과제 제출 상세조회
	 * @return
	 */
	public AsgnSubmitVO selectAsgnSubmitInfo(String asNo);
	
	
	
}
