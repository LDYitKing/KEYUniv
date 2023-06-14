package kr.or.ddit.basket.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.or.ddit.basket.dao.BasketDAO;
import kr.or.ddit.basket.vo.BasketVO;
import kr.or.ddit.enumpkg.ServiceResult;

@Service
public class BasketServiceImpl implements BasketService {

	@Inject
	private BasketDAO basketDAO;
	
	@Override
	public List<BasketVO> retrieveBasketList(String stuNo) {
		return basketDAO.selectBasketList(stuNo);
	}

	@Override
	public ServiceResult createBasket(BasketVO basket) {
		ServiceResult sr = null;
		
		BasketVO input = basketDAO.selectBasket(basket);

		// 이미 장바구니에 존재하는 경우
		if(input!=null) return ServiceResult.DUPLICATED;
		
		int cnt = basketDAO.insertBasket(basket);
		if(cnt>0) return ServiceResult.OK;
		return ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeBasket(String basketNo) {
		BasketVO input = basketDAO.selectBasketByPk(basketNo);
		if(input==null) return ServiceResult.NOTFOUND;
		
		int cnt = basketDAO.deleteBasket(basketNo);
		if(cnt>0) return ServiceResult.OK; 
		return ServiceResult.FAIL;
	}

}



