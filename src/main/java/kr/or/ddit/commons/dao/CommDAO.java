package kr.or.ddit.commons.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.commons.vo.CommVO;
import kr.or.ddit.lecture.vo.LectureVO;

@Mapper
public interface CommDAO {
	public List<CommVO> selectCommList(String pre);
	
	public List<LectureVO> selectStuLectList(String stuNo);
	public List<LectureVO> selectProLectList(String proNo);
}
