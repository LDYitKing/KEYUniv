package kr.or.ddit.lecture.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.lecture.vo.LectureDataVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface LectureDataDAO {
	 /**
	  * 자료 신규 등록
	 * @param lectureData
	 * @return >0, 성공
	 */
	public int insertLectureData(LectureDataVO lectureData);

	/**
	 * 페이징 처리를 위한 전체 레코드 수 조회
	 * @param pagination
	 * @return
	 */
	public int selectTotalLectureRecord(Pagination<LectureDataVO> pagination);

	/**
	 * 학생 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<LectureDataVO> selectLectureDataList(Pagination<LectureDataVO> pagination);

	/**
	 * PK로 강의 자료 한개 상세 조회
	 * @param lectNo
	 * @return 존재하지 않으면, null
	 */
	public LectureDataVO selectLecutureForAuth(String ldNo);

	/**
	 * 강의자료 수정
	 * @param letureData
	 * @return	>0, 성공
	 */
	public int updateLectureData(LectureDataVO letureData);

	/**
	 * 강의 자료 셀랙트!!
	 * @return
	 */
	public List<LectureVO> selectLectureDataTotalList();

	/**
	 * 강의 자료 삭제
	 * @param letureData
	 * @return
	 */
	public int deleteLectureData(LectureDataVO letureData);

}
