package kr.or.ddit.grid.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.grid.dao.GridDAO;
import kr.or.ddit.grid.vo.GridVO;

@Service
public class GridServiceImpl implements GridService {
	
	@Inject
	private GridDAO gridDAO;

	@Override
	public int createGrid(GridVO grid) {
		return gridDAO.insertGrid(grid);
	}

	@Override
	public int modifyGrid(GridVO grid) {
		return gridDAO.updateGrid(grid);
	}

	@Override
	public List<GridVO> retrieveUserGridList(String memNo) {
		return gridDAO.selectUserGridList(memNo);
	}

	@Override
	public int removeGrid(GridVO grid) {
		return gridDAO.deleteGrid(grid);
	}

}
