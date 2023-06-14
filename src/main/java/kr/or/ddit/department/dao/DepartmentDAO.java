package kr.or.ddit.department.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.department.vo.ColleageVO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.member.vo.MemberVO;

@Mapper
public interface DepartmentDAO {
	public List<DepartmentVO> selectDepartmentList();  
	public List<ColleageVO> selectColleageList();
	  
}
