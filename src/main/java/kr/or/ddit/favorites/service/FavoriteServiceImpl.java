package kr.or.ddit.favorites.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.favorites.dao.FavoriteDAO;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.vo.Pagination;

@Service
public class FavoriteServiceImpl implements FavoriteService {
	@Inject
	private FavoriteDAO favoriteDAO;

	@Override
	public ServiceResult createFavorite(FavoriteVO favorite) {
		int result = favoriteDAO.insertFavorite(favorite);
		return result>0? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeFavorite(FavoriteVO favorite) {
		int result = favoriteDAO.deleteFavorite(favorite);
		return result>0? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<FavoriteVO> retrieveFavorites(String memNo) {
		return favoriteDAO.selectFavorites(memNo);
	}

	@Override
	public ServiceResult removeSubjectFavorite(FavoriteVO favorite) {
		int result = favoriteDAO.deleteSubjectFavorite(favorite);
		return result>0? ServiceResult.OK : ServiceResult.FAIL;
	}

}
