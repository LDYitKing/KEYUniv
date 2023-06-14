package kr.or.ddit.Employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.Employee.vo.EmployeeVO;

@Mapper
public interface EmployeeDAO {
	public List<EmployeeVO> selectEmployeeList(EmployeeVO employee);
	public EmployeeVO selectEmployee(String empNo);
}
