package kr.or.ddit.univBoard.service;


import java.io.File;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.univBoard.UnivBoardException;
import kr.or.ddit.univBoard.dao.UnivBoardDAO;
import kr.or.ddit.univBoard.vo.UnivBoardVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UnivBoardServiceImpl implements UnivBoardService {
	
	@Inject
	private UnivBoardDAO univBoardDAO;
	
	@Inject
	private AttatchFileGroupService fileService;
	
	@Value("#{appInfo['univboard.attatchPath']}")
	private File saveFolder;
	
	

//게시글 등록-----------------------------------------------------------------------------------	
	
	@Override
	public void createUnivBoard(UnivBoardVO univboard) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("현재 로그인된 사용자 : {}", authentication);
		AttatchFileGroupVO atchFileGroup = univboard.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					fileService.createAttatchFileGroup(afg, saveFolder);
					univboard.setUbFile(afg.getAtchId());
				});
		univBoardDAO.insertUnivBoard(univboard);
	}

//게시글 리스트------------------------------------------------------------------------------------	

	@Override
	public void retrievUnivBoardList(Pagination<UnivBoardVO> pagination) {
		int totalRecord = univBoardDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<UnivBoardVO> dataList = univBoardDAO.selectUnivBoardList(pagination);
		pagination.setDataList(dataList);
	}
	
//게시글 상세조회-----------------------------------------------------------------------------------
	
	@Override
	public UnivBoardVO retrieveUnivBoard(int ubNo) {
		UnivBoardVO univboard = univBoardDAO.selectUnivBoard(ubNo);
		if(univboard == null) throw new UnivBoardException(ubNo);
		univBoardDAO.updateUbCnt(ubNo);
		return univboard;
	}
//게시글 수정-------------------------------------------------------------------------------------
	@Override
	public void modifyUnivBoard(UnivBoardVO univboard) {
		UnivBoardVO saved = retrieveUnivBoard(univboard.getUbNo());
		//비번 검증
		//boardAuthenticated(univboard, saved.getBoPass());
		//검증 통과
		
		
		//지우고자 할때
		int rowcnt = Optional.ofNullable(univboard.getDelFileGroup())
						.map((dfg)->{
							dfg.setAtchId(univboard.getUbFile());
							return fileService.removeAttatchFileGroup(dfg, saveFolder);
						}).orElse(0);
		
		//업로드 하고자 할때
		AttatchFileGroupVO addFileGroup = univboard.getAddFileGroup();
		addFileGroup.setAtchId(univboard.getUbFile());
		rowcnt += Optional.ofNullable(univboard.getUbFile())
				//하나라도 파일이 있었을때
					.map((ba)->fileService.modifyAttatchFileGroup(addFileGroup, saveFolder))
					.orElseGet(()->{
						//완전 없었을때
						int cnt = fileService.createAttatchFileGroup(addFileGroup, saveFolder);
						// 만들어진 atchId를 넣음.
						univboard.setUbFile(addFileGroup.getAtchId());
						return cnt;
					});
		//게시글 수정절차
		rowcnt += univBoardDAO.updateUnivBoard(univboard);
		
	}

//게시글 삭제-------------------------------------------------------------------------------------	

	@Override
	public void removeUnivBoard(UnivBoardVO condition) {
		UnivBoardVO saved = retrieveUnivBoard(condition.getUbNo());
		
		int rowcnt = univBoardDAO.deleteUnivBoard(condition);
		if(rowcnt>0) {
			Optional.ofNullable(saved.getUbFile())
					.ifPresent((ubFile)->{
						fileService.removeAttatchFileGroup(ubFile, saveFolder);
					});
		}
	}
	
//첨부파일 다운로드-----------------------------------------------------------------------------------	
	
	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile== null)
			throw new RuntimeException(String.format("%d,%d 번 파일이 없음.",condition.getAtchId(),condition.getAtchSeq()));
		return atchFile;
	}

}
