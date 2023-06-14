package kr.or.ddit.grid.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.grid.vo.GridVO;

/**
 * 그리드 관리
 * @author Kim Eui Yeon
 *
 */
@Mapper
public interface GridDAO {
	/**
	 * 첫 로그인시 그리드 생성
	 * @param grid
	 * @return
	 */
	public int insertGrid(GridVO grid);
	/**
	 * 그리드 변경
	 * @param grid
	 * @return
	 */
	public int updateGrid(GridVO grid);
	/**
	 * 자신의 저장된 그리드 불러오기
	 * @param memNo
	 * @return
	 */
	public List<GridVO> selectUserGridList(String memNo);
	
	/**
	 * 그리드 삭제
	 * @param grid
	 * @return
	 */
	public int deleteGrid(GridVO grid);

}
