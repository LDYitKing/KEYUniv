package kr.or.ddit.facility.service;

import java.util.List;

import kr.or.ddit.facility.vo.FacilityResVO;
import kr.or.ddit.facility.vo.FacilityTimeVO;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.vo.Pagination;

/**
 * 편의시설 서비스
 * 23.05.04 생성
 * @author ShinYuCheol
 *
 */
public interface FacilityService {
	/**
	 * 편의시설 추가
	 * @param facility
	 */
	public void createFacility(FacilityVO facility);
	/**
	 * 편의 시설 수정
	 * @param facility
	 */
	public void modifyFacility(FacilityVO facility);
	/**
	 * 편의 시설 삭제
	 * @param condition
	 * @return
	 */
	public void removeFacility(FacilityVO condition);
	/**
	 * 전체 편의시설 리스트 조회(페이징)
	 * @param pagination
	 */
	public void retrieveFacilityList(Pagination<FacilityVO> pagination);

	/**
	 * 전체 편의시설 리스트 조회(페이징x)
	 */
	public List<FacilityVO> retrieveFaciList();
	/**
	 * 편의시설 상세 조회
	 * @param faciNo
	 * @return
	 */
	public FacilityVO retrieveFacility(String faciNo);

	/**
	 * 편의시설 예약
	 * @param facilityRes
	 */
	public void createFacilityRes(FacilityResVO facilityRes);


	/**
	 * 편의시설 예약시간 조회
	 * @return
	 */
	public List<FacilityTimeVO> retrieveFacilityTimeList();

	/**
	 * 개인별 편의시설 예약현황을 조회하는 기능
	 * @param memNo
	 * @return
	 */
	public List<FacilityResVO> retrieveFacilityResList(String memNo);

	/**
	 * 편의시설 예약 삭제
	 * @param condition
	 */
	public void removeFacilityRes(FacilityResVO condition);

	/**
	 * 전체 정보를 확인하기 위한 기능이에요
	 * @return
	 */
	public List<FacilityResVO> retrieveAllFacilityResList();
}
