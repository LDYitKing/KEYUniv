package kr.or.ddit.department.vo;

import java.io.Serializable;
import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "deptNo")
public class DepartmentVO implements Serializable {
	private String deptNo;
	private String colNo;
	private String colName;
	private String drNo;
	private String deptName;
	private Integer deptTuition;
	
	private List<DepartmentVO> deptList;

	
	private MemberVO member;
}
