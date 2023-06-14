package kr.or.ddit.favorites.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.vo.Pagination;

public interface FavoriteService {
	public List<FavoriteVO> retrieveFavorites(String memNo);
	public ServiceResult createFavorite(FavoriteVO favorite);
	public ServiceResult removeFavorite(FavoriteVO favorite);
	public ServiceResult removeSubjectFavorite(FavoriteVO favorite);
}
