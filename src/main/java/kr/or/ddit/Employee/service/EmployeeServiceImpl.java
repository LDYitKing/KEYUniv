package kr.or.ddit.Employee.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.Employee.dao.EmployeeDAO;
import kr.or.ddit.Employee.vo.EmployeeVO;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Inject
	private EmployeeDAO empDAO;
	
	@Override
	public List<EmployeeVO> retrieveEmployeeList(EmployeeVO employee) {
		return empDAO.selectEmployeeList(employee);
	}

	@Override
	public EmployeeVO retrieveEmployee(String empNo) {
		EmployeeVO employee = empDAO.selectEmployee(empNo);
		if(employee==null) throw new RuntimeException();
		return employee;
	}

}
