package kr.or.ddit.student.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.vo.Pagination;

/**
 * @author PC-02
 * 학생 관리 (CRUD)
 *
 */
@Mapper
public interface StudentDAO {
	/**
	 * 신,편입생 등록
	 * @param student
	 * @return > 0, 성공
	 */
	public int insertStudent(StudentVO student);
	
	/**
	 * 페이징 처리를 위한 전체 레코드 수 조회
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<StudentVO> pagination);
	
	/**
	 * 학생 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<StudentVO> selectStudentList(Pagination<StudentVO> pagination);
	
	/**
	 * PK로 학생 한명 상세 조회
	 * @param memNo
	 * @return 존재하지 않는 경우, null
	 */
	public StudentVO selectStudentForAuth(String memNo);
	
	/**
	 * 학생 정보 수정
	 * @param student
	 * @return > 0, 성공
	 */
	public int updateStudent(StudentVO student);
	
	/**
	 * 학생 삭제
	 * @param memNo
	 * @return > 0, 성공
	 */
	public int deleteStudent(String memNo);
	
	/**
	 * 신편입생 등록 시, 학과 번호로 학번 결정하기
	 * @param param
	 * @return
	 */
	public String selectStudentNoForDept(Map<String, String> param);
	
	
	
	public List<StudentVO> selectStudentPackList();
}



