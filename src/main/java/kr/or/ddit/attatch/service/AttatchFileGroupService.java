package kr.or.ddit.attatch.service;

import java.io.File;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;

public interface AttatchFileGroupService {
	public int createAttatchFileGroup(AttatchFileGroupVO atchFileGroup, File saveFolder);
	public AttatchFileGroupVO retrieveAttatchFileGroup(int atchId, File saveFolder);
	public AttatchFileVO retrieveAttatchFile(AttatchFileVO condition, File saveFolder);
	public int modifyAttatchFileGroup(AttatchFileGroupVO atchFileGroup, File saveFolder);
	public int removeAttatchFileGroup(int atchId, File saveFolder);
	public int removeAttatchFileGroup(AttatchFileGroupVO delFileGroup, File saveFolder);
	
}
