package kr.or.ddit.dgrade.service;

import java.util.List;

import kr.or.ddit.dgrade.vo.DgradeVO;

public interface DgradeService {
	/**
	 * 학생의 이수학점 등록
	 * @param dgrade
	 * @return
	 */
	public int createStuDgrade(DgradeVO dgrade);
	
	/**
	 * 학생의 이수학점과 학생의 학과 졸업이수학점 조회, 학생의 수강중인 강의 학점 포함
	 * @param memNo (학생의 학번과 학생의 학과 번호)
	 * @return
	 */
	public List<DgradeVO> selectDgrade(String memNo);
}
