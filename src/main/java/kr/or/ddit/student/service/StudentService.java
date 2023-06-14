package kr.or.ddit.student.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.vo.Pagination;

public interface StudentService {
	public void createStudent(StudentVO student);
	
	public String retrieveStudentNoForDept(Map<String, String> param);
	
	public StudentVO retrieveStudentForAuth(String memNo);
	
	public List<StudentVO> retrieveStudentList(Pagination<StudentVO> pagination);
//	retrieveStudent
	public void modifyStudent(StudentVO student);
//	removeStudent
}
