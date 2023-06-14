package kr.or.ddit.professor.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.professor.dao.ProfessorDAO;
import kr.or.ddit.professor.vo.ProfessorVO;

@Service
public class ProfessorServiceImpl implements ProfessorService {

	@Inject
	private ProfessorDAO proDAO;
	
	@Override
	public List<ProfessorVO> retrieveProfessorList(ProfessorVO professor) {
		
		return proDAO.selectProfessorList(professor);
	}

	@Override
	public ProfessorVO retrieveProfessor(String memNo) {
		ProfessorVO professor = proDAO.selectProfessor(memNo);
		if(professor==null) throw new RuntimeException();
		return professor;
	}

}
