package kr.or.ddit.sample.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.sample.dao.SampleDAO;
import kr.or.ddit.sample.vo.SampleVO;

@Service
public class SampleServiceImpl implements SampleService {

	@Inject
	private SampleDAO dao;
	
	@Override
	public List<SampleVO> retrieveSampleList() {
		return dao.selectSampleList();
	}

}
