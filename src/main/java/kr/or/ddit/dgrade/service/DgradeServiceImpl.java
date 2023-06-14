package kr.or.ddit.dgrade.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.course.dao.CourseDAO;
import kr.or.ddit.dgrade.dao.DgradeDAO;
import kr.or.ddit.dgrade.vo.DgradeVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DgradeServiceImpl implements DgradeService {

	@Inject
	private DgradeDAO dgradeDAO;
	@Inject
	private CourseDAO courseDAO;
	
	
	@Override
	public int createStuDgrade(DgradeVO dgrade) {
		return dgradeDAO.insertStuDgrade(dgrade);
	}

	@Override
	public List<DgradeVO> selectDgrade(String memNo) {
		List<DgradeVO> dgradeList = dgradeDAO.selectDgrade(memNo);
		if(!dgradeList.isEmpty()) {
			int countScr = courseDAO.countScr(memNo);
			dgradeList.forEach((vo)->{vo.setCountScr(countScr);});
			log.info("dgradeList : {}", dgradeList);
		}
		return dgradeList;
	}

}
