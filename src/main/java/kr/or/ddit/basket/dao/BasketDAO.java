package kr.or.ddit.basket.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.basket.vo.BasketVO;

@Mapper
public interface BasketDAO {
	/**
	 * 이미 장바구니에 담은 강의 인지 조회
	 * @param basket
	 * @return
	 */
	public BasketVO selectBasket(BasketVO basket);
	
	/**
	 * 학생 한 명의 장바구니 전체 조회
	 * @param stuNo 학생 학번
	 * @return
	 */
	public List<BasketVO> selectBasketList(String stuNo);
	
	/**
	 * 장바구니 추가
	 * @param basket
	 * @return
	 */
	public int insertBasket(BasketVO basket);
	
	/**
	 * 장바구니 삭제
	 * @param basketNo
	 * @return
	 */
	public int deleteBasket(String basketNo);
	
	/**
	 * 장바구니에 존재하는지 조회
	 * @param basketNo
	 * @return
	 */
	public BasketVO selectBasketByPk(String basketNo);
}
