package kr.or.ddit.academicyear.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.academicyear.vo.AcademicYearVO;

@Mapper
public interface AcademicYearDAO {
	public AcademicYearVO selectNowAcademicYear();
}
