package kr.or.ddit.attatch.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;

/**
 * 첨부된 형태의 파일 데이터를 관리하기 위한 Persistence Layer
 *
 */
@Mapper
public interface AttatchFileGroupDAO {
	public int insertAttatchFileGroup(AttatchFileGroupVO atchGroup);
	
	public AttatchFileVO selectAttatch(AttatchFileVO condition); // condition : id, 순번
	
	public AttatchFileGroupVO selectAttatchList(int atchId); // 그룹 검색
	
	// group -> update , file -> insert/delete
	public int updateAttatchFileGroup(AttatchFileGroupVO atchFileGroup); // return 수정한 개수
	
	// 게시글 수정 첨부파일 삭제
	public int deleteAttatch(AttatchFileVO condition);
	
	public int deleteAttatchList(int atchId); // 그룹 삭제, return : 그룹 길이
}
