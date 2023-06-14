package kr.or.ddit.carte.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.carte.dao.CarteDAO;
import kr.or.ddit.carte.vo.CarteVO;

@Controller
public class CarteController {
	@Inject
	private CarteDAO carteDAO;
	
	@GetMapping(produces = "application/json;charset=utf-8", value = "/carte/carteList.do")
	@ResponseBody
	public List<CarteVO> carteList(){
		return carteDAO.selectCarteList();
		
	}
	
	

}
