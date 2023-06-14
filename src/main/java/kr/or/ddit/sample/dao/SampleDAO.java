package kr.or.ddit.sample.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sample.vo.SampleVO;

@Mapper
public interface SampleDAO {
	public List<SampleVO> selectSampleList();
}
