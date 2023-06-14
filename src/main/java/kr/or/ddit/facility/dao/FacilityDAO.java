package kr.or.ddit.facility.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.facility.vo.FacilityResVO;
import kr.or.ddit.facility.vo.FacilityTimeVO;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.vo.Pagination;

/**
 * 편의시설 DAO
 * 2023.05.04 생성
 * @author ShinYuCheol
 *
 */
@Mapper
public interface FacilityDAO {
	//교직원 편의시설 등록 수정 삭제

	/**
	 * 편의시설 등록
	 * @param facility
	 * @return >= 0, 성공
	 */
	public int insertFacility(FacilityVO facility);

	/**
	 * 편의시설 수정
	 * @param facility
	 * @return >= 0, 성공
	 */
	public int updateFacility(FacilityVO facility);

	/**
	 * 편의시설 삭제
	 * @param condition
	 * @return >= 0, 성공
	 */
	public int deleteFacility(FacilityVO condition);

	/**
	 * 편의시설 전체 리스트 조회(페이징 O)
	 * @param pagination
	 * @return
	 */
	public List<FacilityVO> selectFacilityList(Pagination<FacilityVO> pagination);

	/**
	 * 편의시설 전체 리스트 조회(페이징 X)
	 * @return
	 */
	public List<FacilityVO> selectFaciList();

	/**
	 * 페이징처리를 위한 전체 레코드 수 조회(편의시설 리스트)
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<FacilityVO> pagination);

	/**
	 * 편의시설 상세 조회
	 * @param faciNo
	 * @return
	 */
	public FacilityVO selectFacility(String faciNo);

	/**
	 * 편의시설 예약시간 리스트
	 * @return
	 */
	public List<FacilityTimeVO> selectFacilityTimeList();

	/**
	 * 편의시설 예약
	 * @param facilityRes
	 * @return >= 0, 성공
	 */
	public int insertFacilityRes(FacilityResVO facilityRes);

	/**
	 * 멤버별 편의시설 예약 현황 조회
	 * @param pagination
	 * @return
	 */
	public List<FacilityResVO> selectFacilityResList(String memNo);

	/**
	 * 편의시설 예약 삭제
	 * @param facilityRes
	 * @return >= 0, 성공
	 */
	public int deleteFacilityRes(FacilityResVO facilityRes);

	/**
	 * 예약정보 전체 화면 찍기를 위한 쿼리문이에용
	 * @return
	 */
	public List<FacilityResVO> selectTotalFacilityResList();

}





















