package kr.or.ddit.facility.service;


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
import kr.or.ddit.facility.dao.FacilityDAO;
import kr.or.ddit.facility.vo.FacilityResVO;
import kr.or.ddit.facility.vo.FacilityTimeVO;
import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FacilityServiceImpl implements FacilityService{

	@Inject
	private FacilityDAO facilityDAO;

	@Inject
	private AttatchFileGroupService fileService;

	@Value("#{appInfo['contracts']}")
	private File saveFolder;

	@Override
	public void createFacility(FacilityVO facility) {
		AttatchFileGroupVO atchFileGroup = facility.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					fileService.createAttatchFileGroup(afg, saveFolder);
					facility.setFaciFile(afg.getAtchId());
				});
		facilityDAO.insertFacility(facility);

	}

	@Override
	public void modifyFacility(FacilityVO facility) {
		// 게시글 수정 절차?
		FacilityVO saved = retrieveFacility(facility.getFaciNo());
		// 지우기
		int rowcnt = Optional.ofNullable(facility.getDelFileGroup())
							 .map((dfg)->{
									dfg.setAtchId(facility.getFaciFile());
									return fileService.removeAttatchFileGroup(dfg, saveFolder);
								}).orElse(0);
		// 업로드
		AttatchFileGroupVO addFileGroup = facility.getAddFileGroup();
		addFileGroup.setAtchId(facility.getFaciFile());
		rowcnt += Optional.ofNullable(facility.getFaciFile())
							.map((ff)->fileService.modifyAttatchFileGroup(addFileGroup, saveFolder))
							.orElseGet(()->{
								int cnt = fileService.createAttatchFileGroup(addFileGroup, saveFolder);
								facility.setFaciFile(addFileGroup.getAtchId());
								return cnt;
							});
		rowcnt += facilityDAO.updateFacility(facility);
	}

	@Override
	public void removeFacility(FacilityVO condition) {
		FacilityVO saved = retrieveFacility(condition.getFaciNo());

		int rowcnt = facilityDAO.deleteFacility(condition);
		if(rowcnt > 0) {
			Optional.ofNullable(saved.getFaciFile())
					.ifPresent((faciFile)->{
						fileService.removeAttatchFileGroup(faciFile, saveFolder);
					});
		}

	}

	@Override
	public void retrieveFacilityList(Pagination<FacilityVO> pagination) {
		int totalRecord = facilityDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<FacilityVO> dataList = facilityDAO.selectFacilityList(pagination);
		pagination.setDataList(dataList);
	}

	@Override
	public FacilityVO retrieveFacility(String faciNo) {
		FacilityVO facility = facilityDAO.selectFacility(faciNo);
		if(facility==null) throw new RuntimeException();
		return facility;
	}

	@Override
	public void createFacilityRes(FacilityResVO facilityRes) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		log.info("현재 로그인된 사용자 : {} ", authentication);
		facilityDAO.insertFacilityRes(facilityRes);
	}

	@Override
	public List<FacilityTimeVO> retrieveFacilityTimeList() {
		return facilityDAO.selectFacilityTimeList();
	}

	@Override
	public List<FacilityVO> retrieveFaciList() {
		return facilityDAO.selectFaciList();

	}

	@Override
	public List<FacilityResVO> retrieveFacilityResList(String memNo) {
		List<FacilityResVO> facilityResList = facilityDAO.selectFacilityResList(memNo);
		return facilityResList;
	}

	@Override

	public void removeFacilityRes(FacilityResVO condition) {
		int rowcnt = facilityDAO.deleteFacilityRes(condition);

	}

	@Override
	public List<FacilityResVO> retrieveAllFacilityResList() {
		return facilityDAO.selectTotalFacilityResList();
	}








}
