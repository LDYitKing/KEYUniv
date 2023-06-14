package kr.or.ddit.attatch.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import com.sun.el.stream.Stream;

import kr.or.ddit.attatch.dao.AttatchFileGroupDAO;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;

@Service
public class AttatchFileGroupServiceImpl implements AttatchFileGroupService {
	
	@Inject
	private AttatchFileGroupDAO fileGroupDAO;

	@Override
	public int createAttatchFileGroup(AttatchFileGroupVO atchFileGroup, File saveFolder) {
		// 메타데이터 저장
		int rowcnt = Optional.ofNullable(atchFileGroup.getAtchfileList())
							.filter((afl)->!afl.isEmpty())
							.map((afl)->fileGroupDAO.insertAttatchFileGroup(atchFileGroup))
							.orElse(0);
		
		// 이진데이터 저장
		if(rowcnt>0) {
			processAttatchFileGroupBinary(atchFileGroup, saveFolder);
		}
		return rowcnt;
	}

	private void processAttatchFileGroupBinary(AttatchFileGroupVO atchFileGroup, File saveFolder) {
		atchFileGroup.getAtchfileList().stream()
					.forEach((af)->{
						try{
							af.saveTo(saveFolder);
						}catch (IOException e) {
							throw new RuntimeException(e);
						}
					});
	}

	@Override
	public AttatchFileGroupVO retrieveAttatchFileGroup(int atchId, File saveFolder) {
		AttatchFileGroupVO atchFileGroup = fileGroupDAO.selectAttatchList(atchId);
		return atchFileGroup;
	}

	@Override
	public AttatchFileVO retrieveAttatchFile(AttatchFileVO condition, File saveFolder) {
		AttatchFileVO atchFileVO = fileGroupDAO.selectAttatch(condition);
		Optional.ofNullable(atchFileVO)
				.ifPresent((afv)->{
					File saveFile = new File(saveFolder, afv.getAtchSaveName());
					afv.setAtchFile(saveFile);
				});
		
		return atchFileVO;
	}

	@Override
	public int modifyAttatchFileGroup(AttatchFileGroupVO atchFileGroup, File saveFolder) {
		return Optional.ofNullable(atchFileGroup.getAtchfileList()) // 새로 추가할 파일 여부 확인
						.filter((fl)->!fl.isEmpty())
						.map((fl)->{ // not null, not empty
							int rowcnt = fileGroupDAO.updateAttatchFileGroup(atchFileGroup); // 메타데이터 저장
							// 이진데이터 저장
							if(rowcnt>0) {
								processAttatchFileGroupBinary(atchFileGroup, saveFolder);
							}
							return rowcnt;
						}).orElse(0);
	}
	
	private void processAttatchFileBinaryDataDelete(AttatchFileGroupVO fileGroup, File saveFolder){
		fileGroup.getAtchfileList().stream()
			.forEach((af)->{
				FileUtils.deleteQuietly(new File(saveFolder, af.getAtchSaveName()));
			});
	}

	@Override
	public int removeAttatchFileGroup(int atchId, File saveFolder) {
		AttatchFileGroupVO fileGroup = fileGroupDAO.selectAttatchList(atchId);
		
		// 메타데이터 삭제
		int rowcnt = fileGroupDAO.deleteAttatchList(atchId);
		
		if(rowcnt > 0) {
			// 이진데이터 삭제
			processAttatchFileBinaryDataDelete(fileGroup, saveFolder);
		}
		return rowcnt;
	}

	@Override
	public int removeAttatchFileGroup(AttatchFileGroupVO delFileGroup, File saveFolder) {
		List<AttatchFileVO> conditionList =  Optional.ofNullable(delFileGroup.getDelSeqs())
													.map((delSeqs)->{
														return Arrays.stream(delSeqs)
																		.mapToObj((seq)->{
																			AttatchFileVO condition = new AttatchFileVO();
																			condition.setAtchId(delFileGroup.getAtchId());
																			condition.setAtchSeq(seq);
																			return fileGroupDAO.selectAttatch(condition);
																		}).collect(Collectors.toList());
													}).orElse(null);
		return Optional.ofNullable(conditionList)
						.map((cl)->{
							cl.stream()
								.forEach((condition)->{
									fileGroupDAO.deleteAttatch(condition);
									FileUtils.deleteQuietly(new File(saveFolder, condition.getAtchSaveName()));
								});
							return cl.size();
						}).orElse(0);
	}
	
}
