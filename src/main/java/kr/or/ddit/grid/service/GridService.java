package kr.or.ddit.grid.service;

import java.util.List;

import kr.or.ddit.grid.vo.GridVO;

/**
 * 그리드 서비스
 * @author Kim Eui Yeon
 *
 */
public interface GridService {

	/**
	 * 첫 로그인시 그리드 생성
	 * @param grid
	 * @return
	 */
	public int createGrid(GridVO grid);

	/**
	 * 그리드 수정
	 * @param grid
	 * @return
	 */
	public int modifyGrid(GridVO grid);
	
	/**
	 * 그리드 삭제
	 * @param grid
	 * @return
	 */
	public int removeGrid(GridVO grid);

	/**
	 * 자신의 그리드 불러오기
	 * @param memNo
	 * @return
	 */
	public List<GridVO> retrieveUserGridList(String memNo);

}
