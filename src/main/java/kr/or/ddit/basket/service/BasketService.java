package kr.or.ddit.basket.service;

import java.util.List;

import kr.or.ddit.basket.vo.BasketVO;
import kr.or.ddit.enumpkg.ServiceResult;

public interface BasketService {
	/**
	 * 학생 한 명의 장바구니 전체 조회
	 * @param stuNo 학생 학번
	 * @return
	 */
	public List<BasketVO> retrieveBasketList(String stuNo);
	

	/**
	 * 장바구니 추가
	 * @param basket
	 * @return OK, FAIL
	 */
	public ServiceResult createBasket(BasketVO basket);
	
	/**
	 * 장바구니 삭제
	 * @param basketNo
	 * @return
	 */
	public ServiceResult removeBasket(String basketNo);
	
}
