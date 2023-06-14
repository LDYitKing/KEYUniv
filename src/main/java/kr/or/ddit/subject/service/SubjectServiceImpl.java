package kr.or.ddit.subject.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.favorites.vo.FavoriteVO;
import kr.or.ddit.subject.dao.SubjectDAO;
import kr.or.ddit.subject.vo.SubjectVO;
import kr.or.ddit.vo.Pagination;

@Service
public class SubjectServiceImpl implements SubjectService {
	@Inject
	private SubjectDAO subjectDAO;

	@Override
	public SubjectVO retrieveSubject(String subNo) throws PKNotFoundException {
		SubjectVO subject = subjectDAO.selectSubject(subNo);
		return subject;
	}

	@Override
	public ServiceResult createSubject(SubjectVO subject) {
		int result = subjectDAO.insertSubject(subject);
		return result >0? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifySubject(SubjectVO subject) throws PKNotFoundException {
		int result = subjectDAO.updateSubject(subject);
		if(result==0) {
			throw new PKNotFoundException(subject.getSubNo());
		}
		return ServiceResult.OK;
	}


	@Override
	public ServiceResult removeSubject(String subNo) throws PKNotFoundException {
		int result = subjectDAO.deleteSubject(subNo);
		if(result==0) {
			throw new PKNotFoundException(subNo);
		}
		return ServiceResult.OK;
	}
	@Override
	public List<SubjectVO> retrieveSubjectList() {
		return subjectDAO.selectSubjectList();
	}

	@Override
	public Integer subjectProcess(SubjectVO subject) {
		return subjectDAO.subjectProcess(subject);
	}

	@Override
	public List<SubjectVO> retrieveLectureWithFavorites(String memNo) {
		List<SubjectVO> subList = subjectDAO.selectLectureWithFavorites(memNo);
		return subList;
	}

	@Override
	public List<FavoriteVO> retrieveJobSubjectList() {
		return subjectDAO.selectJobList();
	}

}
