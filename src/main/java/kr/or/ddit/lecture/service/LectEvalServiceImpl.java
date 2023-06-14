package kr.or.ddit.lecture.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.lecture.dao.LectEvalDAO;
import kr.or.ddit.lecture.vo.LectureEvaluationVO;

@Service
public class LectEvalServiceImpl implements LectEvalService {

	@Inject
	private LectEvalDAO lectEvalDAO;
	
	@Override
	public int createLectEval(LectureEvaluationVO lectEval) {
		return lectEvalDAO.insertLectEval(lectEval);
	}

}
