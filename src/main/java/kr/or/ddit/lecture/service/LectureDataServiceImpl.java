package kr.or.ddit.lecture.service;

import java.io.File;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.lecture.dao.LectureDataDAO;
import kr.or.ddit.lecture.vo.LectureDataVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.vo.Pagination;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class LectureDataServiceImpl implements LectureDataService {
	@Inject
	private LectureDataDAO lectureDataDAO;

	@Inject
	private AttatchFileGroupService fileService;

	@Value("#{appInfo['contracts']}")
	private File saveFolder;

	@Override
	public List<LectureDataVO> retrieveLectureDataList(Pagination<LectureDataVO> pagination) {
	    LectureDataVO detailCondition = pagination.getDetailCondition();
	    if (detailCondition == null) {
	        detailCondition = new LectureDataVO();
	    }
	    detailCondition.setLectNo(pagination.getDetailCondition().getLectNo());
	    log.info("detailCondition값은?{}",detailCondition);
	    pagination.setDetailCondition(detailCondition);

		pagination.setTotalRecord(lectureDataDAO.selectTotalLectureRecord(pagination));
		List<LectureDataVO> lectureDataList = lectureDataDAO.selectLectureDataList(pagination);
		pagination.setDataList(lectureDataList);

		String getLect = pagination.getDetailCondition().getLectNo();
		log.info("detail lectNo == {}",getLect);
		return lectureDataList;
	}

	@Override
	public void createLectureData(LectureDataVO lectureData) {
		AttatchFileGroupVO atchFileGroup = lectureData.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					fileService.createAttatchFileGroup(atchFileGroup, saveFolder);
					lectureData.setLdFile(afg.getAtchId());
				});
			lectureDataDAO.insertLectureData(lectureData);
	}

	@Override
	public List<LectureVO> retrieveLectureDataTotalList() {
		List<LectureVO> lectureDataTotalList = lectureDataDAO.selectLectureDataTotalList();
		return lectureDataTotalList;
	}

	@Override
	public LectureDataVO retrieveLectureData(String ldNo) {
		LectureDataVO lectureData = lectureDataDAO.selectLecutureForAuth(ldNo);
		return lectureData;
	}

	@Override
	public void removeLectureData(LectureDataVO condition) {
		LectureDataVO saved  = retrieveLectureData(condition.getLdNo());

		int rowcnt = lectureDataDAO.deleteLectureData(condition);
		if(rowcnt >0) {
			Optional.ofNullable(saved.getLdFile())
					.ifPresent((lectFile)->{
						fileService.removeAttatchFileGroup(lectFile, saveFolder);
					});
		}

	}

	@Override
	public void modifyLectureData(LectureDataVO lectureData) {
		LectureDataVO saved = retrieveLectureData(lectureData.getLdNo());
		//지우기
		int rowcnt = Optional.ofNullable(lectureData.getDelFileGroup())
							 .map((dfg)->{
								 dfg.setAtchId(lectureData.getLdFile());
								 return fileService.removeAttatchFileGroup(dfg, saveFolder);
							 }).orElse(0);

		AttatchFileGroupVO addFileGroup = lectureData.getAddFileGroup();
		addFileGroup.setAtchId(lectureData.getLdFile());
		rowcnt += Optional.ofNullable(lectureData.getLdFile())
						  .map((ff)->fileService.modifyAttatchFileGroup(addFileGroup, saveFolder))
						  .orElseGet(()->{
							  int cnt = fileService.createAttatchFileGroup(addFileGroup, saveFolder);
							  lectureData.setLdFile(addFileGroup.getAtchId());
							  return cnt;
						  });
		rowcnt += lectureDataDAO.updateLectureData(lectureData);
	}

	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) throw new RuntimeException(String.format("%d, %d 번 파일이 없음", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;
	}

}
