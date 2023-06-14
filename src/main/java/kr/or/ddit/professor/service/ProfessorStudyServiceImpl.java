package kr.or.ddit.professor.service;

import java.io.File;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;
import javax.management.RuntimeErrorException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.professor.dao.ProfessorDAO;
import kr.or.ddit.professor.vo.StudyVO;
import kr.or.ddit.vo.Pagination;

@Service
public class ProfessorStudyServiceImpl implements ProfessorStudyService {
	
	@Inject
	private ProfessorDAO professorDAO;
	
	@Inject
	private AttatchFileGroupService fileService;
	
	@Value("#{appInfo['contracts']}")
	private File saveFolder;
	
	@Override
	public List<StudyVO> retrieveStudyList() {
		List<StudyVO> list = professorDAO.selectStudyList();
		
		//필요한가 ?
//		if(list.isEmpty())
		//언체크드익셉션은 회피전략임.
//		throw new RuntimeException("테이블이 하나도 없음.");
		
		return list;
		
	}
	
	@Override
	public int createStudy(StudyVO study) {
		AttatchFileGroupVO atchFileGroup = study.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
			.ifPresent((afg)->{
				fileService.createAttatchFileGroup(afg, saveFolder);
				study.setStudyFile(afg.getAtchId());
			});
		
		return professorDAO.insertStudy(study);
	}


	@Override
	public StudyVO retrieveStudy(String studyNo) {
		StudyVO study = professorDAO.selectStudy(studyNo);
		if(study==null) throw new RuntimeException(); //일단넣어둠.
		return study;
	}

	@Override
	public int modifyStudy(StudyVO study) {
		int reCnt = 0;
		StudyVO saved = professorDAO.selectStudy(study.getStudyNo());
		
		if(saved.getProNo().equals(study.getProNo())) {
			int rowcnt = Optional.ofNullable(study.getDelFileGroup())
							.map((dfg)->{
								dfg.setAtchId(study.getStudyFile());
								return fileService.removeAttatchFileGroup(dfg, saveFolder);
							}).orElse(0);
			
			AttatchFileGroupVO addFileGroup = study.getAddFileGroup();
			addFileGroup.setAtchId(study.getStudyFile());
			
			rowcnt = Optional.ofNullable(study.getStudyFile())
						.map((sf)->{
							return fileService.modifyAttatchFileGroup(addFileGroup, saveFolder);
						}).orElseGet(()->{
							int cnt = fileService.createAttatchFileGroup(addFileGroup,saveFolder);
							study.setStudyFile(addFileGroup.getAtchId());
							return cnt;
						});
			
			rowcnt += professorDAO.updateStudy(study);
				
					
			reCnt = rowcnt;
		}
		
		return reCnt;
	}

	

	@Override
	public int removeStudy(StudyVO condition) {
		StudyVO saved = retrieveStudy(condition.getStudyNo());
		
		int rowcnt = professorDAO.deleteStudy(condition);
		if(rowcnt >0) {
			Optional.ofNullable(saved.getStudyFile())
				.ifPresent((studyFile)->{
					fileService.removeAttatchFileGroup(studyFile, saveFolder);
				});
		}else {
			rowcnt = 0;
		}
		return rowcnt;
	}

	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		// 검색 조건 condition , 결과물 atchFile
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) 
			throw new RuntimeException(String.format("%d, %d 번 파일이 없음.", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;
	}

	

}
