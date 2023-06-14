package kr.or.ddit.dgrade.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.dgrade.vo.DgradeVO;

@Mapper
public interface DgradeDAO {
	/**
	 * 학생의 이수학점 등록
	 * @param dgrade
	 * @return
	 */
	public int insertStuDgrade(DgradeVO dgrade);
//	public int insertDeptDgrade(DgradeVO dgrade);
	
	/**
	 * 학생의 이수학점과 학생의 학과 졸업이수학점 조회
	 * @param memNo (학생의 학번과 학생의 학과 번호)
	 * @return
	 */
	public List<DgradeVO> selectDgrade(String memNo);
}
