package kr.or.ddit.asgn.service;

import java.io.File;
import java.security.cert.PKIXRevocationChecker.Option;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.asgn.dao.AsgnDAO;
import kr.or.ddit.asgn.vo.AsgnSubmitVO;
import kr.or.ddit.asgn.vo.AsgnVO;
import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AsgnServiceImpl implements AsgnService {
	@Inject
	private AsgnDAO asgnDAO;
	
	@Inject
	private AttatchFileGroupService fileService;
	
	@Value("#{appInfo['as.attatchPath']}")
	private File saveFolder;
	
//------------------- 학생이 과제 제출 -----------------------//
	@Override
	public int createdAsgnSubmit(AsgnSubmitVO asgnSubmit) {
		// 인증객체 꺼내기
		Authentication authentication 
			= SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();
		asgnSubmit.setStuNo(stuNo);
		
		AttatchFileGroupVO atchFileGroup = asgnSubmit.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					//1. 파일서비스에서 metadata랑 이진데이터 넣고 1:N처리
					fileService.createAttatchFileGroup(afg, saveFolder);
					//2. C.O에 파일그룹에서 그룹id를 받아와서 저장한다.1:1처리
					asgnSubmit.setAsFile(afg.getAtchId()); 
				});
		return asgnDAO.insertAsgnSubmit(asgnSubmit);
	}
//--------------------------------------------------------//

//------------------- 과제 리스트 조회 -----------------------//
	@Override
	public List<AsgnVO> retrieveAsgnList(String lectNo) {
		// 인증객체에서 학번 꺼내기.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();
		
		// 맵 생성
		Map<String, String> paramAsgn = new HashMap<>();
		paramAsgn.put("stuNo", stuNo);
		paramAsgn.put("lectNo", lectNo);
		
		// 과제정보 리스트 조회 -> 리턴할 강의당과제 조회결과
		List<AsgnVO> asgnList = asgnDAO.selectAsgnList(paramAsgn); 
		
		return asgnList;
	}
//--------------------------------------------------------//

//-------------------- 과제 상세 조회 ------------------------//
	@Override
	public AsgnVO retrieveAsgn(String asgnNo) {
		// 인증객체에서 학번 꺼내기.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberVOWrapper memVO = (MemberVOWrapper)authentication.getPrincipal();
		String stuNo = memVO.getRealUser().getMemNo();

		// 강의과제 하나 조회하기
		AsgnVO asgnVO = asgnDAO.selectAsgn(asgnNo);
		
		// 과제제출객체 생성
		AsgnSubmitVO asVO = new AsgnSubmitVO();
		asVO.setAsgnNo(asgnNo);
		asVO.setStuNo(stuNo);
		
		// 과제제출객체 조회
		List<AsgnSubmitVO> asVOList = new ArrayList<>();
		AsgnSubmitVO asVOall = asgnDAO.selectAsgnSubmit(asVO);
		asVOList.add(asVOall);
		// 강의과제객체에 넣기
		asgnVO.setAsgnSubmitList(asVOList);
		
		return asgnVO;
	}
//--------------------------------------------------------//

//--------------------- 파일 다운로드 ------------------------//
	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) throw new RuntimeException(String.format("%d, %d 번 파일이 없음", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;
	}
//--------------------------------------------------------//
	
//--------------------- 과제 제출 취소------------------------//
	@Override
	public String removeAsngSubmit(String asNo) {
		// 1. asVO로 dao에서 select해서 객체 받아두기
//		AsgnSubmitVO inputASVO = new AsgnSubmitVO();
//		inputASVO.setAsNo(asNo);
		AsgnSubmitVO saved = asgnDAO.selectASonAsNo(asNo);
		String asgnNo = null;
		// 2. asNo로 dao에서 delete하기
		int rowcnt = asgnDAO.deleteAsngSubmit(asNo);
		// 3. 파일지우기
		if(rowcnt > 0) {
			Optional.ofNullable(saved.getAsFile())
					.ifPresent((asFile)->{
						fileService.removeAttatchFileGroup(asFile, saveFolder);
					});
			asgnNo = saved.getAsgnNo();
		}
		return asgnNo;
	}
//--------------------------------------------------------//

	// 교수 과제 등록
	@Override
	public int createAsgn(AsgnVO asgn) {
		// 인증객체 꺼내기
		Authentication authentication 
			= SecurityContextHolder.getContext().getAuthentication();
		AttatchFileGroupVO atchFileGroup = asgn.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					//1. 파일서비스에서 metadata랑 이진데이터 넣고 1:N처리
					fileService.createAttatchFileGroup(afg, saveFolder);
					//2. C.O에 파일그룹에서 그룹id를 받아와서 저장한다.1:1처리
					asgn.setAsgnFile(afg.getAtchId());

				});
		return asgnDAO.insertProAsgn(asgn);
	}

	// 교수 강의별 과제 조회
	@Override
	public List<AsgnVO> retrieveProAsgnList(String lectNo) {
		List<AsgnVO> proAsgnList = asgnDAO.selectProAsgnList(lectNo);
		return proAsgnList;
	}

	@Override
	public void retrieveProStuAsgnList(Pagination<AsgnVO> pagination) {
		log.info("pagination : {}", pagination);
		int totalRecord = asgnDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<AsgnVO> dataList = asgnDAO.selectProStuAsgnList(pagination);
		pagination.setDataList(dataList);
	}

	@Override
	public void modifyScore(AsgnSubmitVO asVO) {
		// 수정 절차
		AsgnSubmitVO saved = retrieveAsgnSubmitInfo(asVO.getAsNo());
		// 지우기
		int rowcnt = Optional.ofNullable(asVO.getDelFileGroup())
							 .map((dfg)->{
									dfg.setAtchId(asVO.getAsFile());
									return fileService.removeAttatchFileGroup(dfg, saveFolder);
								}).orElse(0);
		rowcnt += asgnDAO.updateScore(asVO);
		
	}

	@Override
	public AsgnSubmitVO retrieveAsgnSubmitInfo(String asNo) {
		AsgnSubmitVO as = asgnDAO.selectAsgnSubmitInfo(asNo);
		return as;
	}
	
	


	
}
