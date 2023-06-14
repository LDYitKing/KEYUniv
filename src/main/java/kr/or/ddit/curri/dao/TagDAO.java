package kr.or.ddit.curri.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.curri.vo.CurriBoardVO;
import kr.or.ddit.curri.vo.TagVO;

@Mapper
public interface TagDAO {
	public int insertTagList(CurriBoardVO curriBoard);
	
	public List<TagVO> getTagRank(int rank);
}
