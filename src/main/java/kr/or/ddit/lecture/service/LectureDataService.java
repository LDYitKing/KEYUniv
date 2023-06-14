package kr.or.ddit.lecture.service;

import java.util.List;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.lecture.vo.LectureDataVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.vo.Pagination;

public interface LectureDataService {
	/**
	 * 강의 자료 만드는 기능
	 * @param lectureData
	 */
	public void createLectureData(LectureDataVO lectureData);
	/**
	 * 강의 자료 리스트 띄우기!!! 페이징과 검색까지 가능
	 * @param pagination
	 * @return
	 */
	public List<LectureDataVO> retrieveLectureDataList(Pagination<LectureDataVO> pagination);
	/**
	 * 강의 자료 상세 검색
	 * @param ldNo
	 * @return
	 */
	public LectureDataVO retrieveLectureData(String ldNo);
	/**
	 * 일반 리스트 띄우기!!!!!
	 * @return
	 */
	public List<LectureVO> retrieveLectureDataTotalList();
	/**
	 * 강의 자료 수정
	 * @param lectureData
	 */
	public void modifyLectureData(LectureDataVO lectureData);
	/**
	 * 강의자료 삭제
	 * @param condition
	 */
	public void removeLectureData(LectureDataVO condition);
	/**
	 * 강의 자료 첨부파일 다운로드
	 * @param condition
	 * @return
	 */
	public AttatchFileVO download(AttatchFileVO condition);
}
