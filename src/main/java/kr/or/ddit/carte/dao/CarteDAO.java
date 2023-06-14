package kr.or.ddit.carte.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.carte.vo.CarteVO;

@Mapper
public interface CarteDAO {
	public List<CarteVO> selectCarteList();

}
