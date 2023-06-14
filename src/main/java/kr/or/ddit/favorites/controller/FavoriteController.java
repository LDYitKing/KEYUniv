package kr.or.ddit.favorites.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.favorites.dao.FavoriteDAO;
import kr.or.ddit.favorites.service.FavoriteService;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.member.vo.MemberVOWrapper;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {
	@Inject
	private FavoriteService favoriteService;
	@Inject
	private FavoriteDAO favoriteDao;

	
	@GetMapping(produces = "application/json;charset=utf-8", value = "/favorites.do")
	@ResponseBody
	public List<FavoriteVO> favorites(
			 Authentication authentication
			){
		MemberVOWrapper memVOW = (MemberVOWrapper) authentication.getPrincipal();
		String memNo = memVOW.getRealUser().getMemNo();
		return favoriteService.retrieveFavorites(memNo);
		
	}
	
	@PostMapping(produces = "application/json;charset=utf-8", value = "/favoriteInsert.do")
	@ResponseBody
	public Integer favoriteInsert(
			@RequestBody FavoriteVO favoriteVO
			) {
		int cnt = 0;
			switch (favoriteService.createFavorite(favoriteVO)) {
			case OK:
				cnt = 1;
				break;
			default:
				
				break;
			}
			return cnt;
	}
	
	@PostMapping(produces = "application/json;charset=utf-8", value = "/favoriteDelete.do")
	@ResponseBody
	public Integer favoriteDelete(
			@RequestBody FavoriteVO favoriteVO
			) {
		int cnt = 0;
		switch (favoriteService.removeFavorite(favoriteVO)) {
		case OK:
			cnt = 1;
			break;
		default:
			break;
		}
		return cnt;
	}
	
	@GetMapping(produces = "application/json;charset=utf-8", value = "/Suggestions.do")
	@ResponseBody
	public List<FavoriteVO> Suggestions(
			@RequestParam("dept") String deptNo 
			){
			List<FavoriteVO> suggestions = new ArrayList<FavoriteVO>();
			List<FavoriteVO> deptProList = favoriteDao.selectSuggestions(deptNo); 
			for(int i = 0; i < deptProList.size(); i++) {
				
				FavoriteVO proFavorite = deptProList.get(i);
				String memName = proFavorite.getMemName();
				String proLoe = proFavorite.getProLoe();
				List<FavoriteVO> proFavList = favoriteService.retrieveFavorites(proFavorite.getProNo());
				
				for(int j=0; j < proFavList.size(); j++) {
					FavoriteVO favorite = proFavList.get(j);
					favorite.setMemName(memName);
					favorite.setProLoe(proLoe);
					suggestions.add(favorite);
				}
			}
			return suggestions;
		
	}
	
	@GetMapping(produces = "application/json;charset=utf-8", value = "/mylectList.do")
	@ResponseBody
	public List<FavoriteVO> mylectList(
			 Authentication authentication
			){
		MemberVOWrapper memVOW = (MemberVOWrapper) authentication.getPrincipal();
		String memNo = memVOW.getRealUser().getMemNo();
		return favoriteDao.imsiLect(memNo);
		
	}
	
	
	

}
