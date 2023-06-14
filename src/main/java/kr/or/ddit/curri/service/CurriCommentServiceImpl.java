package kr.or.ddit.curri.service;

import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.curri.dao.CurriCommentDAO;
import kr.or.ddit.curri.vo.CurriCommentVO;

@Service
public class CurriCommentServiceImpl implements CurriCommentService {

	@Inject
	private CurriCommentDAO commentDAO;
		
	@Override
	public int createComment(CurriCommentVO comment) {
		return commentDAO.insertComment(comment);
	}

	@Override
	public List<CurriCommentVO> retrieveCommentList(String cbNo) {
		return commentDAO.selectCommentList(cbNo);
	}

	@Override
	public int modifyComment(CurriCommentVO comment) {
		return commentDAO.updateComment(comment);
	}

	@Override
	public int removeComment(String ccNo) {
		return commentDAO.deleteComment(ccNo);
	}

}
