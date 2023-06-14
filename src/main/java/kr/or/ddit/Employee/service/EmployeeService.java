package kr.or.ddit.Employee.service;

import java.util.List;

import kr.or.ddit.Employee.vo.EmployeeVO;

public interface EmployeeService {
	public List<EmployeeVO> retrieveEmployeeList(EmployeeVO employee);
	public EmployeeVO retrieveEmployee(String empNo);
}
